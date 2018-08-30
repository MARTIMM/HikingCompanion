import "." as HCPage
import "../Button" as HCButton
import "../Parts" as HCParts

import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.Config 0.3
//import io.github.martimm.HikingCompanion.Language 0.2
//import io.github.martimm.HikingCompanion.Languages 0.1

import QtQuick 2.9
import QtQuick.Controls 2.2

HCPage.Plain {
  id: configPage

  property string osType

  width: parent.width
  height: parent.height
  anchors.fill: parent

  Component.onCompleted: {
    //configPage.osType = config.osType;
    config.readProperties;

//    console.log("language list: " + lngs.languageList);
  }

//  Languages { id: lngs }

  Config {
    id: config

    // This is using languageList() to set items in Config::_languages
/*
    languageList: [
      Language { name: "English" },   // using append functions from Config
      Language { name: "Nederlands" } // to add the Language objects
    ]
*//*
    onLanguageListChanged: {
      console.log("language list changed: " + config.languageList);
    }
*/
    onUsernameChanged: {
      console.log("username from data: " + config.username);
      username.inputText.text = config.username;
    }

    onEmailChanged: {
      console.log("email from data: " + config.email);
      email.inputText.text = config.email;
    }

    onLanguageChanged: {
      console.log("currentIndex from data: " + config.language);
      language.currentIndex = config.language;
    }
  }

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

  property Grid configGrid: configGrid
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
    property Row languageRow: languageRow
    Row {
      id: languageRow
      width: parent.width
      height: Theme.cfgRowHeight
      spacing: 2

      HCParts.ConfigLabel {
        text: qsTr("Language")
        width: leftWidth
        height: parent.height
        //anchors.topMargin: 10
      }

      property ComboBox languages: languages
      ComboBox {
        id: languages
        width: rightWidth
        height: parent.height
        model: [ "English", "Nederlands"]
        //model: lngs.languageList
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
        //anchors.topMargin: 10
      }

      HCParts.ConfigSwitch {
        id: consent
        width: rightWidth
        height: parent.height
        text: ""
        //scale: 0.8
        //z: 50
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
  }

  HCParts.PageButtonRow {
    id: pageButtonRow

    anchors.bottom: parent.bottom

    Button {
      width: textMetrics.boundingRect.width + 30
      text: qsTr("Save")
      onClicked: {
        config.language = languages.currentIndex;
        config.username = username.inputText.text;
        config.email = email.inputText.text;
      }
    }
  }
}




/*
import QtQuick 2.9
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
      language.language = config.language;
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

*/
/*
  Component.onCompleted: {
    configPage.osType = config.osType
    console.log("os: " + configPage.osType)
    var x = config.readProperties;
    console.log("Read: " + x);
  }

  width: parent.width
  height: parent.height
  anchors.fill: parent
  visible: false

  property int Theme.cfgFieldMargin: 6
  property int leftWidth: 3 * width / 10 - Theme.cfgFieldMargin
  property int rightWidth: 7 * width / 10 - Theme.cfgFieldMargin
  property Grid configGrid: configGrid

  Grid {
    id: configGrid

    columns: 2
    width: parent.width
    height: parent.height - pageToolbarRow.height - pageButtonRow.height

    anchors {
      left: parent.left
      leftMargin: Theme.cfgFieldMargin
      right: parent.right
      rightMargin: Theme.cfgFieldMargin
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
