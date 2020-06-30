import "." as HCPage
import "../Button" as HCButton
import "../Parts" as HCParts
import "../Text" as HCText

import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.Config 0.3
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.9
import QtQuick.Controls 2.2

HCPage.Plain {
  id: trackSelectPage

  Config { id: config }

  Component.onCompleted: {
    // Get the track list. Here it is prepared on startup.
    changeTrackList();
  }

  // This function is called from other places too. Do not
  // move code to 'Component.onCompleted {}' above.
  function changeTrackList ( ) {
    //backgroundImage.source = "file://" + config.getFilenameFromPart("Images/background.png");

    // Get the track list and check if empty. If empty, the select button
    // must be disabled. If not empty, set the previous selected entry
    // in the tracklist.
    lv.model = config.trackList();
    if ( lv.model.length === 0 ) {
      lv.contentHeight = 0;
      //selectButton.enabled = false;
    }

    else {
      currentIndex = config.getGpxFileIndexSetting();
      var entriesHeight = lv.model.length * 20;
      lv.contentHeight = 20 + entriesHeight;
      //selectButton.enabled = true;
    }
  }

  width: parent.width
  height: parent.height
  anchors.fill: parent

  HCParts.ButtonRow {
    id: toolbarButtons

    Component.onCompleted: {
      init(GlobalVariables.ToolbarButton);
      addButton("qrc:Qml/Button/OpenMenuTbButton.qml");
      addButton("qrc:Qml/Button/HomeTbButton.qml");
    }

    anchors.top: parent.top
  }

  // Set text of title via this property. Component is not yet ready
  //TODO: must set yet from track loading
  property string trackTitle
  property int currentIndex

  // A whitish transparent rectangle around title and list
  Rectangle {
    id: trackList

    width: parent.width
    radius: 7
    color: Qt.rgba(240,240,255,0.70)

    anchors {
      left: parent.left
      right: parent.right
      //top: parent.top
      //bottom: parent.bottom
      top: toolbarButtons.bottom
      bottom: footerButtons.top

      leftMargin: 5
      rightMargin: 5
      topMargin: 2
      bottomMargin: 2
    }

    // A fixed title from the tracks description on top
    HCText.TextTypes {
      id: titleText
      Component.onCompleted: {
        init(GlobalVariables.TitleText);
      }
      text: 'Tracks of this trail'  // trackSelectPage.trackTitle
    }

    // The list of tracks
    Rectangle {
      id: listEntries

      width: parent.width
      height: parent.height
      radius: 7
      color: properties.background //trackSelectPage.colors.window //GlobalVariables.setComponentBgColor(Theme.component.color)

      anchors {
        top: titleText.bottom
        bottom: parent.bottom
        left: parent.left
        right: parent.right

        leftMargin: properties.leftMargin
        rightMargin: properties.rightMargin
        topMargin: properties.topMargin
        bottomMargin: properties.bottomMargin
      }

      ListView {
        id: lv
        width: parent.width
        height: parent.height
        contentWidth: parent.width
/*
        anchors {
          leftMargin: 2
          rightMargin: 2
          topMargin: 4
          bottomMargin: 4
        }
*/
        clip: true

        currentIndex: trackSelectPage.currentIndex

        highlightResizeDuration: 1
        highlightMoveDuration: 400

        // A selected track
        highlight: Rectangle {

          width: parent.width
          height: Theme.listTextProperties.height
          radius: 7

          // Must be higher than 1 otherwise highlighting will be cut outside
          // a certain range.
          z: 2

          color: Theme.listTextProperties.textSelectedColor //trackSelectPage.colors.highlight //GlobalVariables.setComponentBgColor(Theme.component.color)
          opacity: 0.2//Theme.listTextProperties.bgTransparency

          border {
            width: Theme.listTextProperties.borderWidth
            color: Theme.listTextProperties.borderColor //trackSelectPage.colors.dark // GlobalVariables.setComponentFgColor(Theme.component.color)
          }
        }

        // All thracks
        delegate: Rectangle {
          width: parent.width
          height: Theme.listTextProperties.height

          MouseArea {
            anchors.fill: parent
            onClicked: {
              currentIndex = index
              trackSelectPage.currentIndex = currentIndex;
            }
          }

          // Parent rectangle gets background color. Here it must be transparent
          // otherwise it gets white.
          color: "transparent"

          HCText.TextTypes {
            id: wrapperText
            Component.onCompleted: {
              init(GlobalVariables.ListText);
            }
            text: "[" + index + "] " + modelData
          }
        }
      }
    }
  }

  HCParts.ButtonRow {
    id: footerButtons

    Component.onCompleted: {
      init(GlobalVariables.FooterBar);
      addButton("qrc:Qml/Button/TrackSelectButton.qml");
    }

    anchors.bottom: parent.bottom
  }
}
