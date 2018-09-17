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
void Hikes::defineTrackList() {

  // Get all entries from the hike list
  _trackList.clear();

  emit trackListDefined();
}

// ----------------------------------------------------------------------------
QStringList Hikes::trackList() {

  return _trackList;
}
