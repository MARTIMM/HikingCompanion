import "." as HCPage
import "../Button" as HCButton
import "../Parts" as HCParts

import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.Textload 0.1

import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

HCPage.Plain {
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
  width: parent.width
  height: parent.height
  anchors.fill: parent

  HCParts.ToolbarRow {
    id: pageToolbarRow

    HCButton.OpenMenu {  }
    HCButton.Home { }

    Text {
      text: qsTr(" Exit page")
    }
  }

  HCParts.InfoArea {
    id: exitText

    width: parent.width
    height: parent.height
    //anchors.fill: parent

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
      onTextReady: {
        console.log("Text ready...");
        exitText.text = exitTextData.text
      }
*/
    }

    text: exitTextData.text
  }

  HCParts.PageButtonRow {
    id: pageButtonRow

    anchors.bottom: parent.bottom

    Button {
      width: textMetrics.boundingRect.width + 30
      text: qsTr("Exit")
      onClicked: {
        console.log("Exit click");
        Qt.exit(0);
      }
    }

    Button {
      width: textMetrics.boundingRect.width + 30
      text: qsTr("Save Track")
      enabled: false
    }
  }

  /*

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
}
