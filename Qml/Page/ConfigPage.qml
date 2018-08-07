
import QtQuick 2.11
//import QtQuick.Controls 2.2
//import QtQuick.Layouts 1.3

import "../.."
//import "../Menu" as HCMenu
import "../Button" as HCButton
import "../Parts" as HCParts
import "." as HCPage
import io.github.martimm.HikingCompanion.Config 0.2
import io.github.martimm.HikingCompanion.Style 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

HCPage.Base {
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

  Component.onCompleted: {
    pageToolbarRow.insertRowButton(
          "../Button/OpenMenu.qml", {
            "id": "OMOnAbout_0"
          }
          );
    pageToolbarRow.insertRowButton(
          "../Button/Home.qml", {
            "id": "OMOnAbout_1"
          }
          );

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

    HCButton.PageButtonBase {
      text: qsTr("Save")
      onClicked: {
        config.language = language.currentIndex;
        config.username = username.inputText.text;
        config.email = email.inputText.text;
      }
    }
  }
}
