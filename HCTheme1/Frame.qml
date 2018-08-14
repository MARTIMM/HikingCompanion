import QtQuick 2.8
import QtGraphicalEffects 1.0
import QtQuick.Templates 2.1 as T

import io.github.martimm.HikingCompanion.HCTheme1 0.1
import io.github.martimm.HikingCompanion.Theme 0.1

T.Frame {
  id: control

  width: parent.width
  height: parent.height
  anchors.fill: parent

  Component.onCompleted: {
    console.log("FR");
  }

  background: Rectangle {
    //id: rectBackground
    color: HCTheme1.mainBgColorL
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
        GradientStop { position: 0.0; color:  HCTheme1.mainBgColorL}
        GradientStop { position: 1.0; color:  HCTheme1.mainBgColorD}
        //            GradientStop { position: 1.0; color:  HCTheme1.cmptBgColorD}
      }
    }
  }
}
