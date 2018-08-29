import "." as HCPage
import "../Button" as HCButton
import "../Parts" as HCParts

import io.github.martimm.HikingCompanion.Theme 0.1

import QtQuick 2.9
import QtQuick.Controls 2.2

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
      text: qsTr(" About page")
    }
  }
}
/*
  Row {
    id: root

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
      id: pageToolbarRow

      Button {
        id: OMOnAbout
      }
    }
*/
  /*
  Component.onCompleted: {
    pageToolbarRow.insertRowButton(
          //"../Button/OpenMenu.qml", {
            "qrc:OpenMenu.qml", {
            "id": "OMOnAbout_0"
          }
          );
    pageToolbarRow.insertRowButton(
          "qrc:Home.qml", {
            "id": "OMOnAbout_1"
          }
          );
  }
*/

  //text: qsTr("About")
  /*
  Text {
    text: qsTr("About")
    color: HCStyle.textColor
  }
*/
