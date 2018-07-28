import QtQuick 2.11
import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

ToolButton {
  id: openMenuButton

  x: 600
  y: 0
  z: 2

  visible: false
  display: AbstractButton.TextOnly

  anchors.right: parent.right
  anchors.rightMargin: 0
  anchors.top: parent.top
  anchors.topMargin: 20

  text: qsTr("☰")

  font.capitalization: Font.MixedCase
  font.bold: true
  font.pointSize: 20

  onClicked: {
    menuAnimateOpen.start()
    openMenuButton.visible = false
  }
}
