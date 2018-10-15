import "." as HCPage
import "../Button" as HCButton
import "../Parts" as HCParts

import io.github.martimm.HikingCompanion.Theme 0.1

import QtQuick 2.9
import QtQuick.Controls 2.2
import QtLocation 5.9
import QtPositioning 5.8
import QtQuick.Window 2.11

HCPage.Plain {
  id: mapPage

  width: parent.width
  height: parent.height
  anchors.fill: parent

  HCParts.ToolbarRow {
    id: pageToolbarRow

    HCButton.OpenMenu {  }
    //TODO North button
    //TODO Zoom current location
    //TODO Zoom to current track
    //TODO Reset 3D view to 2D view
  }


  // See also https://doc-snapshots.qt.io/qt5-5.9/location-plugin-itemsoverlay.html#
  property alias hikerCompanionMap: hikerCompanionMap
  property alias currentLocationFeature: hikerCompanionMap.currentLocationFeature
  Map {
    id: hikerCompanionMap

    Component.onCompleted: {
      location.start();
      hikerCompanionMap.addMapItem(currentLocationFeature)
    }

    width: parent.width
    height: parent.height
    anchors.fill: parent
    gesture.enabled: true
    z: parent.z + 1

    //activeMapType: MapType.CycleMap
    //color: "transparent"
    //opacity: 0

    //plugin: mapPlugin
    plugin: Plugin {
      // For the OSM plugin see also a blog at http://blog.qt.io/blog/2017/03/09/provisioning-openstreetmap-providers-in-qtlocation/
      //id: mapPlugin
      //locales: [ "en_US", "nl_NL"]
      name: "osm" // "osm", "mapboxgl", "esri", ...
      //preferred: [ "osm", "esri"]
      //required: Plugin.MappingFeature
      //          | Plugin.GeocodingFeature
      //          | Plugin.AnyPlacesFeature

      // specify OSM plugin parameters
      //PluginParameter { name: "osm.mapping.host"; value: "http://tile.thunderforest.com/landscape" }
      //PluginParameter { name: "osm.mapping.host"; value: "http://c.tiles.wmflabs.org/hillshading" }
      //PluginParameter { name: "osm.mapping.providersrepository.disabled"; value: true}
      //PluginParameter { name: "osm.mapping.host"; value: "http://c.tiles.wmflabs.org/hillshading" }

      //PluginParameter { name: "osm.mapping.host"; value: "https://tile.openstreetmap.org/" }
      //PluginParameter { name: "osm.geocoding.host"; value: "https://nominatim.openstreetmap.org" }
      //PluginParameter { name: "osm.routing.host"; value: "https://router.project-osrm.org/viaroute" }
      //PluginParameter { name: "osm.places.host"; value: "https://nominatim.openstreetmap.org/search" }
      //PluginParameter { name: "osm.mapping.copyright"; value: "" }
      //PluginParameter { name: "osm.mapping.highdpi_tiles"; value: true }
    }

    center: location.valid
            ? location.coordinate
            : QtPositioning.coordinate( 59.91, 10.75) // Oslo
    zoomLevel: 12

    // This object is set from the tracksPage after selecting a track.
    property alias trackCourse: trackCourse
    MapPolyline {
      id: trackCourse
      line.width: 5
      line.color: '#785a3a'
    }

    property real radius: currentLocationFeature.radius
    property real bw: currentLocationFeature.border.width
    function setRad() {
      var zl = hikerCompanionMap.zoomLevel;
      console.log("Zoomlevel: " + zl);
      if ( zl < 4 )               { radius = 10000.0; bw = 20; }
      if ( zl >= 4 && zl < 6 )    { radius = 1000.0; bw = 15; }
      if ( zl >= 6 && zl < 9 )    { radius = 1000.0; bw = 10; }
      if ( zl >= 9 && zl < 12 )   { radius = 600.0; bw = 8; }
      if ( zl >= 12 && zl < 15 )  { radius = 400.0; bw = 6; }
      if ( zl >= 15 )             { radius = 200.0; bw = 4; }
    }

    property alias currentLocationFeature: currentLocationFeature
    MapCircle {
      id: currentLocationFeature

      radius: 6.0
      color: 'transparent'  // or #00000000 with alpha to zero
      opacity: 0.7
      border.width: 4
      border.color: 'blue'
    }
  }

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
      hikerCompanionMap.center = location.position.coordinate
      hikerCompanionMap.setRad();
    }
  }

  Map {
    id: hillshadeOverlay

    width: parent.width
    height: parent.height
    anchors.fill: parent

//    opacity: 0.6
    opacity: 0
    color: 'transparent' // Necessary to make this map transparent
    gesture.enabled: false

    center: hikerCompanionMap.center
    minimumFieldOfView: hikerCompanionMap.minimumFieldOfView
    maximumFieldOfView: hikerCompanionMap.maximumFieldOfView
    minimumTilt: hikerCompanionMap.minimumTilt
    maximumTilt: hikerCompanionMap.maximumTilt
    minimumZoomLevel: hikerCompanionMap.minimumZoomLevel
    maximumZoomLevel: hikerCompanionMap.maximumZoomLevel
    zoomLevel: hikerCompanionMap.zoomLevel
    tilt: hikerCompanionMap.tilt;
    bearing: hikerCompanionMap.bearing
    fieldOfView: hikerCompanionMap.fieldOfView
    z: hikerCompanionMap.z + 1

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
}

