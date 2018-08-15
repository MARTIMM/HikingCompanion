import QtQuick 2.11
import QtQuick.Controls 2.4

import "." as HCButton
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

HCButton.ToolbarButton {
  id: root
  text: "🌍"
  //text: qsTr("🏠")
  onClicked: {
    //root.visible = false
    //GlobalVariables.setHomePage();
    //console.log("homeButton clicked");

    console.log("TB Home");
  }
}
