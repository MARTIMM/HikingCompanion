
import QtQuick 2.11
import QtQuick.Controls 2.2
//import QtQuick.Layouts 1.3

import "../.."
//import "../Menu" as HCMenu
import "../Button" as HCButton
import "../Parts" as HCParts
import "." as HCPage
import io.github.martimm.HikingCompanion.Config 0.1
import io.github.martimm.HikingCompanion.Style 0.1

HCPage.Base {
  id: configPage

  Config { id: config }

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
//    console.log("osType: " + configPage.osType)
  }

  anchors.fill: parent
  visible: false
/*
  ListModel {
    id: itemList

    ListElement {
      label: qsTr("Name")
      placeholderText: qsTr("type your name here")
    }

    ListElement {
      label: qsTr("Email address")
      placeholderText: qsTr("type your email address here")
    }
  }
*/

  Column {
    id: configItems

    width: parent.width
    height: parent.height - pageToolbarRow.height - pageButtonRow.height

    anchors {
      left: parent.left
      right: parent.right
      top: pageToolbarRow.bottom
      bottom: pageButtonRow.top
    }

    Component.onCompleted: {
      console.log("C W: " + width)
    }

    //columns: 2
    //spacing: 2
    //flow: Grid.LeftToRight

//    model: itemList
//    delegate: Column {
      Row {
        width: parent.width
//        spacing: 2
/*
        Rectangle {
          Text {
            text: "abc"
            color: "#000"
            anchors.left: parent.left
            width: parent.width / 2
            height: 20
          }
        }

        Rectangle {
          TextField {
            placeholderText: "pl"
            color: "#000"
            anchors.right: parent.right
            width: parent.width / 2
            height: 20
          }
        }
*/

        HCParts.ConfigLabel {
          id: labelOfItem
          //anchors.left: parent.left
          text: qsTr("Name")
          width: parent.width / 2
          height: Style.cfgTextHeight
        }

        HCParts.ConfigInputText {
          //anchors.left: labelOfItem.right
          //anchors.right: parent.right
          placeholderText: qsTr("type your name here")
          width: parent.width / 2
          height: Style.cfgTextHeight
        }

      //}
    }
  }

  HCButton.PageButtonRow {
    id: pageButtonRow

    // anchor only to the bottom because height of this and
    // footer row are known
    anchors.bottom: parent.bottom

    HCButton.PageButtonBase {
      text: qsTr("Save")
      enabled: false
    }
  }
}
