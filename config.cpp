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
  QString dataDir = QStandardPaths::standardLocations(
        QStandardPaths::GenericDataLocation
        ).first() + "/" + id;

  QDir dd(dataDir);
  if ( ! dd.exists() ) dd.mkdir(dataDir);

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
}

