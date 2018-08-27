#ifndef GPXFILES_H
#define GPXFILES_H

#include "gpxfile.h"

#include <QObject>

class GpxFiles : public QObject {

  Q_OBJECT
  Q_PROPERTY( QList<GpxFile *> gpxFileList READ gpxFileList)

public:
  explicit GpxFiles(
      QString path = "/home/marcel/Projects/Mobile/Projects/Sufitrail/Qt/Sufitrail/trackData/tracks",
      QObject *parent = nullptr
      );
  ~GpxFiles();

  QList<GpxFile *> gpxFileList();
  //QVector<GpxFile *> gpxFileList();
  int nbrGpxFiles();

signals:

public slots:

private:
  void _clearGpxFileList();
  void _appendGpxFile(GpxFile *gpxFile);

  QList<GpxFile *> _gpxFileList;
  QString _gpxPath;
  QString _gpxDescr;
};

#endif // GPXFILES_H
