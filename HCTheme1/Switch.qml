import QtQuick 2.8
import QtGraphicalEffects 1.0
import QtQuick.Templates 2.1 as T
import QtQuick.Controls.Styles 1.4

import io.github.martimm.HikingCompanion.HCTheme1 0.1
import io.github.martimm.HikingCompanion.Theme 0.1

T.Switch {
  id: control

  width: parent.width
  height: parent.height
  anchors.fill: parent
/*

  //horizontalAlignment: Text.AlignLeft
  //verticalAlignment: Text.AlignVCenter

  leftPadding: 2
  checked: false
  //rightPadding: 2

  font {
    bold: true
    underline: false
    pixelSize: Theme.lblPixelSize
    family: "arial"
  }

  background: Rectangle {
    id: btBackground

    anchors.fill: parent

    opacity: enabled ? 1 : 0.7

    color: HCTheme1.cmptBgColor
    border {
      color: HCTheme1.cmptFgColorL
      width: 1
    }
  }

  property alias textItem: textItem
  contentItem: Text {
    id: textItem
    text: control.text

    font: control.font
    opacity: enabled ? 1.0 : 0.3
    color: HCTheme1.cmptFgColorLL
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    //elide: Text.ElideRight
  }
*/
}
