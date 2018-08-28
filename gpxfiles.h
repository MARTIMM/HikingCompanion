#ifndef GPXFILES_H
#define GPXFILES_H

#include "gpxfile.h"

#include <QObject>
#include <QVariantList>

// Hè hè, finally someone with a working suggestion:
// https://forum.qt.io/topic/43226/solved-qml-combobox-model-from-c/2

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

public:
  explicit GpxFiles(QObject *parent = nullptr);
  ~GpxFiles();

  //Q_INVOKABLE QVariantList gpxFileList();
  Q_INVOKABLE QList<GpxFile *> gpxFileList();
  Q_INVOKABLE QVariantList gpxTrackList();
  int nbrGpxFiles();
  bool readGpxFileInfo();

signals:
  void gpxFileListChanged();

public slots:

private:
  void _clearGpxFileList();
  void _appendGpxFile(GpxFile *gpxFile);
  void _setGpxFiles();

  QList<GpxFile *> _gpxFileList;
  QVariantList _gpxTrackList;
  QString _gpxPath;
  QString _gpxDescr;
};

#endif // GPXFILES_H
