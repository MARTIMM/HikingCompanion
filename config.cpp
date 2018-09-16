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
Config::Config(QObject *parent) : QObject(parent) {

  // See also http://doc.qt.io/qt-5/qguiapplication.html#platformName-prop
  // For me it could be: android, ios or xcb (x11 on linux)
  qDebug() << "platform name: " << qApp->platformName();

  // Check the data directories. Make use of GenericDataLocation standard path
  // and look for the directory made up by its id.
  QString id = QCoreApplication::organizationDomain() +
      "." + QCoreApplication::applicationName();
  qDebug() << "Id: " << id;

  // Take first directory from the list. That one is the users
  // data directory.
  _dataDir = QStandardPaths::standardLocations(
        QStandardPaths::GenericDataLocation
        ).first() + "/" + id;

  QDir dd(_dataDir);
  if ( ! dd.exists() ) dd.mkdir(_dataDir);
  qDebug() << "Data location:" << _dataDir;

/*
  QStringList keys = readKeys("HikeList");
  for( int i = 0; i < keys.length(); i++) {
    qDebug() << getSetting("HikeList/" + keys[i]);
  }
  qDebug() << getSetting("Hike.HaarlemNHTrips/Type");
*/
}

// ----------------------------------------------------------------------------
void Config::setSetting( QString name, QString value) {

  QSettings settings;
  settings.setValue( name, value);
}

// ----------------------------------------------------------------------------
QString Config::getSetting(QString name) {

  QSettings settings;
  return settings.value(name).toString();
}

// ----------------------------------------------------------------------------
QStringList Config::readKeys(QString group) {

  QSettings settings;
  settings.beginGroup(group);
  QStringList keys = settings.childKeys();
  qDebug() << "returned keys for group: " << keys;

  settings.endGroup();
  return keys;
}

// ----------------------------------------------------------------------------
void Config::installNewData(QString dataPath) {

  qDebug() << "Install data from" << dataPath;
  QSettings *s = new QSettings( dataPath + "/hike.conf", QSettings::IniFormat);

  QString hikename = s->value("hike").toString();
  qDebug() << "Hike key" << hikename;
  qDebug() << "Version" << s->value("version").toString();
  qDebug() << "Description" << s->value("shortdescr").toString();

  // Create the root of the hike data dir
  QString hikeDir = _dataDir + "/" + hikename;
  QDir *dd = new QDir(hikeDir);
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

  // Check if we found a table. If not create a new table. Imported tables
  // start with letter 'h'.
  if ( hikeEntryKey.compare("") == 0 ) {
    hikeEntryKey = QString("h") + hikeList.count();
    hikeTableName = hikeEntryKey + "." + hikename;
    hikeVersion = "";

    setSetting( "HikeList/h" + hikeList.count(), hikename);
  }

  else {
    hikeVersion = getSetting(hikeTableName + "/version");
  }

  // If version of imported hike is greater, then there is work to do
  if ( hikeVersion.compare(s->value("version").toString()) > 0 ) {
    _mkNewTable( s, hikeTableName);
    _refreshData( s, hikeEntryKey, hikeTableName, hikeDir);
  }

}

// ----------------------------------------------------------------------------
void Config::_mkNewTable( QSettings *s, QString hikeTableName) {

  setSetting( hikeTableName + "/version", s->value("version").toString());

}

// ----------------------------------------------------------------------------
void Config::_refreshData(
    QSettings *s,
    QString hikeEntryKey,
    QString hikeTableName,
    QString hikeDir
    ) {

  // Remove all data first then create all directories, if needed,
  // and add data to it
  QString hikeSubdir = hikeDir + "/Tracks";
  QDir *dd = new QDir(hikeSubdir);

  // Remove tracks. Table count must follow track names. Then create
  // table and copy track
  if ( dd->exists() ) {
    QStringList gpxFiles = dd->entryList( hikeSubdir, QDir::Files);
    for ( gfi = 0; gfi < gpxFiles.count(); gfi++) {

      // Remove table
      QString trackTableName = hikeEntryKey + ".track" + QString(gfi + 1);
      _removeSettings(trackTableName);

      // Remove file
      QFile::remove(gpxFiles[gfi]);

      // Copy file

      // Create table
    }
  }

  else {
    dd->mkdir(hikeSubdir);
  }
  // Add tracks
  qDebug() << "hike tracks:" << hikeSubdir;

  hikeSubdir = QString(hikeDir + "/Photos");
  dd = new QDir(hikeSubdir);
  if ( ! dd->exists() ) dd->mkdir(hikeSubdir);
  qDebug() << "hike photos:" << hikeSubdir;

  hikeSubdir = hikeDir + "/Notes";
  dd = new QDir(hikeSubdir);
  if ( ! dd->exists() ) dd->mkdir(hikeSubdir);
  qDebug() << "hike notes:" << hikeSubdir;

  hikeSubdir = hikeDir + "/Features";
  dd = new QDir(hikeSubdir);
  if ( ! dd->exists() ) dd->mkdir(hikeSubdir);
  qDebug() << "hike features:" << hikeSubdir;

}

// ----------------------------------------------------------------------------
void Config::_removeSettings(QString group) {
  QSettings settings;
  settings.remove(group);
}
