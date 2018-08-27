#ifndef GPXFILE_H
#define GPXFILE_H

#include <QObject>
#include <QXmlStreamReader>

// ----------------------------------------------------------------------------
class GpxFile : public QObject {

  Q_OBJECT
  Q_PROPERTY( QString description READ description)
  Q_PROPERTY( QString name READ name)

public:
  explicit GpxFile(QObject *parent = nullptr);

  QString gpxFilename();
  void setGpxFilename( QString gpxPath, QString gpxFilename);

  QString description();
  QString name();

signals:

public slots:

private:
  QString _gpxFilename;
  QString _gpxPath;
  QString _description;
  QString _name;

  void _parseMetadata(QXmlStreamReader &xml);
  void _parseTrackdata(QXmlStreamReader &xml);
};

#endif // GPXFILE_H
