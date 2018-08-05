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

/*
  width: parent.width / 2 - 6
  height: Style.largeButtonHeight
  radius: Style.smallButtonRadius

  color: Style.buttonBackgroundColor
  border {
    color: Style.buttonBorderColor
    width: Style.smallButtonBorder
  }
*/
  //anchors.fill: parent
  width: parent.width / 2
  height: Style.largeButtonHeight

  Component.onCompleted: {
    console.log("CIT W: " + width + ", " + root.placeholderText)
  }

  property alias inputText: inputText
  property alias placeholderText: inputText.placeholderText
  TextField {
    id: inputText

    background: Rectangle {
      color: Style.compBackgroundColor
      anchors.fill: parent
/*
      radius: Style.smallButtonRadius
      border {
        color: Style.buttonBorderColor
        width: Style.smallButtonBorder
      }
*/
    }

    color: Style.textColor
    //style: Text.Raised
    //styleColor: Style.appBackgroundColor

    font {
      //family: "Source Code Pro"
      capitalization: Font.MixedCase
      //bold: true
      pointSize: Style.cfgTextPointSize
    }
  }
}
