import QtQuick 2.11
import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

Rectangle {
  id: aboutPage

  anchors.fill: parent
  visible: false

  // Need the menu button on this page
  OpenMenuButton { id: openMenuButton }

  Text {
    text: qsTr("About")
  }
}
