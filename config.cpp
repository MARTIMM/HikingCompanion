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

