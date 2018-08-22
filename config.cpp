#include "config.h"
#include "configdata.h"

#include <QDebug>

// ----------------------------------------------------------------------------
// See also http://blog.qt.io/blog/2017/12/01/sharing-files-android-ios-qt-app/
// to use Q_OS_IOS, Q_OS_ANDROID etc.
// ----------------------------------------------------------------------------
Config::Config(QObject *parent) : QObject(parent) {

  _gpxManager = new GpxManager();

  // See also http://doc.qt.io/qt-5/qguiapplication.html#platformName-prop
  // For me it could be: android, ios or xcb (x11 on linux)
  //qDebug() << "platform name: " << app.platformName();

  //_osType = QString(app.platformName());
}

// ----------------------------------------------------------------------------
QString Config::osType() {

  ConfigData *c = ConfigData::instance();
  return c->osType();
}

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

  ConfigData *c = ConfigData::instance();
  return c->username();
}

// ----------------------------------------------------------------------------
void Config::setUsername(const QString username) {

  ConfigData *c = ConfigData::instance();

  if ( c->username() != username ) {
    c->setUsername(username);
    emit usernameChanged();
  }
}

// ----------------------------------------------------------------------------
QString Config::email() {

  ConfigData *c = ConfigData::instance();
  return c->email();
}

// ----------------------------------------------------------------------------
void Config::setEmail(const QString email) {

  ConfigData *c = ConfigData::instance();

  if ( c->email() != email ) {
    c->setEmail(email);
    emit emailChanged();
  }
}

// ----------------------------------------------------------------------------
int Config::language() {

  ConfigData *c = ConfigData::instance();
  return c->language();
}

// ----------------------------------------------------------------------------
void Config::setLanguage(const int language) {

  ConfigData *c = ConfigData::instance();

  if ( c->language() != language ) {
    c->setLanguage(language);
    emit languageChanged();
  }
}


// ----------------------------------------------------------------------------
// emit all property signals so as to force listeners to update their data
bool Config::readProperties() {

  emit usernameChanged();
  emit emailChanged();
  emit languageChanged();

  return true;
}

// ----------------------------------------------------------------------------
QString *Config::readLanguageList() {

  _langArray[0] = "a";
  _langArray[1] = "b";
  return _langArray;
}

