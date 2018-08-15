import QtQuick 2.11
import QtQuick.Controls 2.4

import "." as HCButton
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

HCButton.ToolbarButton {
  id: root
  text: qsTr("☰")
  onClicked: {
    //GlobalVariables.menuAnimateOpen.start()
    //root.visible = false

    console.log("TB Open menu");
  }
}
