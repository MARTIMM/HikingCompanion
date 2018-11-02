import "." as HCPage
import "../Button" as HCButton
import "../Parts" as HCParts

import io.github.martimm.HikingCompanion.Config 0.3
import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.Textload 0.1

import QtQuick 2.11

import QtQuick.Controls 2.4

HCPage.Plain {
  id: userTrackConfigPage

  width: parent.width
  height: parent.height
  anchors.fill: parent

  Component.onCompleted: {
/*
    lngs.defineLanguages();
    config.defineHikeList();

    username.inputText.text = config.getSetting("User/username");
    email.inputText.text = config.getSetting("User/email");
    consent.checked = config.getSetting("User/consent") === "1" ? true : false;
    console.log("consent: " + consent.checked + ", " + config.getSetting("User/consent"));
*/
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

    //rows: 5
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
    }

    property int labelWidth: 3 * parent.width / 10 - Theme.cfgFieldMargin
    property int inputWidth: 7 * parent.width / 10 - Theme.cfgFieldMargin
    property int configHeight: Theme.cfgRowHeight


    // Selection of a language
    HCParts.ConfigLabel { text: qsTr("Language") }
    ComboBox {
      id: cbx1
      width: rightWidth
      height: Theme.cfgRowHeight
    }


    // Setting consent of privacy variables
    HCParts.ConfigLabel { text: qsTr("Hike name") }
    HCParts.ConfigInputText {
      id: email
      placeholderText: qsTr("type your email address here")
      inputText.validator: RegExpValidator {
        regExp: /^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/
      }
    }
  }

  HCParts.PageButtonRow {
    id: pageButtonRow

    anchors.bottom: parent.bottom

    HCButton.ButtonRowButton {
      text: qsTr("Save")
      onClicked: {
/*
        // Save settings from this page
        config.setSetting( "languageindex", cbx1.currentIndex);
        config.setSetting( "User/username", username.inputText.text);
        config.setSetting( "User/email", email.inputText.text);
        config.setSetting( "User/consent", consent.checked);
*/
      }
    }

    HCButton.ButtonRowButton {
      text: qsTr("Start")
      onClicked: {
      }
    }

    HCButton.ButtonRowButton {
      text: qsTr("Pause")
      onClicked: {
      }
    }

    HCButton.ButtonRowButton {
      text: qsTr("Continue")
      onClicked: {
      }
    }

    HCButton.ButtonRowButton {
      text: qsTr("Stop")
      onClicked: {
      }
    }
  }
}
