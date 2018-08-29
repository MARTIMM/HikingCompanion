import io.github.martimm.HikingCompanion.GpxFiles 0.1

import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.3


ApplicationWindow {
  id: root
  title: qsTr("Your Hiking Companion")

  visible: true
  width: 640
  height: 480

  Component.onCompleted: {
    gpxf.readGpxFileInfo;
    console.log("type model array is " + typeof lv.model);
    console.log("type model array [0] is " + typeof lv.model[0]);
  }

  GpxFiles {
    id: gpxf
    //property QList<QString> gfl
/*
    Component.onCompleted: {
      console.log("gpxfs: " + gpxf.gpxFileList);
      console.log("nbr gpxfs: " + gpxf.gnbrGpxFiles);
    }

    onGpxFileListChanged: {
      var gfl = [gpxf.gpxFileList()];
      console.log("gpxfs event ready: " + gfl[0].length);
      //lv.model = gfl;
    }
*/

    onGpxFileListChanged: {
      lv.model = gpxf.gpxTrackList();
      console.log("gpxfs event ready: " + lv.model.length + ", " + lv.model[0]);
      console.log("type is " + typeof lv.model[0]);
    }
  }

  ComboBox {
    id: lv
    //anchors.fill: parent
    width: parent.width
    //height: parent.height
    //visible: true
    //editable: false

    //model: ["a", "b"] //gpxf.gpxTrackList()
/*
    delegate: Text {
      text: name
    }
*/
  }
}

