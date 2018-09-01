#ifndef GPXFILES_H
#define GPXFILES_H

#include "gpxfile.h"

#include <QObject>
#include <QVariantList>
#include <QList>

class GpxFiles : public QObject {

  Q_OBJECT
  /*
  Q_PROPERTY(
      QVariantList gpxFileList
      READ gpxFileList
      NOTIFY gpxFileListChanged
      )
  */
  Q_PROPERTY( bool readGpxFileInfo READ readGpxFileInfo)
  Q_PROPERTY( QString description READ description)

public:
  explicit GpxFiles(QObject *parent = nullptr);
  ~GpxFiles();

  //Q_INVOKABLE QVariantList gpxFileList();
  Q_INVOKABLE QList<QObject *> gpxFileList();
  Q_INVOKABLE QVariantList gpxTrackList();
  int nbrGpxFiles();

//TODO: must come from ConfigData
  bool readGpxFileInfo(QString path = "/home/marcel/Projects/Mobile/Projects/Sufitrail/Qt/Sufitrail/trackData/tracks");

  QString description();

signals:
  void gpxFileListChanged();

public slots:

private:
  void _setGpxFiles();

  QList<QObject *> _gpxFileList;
  QVariantList _gpxTrackList;
  QString _gpxPath;
  QString _description;
};

#endif // GPXFILES_H
