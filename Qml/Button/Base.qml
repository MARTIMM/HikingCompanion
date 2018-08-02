import QtQuick 2.0
//import QtQuick.Controls 2.4
//import QtQuick.Layouts 1.3

Item {
  id: root;

  property alias pointSize: buttonText.font.pointSize
  property alias text: buttonText.text
  //property alias visible: buttonArea.visible
  signal clicked

  width: 15
  height: 15

  Rectangle {
    id: buttonArea

    anchors.fill: parent

    Text {
      id: buttonText

      font {
        family: "Source Code Pro"
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
