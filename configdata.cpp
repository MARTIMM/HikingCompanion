#include "singleton.h"
#include "configdata.h"

#include <QDebug>

// ----------------------------------------------------------------------------
// See also http://blog.qt.io/blog/2017/12/01/sharing-files-android-ios-qt-app/
// to use Q_OS_IOS, Q_OS_ANDROID etc.
// ----------------------------------------------------------------------------
ConfigData::ConfigData(QObject *parent) : QObject(parent) {

  // get properties ready
  readProperties();

  // get the gpxManager ready
  //_gpxManager = new GpxManager();
  //_gpxManager->setGpxPath("/home/marcel/Projects/Mobile/Projects/Sufitrail/Qt/Sufitrail/trackData/tracks");

  // See also http://doc.qt.io/qt-5/qguiapplication.html#platformName-prop
  // For me it could be: android, ios or xcb (x11 on linux)
  //qDebug() << "platform name: " << app.platformName();

  //_osType = QString(app.platformName());
}

// ----------------------------------------------------------------------------
ConfigData *ConfigData::instance() {
  return Singleton<ConfigData>::instance(ConfigData::_createInstance);
}

// ----------------------------------------------------------------------------
ConfigData *ConfigData::_createInstance() {
  return new ConfigData;
}

// ----------------------------------------------------------------------------
QString ConfigData::osType() {
  return _osType;
}

/*
// ----------------------------------------------------------------------------
QGuiApplication *ConfigData::appObject() {
  return _appObject;
}

// ----------------------------------------------------------------------------
void ConfigData::setAppObject(QGuiApplication *appObject) {
  _appObject = appObject;  //qobject_cast<QApplication *>(appObjectPtr);
}
*/

// ----------------------------------------------------------------------------
QString ConfigData::username() {
  return _username;
}

// ----------------------------------------------------------------------------
void ConfigData::setUsername(const QString username) {

  if ( _username != username ) {
    _username = username;

    QSettings settings;
    settings.setValue( "user/username", username);
  }
}

// ----------------------------------------------------------------------------
QString ConfigData::email() {
  return _email;
}

// ----------------------------------------------------------------------------
void ConfigData::setEmail(const QString email) {

  if ( _email != email ) {
    _email = email;
  }

  QSettings settings;
  settings.setValue( "user/email", email);
}

// ----------------------------------------------------------------------------
int ConfigData::language() {
  return _language;
}

// ----------------------------------------------------------------------------
void ConfigData::setLanguage(const int language) {
  qDebug()  << "language: " << language;
  if ( _language != language ) {
    _language = language;
  }

  QSettings settings;
  settings.setValue( "sys/language", language);
}


// ----------------------------------------------------------------------------
bool ConfigData::readProperties() {

  // Look for settings
  QSettings settings;
  if ( settings.contains("user/username") ) {
    _username = settings.value("user/username").toString();
  }

  if ( settings.contains("user/email") ) {
    _email = settings.value("user/email").toString();
  }

  if ( settings.contains("sys/language") ) {
    _language = settings.value("sys/language").toInt();
  }

  else {
    _language = 0;
  }


  // Process language setting
  if ( _language == 0 ) {

  }

  return true;
}

// ----------------------------------------------------------------------------
GpxManager *ConfigData::gpxManager() {

  return _gpxManager;
}
