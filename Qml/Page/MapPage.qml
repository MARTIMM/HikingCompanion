import QtQuick 2.11
import QtQuick.Controls 2.4
//import QtQuick.Layouts 1.3
import QtLocation 5.6
import QtPositioning 5.6

//import "../Menu" as HCMenu
//import "../Button" as HCButton
import io.github.martimm.HikingCompanion.Theme 0.1

Rectangle {
  id: mapPage
  visible: true
/*
  Row {
    id: pageToolbarRow
    spacing: 2

    height: Theme.largeButtonHeight + 2
    width: parent.width
    z: 50

    anchors {
      top: parent.top
      topMargin: 6
      right: parent.right
      rightMargin: 6
      left: parent.left
      leftMargin: 6
    }

    layoutDirection: Qt.RightToLeft

    HCButton.OpenMenu { }
  }
*/
  Plugin {
    id: mapPlugin
    name: "osm" // "osm" // "mapboxgl", "esri", ...
    // specify plugin parameters if necessary
    // PluginParameter {
    //     name:
    //     value:
    // }
  }

  MapCircle {
    id: currentLocationFeature

    radius: 6.0
    color: 'transparent'  // or #00000000 with alpha to zero
    opacity: 0.7
    border.width: 4
    border.color: 'blue'
  }

  Map {
    id: hikerCompanionMap

    Component.onCompleted: {
      location.start();
      hikerCompanionMap.addMapItem(currentLocationFeature)
    }

    z: 100
    anchors.fill: parent
    plugin: mapPlugin
    //    center: QtPositioning.coordinate(59.91, 10.75) // Oslo
    center: location.valid ? location.coordinate : QtPositioning.coordinate( 0, 0)
    zoomLevel: 14
  }

  PositionSource {
    id: location
    //preferredPositioningMethods: PositionSource.SatellitePositioningMethods
    preferredPositioningMethods: PositionSource.AllPositioningMethods
    //name: "SerialPortNmea"
    updateInterval: 1000
    //active: true

    onPositionChanged: {
      var coord = location.position.coordinate;
      console.log( "Coordinate:", coord.longitude, coord.latitude);

      currentLocationFeature.center = location.position.coordinate
      hikerCompanionMap.center = location.position.coordinate
    }
  }
}

