#include "gpxfiles.h"
#include "config.h"

#include <QDebug>
#include <QDir>
//#include <QFile>

/*
// ----------------------------------------------------------------------------
void GpxFiles::_setGpxFiles() {

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

// ----------------------------------------------------------------------------
void GpxFiles::loadCoordinates(int index) {

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

  emit coordinatesReady();
}
