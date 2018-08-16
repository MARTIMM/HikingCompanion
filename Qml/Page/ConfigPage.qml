import "." as HCPage
import "../Button" as HCButton
import "../Parts" as HCParts

import io.github.martimm.HikingCompanion.Theme 0.1

import QtQuick 2.11
import QtQuick.Controls 2.4

HCPage.Plain {
  id: aboutPage

  width: parent.width
  height: parent.height
  anchors.fill: parent
  visible: false

  HCParts.ToolbarRow {
    id: pageToolbarRow

    HCButton.OpenMenu {  }
    HCButton.Home {  }

    Text {
      text: "config page"
    }
  }

  HCParts.PageButtonRow {
    id: pageButtonRow

    anchors.bottom: parent.bottom

    Button {
      width: textMetrics.boundingRect.width + 30
      text: qsTr("Save")
      onClicked: {
        console.log("Save click");
      }
    }
  }
}




/*
import QtQuick 2.11
import QtQuick.Controls 2.2
//import QtQuick.Layouts 1.3
import QtQuick.Templates 2.1 as T


import "../.."
//import "../Menu" as HCMenu
import "../Button" as HCButton
import "../Parts" as HCParts
//import "." as HCPage
import io.github.martimm.HikingCompanion.Config 0.2
//import io.github.martimm.HikingCompanion.HCStyle 0.1
//import io.github.martimm.HikingCompanion.GlobalVariables 0.1
import io.github.martimm.HikingCompanion.Theme 0.1
//import Theme 0.1

Rectangle {
  id: configPage

  Config {
    id: config
    onUsernameChanged: {
      console.log("username from data: " + config.username);
      username.inputText.text = config.username;
    }

    onEmailChanged: {
      email.inputText.text = config.email;
    }

    onLanguageChanged: {
      language.currentIndex = config.language;
    }
  }

  property string osType
  Row {
    id: pageToolbarRow

    height: Theme.largeButtonHeight + 2
    width: parent.width
    z: 50

    spacing: 2
    layoutDirection: Qt.RightToLeft

    anchors {
      right: parent.right
      rightMargin: 14
      left: parent.left
      leftMargin: 6
      topMargin: 4
      bottom: parent.bottom
      bottomMargin: 1
    }

    HCButton.OpenMenu { }
    HCButton.Home { }
  }

  Component.onCompleted: {
*/
/*
    pageToolbarRow.insertRowButton(
          "qrc:OpenMenu.qml", {
            "id": "OMOnAbout_0"
          }
          );
    pageToolbarRow.insertRowButton(
          "qrc:Home.qml", {
            "id": "OMOnAbout_1"
          }
          );
*/
/*
    configPage.osType = config.osType
    console.log("os: " + configPage.osType)
    var x = config.readProperties;
    console.log("Read: " + x);
  }

  width: parent.width
  height: parent.height
  anchors.fill: parent
  visible: false

  property int fieldMargin: 6
  property int leftWidth: 3 * width / 10 - fieldMargin
  property int rightWidth: 7 * width / 10 - fieldMargin
  property Grid configGrid: configGrid

  Grid {
    id: configGrid

    columns: 2
    width: parent.width
    height: parent.height - pageToolbarRow.height - pageButtonRow.height

    anchors {
      left: parent.left
      leftMargin: fieldMargin
      right: parent.right
      rightMargin: fieldMargin
      top: pageToolbarRow.bottom
      bottom: pageButtonRow.top
    }


    HCParts.ConfigLabel {
      text: qsTr("Language")
      width: leftWidth
      //anchors.topMargin: 10
    }

    HCParts.ConfigComboBox {
      id: language
      width: rightWidth
      model: [ "English", "Nederlands"]
    }


    HCParts.ConfigLabel {
      text: qsTr("Name")
      width: leftWidth
    }

    HCParts.ConfigInputText {
      id: username
      placeholderText: qsTr("type your name here")
      width: rightWidth
      inputText.validator: RegExpValidator {
        regExp: /^\w+$/
      }
    }


    HCParts.ConfigLabel {
      text: qsTr("Email address")
      width: leftWidth
    }

    HCParts.ConfigInputText {
      id: email
      placeholderText: qsTr("type your email address here")
      width: rightWidth
      inputText.validator: RegExpValidator {
        regExp: /^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/
      }
    }
  }

  HCButton.PageButtonRow {
    id: pageButtonRow

    anchors.bottom: parent.bottom
    Button {
      text: qsTr("Save")
      onClicked: {
        config.language = language.currentIndex;
        config.username = username.inputText.text;
        config.email = email.inputText.text;
      }
    }

*/
/*
    HCButton.PageButtonBase {
      text: qsTr("Save")
      onClicked: {
        config.language = language.currentIndex;
        config.username = username.inputText.text;
        config.email = email.inputText.text;
      }
    }
*/
/*
  }
}
*/
