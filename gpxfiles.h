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
  Q_PROPERTY( bool readGpxFileInfo READ readGpxFileInfo)
  Q_PROPERTY( QString description READ description)

public:
  explicit GpxFiles(QObject *parent = nullptr);
  ~GpxFiles();

  //Q_INVOKABLE QVariantList gpxFileList();
  Q_INVOKABLE QList<QObject *> gpxFileList();
  Q_INVOKABLE QVariantList gpxTrackList();
  Q_INVOKABLE void loadCoordinates(int index);
  Q_INVOKABLE QGeoPath coordinateList();
//  int nbrGpxFiles();

//TODO: must come from ConfigData
  bool readGpxFileInfo(QString path = "/home/marcel/Projects/Mobile/Projects/Sufitrail/Qt/Sufitrail/trackData/tracks");

  QString description();

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
};

#endif // GPXFILES_H
