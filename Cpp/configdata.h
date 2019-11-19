#ifndef CONFIGDATA_H
#define CONFIGDATA_H

#include "hikes.h"
#include "trackcoordinates.h"

#include <QObject>
#include <QSettings>
#include <QLoggingCategory>

// ----------------------------------------------------------------------------
#define HIKING_COMPANION_VERSION "0.14.6"

Q_DECLARE_LOGGING_CATEGORY(config)
Q_DECLARE_LOGGING_CATEGORY(configGetSel)
Q_DECLARE_LOGGING_CATEGORY(configSetSel)

constexpr double PI = 3.141592653589793;

// ----------------------------------------------------------------------------
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

  inline QString dataDir() { return _dataDir; }
  inline QString tileCacheDir() { return _dataDir + "/Cache/Tiles"; }
  inline QString featureCacheDir() { return _dataDir + "/Cache/Features"; }
  inline QString dataShareDir() { return _dataShareDir; }

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

  QString getFilenameFromPart( QString partName );

  QString getTheme( bool takeHCSettings );

  QString getHCVersion();
  QString getOsVersion();
  QStringList getHikeVersions();
  QStringList getVersions();

  inline int windowWidth() { return _width; }
  inline int windowHeight() { return _height; }
  double fysLength( int pixels );
  int pixels( double fysLength );
  void setWindowSize( int w, int h);
  inline int getWindowWidth() { return _width; }
  inline int getWindowHeight() { return _height; }

  void saveUserTrackNames( QString hikeTitle, QString hikeDesc, QString hikeKey);
  bool saveUserTrack(
      QString hikeKey, QString trackTitle, QString trackDesc,
      QString trackType, std::vector<Coord> coordinates
      );

  inline QString thunderForestApiKey() { return _thunderForestApiKey; }

signals:

public slots:

private:
  ConfigData(QObject *parent = nullptr);
  static ConfigData *_createInstance();

  bool _checkForNewHikeData();
  bool _checkHikeVersion();
//  void _mkNewTables();
//  void _refreshData();
  void _moveTable( QString fromTable, QString toTable);
  bool _mkpath(QString path);
  bool _copy( QString from, QString to );
  void _dirCopy( QString from, QString to );
  void _removeSettings(QString group);
  bool _storeCoordinates(
      QString hikeKey, QString hikeTableName, QString trackTitle,
      QString trackDesc, QString trackType, std::vector<Coord> coordinates,
      QString nTracks
      );
  void _loadThunderForestApiKey();
  void _manageHCConfig();              // Hiking companion config
  void _manageHikeConfig(bool check);  // Imported hike config
  void _manageFeatures(bool check);
  void _manageNotes(bool check);
  void _managePages(bool check);
  void _managePhotos(bool check);
  void _manageTracks(bool check);

  QString _programId;     // Program identification as reversed domainname
  QString _platformName;  // Name of platform os
  QString _dataDir;       // Location where all hikes are stored
  QString _dataShareDir;  // Location where new data is placed to install

  QString _thunderForestApiKey;

  QSettings *_settings;     // Hiking companions config
  QSettings *_hikeSettings; // Config of newly imported hike
  QStringList _pages;       // Html pages
  Hikes *_hikes;            // Available hikes

  int _width;
  int _height;
  double _pixelRatio = -1.0;
  double _pixelDensity = -1.0;
};

#endif // CONFIGDATA_H
