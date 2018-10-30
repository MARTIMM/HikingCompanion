#include "hikes.h"
#include "gpxfile.h"
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

// ----------------------------------------------------------------------------
void Hikes::loadCoordinates(int index) {

  qDebug() << "get coordinates from selected index: " << index;

  Config *cfg = new Config();
  QString entryKey = cfg->hikeEntryKey();
  QString tableName = cfg->hikeTableName(entryKey);
  QString tracksTableName = cfg->tracksTableName( tableName, index);

  QString hikeName = cfg->getSetting("HikeList/" + entryKey);
  QString gpxFile =
      cfg->dataDir() + "/" + hikeName + "/Tracks/" +
      cfg->getSetting(tracksTableName + "/fname");

  _coordinateList = GpxFile::coordinateList(gpxFile);
  qDebug() << _coordinateList.count() << " coordinates found";
  _boundary = GpxFile::boundary(_coordinateList);
  qDebug() << _boundary.count() << " boundaries set";

  //emit coordinatesReady();
}
/*
// ----------------------------------------------------------------------------
void Hikes::_setGpxFiles() {

  _gpxFileList.clear();
  _gpxTrackList.clear();

  // Read directory and select gpx files. Create a GpxFile object with it
  // and append to _gpxFileList
  qDebug() << "Path: " << _gpxPath;
  QRegExp rx("\\.gpx$");

  QStringList filters = { "*.gpx" };
  QDir d(_gpxPath);
  d.setNameFilters(filters);
  d.setSorting(QDir::Name);

  QStringList fnames = d.entryList(QDir::Files);
  for ( int i = 0; i < fnames.size(); i++ ) {
    GpxFile *gf = new GpxFile();
    QString description = gf->setGpxFilename( _gpxPath, fnames[i]);
    if ( _description == nullptr && description.length() > 0 ) {
      _description = description;
    }

    _gpxFileList.append(gf);
    _gpxTrackList.append(gf->name());
  }
}
*/
