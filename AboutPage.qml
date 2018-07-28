import QtQuick 2.11
import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

Page {
  id: aboutPage

  anchors.fill: parent
  visible: false

  // Need the menu button on this page
  property alias openMenuButton: openMenuButton
  OpenMenuButton { id: openMenuButton }


  contentData: [
    Text {
      text: qsTr("About")
    }
  ]
}
