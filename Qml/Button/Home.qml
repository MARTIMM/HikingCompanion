import QtQuick 2.11
import QtQuick.Controls 2.4

import "." as HCButton
import io.github.martimm.HikingCompanion.GlobalVariables 0.1
import io.github.martimm.HikingCompanion.HCStyle 0.1

Button {
//HCButton.Base {
  id: root

  width: HCStyle.smallButtonWidth
  height: HCStyle.smallButtonHeight
  //pointSize: 20 //HCStyle.smallButtonPointSize
  display: AbstractButton.TextOnly

  text: "🌍"
  //text: qsTr("🏠")

  //border.width: HCStyle.smallButtonBorder
  //radius: HCStyle.smallButtonRadius

  onClicked: {
    GlobalVariables.setHomePage();
    //console.log("homeButton clicked");
  }
}
