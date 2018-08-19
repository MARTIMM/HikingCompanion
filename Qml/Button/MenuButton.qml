import io.github.martimm.HikingCompanion.Theme 0.1

import QtQuick 2.11
import QtQuick.Controls 2.4

Button {
  id: root

  width: parent.width
  height: Theme.mnBtHeight

  anchors.topMargin: 1
  anchors.left: parent.left

  contentItem: Text {
    text: root.text
    font: root.font

    color: root.txtColor
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
