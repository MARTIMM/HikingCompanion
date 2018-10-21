import QtQuick 2.8
import QtGraphicalEffects 1.0
import QtQuick.Templates 2.1 as T

import io.github.martimm.HikingCompanion.Theme 0.1

T.Label {
  id: control

  width: parent.width
  height: parent.height
  anchors.fill: parent

  horizontalAlignment: Text.AlignLeft
  verticalAlignment: Text.AlignVCenter

  leftPadding: 2
  //rightPadding: 2

  font {
    bold: true
    underline: false
    pixelSize: Theme.lblPixelSize
    family: "arial"
  }

  color: Theme.component.color.foregroundLight

  background: Rectangle {
    id: btBackground

    anchors.fill: parent

    opacity: enabled ? 1 : 0.7

    color: Theme.component.color.backgroundDark
    border {
      color: Theme.component.color.backgroundLight
      width: 1
    }
  }
/*
  property alias textItem: textItem
  contentItem: Text {
    id: textItem
    text: control.text

    font: control.font
    opacity: enabled ? 1.0 : 0.3
    color: Theme.cmptFgColorLL
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    //elide: Text.ElideRight
*/
/*
    states: [
      State {
        name: "normal"
        when: !control.down
      },
      State {
        name: "down"
        when: control.down
        PropertyChanges {
          target: textItem
          color: Theme.cmptFgColor
        }
      }
    ]
*/
//  }
}
