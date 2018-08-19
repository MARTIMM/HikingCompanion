import "." as HCButton

import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.11
import QtQuick.Controls 2.4

HCButton.ToolbarButton {
  id: root
  text: qsTr("☰")
  onClicked: {
    if ( menu.width === 0 ) GlobalVariables.menu.menuAnimateOpen.start();
  }
}
