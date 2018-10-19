import QtQuick 2.8
import QtGraphicalEffects 1.0
import QtQuick.Templates 2.1 as T

import io.github.martimm.HikingCompanion.HCTheme1 0.1
import io.github.martimm.HikingCompanion.Theme 0.1

T.Button {
  id: control

  font {
    bold: true
    underline: false
    //pixelSize: 14
    //pointSize: Theme.largeBtPointSize
    family: "arial"
  }

  //width: textMetrics.boundingRect.width + 30
  height: Theme.largeBtHeight

  leftPadding: 2
  rightPadding: 2

  background: Rectangle {
    id: btBackground

    anchors.fill: parent

    opacity: enabled ? 1 : 0.7

    color: HCTheme1.component.color.backgroundDark
    border {
      color: HCTheme1.component.color.foregroundLight
      width: 1
    }
    radius: HCTheme1.component.rounding
/*
    layer.effect: DropShadow {
      horizontalOffset: 15
      verticalOffset: 20
      color: HCTheme1.component.color.backgroundDark //control.visualFocus ? "#330066ff" : "#aaaaaa"
      samples: 17
      radius: 8
      spread: 0.5
    }
*/
/*
    LinearGradient {
      anchors.fill: parent
      start: Qt.point( 0, 0)
      end: Qt.point( 0, width)
      gradient: Gradient {
        GradientStop {
          id: g0; position: 0.0
          color: HCTheme1.component.color.backgroundLight
        }
        GradientStop {
          id: g1; position: 1.0
          color: HCTheme1.component.color.backgroundDark
        }
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
        PropertyChanges {
          target: btBackground
          color: HCTheme1.component.color.background
        }

        PropertyChanges {
          target: g0
          color: HCTheme1.component.color.backgroundDark
        }
        PropertyChanges {
          target: g1
          color: HCTheme1.component.color.backgroundLight
        }

      }
    ]
*/
}

  property alias textMetrics: textMetrics
  TextMetrics {
    id: textMetrics
    //font.family: root.font.family
    //font.pointSize: Theme.largeBtPointSize
    font: control.font
    elide: Text.ElideNone
    //elideWidth: 100
    text: control.text
  }

  property color txtColor: HCTheme1.component.color.foregroundLight
  property alias textItem: textItem
  contentItem: Text {
    id: textItem
    text: control.text

    font: control.font
    opacity: enabled ? 1.0 : 0.3
    color: HCTheme1.component.color.foregroundLight
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    //elide: Text.ElideRight
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
  }
}
