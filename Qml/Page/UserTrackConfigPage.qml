import "." as HCPage
import "../Button" as HCButton
import "../Parts" as HCParts

import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.Config 0.3

import QtQuick 2.11
//import QtQuick.Controls 2.4
//import QtQuick.Layouts 1.11
import QtQuick.Controls 1.4

HCPage.Plain {
  id: userTrackConfigPage

  width: parent.width
  height: parent.height
  anchors.fill: parent

  Component.onCompleted: {
    console.log("UTCP");

    // Save settings from this page
    hikeKey.inputText.text = config.getSetting("User/hikekey");
    hikeTitle.inputText.text = config.getSetting("User/hiketitle");
    hikeDesc.inputText.text = config.getSetting("User/hikedescr");
    trackTitle.inputText.text = config.getSetting("User/tracktitle");
    trackDesc.inputText.text = config.getSetting("User/trackdescr");
    trackType.rbWalk.checked =
        config.getSetting("User/tracktype") === "W" ? true : false;
  }


  Config {
    id: config
  }

  HCParts.ToolbarRectangle {
    id: pageToolbarRow

    HCParts.ToolbarRow {
      HCButton.OpenMenu { }
      HCButton.Home { }

      Text {
        text: qsTr("User tracks configuration page")
      }
    }
  }



  property alias configGrid: configGrid
  Grid {
    id: configGrid

    columns: 2
    spacing: 2
    width: parent.width
    height: parent.height - pageToolbarRow.height - pageButtonRow.height

    anchors {
      left: parent.left
      right: parent.right
      top: pageToolbarRow.bottom
      bottom: pageButtonRow.top

      leftMargin: Theme.cfgFieldMargin
      rightMargin: Theme.cfgFieldMargin
      topMargin: 2
      bottomMargin: 2
    }

    property int labelWidth: 3 * parent.width / 10 - Theme.cfgFieldMargin
    property int inputWidth: 7 * parent.width / 10 - Theme.cfgFieldMargin
    property int configHeight: Theme.cfgRowHeight

    // Generate key when not provided using sha1 on title
    // Hike key of all tracks
    HCParts.ConfigLabel { text: qsTr("Hike key") }
    HCParts.ConfigInputText {
      id: hikeKey
      inputText.validator: RegExpValidator {
        regExp: /^[a-zA-Z0-9=_-]+$/
      }
    }

    // Hike title of all tracks
    HCParts.ConfigLabel { text: qsTr("Hike title") }
    HCParts.ConfigInputText { id: hikeTitle }

    // Short hike description
    HCParts.ConfigLabel { text: qsTr("Hike description") }
    HCParts.ConfigInputText { id: hikeDesc }

    // Track title
    HCParts.ConfigLabel { text: qsTr("Track title") }
    HCParts.ConfigInputText { id: trackTitle }

    // Short track description
    HCParts.ConfigLabel { text: qsTr("Track description") }
    HCParts.ConfigInputText { id: trackDesc }

    // Track type; walk or bike
    HCParts.ConfigLabel { text: qsTr("Type") }
    Row {
      id: trackType
      property alias rbWalk: rbWalk
      property alias rbBike: rbBike

      ExclusiveGroup { id: tabPositionGroup }
      RadioButton {
        id: rbWalk
        text: "Walk"
        checked: true
        exclusiveGroup: tabPositionGroup
      }
      RadioButton {
        id: rbBike
        text: "Bike"
        exclusiveGroup: tabPositionGroup
      }
    }

    // Recording buttons
    HCParts.ConfigLabel { text: qsTr("Recording") }
    Row {
      id: recordingButtonRow

      HCButton.ButtonRowButton {
        id: startButton
        text: qsTr("Start")
        onClicked: {
          startButton.enabled = false;
          stopButton.enabled = true;
          pauseButton.enabled = true;
        }
      }

      HCButton.ButtonRowButton {
        id: stopButton
        text: qsTr("Stop")
        enabled: false
        onClicked: {
          startButton.enabled = true;
          stopButton.enabled = false;
          pauseButton.enabled = false;
          contButton.enabled = false;
        }
      }
    }

    // Recording buttons
    HCParts.ConfigLabel { text: qsTr("Pause Rec.") }
    Row {
      id: pauseRecButtonRow

      HCButton.ButtonRowButton {
        id: pauseButton
        text: qsTr("Pause")
        enabled: false
        onClicked: {
          pauseButton.enabled = false;
          contButton.enabled = true;
        }
      }

      HCButton.ButtonRowButton {
        id: contButton
        text: qsTr("Continue")
        enabled: false
        onClicked: {
          pauseButton.enabled = true;
          contButton.enabled = false;
        }
      }
    }
  }


  HCParts.PageButtonRow {
    id: pageButtonRow

    anchors.bottom: parent.bottom

    HCButton.ButtonRowButton {
      text: qsTr("Save")
      onClicked: {
        // Save settings from this page
        config.setSetting( "User/hikekey", hikeKey.inputText.text);
        config.setSetting( "User/hiketitle", hikeTitle.inputText.text);
        config.setSetting( "User/hikedescr", hikeDesc.inputText.text);
        config.setSetting( "User/tracktitle", trackTitle.inputText.text);
        config.setSetting( "User/trackdescr", trackDesc.inputText.text);
        config.setSetting(
              "User/tracktype", trackType.rbWalk.checked ? "W" : "B"
              );

        config.saveUserTrackNames(
              hikeTitle.inputText.text, hikeDesc.inputText.text,
              hikeKey.inputText.text
              );
      }
    }
/*
    HCButton.ButtonRowButton {
      text: qsTr("Note")
      enabled: false
      onClicked: {
      }
    }

    HCButton.ButtonRowButton {
      text: qsTr("Camera")
      enabled: false
      onClicked: {
      }
    }
*/
  }
}
