//import "../../Assets/Theme" as ExtraTheme

import io.github.martimm.HikingCompanion.Theme 0.1

import QtQuick 2.11
import QtQuick.Controls 2.4

Button {
  id: root

  width: Theme.mnBtWidth
  height: Theme.mnBtHeight

  //anchors.fill: parent
  anchors.topMargin: 1
  anchors.left: parent.left
  //anchors.right: parent.right

  Component.onCompleted: {
    console.log("BT Menu WH: " + width + ", " + height);
  }

  //ExtraTheme.LinBtGradient { }

  font {
    pixelSize: Theme.MnBtPixelSize
    bold: true
    underline: false
    family: Theme.fontFamily
  }
}
