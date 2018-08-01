import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

Button {
  id: pageButtonBase

  property int buttonSize: 26
  property int pointSize: 24

  // stay above any page
  z: 2

  width: buttonSize
  height: buttonSize

  //display: AbstractButton.TextOnly
  clip: true
  padding: 0

  anchors {
    right: parent.right
    top: parent.top
    topMargin: 6
  }

  text: "x"

  font {
    family: "Source Code Pro"
    capitalization: Font.MixedCase
    bold: true
    pointSize: pointSize
  }
}
