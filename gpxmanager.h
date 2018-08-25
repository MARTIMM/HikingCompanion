#ifndef GPXMANAGER_H
#define GPXMANAGER_H
/*
 * Manager reads a given directory for gpx data stored in files. These files
 * are appended to a list. This list is shown on the qml tracksPage. Clicking
 * on a track from the list will set the current track in the manager and
 * in the Config object. The manager will read the data and hand the data
 * over to the mapPage.
 *
 * The gpx path will be provided by the Config class.
*/
#include "gpxfile.h"

#include <QObject>
#include <QQmlListProperty>
#include <QVector>

// ----------------------------------------------------------------------------
class GpxManager : public QObject {
  Q_OBJECT
/*
  Q_PROPERTY(
      QString gpxPath READ gpxPath WRITE
      setGpxPath NOTIFY gpxPathChanged
      )
  Q_PROPERTY( int nbrGpxFiles READ nbrGpxFiles)
*/
/*
  Q_PROPERTY(
      QQmlListProperty<GpxFile *> gpxFileList READ gpxFileList
      WRITE setGpxFileList NOTIFY gpxFileListChanged
      )
*/

public:
  explicit GpxManager(QObject *parent = nullptr);

  QString gpxPath();
  void setGpxPath(QString path);

  int nbrGpxFiles();
  QString gpxDescr();
  QVector<GpxFile *> gpxFileList();

  //QQmlListProperty<GpxFile *> gpxFileList();
  //void setGpxFileList(QQmlListProperty<GpxFile *> *gpxFileList);

signals:
  void gpxPathChanged();
  void gpxFileListChanged();

public slots:

private:
  QString _currentGpxFile;
  QString _gpxPath;
  QString _gpxDescr;

  QVector<GpxFile *> _gpxFileList;

  void _clearGpxFileList();
  void _appendGpxFile(GpxFile *gpxFile);
};

#endif // GPXMANAGER_H
