#ifndef HIKES_H
#define HIKES_H

#include <QObject>
#include <QVariantList>
#include <QList>
#include <QGeoCoordinate>
#include <QGeoPath>

// ----------------------------------------------------------------------------
class Hikes : public QObject {

  Q_OBJECT

public:
  explicit Hikes(QObject *parent = nullptr);

  void defineHikeList();
  QStringList hikeList();
  QVariantList trackList();
  void loadCoordinates(int index);


  inline QString description() { return _description; }

  inline QList<QObject *> gpxFileList() { return _gpxFileList; }
  inline QVariantList gpxTrackList() { return _gpxTrackList; }

  inline QGeoPath coordinateList() { return QGeoPath(_coordinateList); }
  inline QGeoPath boundary() { return QGeoPath(_boundary); }

signals:

public slots:

private:
  //void _setGpxFiles();

  QList<QObject *> _gpxFileList;
//TODO track list not needed, remove
  QVariantList _gpxTrackList;
  QString _gpxPath;
  QString _description;

  // title => hike table name. titles from the tables are shown in the drop
  // list and after selection it must be used to find the table.
  QStringList _hikeList;
  QVariantList _trackList;

  QList<QGeoCoordinate> _coordinateList;
  QList<QGeoCoordinate> _boundary;
};

#endif // HIKES_H
