#include "config.h"

// ----------------------------------------------------------------------------
// See also http://blog.qt.io/blog/2017/12/01/sharing-files-android-ios-qt-app/
// to use Q_OS_IOS, Q_OS_ANDROID etc.
// ----------------------------------------------------------------------------
Config::Config(QObject *parent) : QObject(parent) {
  _osType = QString("unknown");

  QRegExp rx("\\.fc\\d*\\.");

  if ( QSysInfo::kernelType() == "winnt" ) {
    _osType = "windows";
  }

  else if ( QSysInfo::productType() == "fedora" /* || ... */) {
    _osType = "linux";
  }

  else if ( QSysInfo::productType() == "Android" ) {
    _osType = "android";
  }

  else if ( QSysInfo::productType() == "osx" ) {
    _osType = "mac";
  }

  else if ( QSysInfo::productType() == "ios" ) {
    _osType = "ios";
  }
}

// ----------------------------------------------------------------------------
QString Config::osType() {
  return _osType;
}

// ----------------------------------------------------------------------------
QString Config::username() {
  return _username;
}

// ----------------------------------------------------------------------------
QString Config::email() {
  return _email;
}

// ----------------------------------------------------------------------------
int Config::language() {
  return _language;
}

// ----------------------------------------------------------------------------
bool Config::emitIt() {
  return _emitIt;
}

// ----------------------------------------------------------------------------
/* emitIt should be false. From QML only the username can be given. So when
   called from the storage, emitIt can be set true to signal the QML components
   for the changes. Otherwise, set private var _emiIt first when other QML
   components must be informed from this QML component.
*/
void Config::setUsername( const QString username, const bool emitIt) {
qDebug() << "Username: " << username;
  if ( _username != username ) {
    _username = username;
    if ( emitIt or _emitIt ) {
      emit usernameChanged();
    }

    QSettings settings;
    settings.setValue( "user/username", username);
  }
}

// ----------------------------------------------------------------------------
void Config::setEmail( const QString email, const bool emitIt) {
  qDebug() << "Email: " << email;
  if ( _email != email ) {
    _email = email;
    if ( emitIt or _emitIt ) {
      emit emailChanged();
    }
  }

  QSettings settings;
  settings.setValue( "user/email", email);
}

// ----------------------------------------------------------------------------
void Config::setLanguage( const int language, const bool emitIt) {
  qDebug()  << "language: " << language;
  if ( _language != language ) {
    _language = language;
    if ( emitIt or _emitIt ) {
      emit languageChanged();
    }
  }

  QSettings settings;
  settings.setValue( "sys/language", language);
}

// ----------------------------------------------------------------------------
void Config::setEmitIt(const bool emitIt) {
  _emitIt = emitIt;
}

// ----------------------------------------------------------------------------
bool Config::readProperties() {

  // Look for settings
  QSettings settings;
  if ( settings.contains("user/username") ) {
    _username = settings.value("user/username").toString();
    emit usernameChanged();
  }

  if ( settings.contains("user/email") ) {
    _email = settings.value("user/email").toString();
    emit emailChanged();
  }

  if ( settings.contains("sys/language") ) {
    _language = settings.value("sys/language").toInt();
    emit languageChanged();
  }

  return true;
}
