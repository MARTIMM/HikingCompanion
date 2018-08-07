import QtQuick 2.11

import io.github.martimm.HikingCompanion.Style 0.1

Rectangle {
  id: id

  width: parent.width
  height: Style.largeButtonHeight
//  anchors.fill: parent

  color: Style.appBackgroundColor

  property alias text: labelText.text
  Text {
    id: labelText

    color: Style.textColor

    font {
      family: Style.fontFamily
      capitalization: Font.MixedCase
      pointSize: Style.cfgTextPointSize
    }
  }
}
