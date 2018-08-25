#ifndef GPXFILE_H
#define GPXFILE_H

#include <QObject>
#include <QXmlStreamReader>

// ----------------------------------------------------------------------------
class GpxFile : public QObject {

  Q_OBJECT
//  Q_PROPERTY( QString gpxDescr READ gpxDescr)
//  Q_PROPERTY( QString trackName READ trackName)

public:
  explicit GpxFile(QObject *parent = nullptr);

  QString gpxFilename();
  void setGpxFilename( QString gpxPath, QString gpxFilename);

  QString gpxDescr();
  QString trackName();

signals:

public slots:

private:
  QString _gpxFilename;
  QString _gpxPath;
  QString _gpxDescr;
  QString _trackName;

  void _parseMetadata(QXmlStreamReader &xml);
  void _parseTrackdata(QXmlStreamReader &xml);
};

#endif // GPXFILE_H
