#include "config.h"

// ----------------------------------------------------------------------------
/* Null, because instance will be initialized on demand. */
//Config* Config::_instance = nullptr;

// ----------------------------------------------------------------------------
Config::Config(QObject *parent) : QObject(parent) {
  _osType = QString("unknown");

  qDebug() << "KernelType: " << QSysInfo::kernelType();
  qDebug() << "productType: " << QSysInfo::productType();

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

/*
// ----------------------------------------------------------------------------
Config *Config::instance() {
  if ( _instance == nullptr ) {
    _instance = new Config;
  }

  return _instance;
}
*/

// ----------------------------------------------------------------------------
QString Config::osType() {
  return _osType;
}

