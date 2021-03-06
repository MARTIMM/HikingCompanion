import "." as HCPage
import "../Button" as HCButton
import "../Parts" as HCParts
import "../Dialog" as HCDialog

import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.Config 0.3
import io.github.martimm.HikingCompanion.Languages 0.2
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Dialogs 1.2

HCPage.Plain {
  id: configPage

  //property string osType

  width: parent.width
  height: parent.height
  anchors.fill: parent

  Component.onCompleted: {
    //backgroundImage.source = "file://" + config.getFilenameFromPart("Images/background.png");

    // Define the list of languages after which the method will emit
    // the languageListChanged signal. Do the same for hikes and
    // catch signal hikeListDefined.
    lngs.defineLanguages();
    config.defineHikeList();

    username.inputText.text = config.getSetting("User/username");
    email.inputText.text = config.getSetting("User/email");
    consent.checked = config.getSetting("User/consent") === "1" ? true : false;
  }

  Languages {
    id: lngs

    // Set the model data and the saved index of a previously
    // chosen language
    onLanguageListChanged: {
      cbx1.model = lngs.languageList();
      cbx1.currentIndex = parseInt(config.getSetting("languageindex"));
    }
  }

  Config {
    id: config

    onHikeListDefined: {
      cbx2.model = config.hikeList();
      console.log("hikes: " + config.hikeList());
      cbx2.currentIndex = parseInt(config.getSetting("selectedhikeindex"));
    }
  }

/*
  property alias pageToolbarRow: pageToolbarRow
  HCParts.ToolbarRectangle {
    id: pageToolbarRow

    HCParts.ToolbarRow {
      HCButton.OpenMenu { }
      HCButton.Home { }
    }
  }
*/

  HCParts.ButtonRow {
    id: toolbarButtons

    Component.onCompleted: {
      init(GlobalVariables.ToolbarButton);
      addButton("qrc:Qml/Button/OpenMenuTbButton.qml");
      addButton("qrc:Qml/Button/HomeTbButton.qml");
    }

    anchors.top: parent.top
  }

  property int leftWidth: 3 * width / 10 - Theme.cfgFieldMargin
  property int rightWidth: 7 * width / 10 - Theme.cfgFieldMargin

/*
  Rectangle {
    color: Qt.rgba(240,240,255,0.90)
    radius: 7

    width: parent.width
    height: parent.height - pageToolbarRow.height - footerButtons.height
    //anchors.fill: parent

    anchors {
      left: parent.left
      right: parent.right
      //top: parent.top
      //bottom: parent.bottom
      top: toolbarButtons.bottom
      bottom: footerButtons.top

      leftMargin: 0
      rightMargin: 0
      topMargin: 0
      bottomMargin: 0
    }
  }
*/
/**/
  property alias configGrid: configGrid
  Grid {
    id: configGrid

    //rows: 5
    columns: 2
    spacing: 2
    width: parent.width
    height: parent.height - toolbarButtons.height - footerButtons.height

    anchors {
      left: parent.left
      right: parent.right
      top: toolbarButtons.bottom
      bottom: footerButtons.top

      leftMargin: Theme.cfgFieldMargin
      rightMargin: Theme.cfgFieldMargin
      topMargin: 2
      bottomMargin: 2
    }

    property int labelWidth: 3 * parent.width / 10 - Theme.cfgFieldMargin
    property int inputWidth: 7 * parent.width / 10 - Theme.cfgFieldMargin
    property int configHeight: Theme.cfgRowHeight

    function labelWidth() { return leftWidth; }
    function inputWidth() { return rightWidth; }

    // Selection of a language
    HCParts.ConfigLabel { text: qsTr("Language") }
    ComboBox {
      id: cbx1
      width: rightWidth
      height: Theme.cfgRowHeight
      //editable: false
    }


    // Setting consent of privacy variables
    HCParts.ConfigLabel { text: qsTr("Consent") }
    HCParts.ConfigSwitch {
      id: consent
      width: rightWidth
      height: Theme.cfgRowHeight
      text: ""
      controlObjects: [ usernameLabel, username, emailLabel, email]
    }


    // Input of username
    HCParts.ConfigLabel {
      id: usernameLabel
      text: qsTr("Name")
    }
    HCParts.ConfigInputText {
      id: username
      placeholderText: qsTr("type your name here")
      inputText.validator: RegExpValidator { regExp: /^[\s\w]+$/ }
    }


    // Input of email address
    HCParts.ConfigLabel {
      id: emailLabel
      text: qsTr("Email address")
    }
    HCParts.ConfigInputText {
      id: email
      placeholderText: qsTr("type your email address here")
      inputText.validator: RegExpValidator {
        regExp: /^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/
      }
    }


    // Selection of a hike
    HCParts.ConfigLabel { text: qsTr("Hike/trips") }
    ComboBox {
      id: cbx2
      width: rightWidth
      height: Theme.cfgRowHeight
    }
  }

  HCParts.ButtonRow {
    id: footerButtons

    Component.onCompleted: {
      init(GlobalVariables.FooterBar);
//TODO 'Save config', 'Remove Hike' -> HikeSelectPage?
//      addButton("qrc:Qml/Button/TrackSelectButton.qml");
    }

    anchors.bottom: parent.bottom
  }


/*
  property alias pageButtonRow: pageButtonRow
  HCParts.PageButtonRowRectangle {
    id: pageButtonRow
    HCParts.PageButtonRow {
      anchors.bottom: parent.bottom

      HCButton.ButtonRowButton {
        text: qsTr("Save")
        onClicked: {
          // Save settings from this page
          config.setSetting( "languageindex", cbx1.currentIndex);
          config.setSetting( "User/username", username.inputText.text);
          config.setSetting( "User/email", email.inputText.text);
          config.setSetting( "User/consent", consent.checked);

          // If there aren't any hikes on the list, do a cleanup.
          if ( cbx2.model.length === 0 ) {
            config.cleanupTracks();
          }

          // Set the tracklist on the trackSelectPage
          else {
            if ( GlobalVariables.applicationWindow &&
                GlobalVariables.applicationWindow.trackSelectPage
                ) {
              config.setSetting( "selectedhikeindex", cbx2.currentIndex);
              GlobalVariables.applicationWindow.trackSelectPage.changeTrackList();
            }
          }

          // Set the theme for this hike
          var t = config.getTheme(false);
          Theme.changeColors(JSON.parse(t));

          // Change texts on front and about page
          GlobalVariables.applicationWindow.homePage.changeContent();
          GlobalVariables.applicationWindow.aboutPage.changeContent();

          // Change the background image for each page
          var pages = [
                "aboutPage", "configPage", "exitPage", "homePage",
                "trackSelectPage", "userTrackConfigPage"
              ];
          var fn = function ( page ) {
            GlobalVariables.applicationWindow[page].backgroundImage.source =
              "file://" + config.getFilenameFromPart("Images/background.png");
          }

          pages.forEach(fn);
        }
      }

      // TODO: Dialog window
      HCButton.ButtonRowButton {

        HCDialog.YesNoDialog {
          id: removeHike
          messageText: 'Do you really want to remove the hike?'
          titleText: 'Remove Hike Dialog'
          standardButtons: StandardButton.Yes | StandardButton.No
          onYes: {
            console.info("Yes typed");
            removeHike.close()
          }

          onNo: {
            console.info("No typed");
            removeHike.close()
          }
        }

        text: qsTr("Remove Hike")
        onClicked: {
          removeHike.open();
          if ( GlobalVariables.applicationWindow ) {
            config.setSetting( "selectedhikeindex", cbx2.currentIndex);
            config.cleanupHike();

            if ( GlobalVariables.applicationWindow.trackSelectPage ) {
              GlobalVariables.applicationWindow.trackSelectPage.changeTrackList();
            }

            config.defineHikeList();

            // Set the theme for this hike
            var t = config.getTheme();
            Theme.changeColors(JSON.parse(t));

            // Signal the change to the other pages
            if ( GlobalVariables.applicationWindow.aboutPage ) {
              GlobalVariables.applicationWindow.aboutPage.changeContent();
            }
          }

        }
      }
    }
  }
  */
}
