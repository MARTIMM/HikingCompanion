import QtQuick 2.11
import QtQuick.Controls 2.4
//import QtQuick.Templates 2.1 as T

//import "." as HCButton
import io.github.martimm.HikingCompanion.GlobalVariables 0.1
//import io.github.martimm.HikingCompanion.HCStyle 0.1
import io.github.martimm.HikingCompanion.Theme 0.1

Button {
//HCButton.Base {
  id: root

  width: Theme.smallButtonWidth
  height: Theme.smallButtonHeight
  //pointSize: Theme.smallButtonPointSize
  //display: AbstractButton.TextOnly

  text: "🌍"
  //text: qsTr("🏠")

//  border.width: Theme.smallButtonBorder
//  radius: Theme.smallButtonRadius

  onClicked: {
    GlobalVariables.setHomePage();
    //console.log("homeButton clicked");
  }
}
