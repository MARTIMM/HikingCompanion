import QtQuick 2.11

import io.github.martimm.HikingCompanion.HCStyle 0.1

Rectangle {
  id: id

  width: parent.width
  height: HCStyle.largeButtonHeight
  //anchors.verticalCenter: parent.verticalCenter

//  color: HCStyle.appBackgroundColor

  property alias text: labelText.text
  Text {
    id: labelText

//    color: HCStyle.textColor
/*
    font {
      family: HCStyle.fontFamily
      capitalization: Font.MixedCase
      pointSize: HCStyle.cfgTextPointSize
    }
*/
  }
}
