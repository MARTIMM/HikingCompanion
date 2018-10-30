#ifndef GPXFILES_H
#define GPXFILES_H

#include "gpxfile.h"

#include <QDebug>
#include <QObject>
#include <QVariantList>
#include <QList>
#include <QGeoCoordinate>
#include <QGeoPath>

class GpxFiles : public QObject {

  Q_OBJECT
  Q_PROPERTY( QString description READ description)

public:
  inline explicit GpxFiles(QObject *parent = nullptr) : QObject(parent) { }
  ~GpxFiles() {
    _gpxFileList.clear();
    _gpxTrackList.clear();
  }

  inline QString description() { return _description; }

  inline Q_INVOKABLE QList<QObject *> gpxFileList() { return _gpxFileList; }
  inline Q_INVOKABLE QVariantList gpxTrackList() { return _gpxTrackList; }

  inline Q_INVOKABLE QGeoPath coordinateList() { return QGeoPath(_coordinateList); }
  inline Q_INVOKABLE QGeoPath boundary() { return QGeoPath(_boundary); }

  Q_INVOKABLE void loadCoordinates(int index);

signals:
  void coordinatesReady();

public slots:

private:
  //void _setGpxFiles();

  QList<QObject *> _gpxFileList;
//TODO track list not needed, remove
  QVariantList _gpxTrackList;
  QString _gpxPath;
  QString _description;

  QList<QGeoCoordinate> _coordinateList;
  QList<QGeoCoordinate> _boundary;
};

#endif // GPXFILES_H
