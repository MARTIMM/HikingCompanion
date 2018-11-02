import "." as HCPage
import "../Button" as HCButton
import "../Parts" as HCParts

import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.Config 0.3
import io.github.martimm.HikingCompanion.Languages 0.2
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.11
import QtQuick.Controls 2.4

HCPage.Plain {
  id: configPage

  //property string osType

  width: parent.width
  height: parent.height
  anchors.fill: parent

  Component.onCompleted: {
    // Define the list of languages after which the method will emit
    // the languageListChanged signal. Do the same for hikes and
    // catch signal hikeListDefined.
    lngs.defineLanguages();
    config.defineHikeList();

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

  Config {
    id: config

    onHikeListDefined: {
      configGrid.hikeRow.cbx2.model = config.hikeList();
      console.log("hikes: " + config.hikeList());
      configGrid.hikeRow.cbx2.currentIndex = parseInt(config.getSetting("selectedhikeindex"));
    }
  }

  HCParts.ToolbarRectangle {
    id: pageToolbarRow

    HCParts.ToolbarRow {
      HCButton.OpenMenu { }
      HCButton.Home { }

      Text {
        text: qsTr(" Configuration page")
      }
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
        onSwitched: { switchIt(); }
        Component.onCompleted: { switchIt(); }

        function switchIt ( ) {
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

    HCButton.ButtonRowButton {
      //width: textMetrics.boundingRect.width + 30
      //width: 50
      text: qsTr("Save")
      onClicked: {
        // Save settings from this page
        config.setSetting( "languageindex", configGrid.languageRow.cbx1.currentIndex);
        config.setSetting( "User/username", username.inputText.text);
        config.setSetting( "User/email", email.inputText.text);

        // If there aren't any hikes on the list, do a cleanup.
        if ( configGrid.hikeRow.cbx2.model.length === 0 ) {
          config.cleanupTracks();
        }

        // Set the tracklist on the TracksPage
        else {
          config.setSetting( "selectedhikeindex", configGrid.hikeRow.cbx2.currentIndex);
          GlobalVariables.tracksPage.changeTrackList();
        }

        // Set the theme for this hike
        var t = config.getTheme();
//        console.log("style: " + t);
        Theme.changeClrs(JSON.parse(t));

        // Signal the change to the other pages
        GlobalVariables.applicationPage.aboutPage.changeContent();
      }
    }

    // TODO: Dialog window
    HCButton.ButtonRowButton {
      text: qsTr("Remove Hike")
      onClicked: {
        config.setSetting( "selectedhikeindex", configGrid.hikeRow.cbx2.currentIndex);
        config.cleanupHike();
        GlobalVariables.tracksPage.changeTrackList();
        config.defineHikeList();

        // Set the theme for this hike
        var t = config.getTheme();
//        console.log("style: " + t);
        Theme.changeClrs(JSON.parse(t));

        // Signal the change to the other pages
        GlobalVariables.applicationPage.aboutPage.changeContent();
      }
    }
  }
}
