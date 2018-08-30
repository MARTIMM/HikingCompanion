#include "gpxfiles.h"

#include <QDebug>
#include <QDir>
#include <QFile>

// ----------------------------------------------------------------------------
GpxFiles::GpxFiles( QObject *parent) : QObject(parent) {

//TODO test path
//  _gpxPath = path;
//  _setGpxFiles();
}

// ----------------------------------------------------------------------------
GpxFiles::~GpxFiles() {
  _gpxFileList.clear();
  _gpxTrackList.clear();
}

// ----------------------------------------------------------------------------
int GpxFiles::nbrGpxFiles() {

  return _gpxFileList.count();
}

// ----------------------------------------------------------------------------
QList<QObject *> GpxFiles::gpxFileList() {

  qDebug() << "gpx file list: " << _gpxFileList.count() << "members";
  return _gpxFileList;
}

// ----------------------------------------------------------------------------
QVariantList GpxFiles::gpxTrackList() {

  qDebug() << "gpx track list: " << _gpxTrackList.count() << "members";
  return _gpxTrackList;
}

// ----------------------------------------------------------------------------
bool GpxFiles::readGpxFileInfo() {

  _setGpxFiles();
  emit gpxFileListChanged();

  return true;
}

// ----------------------------------------------------------------------------
void GpxFiles::_clearGpxFileList() {

  _gpxFileList.clear();
}

// ----------------------------------------------------------------------------
void GpxFiles::_appendGpxFile(GpxFile *gpxFile) {

  _gpxFileList.append(gpxFile);
}

// ----------------------------------------------------------------------------
void GpxFiles::_setGpxFiles() {

//TODO test path
  //_gpxPath = path;

  _gpxFileList.clear();
  _gpxTrackList.clear();

  _gpxPath = "/home/marcel/Projects/Mobile/Projects/Sufitrail/Qt/Sufitrail/trackData/tracks";

  qDebug() << "Path: " << _gpxPath;
  // Read directory and select gpx files. Create a GpxFile object with it
  // and append to _gpxFileList

  QRegExp rx("\\.gpx$");

  QStringList filters = { "*.gpx" };
  QDir d (_gpxPath);
  d.setNameFilters(filters);
  d.setSorting(QDir::Name);
  QStringList fnames = d.entryList();
  for ( int i = 0; i < fnames.size(); i++ ) {
    QString fname = fnames[i];
//    qDebug() << fname;

    GpxFile *gf = new GpxFile();
    gf->setGpxFilename( _gpxPath, fname);
//    _appendGpxFile(gf);
    _gpxFileList.append(gf);
//    qDebug() << "Track: " << gf->name();

    _gpxTrackList.append(gf->name());
//    qDebug() << "T: " << _gpxTrackList.count() << ", " << gf->name();
  }

  //_gpxDescr = _gpxFileList.at(0)->description();
  //qDebug() << "Found" << nbrGpxFiles() << "tracks for" << _gpxDescr;

//  emit gpxFileListChanged();
}
