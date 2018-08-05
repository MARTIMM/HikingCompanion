
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
    console.log("CP W: " + width)
  }

  width: parent.width
  height: parent.height
  anchors.fill: parent
  visible: false

  ListModel {
    id: itemList

    ListElement {
      label: qsTr("Name")
      phText: qsTr("type your name here")
    }

    ListElement {
      label: qsTr("Email address")
      phText: qsTr("type your email address here")
    }
  }

  GridView {
    id: configItems

    Component.onCompleted: {
      console.log("GV W: " + width)
    }

    width: parent.width
    height: parent.height - pageToolbarRow.height - pageButtonRow.height

    anchors {
      left: parent.left
      right: parent.right
      top: pageToolbarRow.bottom
      bottom: pageButtonRow.top
    }

    //columns: 2
    //spacing: 2
    //flow: Grid.LeftToRight

    model: itemList
    delegate: Column {
      Component.onCompleted: {
        console.log("GV C W: " + width)
      }

      width: parent.width
      Row {
        width: parent.width
        //spacing: 2

        HCParts.ConfigLabel {
          text: label
          //width: parent.width / 2
          //height: Style.cfgTextHeight
        }

        HCParts.ConfigInputText {
          placeholderText: phText
          //width: parent.width / 2
          //height: Style.cfgTextHeight
        }

        /*
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
*/

        /*
                Rectangle {
                  Text {
                    text: label
                    color: "#000"
                    width: parent.width / 2
                    height: 20
                  }
                }

                Rectangle {
                  TextField {
                    placeholderText: placeholderText
                    color: "#000"
                    width: parent.width / 2
                    height: 20
                  }
                }
        */
      }
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
