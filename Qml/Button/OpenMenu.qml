import QtQuick 2.11
//import QtQuick.Window 2.3
//import QtQuick.Controls 2.4
//import QtQuick.Layouts 1.3

//import "../.."
import "." as HCButton
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

HCButton.Base {
  id: root

  width: 26
  height: 26
  pointSize: 24

  // stay above any page
  z: 2

  text: qsTr("☰")
  visible: false

  //display: AbstractButton.TextOnly
  //clip: true
  //padding: 0
/*
  anchors {
    top: parent.top
    topMargin: 6
    right: parent.right
    rightMargin: 6
  }
*/
  onClicked: {
    GlobalVariables.menuAnimateOpen.start()
    root.visible = false
  }

/*
  // Open and close menu animation
  SequentialAnimation {
    id: menuAnimateOpen
    NumberAnimation {
      target: menu
      property: "width"
      duration: 1000
      from: 0
      to: GlobalVariables.columnWidth
      easing.type: Easing.OutBounce
    }
  }
*/
}

/*
Button {
  id: openMenuButton

  property int buttonSize: 24
  property int pointSize: 24

  // stay above any page
  z: 2

  width: buttonSize
  height: buttonSize

  visible: false
  display: AbstractButton.TextOnly

  anchors.right: parent.right
  anchors.rightMargin: 6
  anchors.top: parent.top
  anchors.topMargin: 6

  text: qsTr("☰")

  font.capitalization: Font.MixedCase
  font.bold: true
  font.pointSize: pointSize

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
*/
