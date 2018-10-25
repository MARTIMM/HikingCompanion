#include "singleton.h"
#include "configdata.h"

#include <QDebug>

// ----------------------------------------------------------------------------
// See also http://blog.qt.io/blog/2017/12/01/sharing-files-android-ios-qt-app/
// to use Q_OS_IOS, Q_OS_ANDROID etc.
// ----------------------------------------------------------------------------
ConfigData::ConfigData(QObject *parent) : QObject(parent) {

}

// ----------------------------------------------------------------------------
ConfigData *ConfigData::instance() {
  return Singleton<ConfigData>::instance(ConfigData::_createInstance);
}

// ----------------------------------------------------------------------------
ConfigData *ConfigData::_createInstance() {
  return new ConfigData;
}
