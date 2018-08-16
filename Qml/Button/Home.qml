import "." as HCButton
import "../Parts" as HCParts

import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.11
import QtQuick.Controls 2.4

HCButton.ToolbarButton {
  id: root
  text: "🌍"
  //MenuColumn.menu { id: menu; visible: false }
  //text: qsTr("🏠")
  onClicked: {
    //root.visible = false
    GlobalVariables.menu.setHomePage();

    console.log("TB Home");
  }
}
