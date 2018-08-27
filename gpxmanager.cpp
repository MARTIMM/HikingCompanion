#include "gpxmanager.h"

#include <QDebug>
#include <QRegExp>
#include <QDir>
#include <QFile>

/*
// ----------------------------------------------------------------------------
GpxManager::GpxManager(QObject *parent) : QObject(parent) {

  _clearGpxFileList();
}

// ----------------------------------------------------------------------------
int GpxManager::nbrGpxFiles() {

  return _gpxFileList.count();
}

// ----------------------------------------------------------------------------
QString GpxManager::gpxPath() {

  return _gpxPath;
}
*/

// ----------------------------------------------------------------------------
void GpxManager::setGpxPath(QString path) {

//  _gpxPath = path;
  if ( _gpxFiles != nullptr ) delete _gpxFiles;
  _gpxFiles = new GpxFiles(path);

//TODO test path

/*
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
    // qDebug() << "Track: " << gf->trackName();
  }

  _gpxDescr = _gpxFileList.at(0)->gpxDescr();
  qDebug() << "Found" << nbrGpxFiles() << "tracks for" << _gpxDescr;
*/
}
/*
// ----------------------------------------------------------------------------
QList<GpxFiles *> GpxManager::gpxFileList() {
  return _gpxFiles;
}
*/
/*
// ----------------------------------------------------------------------------
QQmlListProperty<GpxFile *> GpxManager::gpxFileList() {

  return _gpxFileList;
}

// ----------------------------------------------------------------------------
void GpxManager::setGpxFileList(QQmlListProperty<GpxFile *> gpxFileList) {

  _gpxFileList = gpxFileList;
}
*/

/*
// ----------------------------------------------------------------------------
void GpxManager::_clearGpxFileList() {

  _gpxFileList.clear();
}

// ----------------------------------------------------------------------------
void GpxManager::_appendGpxFile(GpxFile *gpxFile) {

  _gpxFileList.append(gpxFile);
}

// ----------------------------------------------------------------------------
QVector<GpxFile *> GpxManager::gpxFileList() {

  return _gpxFileList;
}
*/
