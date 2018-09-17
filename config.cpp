#include "config.h"
#include "configdata.h"
#include "gpxfile.h"

#include <QDebug>
#include <QQmlEngine>
#include <QQmlComponent>
#include <QDir>
#include <QFile>
#include <QStandardPaths>

// ----------------------------------------------------------------------------
// See also http://blog.qt.io/blog/2017/12/01/sharing-files-android-ios-qt-app/
// to use Q_OS_IOS, Q_OS_ANDROID etc.
// ----------------------------------------------------------------------------
Config::Config(QObject *parent) : QObject(parent) { }

// ----------------------------------------------------------------------------
// Set only new string values to this applications config settings
void Config::setSetting( QString name, QString value) {

  QSettings *settings = new QSettings();
  //qDebug() << "SS Settings file:" << settings->fileName();
  qDebug() << QString("Set %1 to %2").arg(name).arg(value);
  settings->setValue( name, value);
  settings->sync();
}

// ----------------------------------------------------------------------------
// Set only new integer values to this applications config settings
void Config::setSetting( QString name, int value) {

  QSettings *settings = new QSettings();
  //qDebug() << "SS Settings file:" << settings->fileName();
  qDebug() << QString("Set %1 to %2").arg(name).arg(value);
  settings->setValue( name, value);
  settings->sync();
}

// ----------------------------------------------------------------------------
// Read values from this applications config settings or external config
QString Config::getSetting( QString name, QSettings *s) {

  QSettings *settings;
  if ( s == nullptr ) {
    settings = new QSettings();
  }

  else {
    settings = s;
  }

  //qDebug() << "GS Settings file:" << settings->fileName();
  qDebug() << "GS:" << name << settings->value(name).toString();
  return settings->value(name).toString();
}

// ----------------------------------------------------------------------------
// Read keys from this applications config settings or external config
QStringList Config::readKeys( QString group, QSettings *s) {

  QSettings *settings;
  if ( s == nullptr ) {
    settings = new QSettings();
  }

  else {
    settings = s;
  }

  settings->beginGroup(group);
  QStringList keys = settings->childKeys();
  //qDebug() << "returned keys for group: " << keys;
  settings->endGroup();
  return keys;
}

// ----------------------------------------------------------------------------
void Config::installNewData(QString dataPath) {

  // See also http://doc.qt.io/qt-5/qguiapplication.html#platformName-prop
  // For me it could be: android, ios or xcb (x11 on linux)
  //qDebug() << "platform name: " << qApp->platformName();

  // Check the data directories. Make use of GenericDataLocation standard path
  // and look for the directory made up by its id.
  QString id = QCoreApplication::organizationDomain() +
      "." + QCoreApplication::applicationName();
  //qDebug() << "Id: " << id;

  // Take first directory from the list. That one is the users
  // data directory.
  _dataDir = QStandardPaths::standardLocations(
        QStandardPaths::GenericDataLocation
        ).first() + "/" + id;

  QDir *dd = new QDir(_dataDir);
  if ( ! dd->exists() ) dd->mkdir(_dataDir);
  //qDebug() << "Data location:" << _dataDir;


  qDebug() << "Install data from" << dataPath;
  QSettings *s = new QSettings( dataPath + "/hike.conf", QSettings::IniFormat);

  QString hikename = getSetting( "hike", s);
  qDebug() << "Hike key" << hikename;
  //qDebug() << "Version" << getSetting( "version", s);
  //qDebug() << "Description" << getSetting( "shortdescr", s);

  // Create the root of the hike data dir
  QString hikeDir = _dataDir + "/" + hikename;
  dd = new QDir(hikeDir);
  if ( ! dd->exists() ) dd->mkdir(hikeDir);
  qDebug() << "hike root:" << hikeDir;


  // Check its version. First get table if there is any.
  QStringList hikeList = readKeys("HikeList");
  QString hikeEntryKey = "";
  QString hikeTableName;
  QString hikeVersion;
  for ( int hli = 0; hli < hikeList.count(); hli++) {
    QString name = getSetting("HikeList/" + hikeList[hli]);
    if ( name.compare(hikename) == 0 ) {
      hikeEntryKey = hikeList[hli];
      hikeTableName = hikeEntryKey + "." + hikename;
      break;
    }
  }

  // Check if we found a table. If not, create a new table. Imported tables
  // start with letter 'h'.
  if ( hikeEntryKey.compare("") == 0 ) {
    hikeEntryKey = QString("h%1").arg(hikeList.count());
    hikeTableName = hikeEntryKey + "." + hikename;
    hikeVersion = "";

    setSetting( QString("HikeList/") + hikeEntryKey, hikename);
  }

  else {
    hikeVersion = getSetting(hikeTableName + "/version");
  }

  qDebug() << "Versions old/new:" << hikeVersion << getSetting( "version", s);
  // If version of imported hike is greater, then there is work to do
  if ( hikeVersion.compare(getSetting( "version", s)) < 0 ) {
    _mkNewTable( s, hikeTableName);
    _refreshData( s, hikeEntryKey, hikeTableName, hikeDir, dataPath);
  }
}

// ----------------------------------------------------------------------------
// Remove keys from this applications config settings.
void Config::_mkNewTable( QSettings *s, QString hikeTableName) {

  QStringList keys = {
    "version", "title", "shortdescr", "www", "defaultlang",
    "supportedlang", "translationfile"
  };

  for ( int ki = 0; ki < keys.count(); ki++) {
    QString v = getSetting( keys[ki], s);
    setSetting( hikeTableName + "/" + keys[ki], v);
  }

  setSetting( hikeTableName + "/gpxfileindex", "0");
}

// ----------------------------------------------------------------------------
void Config::_refreshData(
    QSettings *s,
    QString hikeEntryKey,
    QString hikeTableName,
    QString hikeDir,
    QString dataPath
    ) {

  // Remove all data first then create all directories, if needed,
  // and add data to it
  QString hikeSubdir = hikeDir + "/Tracks";
  QDir *dd = new QDir(hikeSubdir);

  // Remove track files and config tables. Table count must follow track names.
  if ( dd->exists() ) {

    QStringList gpxFiles = dd->entryList( QDir::Files, QDir::Name);
    for ( int gfi = 0; gfi < gpxFiles.count(); gfi++) {

      // Remove table
      QString trackTableName = hikeEntryKey + QString(".track%1").arg(gfi + 1);
      qDebug() << "Remove table" << trackTableName;
      _removeSettings(trackTableName);

      // Remove file
      qDebug() << "Remove file" << gpxFiles[gfi];
      QFile::remove(hikeSubdir + "/" + gpxFiles[gfi]);
    }

    setSetting(hikeTableName + "/ntracks",gpxFiles.count());
  }

  else {
    qDebug() << "Create dir " << hikeSubdir;
    dd->mkdir(hikeSubdir);
  }

  // Add tracks to empty directory and create tables
  // Get source directory and list of files
  QString sourceGpxDirectory = dataPath + "/" + getSetting( "tracksdir", s);
  QDir *sgd = new QDir(sourceGpxDirectory);

  qDebug() << "src hike tracks:" << sourceGpxDirectory;
  qDebug() << "dest hike tracks:" << hikeSubdir;

  //QStringList newGpxFiles = sgd->entryList( QDir::Files, QDir::Name);
  //for ( int gfi = 0; gfi < newGpxFiles.count(); gfi++) {

  int nbrGpxFiles = sgd->entryList(QDir::Files).count();
  for ( int gfi = 0; gfi < nbrGpxFiles; gfi++) {

    // Create table
    QString srcTrackTable = QString("track%1").arg(gfi + 1);
    QString destTrackTable = hikeEntryKey + QString(".track%1").arg(gfi + 1);

    qDebug() << "src/dest table" << srcTrackTable << destTrackTable;

    // If there are no keys for this table, we are done
    QStringList trackKeys = readKeys( srcTrackTable, s);
    if ( trackKeys.count() == 0 ) break;

    QStringList keys = {
      "fname", "title", "shortdescr", "type", "length",
    };

    for ( int ki = 0; ki < keys.count(); ki++) {
      QString v = getSetting( srcTrackTable + "/" + keys[ki], s);
      setSetting( destTrackTable + "/" + keys[ki], v);
    }

    // Copy file
    QString fname = getSetting( srcTrackTable + "/fname", s);
    QFile::copy(
          sourceGpxDirectory + "/" + fname,
          hikeSubdir + "/" + fname
          );
    qDebug() << "copy" << sourceGpxDirectory + "/" + fname;
  }

  setSetting( hikeTableName + "/ntracks", nbrGpxFiles);


  hikeSubdir = QString(hikeDir + "/Photos");
  dd = new QDir(hikeSubdir);
  if ( ! dd->exists() ) dd->mkdir(hikeSubdir);
  setSetting( hikeTableName + "/nphotos", 0);
  qDebug() << "hike photos:" << hikeSubdir;

  hikeSubdir = hikeDir + "/Notes";
  dd = new QDir(hikeSubdir);
  if ( ! dd->exists() ) dd->mkdir(hikeSubdir);
  setSetting( hikeTableName + "/nnotes", 0);
  qDebug() << "hike notes:" << hikeSubdir;

  hikeSubdir = hikeDir + "/Features";
  dd = new QDir(hikeSubdir);
  if ( ! dd->exists() ) dd->mkdir(hikeSubdir);
  setSetting( hikeTableName + "/nfeatures", 0);
  qDebug() << "hike features:" << hikeSubdir;

}

// ----------------------------------------------------------------------------
void Config::_removeSettings(QString group) {
  QSettings *settings = new QSettings();
  settings->remove(group);
  settings->sync();
}
