import QtQuick 2.8
import QtGraphicalEffects 1.0
import QtQuick.Templates 2.1 as T

import io.github.martimm.HikingCompanion.Theme 0.1

T.Frame {
  id: control

  width: parent.width
  height: parent.height
  anchors.fill: parent

  background: Rectangle {
    //id: rectBackground
    color: Theme.main.color.backgroundLight
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
          position: Theme.pageGradient.p1
          color:    Theme.pageGradient.g1
        }
        GradientStop {
          position: Theme.pageGradient.p2
          color:    Theme.pageGradient.g2
        }
        GradientStop {
          position: Theme.pageGradient.p3
          color:    Theme.pageGradient.g3
        }
        GradientStop {
          position: Theme.pageGradient.p4
          color:    Theme.pageGradient.g4
        }
        GradientStop {
          position: Theme.pageGradient.p5
          color:    Theme.pageGradient.g5
        }
      }
    }
/**/
  }
}
