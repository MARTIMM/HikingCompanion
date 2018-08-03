import QtQuick 2.11
//import QtQuick.Window 2.3
//import QtQuick.Controls 2.4

import "." as HCButton
//import ".."
import io.github.martimm.HikingCompanion.GlobalVariables 0.1
import io.github.martimm.HikingCompanion.Style 0.1

HCButton.Base {
  id: root

  width: parent.width
  height: 50

  anchors.topMargin: 1
  anchors.left: parent.left

  pointSize: 23
}
