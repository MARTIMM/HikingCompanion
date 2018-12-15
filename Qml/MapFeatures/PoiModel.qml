import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.0
import QtLocation 5.9

MapItemView {
  id: root

  model: GlobalVariables.applicationWindow.mapPage.poiMap.searchPoi
  delegate: MapQuickItem {
    coordinate: place.location.coordinate
    onCoordinateChanged: {
      console.info(
            "Coordinate found: " +
            place.location.coordinate + ", " +
            place.location.address.text
            );
    }

    anchorPoint.x: image.width * 0.5
    anchorPoint.y: image.height
    zoomLevel: GlobalVariables.applicationWindow.mapPage.hikingCompanionMap.zoomLevel

    sourceItem: Column {
      Image {
        id: image
        source: "qrc:Assets/Images/Icon/Poi/FoodSleep/restaurant_italian.png"
      }

      Row {
        id: titleText

        width: parent.width
        height: tt1.height
        anchors.top: image.bottom

        Rectangle {
          anchors.fill: parent
          width: parent.width
          height: parent.height

          color: "white"
          opacity: 1

          property alias tt1: tt1.text
          Text {
            id: tt1
            text: title
            font.bold: true
          }
        }
      }

      Row {
        id: addressText

        width: parent.width
        height: tt2.height
        anchors.top: titleText.bottom

        Rectangle {
          anchors.fill: parent
          width: parent.width
          height: parent.height

          color: "green"
          opacity: 1

          property alias tt2: tt2.text
          Text {
            id: tt2
            text: place.location.address.text
            font.bold: true
          }
        }
      }
    }
  }
}

