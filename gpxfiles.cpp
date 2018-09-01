#include "gpxfiles.h"

#include <QDebug>
#include <QDir>
#include <QFile>

// ----------------------------------------------------------------------------
GpxFiles::GpxFiles( QObject *parent) : QObject(parent) {

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
QString GpxFiles::description() {
  return _description;
}

// ----------------------------------------------------------------------------
bool GpxFiles::readGpxFileInfo(QString path) {

//TODO test path
  _gpxPath = path;

  _setGpxFiles();
  emit gpxFileListChanged();

  return true;
}

// ----------------------------------------------------------------------------
void GpxFiles::_setGpxFiles() {

  _gpxFileList.clear();
  _gpxTrackList.clear();

  // Read directory and select gpx files. Create a GpxFile object with it
  // and append to _gpxFileList
  qDebug() << "Path: " << _gpxPath;
  QRegExp rx("\\.gpx$");

  QStringList filters = { "*.gpx" };
  QDir d (_gpxPath);
  d.setNameFilters(filters);
  d.setSorting(QDir::Name);

  QStringList fnames = d.entryList();
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
