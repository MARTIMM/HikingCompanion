import QtQuick 2.11
//import QtQuick.Window 2.3
import QtQuick.Controls 2.4
//import QtQuick.Layouts 1.3
import QtLocation 5.6
import QtPositioning 5.6

Rectangle {
  id: mapPage

  anchors.fill: parent
  visible: true

  // Need the menu button on this page
  OpenMenuButton {
    id: openMenuButton
    visible: true
  }


  Plugin {
    id: mapPlugin
    name: "esri" // "osm" // "mapboxgl", "esri", ...
    // specify plugin parameters if necessary
    // PluginParameter {
    //     name:
    //     value:
    // }
  }

  Map {
    anchors.fill: parent
    plugin: mapPlugin
    center: QtPositioning.coordinate(59.91, 10.75) // Oslo
    zoomLevel: 14
  }
}
