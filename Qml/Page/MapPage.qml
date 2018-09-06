import "." as HCPage
import "../Button" as HCButton
import "../Parts" as HCParts

import io.github.martimm.HikingCompanion.Theme 0.1

import QtQuick 2.9
import QtQuick.Controls 2.2
import QtLocation 5.9
import QtPositioning 5.8

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

  Plugin {
    // For the OSM plugin see also a blog at http://blog.qt.io/blog/2017/03/09/provisioning-openstreetmap-providers-in-qtlocation/
    id: mapPlugin
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

  property alias currentLocationFeature: currentLocationFeature
  MapCircle {
    id: currentLocationFeature

    radius: 6.0
    color: 'transparent'  // or #00000000 with alpha to zero
    opacity: 0.7
    border.width: 4
    border.color: 'blue'
  }

  property alias hikerCompanionMap: hikerCompanionMap
  Map {
    id: hikerCompanionMap

    width: parent.width
    height: parent.height
    anchors.fill: parent

    Component.onCompleted: {
      location.start();
      hikerCompanionMap.addMapItem(currentLocationFeature)
    }

    plugin: mapPlugin
    center: location.valid
            ? location.coordinate
            : QtPositioning.coordinate(59.91, 10.75) // Oslo
    zoomLevel: 5

    // This object is set from the tracksPage after selecting a track.
    property alias trackCourse: trackCourse
    MapPolyline {
      id: trackCourse
      line.width: 4
      line.color: 'red'
    }
  }

  PositionSource {
    id: location
    //preferredPositioningMethods: PositionSource.SatellitePositioningMethods
    preferredPositioningMethods: PositionSource.AllPositioningMethods
    //name: "SerialPortNmea"
    updateInterval: 1000
    active: true

    onPositionChanged: {
      var coord = location.position.coordinate;
      console.log( "Coordinate:", coord.longitude, coord.latitude);

      currentLocationFeature.center = location.position.coordinate
      hikerCompanionMap.center = location.position.coordinate
    }
  }

/*
  Plugin {
    id: mapHillshadePlugin
    //locales: [ "en_US", "nl_NL"]
    name: "osm" // "osm", "mapboxgl", "esri", ...
    //preferred: [ "osm", "esri"]
    //required: Plugin.MappingFeature
    //          | Plugin.GeocodingFeature
    //          | Plugin.AnyPlacesFeature

    // specify OSM plugin parameters
    PluginParameter { name: "osm.mapping.host"; value: "http://c.tiles.wmflabs.org/hillshading" }
    PluginParameter { name: "osm.mapping.providersrepository.disabled"; value: true}
  }

  Map {
    id: hillshade

    width: parent.width
    height: parent.height
    anchors.fill: parent

    plugin: mapHillshadePlugin
    opacity: 0.5
  }
*/
}

