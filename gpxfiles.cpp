#include "gpxfiles.h"

#include <QDebug>
#include <QDir>
#include <QFile>

// ----------------------------------------------------------------------------
GpxFiles::GpxFiles( QString path, QObject *parent) : QObject(parent) {

//TODO test path
  _gpxPath = path;

  qDebug() << "Path: " << path;
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
    // qDebug() << fname;

    GpxFile *gf = new GpxFile();
    gf->setGpxFilename( _gpxPath, fname);
    _appendGpxFile(gf);
    qDebug() << "Track: " << gf->name();
  }

  _gpxDescr = _gpxFileList.at(0)->description();
  qDebug() << "Found" << nbrGpxFiles() << "tracks for" << _gpxDescr;

}

// ----------------------------------------------------------------------------
GpxFiles::~GpxFiles() {
  _gpxFileList.clear();
}

// ----------------------------------------------------------------------------
int GpxFiles::nbrGpxFiles() {

  return _gpxFileList.count();
}

// ----------------------------------------------------------------------------
QList<GpxFile *> GpxFiles::gpxFileList() {
  return _gpxFileList;
}

// ----------------------------------------------------------------------------
void GpxFiles::_clearGpxFileList() {

  _gpxFileList.clear();
}

// ----------------------------------------------------------------------------
void GpxFiles::_appendGpxFile(GpxFile *gpxFile) {

  _gpxFileList.append(gpxFile);
}
