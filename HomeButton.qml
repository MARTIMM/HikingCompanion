import QtQuick 2.11
import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

Button {
  id: homeButton

  property int buttonSize: 24
  property int pointSize: 24

  // stay above any page
  z: 2

  width: buttonSize
  height: buttonSize

  visible: false
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
    menuEntryButton.setHomePage();
  }
}
