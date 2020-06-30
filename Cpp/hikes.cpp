#include "hikes.h"
#include "gpxfile.h"
#include "configdata.h"
#include "cachedata.h"
#include "hikemodelobject.h"

//#include <QDebug>
#include <QApplication>
#include <QFont>

#include <cmath>

// -----------------------------------------------------------------------------
//Hikes::Hikes(QObject *parent) : QObject(parent) { }
Q_LOGGING_CATEGORY( hikes, "hc.hikes")

// -----------------------------------------------------------------------------
// Get information about hikes directly from the configuration in
// the HikeList table
void Hikes::defineHikeList() {

	ConfigData *cfg = ConfigData::instance();

	// Get all entries from the hike list
	_hikeList.clear();
	QStringList hikeKeys = cfg->readKeys("HikeList");
	qDebug() << "Hike keys:" << hikeKeys;

	for ( int hi = 0; hi < hikeKeys.count(); hi++) {
		QString hikeKey = hikeKeys[hi];
		QString hikeKeyTable = QString("h%1").arg(hi) +
		    "." + cfg->getSetting("HikeList/" + hikeKey);
		qDebug() << "Key and table:" << hikeKey << hikeKeyTable;
		_hikeList.append(cfg->getSetting(hikeKeyTable + "/title"));
	}
}

// -----------------------------------------------------------------------------
void Hikes::setHikeModel( ) {

	_hikeModelObjects.clear();
	_hikeModelObjects.append(
	      new HikeModelObject(
	        "Sultans Trail",				// listTitle
	        "Vienna to Istanbul",  	// listText
	        "",									  	// listImage
	        "",											// listTextFile
	        "Sufitrail"							// listHikeKey
	        )
	);

	_hikeModelObjects.append(
	      new HikeModelObject(
	        "Sufi Trail", "",
	        "Images/popkijktindeverte-176x300.png",
	        "hikeListText.html", "Sufitrail"
	        )
	);

	_hikeModelObjects.append(
	      new HikeModelObject(
	        "Haarlem and surroundings",
	        "Haarlem and surroundings in the Netherlands",
	        "", "", "HaarlemNHTrips"
	      )
	);
}

// -----------------------------------------------------------------------------
// Create a list of tracks directly from the configuration using the
// Track# tables. The list shows the title of each entry from each table.
QVariantList Hikes::trackList() {

	ConfigData *cfg = ConfigData::instance();
	_trackList.clear();

	QString entryKey = cfg->hikeEntryKey();
	QString tableName = cfg->hikeTableName(entryKey);
	int ntracks = cfg->getSetting(tableName + "/ntracks").toInt();

	for ( int ni = 0; ni < ntracks; ni++) {
		QString trackLine;
		QString tracksTableName = cfg->tracksTableName( tableName, ni);

		qCDebug(hikes) << "Default font" << qApp->font().family();

		// Get the type of walk, (W) walking, (B) biking or (?) bij rocket ;-)
		QString trackInfo = cfg->getSetting(tracksTableName + "/type");
		if ( trackInfo == "W" ) {
			trackLine = "\U0001F6B6 ";
		}

		else if ( trackInfo == "B" ) {
			trackLine = "\U0001F6B2 ";
		}

		else {
			trackLine = "\U0001F462 ";
		}

		// Get the length of this track
		trackInfo = cfg->getSetting(tracksTableName + "/length");
		if ( trackInfo == "" or trackInfo == "0" ) {
//    if ( true ) {
			QString hikeKey = cfg->getSetting("HikeList/" + entryKey);
			QString fname = cfg->getSetting(tracksTableName + "/fname");
			GpxFile *gf = new GpxFile();
			gf->setGpxFilename(
			      cfg->dataDir() + "/Hikes/" + hikeKey + "/Tracks/", fname
			      );
			QList<QGeoCoordinate> coordinateList = gf->coordinateList();
			qCDebug(hikes) << "nCoordinates:" << coordinateList.count();
			double length = gf->trackDistance(coordinateList) / 1000.0;
			trackInfo = QString("%1 km").arg( length, 8, 'f', 3);
			trackLine += trackInfo;
			cfg->setSetting( tracksTableName + "/length", trackInfo);
		}

		else {
			trackLine += trackInfo;
		}

		// Finally add the track title
		trackLine += ", " + cfg->getSetting(tracksTableName + "/title");
		_trackList.append(trackLine);
	}

	return _trackList;
}

// -----------------------------------------------------------------------------
void Hikes::loadCoordinates(int index) {

	//qDebug() << "get coordinates from selected index: " << index;

	ConfigData *cfg = ConfigData::instance();

	QString entryKey = cfg->hikeEntryKey();
	QString tableName = cfg->hikeTableName(entryKey);
	QString tracksTableName = cfg->tracksTableName( tableName, index);

	QString hikeName = cfg->getSetting("HikeList/" + entryKey);
	QString gpxFile =
	    cfg->dataDir() + "/Hikes/" + hikeName + "/Tracks/" +
	    cfg->getSetting(tracksTableName + "/fname");

	_coordinateList = GpxFile::coordinateList(gpxFile);
	qCDebug(hikes) << _coordinateList.count() << " coordinates found";
	_boundary = GpxFile::boundary(_coordinateList);
	qCDebug(hikes) << _boundary.count() << " boundaries set";

	//TODO must be done for all tracks in the hike at once in a separate thread
	//TODO removing must be between 0 and 19, check for overlap of tiles used
	// for other hikes!
	QHash<QString, QString> ocf = osmCacheFilenames( 8, 16);
	createOsmCache(ocf);
}

// -----------------------------------------------------------------------------
QHash<QString, QString> Hikes::osmCacheFilenames( int minZoom, int maxZoom) {

	QHash<QString, QString> cacheFilenames;
	for( int ci = 0; ci < _coordinateList.count(); ci++) {
		for( int zi = minZoom; zi <= maxZoom; zi++) {
			int x = lon2tileX( _coordinateList[ci].longitude(), zi);
			int y = lat2tileY( _coordinateList[ci].latitude(), zi);
			insertTileCoords( zi, x, y, &cacheFilenames);

			// insert some surrounding tiles when zoomlevel is higher
			if ( zi > 12 ) {
				//qCDebug(hikes) << "X:" << x-1 << x << x+1;
				for( int xi = x - 1; xi < x + 2; xi++ ) {
					for( int yi = y - 1; yi < y + 2; yi++ ) {
						insertTileCoords( zi, x, y, &cacheFilenames);
					}
				}
			}
		}
	}

	return cacheFilenames;
}

// -----------------------------------------------------------------------------
int Hikes::lon2tileX( double lon, int zoomLevel) {
//  return static_cast<int>( (lon + 180.0) / 360.0 * (1 << zoomLevel) );
	return static_cast<int>( (lon + 180.0) / 360.0 * pow( 2.0, zoomLevel)); //(1 << zoomLevel) );
}

// -----------------------------------------------------------------------------
int Hikes::lat2tileY( double lat, int zoomLevel) {
	double n = pow( 2.0, zoomLevel); //1 << zoomLevel;
	double latRad = lat * PI / 180.0;
	//double sec = 1/cos(latRad);
	return static_cast<int>(
	      ( 1 - log(tan(latRad) + 1/cos(latRad) ) / PI ) / 2.0 * n
	      );
}

// -----------------------------------------------------------------------------
void  Hikes::insertTileCoords(
    int zi, int x, int y, QHash<QString, QString> *cacheFilenames
    ) {

	ConfigData *cfg = ConfigData::instance();
	QString tfApiKey = cfg->thunderForestApiKey();

	// https://blog.qt.io/blog/2017/05/24/qtlocation-using-offline-map-tiles-openstreetmap-plugin/
	// terrain maps are code maptype 6 (we must use custom maps (8))
	QString cacheFilename = QString(
	      "osm_100-l-8-%1-%2-%3.png"
	      ).arg(zi).arg(x).arg(y);

	// There will be many tiles recalculated so check hash before
	// calculating the uri
	if ( cacheFilenames->value(cacheFilename).isEmpty() ) {

/*
		// See qrs:Assets/Providers/terrain
		QString uri = QString(
					"https://a.tile.thunderforest.com/landscape/%1/%2/%3.png?apikey=%4"
					).arg(zi).arg(x).arg(y).arg(tfApiKey);
*/
/*
		QString uri = QString(
					"https://c.tile.opentopomap.org/%1/%2/%3.png"
					).arg(zi).arg(x).arg(y);
*/
		QString uri = QString(
		      "https://b.tile.openstreetmap.org/%1/%2/%3.png"
		      ).arg(zi).arg(x).arg(y);

		cacheFilenames->insert( cacheFilename, uri);

		qCDebug(hikes) << "Cache filename:" << cacheFilename;
		qCDebug(hikes) << "Uri of tile:" << uri;
	}
}

// -----------------------------------------------------------------------------
void Hikes::createOsmCache(QHash<QString, QString> osmCacheFilenames) {

	CacheData *cache = new CacheData();

	ConfigData *cfg = ConfigData::instance();
	QString cacheDir = cfg->tileCacheDir();

	QHashIterator<QString, QString> i(osmCacheFilenames);
	while ( i.hasNext() ) {
		i.next();

		QString cacheFilename = cacheDir + "/" + i.key();
		QString uri = i.value();
		cache->cacheData( uri, cacheFilename);
	}
}

// -----------------------------------------------------------------------------
QGeoCoordinate Hikes::findClosestPointOnRoute(QGeoCoordinate c) {

	// Check if there are coordinates
	if ( _coordinateList.count() == 0 ) return c;

	// Set to maximum possible here on earth about 40.075 km along
	// the eqator in metres.
	double minDist = 41000000.0;
	QGeoCoordinate cOfMinDist = _coordinateList[0];
	for ( int ci = 0; ci < _coordinateList.count(); ci++ ) {
		double d = c.distanceTo(_coordinateList[ci]);
		if ( minDist > d ) {
			minDist = d;
			cOfMinDist = _coordinateList[ci];
		}
	}

	return cOfMinDist;
}

// -----------------------------------------------------------------------------
double Hikes::distanceToPointOnRoute( QGeoCoordinate c1, QGeoCoordinate c2) {
	return c1.distanceTo(c2);
/*
	// original calculations; keep this in as well ass geoDistance()
	return GpxFile::geoDistance(
				c1.longitude(), c1.latitude(),
				c2.longitude(), c2.latitude()
				);
*/
}

/*
// -----------------------------------------------------------------------------
void Hikes::_setGpxFiles() {

	_gpxFileList.clear();
	_gpxTrackList.clear();

	// Read directory and select gpx files. Create a GpxFile object with it
	// and append to _gpxFileList
	qDebug() << "Path: " << _gpxPath;
	QRegExp rx("\\.gpx$");

	QStringList filters = { "*.gpx" };
	QDir d(_gpxPath);
	d.setNameFilters(filters);
	d.setSorting(QDir::Name);

	QStringList fnames = d.entryList(QDir::Files);
	for ( int i = 0; i < fnames.size(); i++ ) {
		GpxFile *gf = new GpxFile();
		QString description = gf->setGpxFilename( _gpxPath, fnames[i]);
		if ( _description == nullptr && description.length() > 0 ) {
			_description = description;
		}

		_gpxFileList.append(gf);
		_gpxTrackList.append(gf->name());
	}
}
*/

