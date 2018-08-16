import QtQuick 2.9
import QtGraphicalEffects 1.0

import io.github.martimm.HikingCompanion.HCTheme1 0.1
import io.github.martimm.HikingCompanion.Theme 0.1

LinearGradient {
  anchors.fill: parent
  start: Qt.point( 0, 0)
  end: Qt.point( 0, width)
  gradient: Gradient {
    GradientStop { position: 0.0; color: "#ae50f0"}
    GradientStop { position: 1.0; color: "#300080"}
  }
}

