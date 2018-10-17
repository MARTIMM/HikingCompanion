import io.github.martimm.HikingCompanion.Theme 0.1

import QtQuick 2.9
import QtQuick.Controls 2.2

Button {
  id: root

  width: parent.width
  height: Theme.mnBtHeight

  anchors.topMargin: 1
  anchors.left: parent.left

  contentItem: Text {
    text: root.text
    font: root.font

    //color: root.txtColor
    color: "black"
    horizontalAlignment: Text.AlignLeft
    verticalAlignment: Text.AlignVCenter
  }

  font {
    pixelSize: Theme.mnBtPixelSize
    bold: true
    underline: false
    family: Theme.fontFamily
  }
}
