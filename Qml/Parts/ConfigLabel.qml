import QtQuick 2.11
import QtQuick.Controls 2.2

import io.github.martimm.HikingCompanion.Theme 0.1

Rectangle {
  id: id

  width: parent.width
  height: Theme.largeButtonHeight
  //anchors.verticalCenter: parent.verticalCenter

//  color: HCStyle.appBackgroundColor

  property alias text: labelText.text
  Label {
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
