import QtQuick 2.11
//import QtQuick.Window 2.3
import QtQuick.Controls 2.4
//import QtQuick.Layouts 1.3

//import "../.."
//import "." as HCButton
import io.github.martimm.HikingCompanion.HCStyle 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

//HCButton.Base {
Button {
  id: root

  width: HCStyle.smallButtonWidth
  height: HCStyle.smallButtonHeight
  //pointSize: HCStyle.smallButtonPointSize
  display: AbstractButton.TextOnly

  text: qsTr("☰")

  //border.width: HCStyle.smallButtonBorder
  //radius: HCStyle.smallButtonRadius

  onClicked: {
    GlobalVariables.menuAnimateOpen.start()
    //root.visible = false
  }
}
