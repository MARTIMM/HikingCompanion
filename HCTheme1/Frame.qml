import QtQuick 2.8
import QtGraphicalEffects 1.0
import QtQuick.Templates 2.1 as T

import io.github.martimm.HikingCompanion.HCTheme1 0.1
import io.github.martimm.HikingCompanion.Theme 0.1

import "../Assets/Theme" as ExtraTheme

T.Frame {
  id: control

  width: parent.width
  height: parent.height
  anchors.fill: parent

  background: Rectangle {
    //id: rectBackground
    color: HCTheme1.mainBgColorL
    /*
    implicitWidth: 100
    implicitHeight: 40
*/
    anchors.fill: parent

    ExtraTheme.LinGradient { }
  }
}
