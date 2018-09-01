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

  //property string osType

  width: parent.width
  height: parent.height
  anchors.fill: parent

  Component.onCompleted: {
    languages.currentIndex = config.languageIndex;
    username.inputText.text = config.username;
    email.inputText.text = config.email;
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
        config.languageIndex = languages.currentIndex;
        config.username = username.inputText.text;
        config.email = email.inputText.text;
      }
    }
  }
}
