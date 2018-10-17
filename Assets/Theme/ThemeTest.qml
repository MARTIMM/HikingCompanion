import "../../Qml/Page" as HCPage
import "../../Qml/Parts" as HCParts
import "../../Qml/Button" as HCButton

//import io.github.martimm.HikingCompanion.GpxFiles 0.1
import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.3


ApplicationWindow {
  id: root
  title: qsTr("Test Application")

  visible: true

  width: 600
  height: 450

  HCPage.TracksPage {
    id: tracksPage;
    visible: true
  }
/**/
}










/*
  Component.onCompleted: {
    gpxf.readGpxFileInfo;
  }

  GpxFiles {
    id: gpxf

    onGpxFileListChanged: {
      lv.model = gpxf.gpxFileList();
      lv.trackTitle = lv.model[0].description;

      // example previous setting
      currentIndex = 5;

      console.log("gpxfs event ready: " + lv.model.length + ", " + lv.model[0]);
      console.log("gpxfs description: " + lv.model[0].description);
    }
  }

  property int currentIndex
  ListView {
    id: lv

    // Set text of title via this property. Component is not yet ready
    property string trackTitle

    anchors.fill: parent

    currentIndex: root.currentIndex
    header: Rectangle {
      width: parent.width;
      height: 50

      border { color: "#9EDDF2"; width: 2}
      Text {
        anchors.centerIn: parent
        text: lv.trackTitle
        font.pixelSize: 25
      }
    }

    highlight: Rectangle {
      width: parent.width
      height: parent.height
      z: 1
      color: "transparent"
      radius: 5
      border {
        width: 1
        color: "purple"
      }
    }

    delegate: Rectangle {
      width: parent.width
      height: 20
      MouseArea {
        anchors.fill: parent
        onClicked: {
          currentIndex = index
          root.currentIndex = currentIndex;
          console.log("clicked: [" + index + "] " + modelData.name);
        }
      }

      Text {
        anchors.fill: parent
        anchors.leftMargin: 12
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        text: " [" + index + "] " + modelData.name
        color: lv.CurrentIndex === index ? "yellow" : "black"
      }
    }
  }
*/

