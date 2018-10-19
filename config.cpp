#include "config.h"
#include "configdata.h"
#include "gpxfile.h"

#include <QDebug>
//#include <QApplication>
//#include <QQuickApplicationWindow>
#include <QMainWindow>
//#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQmlComponent>
#include <QDir>
#include <QFile>
#include <QStandardPaths>
#include <QRegExp>

// ----------------------------------------------------------------------------
// Global variable defined in main.cpp and has loaded the Application.qml
//extern QQmlApplicationEngine *applicationEngine;

// ----------------------------------------------------------------------------
// See also http://blog.qt.io/blog/2017/12/01/sharing-files-android-ios-qt-app/
// to use Q_OS_IOS, Q_OS_ANDROID etc.
// ----------------------------------------------------------------------------
Config::Config(QObject *parent) : QObject(parent) {

  // See also http://doc.qt.io/qt-5/qguiapplication.html#platformName-prop
  // For me it could be: android, ios or xcb (x11 on linux)
  //qDebug() << "platform name: " << qApp->platformName();

  // Check the data directories. Make use of GenericDataLocation standard path
  // and look for the directory made up by its id.
  QString id = QCoreApplication::organizationDomain() +
      "." + QCoreApplication::applicationName();
  qDebug() << "Id: " << id;

  // Take first directory from the list. That one is the users data directory.
  // linux:     /home/marcel/.config/io.martimm.github.HikingCompanion
  // android:   /data/user/0/io.martimm.github.HikingCompanion/files/settings

#if defined(Q_OS_ANDROID)
  _dataDir = QStandardPaths::standardLocations(
        QStandardPaths::AppConfigLocation
        ).first();

  // Create directory if needed
  this->mkpath(_dataDir);

  // Create settings and load them
  _settings = new QSettings();
  _settings->setIniCodec("UTF-8");

#elif defined(Q_OS_LINUX)
  _dataDir = QStandardPaths::standardLocations(
        QStandardPaths::GenericConfigLocation
        ).first();
  _dataDir += "/" + id;

  // Create directory if needed
  this->mkpath(_dataDir);

  // Create settings and load them
  _settings = new QSettings( _dataDir + "/HikingCompanion.conf", QSettings::IniFormat);
  _settings->setIniCodec("UTF-8");
#endif
/*
  //setSetting( "stylesheet", ":Assets/Theme/HikingCompanionSS.qss");

  // Place default stylesheet into _dataDir directory
  QFile::remove(_dataDir + "/stylesheet.qss");
  QString stylesheetPath = getSetting("stylesheet");
  if ( QFile::copy( stylesheetPath, _dataDir + "/stylesheet.qss") ) {
    qDebug() << "copy stylesheet ok";
  }

  else {
    qDebug() << "copy stylesheet not ok";
  }
*/

  // Prepare for data sharing location and create the root of it
  // linux:     /home/marcel/.local/share/io.github.martimm.HikingCompanion
  // Android:   /storage/emulated/0/Android/Data/io.github.martimm.HikingCompanion
  QString publicLoc = QStandardPaths::standardLocations(
        QStandardPaths::GenericDataLocation
        ).first();

#if defined(Q_OS_ANDROID)
  publicLoc += "/Android/Data/" + id;
#elif defined(Q_OS_LINUX)
  publicLoc += "/" + id;
#endif

  this->mkpath(publicLoc);
  _dataShareDir = publicLoc + "/newHikeData";
  this->checkForNewHikeData();
}

// ----------------------------------------------------------------------------
void Config::checkForNewHikeData() {

  //TODO test for newHikeData to see if there is new data
  QDir *dd = new QDir(_dataShareDir);
  if( dd->exists() ) {
    this->_installNewData();
    qDebug() << "Remove public hike source data from" << _dataShareDir;
    dd = new QDir(_dataShareDir);
    dd->removeRecursively();
  }
}

// ----------------------------------------------------------------------------
bool Config::mkpath(QString path) {

  bool ok = true;
  QString p = "/";
  QDir *dd;

  QStringList parts = path.split( '/', QString::SkipEmptyParts);
  for ( int pi = 0; pi < parts.count(); pi++) {
    dd = new QDir(p);
    if ( dd->exists(parts[pi]) ) {
      //qDebug() << p << parts[pi] << "exists -> next";
    }

    else if ( dd->mkdir(parts[pi]) ) {
      //qDebug() << p << parts[pi] << "ok";
    }

    else {
      qDebug() << p << parts[pi] << "fails";
      ok = false;
      break;
    }

    if ( pi == 0 ) {
      p += parts[pi];
    }

    else {
      p += "/" + parts[pi];
    }
  }

  qDebug() << path << "ok:" << ok;
  return ok;
}

// ----------------------------------------------------------------------------
// Cleanup tracks information in config when there are no entries
// in the hike list. This is to prevent linguering entries to disturb
// later config changes.
void Config::cleanupTracks() {

  QRegExp rx("^(h\\d+|h\\.)");
  QStringList topLevelKeys = _settings->childGroups();
  for ( int hi = 0; hi < topLevelKeys.count(); hi++ ) {
    if ( topLevelKeys[hi].contains(rx) ) {
      qDebug() << "Remove keys of" << topLevelKeys[hi];
      _removeSettings(topLevelKeys[hi]);
    }
  }
}

// ----------------------------------------------------------------------------
// Set only new string values to this applications config settings
void Config::setSetting( QString name, QString value ) {

  qDebug() << QString("Set %1 to %2").arg(name).arg(value);
  _settings->setValue( name, value);
  _settings->sync();
}

// ----------------------------------------------------------------------------
// Set only new integer values to this applications config settings
void Config::setSetting( QString name, int value ) {

  qDebug() << QString("Set %1 to %2").arg(name).arg(value);
  _settings->setValue( name, value);
  _settings->sync();
}

// ----------------------------------------------------------------------------
// Read values from this applications config settings or external config
QString Config::getSetting( QString name, QSettings *s ) {

  QSettings *settings;
  if ( s == nullptr ) {
    settings = _settings;
  }

  else {
    settings = s;
  }

  if ( settings->value(name).type() == QVariant::Invalid ) return "";
  QString v = settings->value(name).toString();
  //qDebug() << "GS:" << name << v;
  return v;
}

// ----------------------------------------------------------------------------
// Read keys from this applications config settings or external config
QStringList Config::readKeys( QString group, QSettings *s ) {

  QSettings *settings;
  if ( s == nullptr ) {
    settings = _settings;
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
QString Config::hikeEntryKey() {

  QString hikeIndex = getSetting("selectedhikeindex");
  return QString("h") + hikeIndex;
}

// ----------------------------------------------------------------------------
QString Config::hikeTableName( QString hikeEntryKey ) {

  QString hikeKey = getSetting("HikeList/" + hikeEntryKey);
  return hikeEntryKey + "." + hikeKey;
}

// ----------------------------------------------------------------------------
QString Config::tracksTableName( QString hikeTableName, int trackCount) {

  return QString("%1.Track%2").arg(hikeTableName).arg(trackCount);
}

// ----------------------------------------------------------------------------
QString Config::dataDir() {
  return _dataDir;
}

// ----------------------------------------------------------------------------
int Config::getGpxFileIndexSetting() {

  QString entryKey = hikeEntryKey();
  QString tableName = hikeTableName(entryKey);
  return getSetting( tableName + "/gpxfileindex").toInt();
}

// ----------------------------------------------------------------------------
void Config::setGpxFileIndexSetting( int currentIndex ) {

  QString entryKey = hikeEntryKey();
  QString tableName = hikeTableName(entryKey);
  setSetting( tableName + "/gpxfileindex", currentIndex);
}

/*
// ----------------------------------------------------------------------------
void Config::setStyleSheet() {
  QString stylesheetPath;
  QString entryKey = this->hikeEntryKey();
  QString tableName = this->hikeTableName(entryKey);
  if ( tableName == "" ) {
    stylesheetPath = _dataDir + "/stylesheet.qss";
    qDebug() << "SS no tablename:" << stylesheetPath;
  }

  else {
    stylesheetPath = getSetting( tableName + "/stylesheet");
    if ( stylesheetPath == "" ) {
      stylesheetPath = _dataDir + "/stylesheet.qss";
      qDebug() << "SS no stylesheet in:" << tableName << "->" << stylesheetPath;
    }

    else {
      qDebug() << "SS stylesheet:" << tableName << "->" << stylesheetPath;
    }
  }

/ *
  QFile *stylesheet = new QFile(stylesheetPath);
  if ( stylesheet->open(QIODevice::ReadOnly) ) {
    qDebug() << "stylesheet opened";
  }
  else {
    qDebug() << "stylesheet not opened";
  }

  qDebug() << "Previous installed stylesheet:" << qApp->styleSheet();

  QString stylesheetText = QLatin1String(stylesheet->readAll());
  //qDebug() << "stylesheet text\n" << stylesheetText;
  qApp->setStyleSheet(stylesheetText);
  //qApp->setStyleSheet("background-color: green");
* /

  //qDebug() << "widgets:" << QApplication::allWidgets();
  //QMainWindow *mw = reinterpret_cast<QMainWindow *>(
  //      applicationEngine->rootObjects().first()
  //      );
  //qDebug() << "root objs:" << mw->children();
  //qApp->setStyleSheet("background-color: green; color: blue;");
  //qApp->style()->polish(qApp);

  QDir *dd = new QDir(".");
  qApp->setStyleSheet("file:///" + dd->absoluteFilePath(stylesheetPath));
  qDebug() << "Installed stylesheet:" << qApp->styleSheet();
}
*/

// ----------------------------------------------------------------------------
void Config::_installNewData() {

  qDebug() << "Install data from" << _dataShareDir + "/hike.conf";
  if ( ! QFile::exists(_dataShareDir + "/hike.conf") ) {
    qDebug() << _dataShareDir + "/hike.conf does not exist";
    return;
  }

  QSettings *s = new QSettings( _dataShareDir + "/hike.conf", QSettings::IniFormat);
  s->setIniCodec("UTF-8");

  QString hikename = getSetting( "hike", s);
  qDebug() << "Hike key" << hikename;
  //qDebug() << "Version" << getSetting( "version", s);
  //qDebug() << "Description" << getSetting( "shortdescr", s);

  // Create the root of the hike data dir
  QString hikeDir = _dataDir + "/" + hikename;



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
    qDebug() << "Remove old data from" << hikeDir;
    QDir *dd = new QDir(hikeDir);
    dd->removeRecursively();
    dd->mkpath(hikeDir);

    _mkNewTables( s, hikeTableName);
    _refreshData( s, hikeTableName, hikeDir);
  }
}

// ----------------------------------------------------------------------------
// Create new tables. One for the hike and one for its release notes
void Config::_mkNewTables( QSettings *s, QString hikeTableName ) {

  // Remove the hike table and the releases table
  _removeSettings(hikeTableName);
  QString releaseTableName = hikeTableName + ".Releases";
  _removeSettings(releaseTableName);

  // Keys needed for the hike table
  QStringList keys = {
    "version", "title", "shortdescr", "www", "defaultlang",
    "supportedlang", "translationfile"
  };

  for ( int ki = 0; ki < keys.count(); ki++) {
    QString v = getSetting( keys[ki], s);
    setSetting( hikeTableName + "/" + keys[ki], v);
  }

  // Default the first track is selected
  setSetting( hikeTableName + "/gpxfileindex", 0);

  // Release notes table
  QStringList releaseKeys = readKeys( "Releases", s);
  for ( int ri = 0; ri < releaseKeys.count(); ri++) {
    setSetting(
          releaseTableName + "/" + releaseKeys[ri],
          getSetting( "Releases/" + releaseKeys[ri], s)
          );
  }
}

// ----------------------------------------------------------------------------
void Config::_refreshData(
    QSettings *s, QString hikeTableName, QString hikeDir
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
      QString trackTableName = hikeTableName + QString(".Track%1").arg(gfi + 1);
      qDebug() << "Remove table" << trackTableName;
      _removeSettings(trackTableName);

      // Remove file
      //qDebug() << "Remove file" << gpxFiles[gfi];
      //QFile::remove(hikeSubdir + "/" + gpxFiles[gfi]);
    }
  }

  else {
    qDebug() << "Create dir " << hikeSubdir;
    dd->mkpath(hikeSubdir);
  }

  // Add tracks to empty directory and create tables
  // Get source directory and list of files
  QString sourceGpxDirectory = _dataShareDir + "/" + getSetting( "tracksdir", s);
  QDir *sgd = new QDir(sourceGpxDirectory);

  qDebug() << "src hike tracks:" << sourceGpxDirectory;
  qDebug() << "dest hike tracks:" << hikeSubdir;

  //QStringList newGpxFiles = sgd->entryList( QDir::Files, QDir::Name);
  //for ( int gfi = 0; gfi < newGpxFiles.count(); gfi++) {

  // Maximum number of files possible
  int nbrGpxFiles = sgd->entryList(QDir::Files).count();
  int nbrDefinedGpxFiles = 0;
  for ( int gfi = 0; gfi < nbrGpxFiles; gfi++) {

    // Create table
    QString srcTrackTable = QString("Track%1").arg(gfi);
    QString destTrackTable = hikeTableName + QString(".Track%1").arg(gfi);

    qDebug() << "src/dest table" << srcTrackTable << destTrackTable;

    // If there are no keys for this table, we are done
    QStringList trackKeys = readKeys( srcTrackTable, s);
    if ( trackKeys.count() == 0 ) {
      nbrDefinedGpxFiles = gfi;
      break;
    }

    //TODO: Lenght must be calculated
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

  setSetting( hikeTableName + "/ntracks", nbrDefinedGpxFiles);


  hikeSubdir = QString(hikeDir + "/Photos");
  dd = new QDir(hikeSubdir);
  if ( ! dd->exists() ) dd->mkpath(hikeSubdir);
  setSetting( hikeTableName + "/nphotos", 0);
  qDebug() << "hike photos:" << hikeSubdir;

  hikeSubdir = hikeDir + "/Notes";
  dd = new QDir(hikeSubdir);
  if ( ! dd->exists() ) dd->mkpath(hikeSubdir);
  setSetting( hikeTableName + "/nnotes", 0);
  qDebug() << "hike notes:" << hikeSubdir;

  hikeSubdir = hikeDir + "/Features";
  dd = new QDir(hikeSubdir);
  if ( ! dd->exists() ) dd->mkpath(hikeSubdir);
  setSetting( hikeTableName + "/nfeatures", 0);
  qDebug() << "hike features:" << hikeSubdir;
}

// ----------------------------------------------------------------------------
void Config::_removeSettings(QString group) {
  _settings->remove(group);
  _settings->sync();
}

