import QtQuick 2.11
import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

import io.github.martimm.HikingCompanion.Textload 0.1
import "../.."
//import "../Menu" as HCMenu
//import "." as HCPage
import "../Parts" as HCParts
import "../Button" as HCButton
import io.github.martimm.HikingCompanion.Theme 0.1

Rectangle {
//Pane {
//  ColumnLayout {
  id: exitPage
//  objectName: "exitPage"
/*
  Component.onCompleted: {
    var b = pageToolbarRow.insertRowButton(
          "qrc:Qml/Button/OpenMenu.qml", {
            "id": "OMOnAbout_0"
          }
          );
    if ( b === null ) console.log("OpenMenu button create failed");

    b = pageToolbarRow.insertRowButton(
          ":Qml/Button/Home.qml", {
            "id": "OMOnAbout_1"
          }
          );
    if ( b === null ) console.log("Home button create failed");

    console.log("H EP: " + height);
  }
*/
  anchors.fill: parent

  width: parent.width
  height: parent.height - pageToolbarRow.height - pageButtonRow.height

  visible: false

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

  HCParts.InfoArea {
    width: parent.width
    height: parent.height

    anchors {
      left: parent.left
      right: parent.right
      top: pageToolbarRow.bottom
      bottom: pageButtonRow.top
    }

    TextLoad {
      id: exitTextData
      filename: ":Assets/Pages/exitText.html"
/*
    onFileRead: {
      exitText.text = TextLoad.text
    }
*/
    }

    text: exitTextData.text
  }

  Row {
    id: pageButtonRow

    // anchor only to the bottom because height of this and
    // footer row are known
    anchors.bottom: parent.bottom

    Button {
      text: qsTr("Exit")
      onClicked: {
        console.log("Exit click");
        Qt.exit(0);
      }
/*
      Connections {
        target: applicationRoot.parent
        onClicked: Qt.close()
      }
*/
    }

    Button {
      text: qsTr("Save Track")
      enabled: false
    }
  }

  /*
  HCDecoration.Header {
    id: header

    // only anchor to the top. height is known
    anchors.top: parent.top

    headerText: qsTr("exit page")
  }

  Flickable {
    id: flickable

    // clip content when going outside content borders
    clip: true

    // take away some space for the vertical scrollbar
    width: parent.width - 10
    height: parent.height - header.height -
            buttonRow.height - footer.height

    contentWidth: parent.width - 10
    contentHeight: exitText.height

    // anchor to the top and bottom because height is
    // variable
    anchors.top: header.bottom
    anchors.bottom: buttonRow.top

    Text {
      id: exitText

      width: parent.width
      height: parent.height

      anchors.top: parent.top
      anchors.bottom: parent.bottom

      wrapMode: Text.WordWrap
      text: exitTextData.text
      font.pixelSize: 18
      color: HCStyle.textColor
    }

    ScrollBar.vertical: ScrollBar {
      width: 10
      parent: flickable.parent

      anchors.top: flickable.top
      anchors.left: flickable.right
      anchors.bottom: flickable.bottom

      policy: ScrollBar.AlwaysOn
    }
  }
*/

/*
  HCDecoration.Footer {
    id: footer
    // only anchor to the bottom
    anchors.bottom: parent.bottom

    footerText: qsTr("exit page")
  }
*/
}
//}
