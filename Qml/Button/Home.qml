import QtQuick 2.11

import "." as HCButton
import io.github.martimm.HikingCompanion.GlobalVariables 0.1
import io.github.martimm.HikingCompanion.Style 0.1

HCButton.Base {
  id: root

  width: 35
  height: 35
  pointSize: 20

  text: "🌍"
  //text: qsTr("🏠")

  border.width: Style.smallButtonBorder
  radius: Style.smallButtonRadius

  onClicked: {
    GlobalVariables.setHomePage();
    //console.log("homeButton clicked");
  }
}
