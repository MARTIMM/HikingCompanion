import QtQuick 2.11
import QtQuick.Controls 2.4

import io.github.martimm.HikingCompanion.GlobalVariables 0.1

Frame {
  id: root

  width: parent.width
  height: parent.height
  anchors.fill: parent

  MouseArea {
    width: parent.width
    height: parent.height
    anchors.fill: parent

    onClicked: {
      GlobalVariables.menu.menuAnimateClose.start();
    }
  }
}
