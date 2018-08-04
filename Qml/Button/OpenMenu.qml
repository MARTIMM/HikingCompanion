import QtQuick 2.11
//import QtQuick.Window 2.3
//import QtQuick.Controls 2.4
//import QtQuick.Layouts 1.3

//import "../.."
import "." as HCButton
import io.github.martimm.HikingCompanion.Style 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

HCButton.Base {
  id: root

  width: Style.smallButtonWidth
  height: Style.smallButtonHeight
  pointSize: Style.smallButtonPointSize

  text: qsTr("☰")

  border.width: Style.smallButtonBorder
  radius: Style.smallButtonRadius

  onClicked: {
    GlobalVariables.menuAnimateOpen.start()
    //root.visible = false
  }
}
