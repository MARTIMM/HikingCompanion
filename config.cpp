#include "config.h"
#include "configdata.h"
#include "gpxfile.h"

#include <QDebug>
#include <QApplication>
#include <QDir>
#include <QFile>
#include <QStandardPaths>
#include <QRegExp>

// ----------------------------------------------------------------------------
Config::Config(QObject *parent) : QObject(parent) { }

// ----------------------------------------------------------------------------
QString Config::dataDir() {
  return ConfigData::instance()->dataDir();
}

// ----------------------------------------------------------------------------
QString Config::dataShareDir() {
  return ConfigData::instance()->dataShareDir();
}

// ----------------------------------------------------------------------------
void Config::checkForNewHikeData() {
  ConfigData::instance()->checkForNewHikeData();
}

// ----------------------------------------------------------------------------
void Config::cleanupTracks() {
  ConfigData::instance()->cleanupTracks();
}

// ----------------------------------------------------------------------------
void Config::cleanupHike() {
  ConfigData::instance()->cleanupHike();
}

// ----------------------------------------------------------------------------
// Set only new string values to this applications config settings
void Config::setSetting( QString name, QString value ) {
  ConfigData::instance()->setSetting( name, value);
}

// ----------------------------------------------------------------------------
// Set only new integer values to this applications config settings
void Config::setSetting( QString name, int value ) {
  ConfigData::instance()->setSetting( name, value);
}

// ----------------------------------------------------------------------------
// Read values from this applications config settings or external config
QString Config::getSetting( QString name, QSettings *s ) {
  return ConfigData::instance()->getSetting( name, s);
}

// ----------------------------------------------------------------------------
// Read keys from this applications config settings or external config
QStringList Config::readKeys( QString group, QSettings *s ) {
  return ConfigData::instance()->readKeys( group, s);
}

// ----------------------------------------------------------------------------
QString Config::hikeEntryKey() {
  return ConfigData::instance()->hikeEntryKey();
}

// ----------------------------------------------------------------------------
QString Config::hikeTableName( QString hikeEntryKey ) {
  return ConfigData::instance()->hikeTableName(hikeEntryKey);
}

// ----------------------------------------------------------------------------
QString Config::tracksTableName( QString hikeTableName, int trackCount) {
  return ConfigData::instance()->tracksTableName( hikeTableName, trackCount);
}

// ----------------------------------------------------------------------------
void Config::setGpxFileIndexSetting( int currentIndex ) {
  ConfigData::instance()->setGpxFileIndexSetting(currentIndex);
}

// ----------------------------------------------------------------------------
int Config::getGpxFileIndexSetting() {
  return ConfigData::instance()->getGpxFileIndexSetting();
}

// ----------------------------------------------------------------------------
QString Config::getHtmlPageFilename( QString pageName) {
  return ConfigData::instance()->getHtmlPageFilename(pageName);
}

// ----------------------------------------------------------------------------
QString Config::getTheme( ) {
  return ConfigData::instance()->getTheme();
}

// ----------------------------------------------------------------------------
QString Config::getHCVersion() {
  return ConfigData::instance()->getHCVersion();
}

// ----------------------------------------------------------------------------
QStringList Config::getHikeVersions() {
  return ConfigData::instance()->getHikeVersions();
}

// ----------------------------------------------------------------------------
QStringList Config::getVersions() {
  return ConfigData::instance()->getVersions();
}

