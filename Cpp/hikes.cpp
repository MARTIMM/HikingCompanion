#include "hikes.h"
#include "gpxfile.h"
#include "configdata.h"

#include <QDebug>
#include <QApplication>
#include <QFont>

// ----------------------------------------------------------------------------
//Hikes::Hikes(QObject *parent) : QObject(parent) { }

// ----------------------------------------------------------------------------
// Get information about hikes directly from the configuration in
// the HikeList table
void Hikes::defineHikeList() {

  ConfigData *cfg = ConfigData::instance();

  // Get all entries from the hike list
  _hikeList.clear();
  QStringList hikeKeys = cfg->readKeys("HikeList");
  //qDebug() << "Hike keys:" << hikeKeys;

  for ( int hi = 0; hi < hikeKeys.count(); hi++) {
    QString hikeKey = hikeKeys[hi];
    QString hikeKeyTable = QString("h%1").arg(hi) +
        "." + cfg->getSetting("HikeList/" + hikeKey);
    //qDebug() << "Key and table:" << hikeKey << hikeKeyTable;
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

  ConfigData *cfg = ConfigData::instance();
  _trackList.clear();

  QString entryKey = cfg->hikeEntryKey();
  QString tableName = cfg->hikeTableName(entryKey);
  int ntracks = cfg->getSetting(tableName + "/ntracks").toInt();

  for ( int ni = 0; ni < ntracks; ni++) {
    QString trackLine;
    QString tracksTableName = cfg->tracksTableName( tableName, ni);

    //qDebug() << "Default font" << qApp->font().family();

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
    if ( trackInfo == "" or trackInfo == "0" ) {
//    if ( true ) {
      QString hikeKey = cfg->getSetting("HikeList/" + entryKey);
      QString fname = cfg->getSetting(tracksTableName + "/fname");
      GpxFile *gf = new GpxFile();
      gf->setGpxFilename(
            cfg->dataDir() + "/" + hikeKey + "/Tracks/", fname
            );
      QList<QGeoCoordinate> coordinateList = gf->coordinateList();
//qDebug() << "nCoordinates:" << coordinateList.count();
      double length = gf->trackDistance(coordinateList) / 1000.0;
      trackInfo = QString("%1 km").arg( length, 8, 'f', 3);
      trackLine += trackInfo;
      cfg->setSetting( tracksTableName + "/length", trackInfo);
    }

    else {
      trackLine += trackInfo;
    }

    // Finally add the track title
    trackLine += ", " + cfg->getSetting(tracksTableName + "/title");
    _trackList.append(trackLine);
  }

  return _trackList;
}

// ----------------------------------------------------------------------------
void Hikes::loadCoordinates(int index) {

  //qDebug() << "get coordinates from selected index: " << index;

  ConfigData *cfg = ConfigData::instance();

  QString entryKey = cfg->hikeEntryKey();
  QString tableName = cfg->hikeTableName(entryKey);
  QString tracksTableName = cfg->tracksTableName( tableName, index);

  QString hikeName = cfg->getSetting("HikeList/" + entryKey);
  QString gpxFile =
      cfg->dataDir() + "/" + hikeName + "/Tracks/" +
      cfg->getSetting(tracksTableName + "/fname");

  _coordinateList = GpxFile::coordinateList(gpxFile);
  //qDebug() << _coordinateList.count() << " coordinates found";
  _boundary = GpxFile::boundary(_coordinateList);
  //qDebug() << _boundary.count() << " boundaries set";
}

// ----------------------------------------------------------------------------
QGeoCoordinate Hikes::findClosestPointOnRoute(QGeoCoordinate c) {

  // Check if there are coordinates
  if ( _coordinateList.count() == 0 ) return c;

  // Set to maximum possible here on earth about 40.075 km along
  // the eqator in metres.
  double minDist = 41000000.0;
  QGeoCoordinate cOfMinDist = _coordinateList[0];
  for ( int ci = 0; ci < _coordinateList.count(); ci++ ) {
    double d = c.distanceTo(_coordinateList[ci]);
    //qDebug() << "ci:" << ci << _coordinateList[ci] << d;
    if ( minDist > d ) {
      minDist = d;
      cOfMinDist = _coordinateList[ci];
    }
  }

  //qDebug() << "min distance:" << cOfMinDist;
  return cOfMinDist;
}

// ----------------------------------------------------------------------------
double Hikes::distanceToPointOnRoute( QGeoCoordinate c1, QGeoCoordinate c2) {
  return c1.distanceTo(c2);
/*
  return GpxFile::geoDistance(
        c1.longitude(), c1.latitude(),
        c2.longitude(), c2.latitude()
        );
*/
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