#ifndef CONFIGDATA_H
#define CONFIGDATA_H

#include "hikes.h"

#include <QObject>
#include <QSettings>
#include <QJsonValue>

#define HIKING_COMPANION_VERSION "0.13.0"


class ConfigData : public QObject {
  Q_OBJECT

public:
  // This class is a singleton and the constructor should be private. Problem
  // is when registering to be usable from qml it must be public. Possibly
  // bypassing the singleton principle and create an object always.
  static ConfigData *instance();

  // language enumerations
  enum Languages {
    English, Nederlands
  };
  Q_ENUM(Languages)

  inline void defineHikeList() { _hikes->defineHikeList(); }
  inline QStringList hikeList() { return _hikes->hikeList(); }
  inline QVariantList trackList() { return _hikes->trackList(); }
  inline void loadCoordinates(int index) {
    return _hikes->loadCoordinates(index);
  }

  //inline QString description() { return _hikes->description(); }

  inline QList<QObject *> gpxFileList() { return _hikes->gpxFileList(); }
  inline QVariantList gpxTrackList() { return _hikes->gpxTrackList(); }

  inline QGeoPath coordinateList() { return _hikes->coordinateList(); }
  inline QGeoPath boundary() { return _hikes->boundary(); }

  inline QGeoCoordinate findClosestPointOnRoute(QGeoCoordinate c) {
    return _hikes->findClosestPointOnRoute(c);
  }

  inline double distanceToPointOnRoute( QGeoCoordinate c1, QGeoCoordinate c2) {
    return _hikes->distanceToPointOnRoute( c1, c2);
  }

  QString dataDir() { return _dataDir; }
  QString dataShareDir() { return _dataShareDir; }

  void checkForNewHikeData();
  void cleanupTracks();
  void cleanupHike();

  void setSetting( QString name, QString value);
  void setSetting( QString name, int value);
  QString getSetting(QString name, QSettings *s = nullptr);

  QStringList readKeys( QString group, QSettings *s = nullptr);
  QString hikeEntryKey(QString hikeKey = "");
  QString hikeTableName(QString hikeEntryKey);
  QString tracksTableName( QString hikeTableName, int trackCount);

  void setGpxFileIndexSetting(int currentIndex);
  int getGpxFileIndexSetting();

  QString getHtmlPageFilename( QString pageName);

  QString getTheme();

  QString getHCVersion();
  QStringList getHikeVersions();
  QStringList getVersions();

  inline int windowWidth() { return _width; }
  inline int windowHeight() { return _height; }
  void setWindowSize( int w, int h);

  void saveUserTrackNames( QString hikeTitle, QString hikeDesc, QString hikeKey);
  void saveUserTrack(
      QString trackTitle, QString trackDesc,
      QString hikeKey, QJsonValue coordinates
      );

signals:

public slots:

private:
  ConfigData(QObject *parent = nullptr);
  void _removeSettings(QString group);
  void _installNewData();
  void _mkNewTables( QSettings *s,  QString hikeTableName);
  void _refreshData( QSettings *s, QString hikeTableName, QString hikeDir);
  void _moveTable( QString fromTable, QString toTable);
  bool _mkpath(QString path);
  static ConfigData *_createInstance();

  QString _dataDir;       // Location where all hikes are stored
  QString _dataShareDir;  // Location where new data is placed to install

  QSettings *_settings;
  QStringList _pages;
  Hikes *_hikes;

  int _width;
  int _height;
};

#endif // CONFIGDATA_H
