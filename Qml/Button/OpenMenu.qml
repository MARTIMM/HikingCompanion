import "." as HCButton

import QtQuick 2.11
import QtQuick.Controls 2.4

HCButton.ToolbarButton {
  id: root
  text: qsTr("☰")
  onClicked: {
    GlobalVariables.menu.menuAnimateOpen.start()
  }
}
