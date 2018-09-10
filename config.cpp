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
void Config::setSetting( QString name, QString value) {

  qDebug() << "name: " << name << ", value: " << value;
  QSettings settings;
  settings.setValue( name, value);
}

// ----------------------------------------------------------------------------
QString Config::getSetting(QString name) {

  QSettings settings;
  qDebug() << "return value for name: " << name << ", value: " << settings.value(name).toString();
  return settings.value(name).toString();
}

