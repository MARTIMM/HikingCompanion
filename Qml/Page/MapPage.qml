import "." as HCPage
import "../Button" as HCButton
import "../Parts" as HCParts

import io.github.martimm.HikingCompanion.Theme 0.1

import QtQuick 2.11
import QtQuick.Controls 2.2
import QtLocation 5.9
import QtPositioning 5.8

HCPage.Plain {
  id: mapPage

  width: parent.width
  height: parent.height
  anchors.fill: parent

  HCParts.ToolbarRectangle {
    id: pageToolbarRow
    color: "transparent"

    HCParts.ToolbarRow {
      HCButton.OpenMenu { }
      HCButton.CurrentLocationButton { }
      HCButton.CurrentTrackButton { }

      //TODO North button
      //TODO Reset 3D view to 2D view
      //TODO Camera button to make a picture
      //TODO Note button to make a note
    }
  }


  // https://doc-snapshots.qt.io/qt5-5.9/location-plugin-osm.html#
  property alias hikingCompanionMap: hikingCompanionMap
  property alias currentLocationFeature: hikingCompanionMap.currentLocationFeature
  Map {
    id: hikingCompanionMap

    Component.onCompleted: {
      location.start();

      hikingCompanionMap.clearData();
      hikingCompanionMap.addMapItem(currentLocationFeature);

      // When there is no gps, just set the circle on top of the
      // current map center.
      currentLocationFeature.center = hikingCompanionMap.center;

      // Search for 'TerrainMap' map type and set activeMapType with it
      for ( var mt in supportedMapTypes ) {
/*
        console.log("---");
        console.log("name: " + supportedMapTypes[mt].name);
        console.log("descr: " + supportedMapTypes[mt].description);
        console.log("mobile: " + supportedMapTypes[mt].mobile);
        console.log("night: " + supportedMapTypes[mt].night);
        console.log("style: " + supportedMapTypes[mt].style);
*/
/*
  From MapType QML component
        MapType.NoMap - No map.
        MapType.StreetMap - A street map.
        MapType.SatelliteMapDay - A map with day-time satellite imagery.
        MapType.SatelliteMapNight - A map with night-time satellite imagery.
        MapType.TerrainMap - A terrain map.
        MapType.HybridMap - A map with satellite imagery and street information.
        MapType.GrayStreetMap - A gray-shaded street map.
        MapType.PedestrianMap - A street map suitable for pedestriants.
        MapType.CarNavigationMap - A street map suitable for car navigation.
        MapType.CycleMap - A street map suitable for cyclists.
        MapType.CustomMap - A custom map type.
*/
        if ( supportedMapTypes[mt].style === MapType.TerrainMap ) {
//        if ( supportedMapTypes[mt].style === MapType.CycleMap ) {
//        if ( supportedMapTypes[mt].style === MapType.CustomMap ) {
          hikingCompanionMap.activeMapType = supportedMapTypes[mt];
          break;
        }
      }

      console.log("Map set to " + hikingCompanionMap.activeMapType.description);
    }

    width: parent.width
    height: parent.height
    anchors.fill: parent
    gesture.enabled: true
    z: parent.z + 1

    plugin: Plugin {
      name: "osm" // "osm" // "mapboxgl" // "mapbox" // "esri", ...

/*
      // Search and set MapType.CustomMap
      // There are problems using https:
      //   Error is: 'qt.network.ssl: Incompatible version of OpenSSL'
      // Messages from main qDebug output:
      //   SslSupport:  false
      //   SslLibraryBuildVersion:  "OpenSSL 1.0.2k-fips  26 Jan 2017"
      //   SslLibraryRuntimeVersion:  ""

      PluginParameter {
        name: "osm.mapping.custom.host"
        value: "https://a.tile.opentopomap.org/"
      }

      PluginParameter {
        name: "osm.mapping.custom.mapcopyright"
        value: "<a href='http://www.opentopomap.com/'>OpenTopoMap</a>"
      }

      PluginParameter {
        name: "osm.mapping.custom.datacopyright"
        value: "<a href='http://www.opentopomap.com/'>OpenTopoMap</a>"
      }

      PluginParameter {
        name: "osm.mapping.providersrepository.disabled"
        value: true
      }
*/

      // Copy all files from <qt install>/5.11.2/Src/qtlocation/src/plugins/geoservices/osm/providers/5.8/*
      // to qrc:Assets/Providers and add to resources file. Then the api key
      // can be added to the url strings for the thunderforest site.
      PluginParameter {
        name: "osm.mapping.providersrepository.address"
        //value: "http://192.168.0.22/~marcel/Assets/Providers/"
        //value: "file:////home/marcel/Projects/Mobile/Projects/HikingCompanion/HikingCompanion/Assets/Providers"
        value: "qrc:Assets/Providers"
      }
    }

    center: location.valid
            ? location.coordinate
            : QtPositioning.coordinate( 59.91, 10.75) // Oslo
    //zoomLevel: 12
    zoomLevel: 17

    // This object is set from the tracksPage after selecting a track.
    property alias trackCourse: trackCourse
    MapPolyline {
      id: trackCourse
      line.width: 3
      line.color: '#785a3a'

      // Set from the TracksPage whe a track is selected
      property var boundary;
    }

    // This object is set each time when a new coordinate comes in from GPS
    // and the user has tracking enabled. Later when ready, it is stored and
    // then selectable from the hike table and is made visible in the
    // trackCourse object
    property alias userTrackCourse: userTrackCourse
    MapPolyline {
      id: userTrackCourse
      line.width: 3
      line.color: '#6a883a'
    }

    property alias wanderOffTrackNotation: wanderOffTrackNotation
    MapPolyline {
      id: wanderOffTrackNotation
      line.width: 4
      line.color: '#dfffff'
/*
      property alias mpl: mpl
      path: Path {
        id: mpl
        startX: currentLocationFeature.center.longitude
        startY: currentLocationFeature.center.latitude

        property alias psvg: psvg
        PathLine { id: psvg }
      }
*/
    }

    // Draw a line when the current location is too far away from the
    // currently selected track. It shows as a light line from the current
    // location to the closest point on the track.
    function setWanderOffTrackNotation() {
      //console.log("Calculate dist from route");
      var closestPointOnRoute = config.findClosestPointOnRoute(
            currentLocationFeature.center
            );
      var dist = config.distanceToPointOnRoute(
            closestPointOnRoute,
            currentLocationFeature.center
            );
      //console.log("cp: " + closestPointOnRoute + ", dist: " + dist);

      var path = [];
      // Check if we are further than 500 meters away
      if ( dist > 500 ) {
        //console.log("Path: " + path.length + ", " + path + ", " + currentLocationFeature.center.longitude);
        path.push(
              { "longitude": currentLocationFeature.center.longitude,
                "latitude": currentLocationFeature.center.latitude
              } );
        path.push(
              { "longitude": closestPointOnRoute.longitude,
                "latitude": closestPointOnRoute.latitude
              } );
        wanderOffTrackNotation.path = path;
      }

      else {
        // Clear the line using an empty array
        wanderOffTrackNotation.path = path;
      }
    }

/*
    property real radius: currentLocationFeature.radius
    property real bw: currentLocationFeature.border.width
    function setRad() {
      var zl = hikingCompanionMap.zoomLevel;
      console.log("Zoomlevel: " + zl);
      if ( zl < 4 )               { radius = 10000.0; bw = 20; }
      if ( zl >= 4 && zl < 6 )    { radius = 1000.0; bw = 15; }
      if ( zl >= 6 && zl < 9 )    { radius = 1000.0; bw = 10; }
      if ( zl >= 9 && zl < 12 )   { radius = 600.0; bw = 8; }
      if ( zl >= 12 && zl < 15 )  { radius = 400.0; bw = 6; }
      if ( zl >= 15 )             { radius = 200.0; bw = 4; }
    }
*/

    property alias currentLocationFeature: currentLocationFeature
    MapCircle {
      id: currentLocationFeature

      radius: 12.0
      color: 'transparent'  // or #00000000 with alpha to zero
      //opacity: 0.7
      border.width: 6
      border.color: 'blue'
    }
  }

  //TODO geolocation when no gps is available but internet is there
  PositionSource {
    id: location
    preferredPositioningMethods: PositionSource.SatellitePositioningMethods
    //preferredPositioningMethods: PositionSource.AllPositioningMethods
    //name: "SerialPortNmea"
    updateInterval: 1000
    active: true

    onPositionChanged: {
      var coord = location.position.coordinate;
      console.log( "Coordinate:", coord.longitude, coord.latitude);

      currentLocationFeature.center = location.position.coordinate
      hikingCompanionMap.center = location.position.coordinate
      //hikingCompanionMap.setRad();
    }
  }

  // Function to zoom in on the current location
  function zoomOnCurrentLocation() {
    hikingCompanionMap.center = currentLocationFeature.center;
    hikingCompanionMap.zoomLevel = 17;
  }

  // Function to zoom in on the current selected track
  function zoomOnCurrentTrack() {
    if ( hikingCompanionMap.trackCourse.boundary ) {
      hikingCompanionMap.visibleRegion = hikingCompanionMap.trackCourse.boundary;
      hikingCompanionMap.zoomLevel = hikingCompanionMap.zoomLevel - 0.2;
    }
  }

/*
  // See also https://doc-snapshots.qt.io/qt5-5.9/location-plugin-itemsoverlay.html#
  Map {
    id: hillshadeOverlay

    width: parent.width
    height: parent.height
    anchors.fill: parent

//    opacity: 0.6
    opacity: 0
    color: 'transparent' // Necessary to make this map transparent
    gesture.enabled: false

    center: hikingCompanionMap.center
    minimumFieldOfView: hikingCompanionMap.minimumFieldOfView
    maximumFieldOfView: hikingCompanionMap.maximumFieldOfView
    minimumTilt: hikingCompanionMap.minimumTilt
    maximumTilt: hikingCompanionMap.maximumTilt
    minimumZoomLevel: hikingCompanionMap.minimumZoomLevel
    maximumZoomLevel: hikingCompanionMap.maximumZoomLevel
    zoomLevel: hikingCompanionMap.zoomLevel
    tilt: hikingCompanionMap.tilt;
    bearing: hikingCompanionMap.bearing
    fieldOfView: hikingCompanionMap.fieldOfView
    z: hikingCompanionMap.z + 1

    //plugin: mapHillshadePlugin
    plugin: Plugin {
      id: mapHillshadePlugin
      //locales: [ "en_US", "nl_NL"]
      //name: "itemoverlay"
      name: "osm"
      //preferred: [ "osm", "esri"]
      //required: Plugin.MappingFeature
      //          | Plugin.GeocodingFeature
      //          | Plugin.AnyPlacesFeature

      // specify OSM plugin parameters
//      PluginParameter { name: "osm.mapping.host"; value: "http://c.tiles.wmflabs.org/hillshading" }
      PluginParameter { name: "osm.mapping.custom.host"; value: "http://tile.thunderforest.com/outdoors" }
      PluginParameter { name: "osm.mapping.providersrepository.disabled"; value: true}
    }

    // The code below enables SSAA
    layer.enabled: true
    layer.smooth: true
    property int w : hillshadeOverlay.width
    property int h : hillshadeOverlay.height
    property int pr: Screen.devicePixelRatio
    layer.textureSize: Qt.size( w  * 2 * pr, h * 2 * pr)
  }
*/
}

