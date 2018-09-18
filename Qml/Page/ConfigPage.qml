import "." as HCPage
import "../Button" as HCButton
import "../Parts" as HCParts

import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.Config 0.3
import io.github.martimm.HikingCompanion.Languages 0.2
import io.github.martimm.HikingCompanion.Hikes 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.9
import QtQuick.Controls 2.2

HCPage.Plain {
  id: configPage

  //property string osType

  width: parent.width
  height: parent.height
  anchors.fill: parent

  Component.onCompleted: {
    // Define the list of languages after which the method will emit
    // the languageListChanged signal. Do the same for tracks.
    lngs.defineLanguages();
    hikes.defineHikeList();

    username.inputText.text = config.getSetting("User/username");
    email.inputText.text = config.getSetting("User/email");
  }

  Languages {
    id: lngs

    // Set the model data and the saved index of a previously
    // chosen language
    onLanguageListChanged: {
      configGrid.languageRow.cbx1.model = lngs.languageList();
      configGrid.languageRow.cbx1.currentIndex = parseInt(config.getSetting("languageindex"));
    }
  }

  Hikes {
    id: hikes

    onHikeListDefined: {
      configGrid.hikeRow.cbx2.model = hikes.hikeList();
      console.log("hikes: " + hikes.hikeList());
      configGrid.hikeRow.cbx2.currentIndex = parseInt(config.getSetting("selectedhikeindex"));
    }
  }

  Config { id: config }

  HCParts.ToolbarRow {
    id: pageToolbarRow

    HCButton.OpenMenu {  }
    HCButton.Home {  }

    Text {
      text: qsTr(" Configuration page")
    }
  }

  property int leftWidth: 3 * width / 10 - Theme.cfgFieldMargin
  property int rightWidth: 7 * width / 10 - Theme.cfgFieldMargin

  property alias configGrid: configGrid
  Grid {
    id: configGrid

    columns: 1
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


    // Selection of a language
    property alias languageRow: languageRow
    Row {
      id: languageRow
      width: parent.width
      height: Theme.cfgRowHeight
      spacing: 2

      HCParts.ConfigLabel {
        text: qsTr("Language")
        width: leftWidth
        height: parent.height
      }

      property alias cbx1: cbx1
      ComboBox {
        id: cbx1
        width: rightWidth
        height: parent.height
      }
    }

    // Setting consent of privacy variables
    Row {
      width: parent.width
      height: Theme.cfgRowHeight
      spacing: 2

      HCParts.ConfigLabel {
        text: qsTr("Consent")
        width: leftWidth
        height: parent.height
      }

      HCParts.ConfigSwitch {
        id: consent
        width: rightWidth
        height: parent.height
        text: ""
        onSwitched: {
          if ( consent.checked ) {
            username.enabled = true;
            email.enabled = true;
          }

          else {
            username.enabled = false;
            email.enabled = false;
          }
        }
      }
    }

    // Input of username
    Row {
      width: parent.width
      height: Theme.cfgRowHeight
      spacing: 2

      HCParts.ConfigLabel {
        text: qsTr("Name")
        width: leftWidth
        height: parent.height
      }

      HCParts.ConfigInputText {
        id: username
        width: rightWidth
        height: parent.height

        placeholderText: qsTr("type your name here")
        inputText.validator: RegExpValidator {
          regExp: /^\w+$/
        }
      }
    }

    // Input of email address
    Row {
      width: parent.width
      height: Theme.cfgRowHeight
      spacing: 2

      HCParts.ConfigLabel {
        text: qsTr("Email address")
        width: leftWidth
        height: parent.height
      }

      HCParts.ConfigInputText {
        id: email
        width: rightWidth
        height: parent.height

        placeholderText: qsTr("type your email address here")
        inputText.validator: RegExpValidator {
          regExp: /^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/
        }
      }
    }

    // Selection of a hike
    property alias hikeRow: hikeRow
    Row {
      id: hikeRow
      width: parent.width
      height: Theme.cfgRowHeight
      spacing: 2

      HCParts.ConfigLabel {
        text: qsTr("Hike/trips")
        width: leftWidth
        height: parent.height
      }

      property alias cbx2: cbx2
      ComboBox {
        id: cbx2
        width: rightWidth
        height: parent.height
      }
    }
  }

  HCParts.PageButtonRow {
    id: pageButtonRow

    anchors.bottom: parent.bottom

    Button {
      width: textMetrics.boundingRect.width + 30
      text: qsTr("Save")
      onClicked: {
        config.setSetting( "languageindex", configGrid.languageRow.cbx1.currentIndex);
        config.setSetting( "User/username", username.inputText.text);
        config.setSetting( "User/email", email.inputText.text);
        config.setSetting( "selectedhikeindex", configGrid.hikeRow.cbx2.currentIndex);

        GlobalVariables.tracksPage.changeTrackList();
      }
    }
  }
}
