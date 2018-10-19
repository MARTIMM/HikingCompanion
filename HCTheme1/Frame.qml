import QtQuick 2.8
import QtGraphicalEffects 1.0
import QtQuick.Templates 2.1 as T

import io.github.martimm.HikingCompanion.HCTheme1 0.1
//import io.github.martimm.HikingCompanion.Theme 0.1

T.Frame {
  id: control

  width: parent.width
  height: parent.height
  anchors.fill: parent

  background: Rectangle {
    //id: rectBackground
    color: HCTheme1.main.color.backgroundLight
/*
    implicitWidth: 100
    implicitHeight: 40
*/
    anchors.fill: parent

    LinearGradient {
      anchors.fill: parent
      start: Qt.point( 0, 0)
      end: Qt.point( 0, width)
      gradient: Gradient {
        GradientStop {
          position: HCTheme1.pageGradient.p1
          color:    HCTheme1.pageGradient.g1
        }
        GradientStop {
          position: HCTheme1.pageGradient.p2
          color:    HCTheme1.pageGradient.g2
        }
        GradientStop {
          position: HCTheme1.pageGradient.p3
          color:    HCTheme1.pageGradient.g3
        }
        GradientStop {
          position: HCTheme1.pageGradient.p4
          color:    HCTheme1.pageGradient.g4
        }
        GradientStop {
          position: HCTheme1.pageGradient.p5
          color:    HCTheme1.pageGradient.g5
        }
      }
    }
/**/
  }
}
