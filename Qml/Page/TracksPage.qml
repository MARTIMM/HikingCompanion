import "." as HCPage
import "../Button" as HCButton
import "../Parts" as HCParts

import io.github.martimm.HikingCompanion.Theme 0.1
//import io.github.martimm.HikingCompanion.Config 0.3
import io.github.martimm.HikingCompanion.GpxFiles 0.1

import QtQuick 2.9
import QtQuick.Controls 2.2

HCPage.Plain {
  id: tracksPage

  width: parent.width
  height: parent.height
  anchors.fill: parent

  /*
  Config {
    id: config

    //tracks: [ ]
  }

  Component.onCompleted: {
    console.log("track 0: " + config.tracks[0]);
  }
  */

  HCParts.ToolbarRow {
    id: pageToolbarRow

    HCButton.OpenMenu {  }
    HCButton.Home {  }

    Text {
      text: qsTr(" Tracks page")
    }
  }

  GpxFiles {
    id: gpxf
    Component.onCompleted: {
      console.log("gpxfs: " + gpxf.gpxFileList);
    }
  }

  ListView {
    anchors {
      top: pageToolbarRow.bottom
      bottom: parent.bottom
      left: parent.left
      right: parent.right
    }

    model: gpxf.gpxFileList
    delegate: Text {
      text: name
    }
  }
}
