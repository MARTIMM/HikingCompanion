import QtQuick 2.11
//import QtQuick.Controls 2.4
//import QtQuick.Layouts 1.3

import io.github.martimm.HikingCompanion.Style 0.1

Item {
  id: root;

  property alias pointSize: buttonText.font.pointSize
  property alias text: buttonText.text
  property alias border: buttonArea.border
  property alias radius: buttonArea.radius
  property alias font: buttonArea.font
  signal clicked

  width: 15
  height: 15

  Rectangle {
    id: buttonArea

    anchors.fill: parent
    color: Style.buttonBackgroundColor
    border.color: Style.buttonBorderColor

    property alias font: buttonText.font
    Text {
      id: buttonText
      color: Style.textColor
      //style: Text.Raised
      //styleColor: Style.appBackgroundColor

      anchors {
        verticalCenter: parent.verticalCenter
        horizontalCenter: parent.horizontalCenter
      }

      font {
        //family: "Source Code Pro"
        capitalization: Font.MixedCase
        bold: true
        pointSize: 12
      }
    }

    MouseArea {
      id: clickArea
      anchors.fill: parent
      onClicked: {
        root.clicked()
      }
    }
  }
}
