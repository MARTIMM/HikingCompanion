import QtQuick 2.8
import QtGraphicalEffects 1.0
import QtQuick.Templates 2.1 as T

import io.github.martimm.HikingCompanion.HCTheme1 0.1
import io.github.martimm.HikingCompanion.Theme 0.1

T.TextField {
  id: control

  width: parent.width
  height: parent.height
  anchors.fill: parent

  horizontalAlignment: Text.AlignLeft
  verticalAlignment: Text.AlignVCenter

  leftPadding: 2
  rightPadding: 2

  font {
    bold: true
    underline: false
    pixelSize: Theme.txtfPixelSize
    //pointSize: Theme.largeBtPointSize
    family: "arial"
  }

  background: Rectangle {
    id: btBackground

    anchors.fill: parent

    opacity: enabled ? 1 : 0.7

    color: HCTheme1.component.color.background
    border {
      color: HCTheme1.component.color.foregroundLight
      width: 1
    }
    //radius: HCTheme1.cmptRdng
/**/
/*
    LinearGradient {
      anchors.fill: parent
      start: Qt.point( 0, 0)
      end: Qt.point( 0, width)
      gradient: Gradient {
        GradientStop { id: g0; position: 0.0; color: HCTheme1.mainBgColorL}
        GradientStop { id: g1; position: 1.0; color: HCTheme1.mainBgColorD}
      }
    }
*/
    // radius doesn't work with gradients
//    radius: HCTheme1.cmptRdng
/*
    states: [
      State {
        name: "normal"
        when: !control.down
        PropertyChanges { target: btBackground}
      },

      State {
        name: "down"
        when: control.down
        PropertyChanges { target: btBackground; color: HCTheme1.cmptBgColor}
      }
    ]
*/
  }
/*
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
          color: HCTheme1.cmptFgColor
        }
      }
    ]
*/
//  }
}
