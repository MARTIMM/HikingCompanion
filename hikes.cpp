#include "hikes.h"
#include "config.h"

#include <QDebug>

// ----------------------------------------------------------------------------
Hikes::Hikes(QObject *parent) : QObject(parent) { }

// ----------------------------------------------------------------------------
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

  emit hikeListDefined();
}

// ----------------------------------------------------------------------------
QStringList Hikes::hikeList() {

  return _hikeList;
}

// ----------------------------------------------------------------------------
QVariantList Hikes::trackList() {

  Config *cfg = new Config();
  _trackList.clear();

  QString entryKey = cfg->hikeEntryKey();
  QString tableName = cfg->hikeTableName(entryKey);
  int ntracks = cfg->getSetting(tableName + "/ntracks").toInt();
  for ( int ni = 0; ni < ntracks; ni++) {
    QString tracksTableName = cfg->tracksTableName( tableName, ni);
    _trackList.append(cfg->getSetting(tracksTableName + "/title"));
  }

  return _trackList;
}
