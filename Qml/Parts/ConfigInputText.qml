import QtQuick 2.11
import QtQuick.Controls 2.2
//import QtQuick.Layouts 1.3

import "../.."
//import "../Menu" as HCMenu
import "../Button" as HCButton
import "." as HCPage
import io.github.martimm.HikingCompanion.Config 0.1
import io.github.martimm.HikingCompanion.Style 0.1


Item {
  id: root

  width: parent.width
  height: Style.largeButtonHeight
//  anchors.fill: parent

  property alias inputText: inputText
  property alias placeholderText: inputText.placeholderText
  TextField {
    id: inputText

    width: parent.width
    background: Rectangle {
      color: Style.compBackgroundColor

      antialiasing: true
      radius: Style.smallButtonRadius
      border {
        color: Style.buttonBorderColor
        width: Style.smallButtonBorder
      }
    }

    color: Style.textColor

    font {
      family: Style.fontFamily
      capitalization: Font.MixedCase
      //bold: true
      pointSize: Style.cfgTextPointSize
    }
  }
}
