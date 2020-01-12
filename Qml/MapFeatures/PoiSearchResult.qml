import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.0
import QtLocation 5.9

MapItemView {
  id: root

  model: GlobalVariables.applicationWindow.mapPage.poiMap.poiSearch
  delegate: MapQuickItem {
    // place item on visible part of the map
    coordinate: place.location.coordinate

    onCoordinateChanged: {
      var loc = place.location.coordinate;
      var addr = place.location.address.text;
 //     console.log('loc: ' + loc);

      // filter items when not in area
      if ( typeof loc.longitude !== "undefined" &&
           typeof loc.latitude !== "undefined" ) {

        var hcm = GlobalVariables.applicationWindow.mapPage.hikingCompanionMap;
        var vr = hcm.visibleRegion.boundingGeoRectangle();

        var longMin = vr.topLeft.longitude;
        var latMin = vr.topLeft.latitude;
        var longMax = vr.bottomRight.longitude;
        var latMax = vr.bottomRight.latitude;
//        console.info('Addr: ' + addr + ', vr: ' + vr);

/*
        console.info('Addr: ' + addr);
        console.info('compare ' + loc.longitude + ' >= ' + longMin + ': ' + (loc.longitude >= longMin));
        console.info('compare ' + loc.latitude + ' >= ' + latMin + ': ' + (loc.latitude >= latMin));
        console.info('compare ' + loc.longitude + ' <= ' + longMax + ': ' + (loc.longitude <= longMax));
        console.info('compare ' + loc.latitude + ' <= ' + latMax + ': ' + (loc.latitude <= latMax));
*/
        if( loc.longitude >= longMin && loc.latitude >= latMin &&
            loc.longitude <= longMax && loc.latitude <= latMax ) {

          this.coordinate = loc;
          console.info( "Coordinate " + addr + "accepted: " + loc + ", " + addr);
        }
      }
    }

    anchorPoint.x: image.width * 0.5
    anchorPoint.y: image.height
    zoomLevel: GlobalVariables.applicationWindow.mapPage.hikingCompanionMap.zoomLevel

    sourceItem: Column {
      id: poiArea
      spacing: 2

      Component.onCompleted: {
        if ( Qt.platform.os === "linux" ) {
          image.mouseArea.hoverEnabled = true;
        }
      }

      property alias image: image
      Image {
        id: image
        //source: place.icon
        source: "qrc:Assets/Images/Icon/Poi/FoodSleep/restaurant_italian.png"
        fillMode: Image.PreserveAspectFit

        property alias mouseArea: mouseArea
        MouseArea {
          id: mouseArea

          anchors.fill: parent
          hoverEnabled: false

          property alias ttRectangle: tt2Rct
          onEntered: {
            console.log("entered");
            if ( Qt.platform.os === "android" ) {
              ttRectangle.visible = true; //!ttRectangle.visible;
            }
            else if ( Qt.platform.os === "linux" ) {
              ttRectangle.visible = true;
            }
          }

          onExited: {
            console.log("exited");
            if ( Qt.platform.os === "linux" ) {
              ttRectangle.visible = false;
            }
          }
        }
      }

/*
      Rectangle {
        id: tt1Rct

        visible: false

        property real tt1cw: tt1.contentWidth
        width: tt1cw

        property real tt1ch: tt1.contentHeight
        height: tt1ch

        color: "white"
        opacity: 0.8

        Text {
          id: tt1
          text: title
          font.bold: true
          font.pointSize: 10
        }
      }
*/
/**/
      Rectangle {
        id: tt2Rct

        visible: false

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

    }
  }
}

