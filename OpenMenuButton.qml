import QtQuick 2.11
import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

Button {
  id: openMenuButton

  x: 600
  y: 0
  z: 2

  width: 18
  height: 18

  visible: false
  display: AbstractButton.TextOnly

  anchors.right: parent.right
  anchors.rightMargin: 6
  anchors.top: parent.top
  anchors.topMargin: 6

  text: qsTr("☰")

  font.capitalization: Font.MixedCase
  font.bold: true
  font.pointSize: 16

  onClicked: {
    menuAnimateOpen.start()
    openMenuButton.visible = false
  }

  // Open and close menu animation
  SequentialAnimation {
    id: menuAnimateOpen
    NumberAnimation {
      target: menu
      property: "width"
      duration: 1000
      from: 0
      to: columnWidth
      easing.type: Easing.OutBounce
    }

    onStopped: {
      openMenuButton.visible = false
    }
  }
}
