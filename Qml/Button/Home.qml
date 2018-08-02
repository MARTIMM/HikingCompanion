import QtQuick 2.11
//import QtQuick.Window 2.3
//import QtQuick.Controls 2.4
//import QtQuick.Layouts 1.3

//import "Qml/Menu" as HCMenu
//import "Qml/Button" as HCButton

import "." as HCButton

HCButton.Base {
  id: root

  text: qsTr("🌍")

  width: 26
  height: 26
//  pointSize: 24
  pointSize: 12

  // stay above any page
  z: 2

//  anchors.rightMargin: 6 + buttonSize + 2

  HCButton.MenuEntry { id: mb }
  onClicked: {
    mb.setHomePage();
    console.log("homeButton clicked");
  }
}

/*
Button {
  id: homeButton

  MenuEntryButton { id: mb }

  property int buttonSize: 24
  property int pointSize: 24

  // stay above any page
  z: 2

  width: buttonSize
  height: buttonSize

  visible: true
  display: AbstractButton.TextOnly

  anchors.right: parent.right
  anchors.rightMargin: 6 + buttonSize + 2
  anchors.top: parent.top
  anchors.topMargin: 6

  text: qsTr("🏠")

  font.capitalization: Font.MixedCase
  font.bold: true
  font.pointSize: pointSize

  onClicked: {
    mb.setHomePage();
  }
}
*/
