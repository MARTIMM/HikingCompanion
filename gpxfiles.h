#ifndef GPXFILES_H
#define GPXFILES_H

#include "gpxfile.h"

#include <QObject>
#include <QVariantList>
#include <QList>
#include <QGeoCoordinate>
#include <QGeoPath>

class GpxFiles : public QObject {

  Q_OBJECT
  Q_PROPERTY( QString description READ description)

public:
  explicit GpxFiles(QObject *parent = nullptr);
  ~GpxFiles();

//TODO: path must come from ConfigData
  Q_INVOKABLE void readGpxFileInfo(QString path = "/home/marcel/Projects/Mobile/Projects/Sufitrail/Qt/Sufitrail/trackData/tracks");
  QString description();

  Q_INVOKABLE QList<QObject *> gpxFileList();
  Q_INVOKABLE QVariantList gpxTrackList();
  Q_INVOKABLE void loadCoordinates(int index);
  Q_INVOKABLE QGeoPath coordinateList();
  Q_INVOKABLE QGeoPath boundary();

signals:
  void gpxFileListReady();
  void coordinatesReady();

public slots:

private:
  void _setGpxFiles();

  QList<QObject *> _gpxFileList;
//TODO track list not needed, remove
  QVariantList _gpxTrackList;
  QString _gpxPath;
  QString _description;

  QList<QGeoCoordinate> _coordinateList;
  QList<QGeoCoordinate> _boundary;
};

#endif // GPXFILES_H
