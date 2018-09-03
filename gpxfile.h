#ifndef GPXFILE_H
#define GPXFILE_H

#include <QObject>
#include <QXmlStreamReader>
#include <QGeoCoordinate>

// ----------------------------------------------------------------------------
class GpxFile : public QObject {

  Q_OBJECT
  Q_PROPERTY( QString name READ name CONSTANT)

public:
  explicit GpxFile(QObject *parent = nullptr);

  QString gpxFilename();
  QString setGpxFilename( QString gpxPath, QString gpxFilename);

  QString name();

  QList<QGeoCoordinate> coordinateList();

signals:

public slots:

private:
  QString _gpxFilename;
  QString _gpxPath;
  QString _name;

  QString _parseMetadata(QXmlStreamReader &xml);
  void _parseTrackdata(QXmlStreamReader &xml);
};

#endif // GPXFILE_H
