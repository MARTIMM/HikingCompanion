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
      id: poiArea

      Component.onCompleted: {
        console.log("P keys: " + place);
      }

      spacing: 2

      Image {
        id: image
        //source: place.icon
        source: "qrc:Assets/Images/Icon/Poi/FoodSleep/restaurant_italian.png"

        MouseArea {
          anchors.fill: parent
          hoverEnabled: true
          onEntered: {
            tt1Rct.visible = true;
          }

          onExited: {
            tt1Rct.visible = false;
          }
        }
      }

      Rectangle {
        id: tt1Rct

        visible: false

        width: tt1cw
        height: tt1ch

        color: "white"
        opacity: 0.8

        property real tt1cw: tt1.contentWidth
        property real tt1ch: tt1.contentHeight
        Text {
          id: tt1
          text: title
          font.bold: true
          font.pointSize: 10
        }
      }
/*
      Rectangle {
        id: tt2Rct

        width: tt2cw
        height: tt2ch

        color: "white"
        opacity: 0.8

        property real tt2cw: tt2.contentWidth
        property real tt2ch: tt2.contentHeight
        Text {
          id: tt2
          text: place.location.address.text
          font.bold: true
          font.pointSize: 10
        }
      }
*/
    }
  }
}

