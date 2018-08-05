import QtQuick 2.11
//import QtQuick.Layouts 1.3

import "../.."
//import "../Menu" as HCMenu
import "../Button" as HCButton
import "." as HCPage
import io.github.martimm.HikingCompanion.Config 0.1
import io.github.martimm.HikingCompanion.Style 0.1


Rectangle {
  id: id

  width: parent.width / 2
  height: Style.largeButtonHeight
//  anchors.fill: parent

  //radius: Style.smallButtonRadius

  color: Style.appBackgroundColor
  //border {
  //  color: Style.buttonBorderColor
  //  width: Style.smallButtonBorder
  //}

  Component.onCompleted: {
    console.log("CL W: " + width + ", " + labelText.text)
  }

  property alias text: labelText.text
  Text {
    id: labelText
    anchors.fill: parent

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
