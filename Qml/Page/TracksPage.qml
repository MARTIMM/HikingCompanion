import "." as HCPage
import "../Button" as HCButton
import "../Parts" as HCParts

//TODO: HCTheme1 settings should go to other module
import io.github.martimm.HikingCompanion.HCTheme1 0.1
import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.Config 0.3
import io.github.martimm.HikingCompanion.GpxFiles 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1
import io.github.martimm.HikingCompanion.Hikes 0.1

import QtQuick 2.9
import QtQuick.Controls 2.2

HCPage.Plain {
  id: tracksPage

  Config { id: config }
  Hikes { id: hikes }

  Component.onCompleted: {
    // Get the track list. Here it is prepared on startup.
    changeTrackList();
  }

  function changeTrackList() {
    // Get the track list and check if empty. If empty, the select button
    // must be disabled. If not empty, set the previous selected entry
    // in the tracklist.
    lv.model = hikes.trackList();
    if ( lv.model.length === 0 ) {
      lv.contentHeight = 0;
      selectButton.enabled = false;
    }

    else {
      currentIndex = config.getGpxFileIndexSetting();
      var entriesHeight = lv.model.length * 20;
      lv.contentHeight = 20 + entriesHeight;
      selectButton.enabled = true;
    }
  }

  GpxFiles {
    id: gpxf

    // Function is triggered when click event on the select button
    // calls loadCoordinates function.
    onCoordinatesReady: {
      // Get the path of coordinates and show on map
      var path = gpxf.coordinateList();
      var mapPage = GlobalVariables.mapPage;
      mapPage.hikerCompanionMap.trackCourse.setPath(path);

      // Get the boundaries of the set of coordinates to zoom in
      // on the track shown on the map
      var bounds = gpxf.boundary();
      mapPage.hikerCompanionMap.visibleRegion = bounds;

      // Make map visible
      GlobalVariables.menu.setHomePage();
    }
  }

/*
  GpxFiles {
    id: gpxf

    onGpxFileListReady: {
      // Copy the data into the model
      lv.model = gpxf.gpxFileList();

      // Set the title from the description
      //TODO; all descriptions are the same, keep this out of the GpxFile obj
      tracksPage.trackTitle = gpxf.description;

      //TODO; must come from config
      // Example previous setting
      //currentIndex = parseInt(config.getSetting("Tracks/gpxfileindex"));

      var entriesHeight = lv.model.length * 20;
      lv.contentHeight = 20 + entriesHeight;
    }
  }
*/

  width: parent.width
  height: parent.height
  anchors.fill: parent

  HCParts.ToolbarRow {
    id: pageToolbarRow

    HCButton.OpenMenu {  }
    HCButton.Home {  }

    Text {
      text: qsTr(" Tracks page")
    }
  }

  // A fixed title from the tracks description on top
  Rectangle {
    id: titleText

    anchors.top: pageToolbarRow.bottom
    width: parent.width;
    height: 40
    color: "transparent"

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

  // Set text of title via this property. Component is not yet ready
  property string trackTitle

  property int currentIndex
  ListView {
    id: lv
    width: parent.width;
    contentWidth: parent.width

    anchors {
      top: titleText.bottom
      bottom: pageButtonRow.top
      left: parent.left
      right: parent.right
    }

    clip: true

    currentIndex: tracksPage.currentIndex

    highlightResizeDuration: 1
    highlightMoveDuration: 400
    highlight: Rectangle {
      width: parent.width

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
          currentIndex = index
          tracksPage.currentIndex = currentIndex;
        }
      }

      color: "transparent"

      Text {
        id: wrapperText
        anchors.fill: parent
        anchors.leftMargin: 12
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        text: "[" + index + "] " + modelData
        color: HCTheme1.cmptFgColorL
      }
    }
  }

  HCParts.PageButtonRow {
    id: pageButtonRow

    anchors.bottom: parent.bottom

    Button {
      id: selectButton
      width: textMetrics.boundingRect.width + 30
      text: qsTr("Select")

      onClicked: {
        config.setGpxFileIndexSetting(currentIndex);

        // Get the coordinates of the selected track and emit a
        // signal when ready. This signal is catched on the mapPage
        // where the coordinates are used.
        gpxf.loadCoordinates(currentIndex);
      }
    }
  }
}
