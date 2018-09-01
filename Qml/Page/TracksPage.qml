import "." as HCPage
import "../Button" as HCButton
import "../Parts" as HCParts

//TODO: HCTheme1 settings should go to other module
import io.github.martimm.HikingCompanion.HCTheme1 0.1
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
  */

  HCParts.ToolbarRow {
    id: pageToolbarRow

    HCButton.OpenMenu {  }
    HCButton.Home {  }

    Text {
      text: qsTr(" Tracks page")
    }
  }

  Rectangle {
    id: titleText

    anchors.top: pageToolbarRow.bottom
    width: parent.width;
    height: 40
    color: "transparent"

    //border { color: "#9EDDF2"; width: 2}
    Text {
      anchors.centerIn: parent
      text: tracksPage.trackTitle
      color: HCTheme1.cmptFgColorL
      font {
        pixelSize: 20
        bold: true
      }
    }
  }

  Component.onCompleted: {
    // get the tracks ready -> onGpxFileListChanged will be emitted
    gpxf.readGpxFileInfo;
  }

  GpxFiles {
    id: gpxf

    onGpxFileListChanged: {
      // Copy the data into the model
      lv.model = gpxf.gpxFileList();

      // Set the title from the description
      //TODO; all descriptions are the same, keep this out of the GpxFile obj
      tracksPage.trackTitle = gpxf.description;

      //TODO; must come from config
      // Example previous setting
      currentIndex = ;

      var entriesHeight = lv.model.length * 20;
      lv.contentHeight = 20 + entriesHeight;

      console.log("gpxfs event ready: " + lv.model.length + ", " + lv.model[0]);
      console.log("gpxfs description: " + gpxf.description);
    }
  }

  // Set text of title via this property. Component is not yet ready
  property string trackTitle

  property int currentIndex
  ListView {
    id: lv

    contentWidth: parent.width

    anchors {
      top: titleText.bottom
      bottom: pageButtonRow.top
      left: parent.left
      right: parent.right
    }

    clip: true

    currentIndex: tracksPage.currentIndex

    //highlightResizeVelocity: 2000.0
    highlightResizeDuration: 1
    //highlightMoveVelocity: 1000.0
    highlightMoveDuration: 400
    highlight: Rectangle {
      width: parent.width
      height: parent.height

      // Must be higher than 1 otherwise highlighting will be cut outside
      // a certain range.
      z: 2

      color: HCTheme1.cmptFgColorD
      opacity: 0.2
      radius: 5
      border {
        width: 2
        color: HCTheme1.cmptBgColorD
      }
    }

    delegate: Rectangle {
      width: parent.width
      height: 20
      MouseArea {
        anchors.fill: parent
        onClicked: {
          console.log("mi: " + lv.model[lv.currentIndex]);
          currentIndex = index
          //lv.model[lv.currentIndex].wrapperText.color = "red"
          tracksPage.currentIndex = currentIndex;
          console.log("clicked: [" + index + "] " + modelData.name);
        }
      }

      color: "transparent"
      //color: index % 2 ? "blue" : "green"

      Text {
        id: wrapperText
        anchors.fill: parent
        anchors.leftMargin: 12
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        text: "[" + index + "] " + modelData.name
        //color: lv.CurrentItem ? "yellow" : "black"
        //color: index % 2 ? "green" : "blue"
        color: HCTheme1.cmptFgColorL
      }
    }
  }

  HCParts.PageButtonRow {
    id: pageButtonRow

    anchors.bottom: parent.bottom

    Button {
      width: textMetrics.boundingRect.width + 30
      text: qsTr("Select")
/*
      onClicked: {
        config.language = language.currentIndex;
        config.username = username.inputText.text;
        config.email = email.inputText.text;
      }
*/
    }
  }
}
