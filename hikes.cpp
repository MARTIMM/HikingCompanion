#include "hikes.h"
#include "config.h"

#include <QDebug>
#include <QApplication>
#include <QFont>

// ----------------------------------------------------------------------------
Hikes::Hikes(QObject *parent) : QObject(parent) { }

// ----------------------------------------------------------------------------
// Get information about hikes directly from the configuration in
// the HikeList table
void Hikes::defineHikeList() {

  Config *cfg = new Config();

  // Get all entries from the hike list
  _hikeList.clear();
  QStringList hikeKeys = cfg->readKeys("HikeList");
  qDebug() << "Hike keys:" << hikeKeys;

  for ( int hi = 0; hi < hikeKeys.count(); hi++) {
    QString hikeKey = hikeKeys[hi];
    QString hikeKeyTable = QString("h%1").arg(hi) +
        "." + cfg->getSetting("HikeList/" + hikeKey);
    qDebug() << "Key and table:" << hikeKey << hikeKeyTable;
    _hikeList.append(cfg->getSetting(hikeKeyTable + "/title"));
  }

  // Emit signal that list is ready
  emit hikeListDefined();
}

// ----------------------------------------------------------------------------
QStringList Hikes::hikeList() {

  // Return the hike list
  return _hikeList;
}

// ----------------------------------------------------------------------------
// Create a list of tracks directly from the configuration using the
// Track# tables. The list shows the title of each entry from each table.
QVariantList Hikes::trackList() {

  Config *cfg = new Config();
  _trackList.clear();

  QString entryKey = cfg->hikeEntryKey();
  QString tableName = cfg->hikeTableName(entryKey);
  int ntracks = cfg->getSetting(tableName + "/ntracks").toInt();

  for ( int ni = 0; ni < ntracks; ni++) {
    QString trackLine;
    QString tracksTableName = cfg->tracksTableName( tableName, ni);

    qDebug() << "Default font" << qApp->font().family();

    // Get the type of walk, (W) walking, (B) biking or (?) bij rocket ;-)
    QString trackInfo = cfg->getSetting(tracksTableName + "/type");
    if ( trackInfo == "W" ) {
      trackLine = "\U0001F6B6 ";
    }

    else if ( trackInfo == "B" ) {
      trackLine = "\U0001F6B2 ";
    }

    else {
      trackLine = "\U0001F462 ";
    }

    // Get the length of this track
    trackInfo = cfg->getSetting(tracksTableName + "/length");
    if ( trackInfo == "" ) {
      trackLine += " - km, ";
    }
    else {
      trackLine += trackInfo + " km, ";
    }

    // Finally add the track title
    trackLine += cfg->getSetting(tracksTableName + "/title");
    _trackList.append(trackLine);
  }

  return _trackList;
}
