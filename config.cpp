#include "config.h"
#include "configdata.h"
#include "gpxfile.h"

#include <QDebug>
#include <QQmlEngine>
#include <QQmlComponent>

// ----------------------------------------------------------------------------
// See also http://blog.qt.io/blog/2017/12/01/sharing-files-android-ios-qt-app/
// to use Q_OS_IOS, Q_OS_ANDROID etc.
// ----------------------------------------------------------------------------
Config::Config(QObject *parent) : QObject(parent) {

  // See also http://doc.qt.io/qt-5/qguiapplication.html#platformName-prop
  // For me it could be: android, ios or xcb (x11 on linux)
  //qDebug() << "platform name: " << app.platformName();

  //_osType = QString(app.platformName());
}
/*
// ----------------------------------------------------------------------------
QString Config::osType() {

  ConfigData *c = ConfigData::instance();
  return c->osType();
}
*/

/*
// ----------------------------------------------------------------------------
QGuiApplication *Config::appObject() {
  return _appObject;
}

// ----------------------------------------------------------------------------
void Config::setAppObject(QGuiApplication *appObject) {
  _appObject = appObject;  //qobject_cast<QApplication *>(appObjectPtr);
}
*/

// ----------------------------------------------------------------------------
QString Config::username() {

  QSettings settings;
  qDebug() << "return gpx f: " << settings.value("user/username");
  return settings.value( "user/username", "").toString();
}

// ----------------------------------------------------------------------------
void Config::setUsername(const QString username) {

  QSettings settings;
  settings.setValue( "user/username", username);
}

// ----------------------------------------------------------------------------
QString Config::email() {

  QSettings settings;
  qDebug() << "return gpx f: " << settings.value("user/email");
  return settings.value( "user/email", "").toString();
}

// ----------------------------------------------------------------------------
void Config::setEmail(const QString email) {

  QSettings settings;
  settings.setValue( "user/email", email);
}

// ----------------------------------------------------------------------------
int Config::languageIndex() {

  QSettings settings;
  qDebug() << "return gpx f: " << settings.value("sys/language");
  return settings.value( "sys/language", 0).toInt();
}

// ----------------------------------------------------------------------------
void Config::setLanguageIndex(const int index) {

  qDebug()  << "language: " << index;
  QSettings settings;
  settings.setValue( "sys/language", index);
}

// ----------------------------------------------------------------------------
int Config::gpxFileIndex() {
  QSettings settings;
  qDebug() << "return gpx f: " << settings.value("tracks/gpxFileIndex");
  return settings.value("tracks/gpxFileIndex").toInt();
}

// ----------------------------------------------------------------------------
void Config::setGpxFileIndex(int index) {

  qDebug()  << "gpx file index: " << index;
  QSettings settings;
  settings.setValue( "tracks/gpxFileIndex", index);
}
