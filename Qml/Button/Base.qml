import QtQuick 2.0
import QtQuick.Controls 2.4
//import QtQuick.Layouts 1.3

Rectangle {
  id: buttonBase;

  property int buttonWidth: 10
  property int buttonHeight: 10
  property int pointSize: 10

  property alias buttonText: buttonText.text
  //property alias onClicked: clickArea.pressed

  width: buttonWidth
  height: buttonHeight

  Text {
    id: buttonText

    font {
      family: "Source Code Pro"
      capitalization: Font.MixedCase
      bold: true
      pointSize: pointSize
    }
  }

  MouseArea {
    id: clickArea
    width: parent.width
    height: parent.height
  }
}
