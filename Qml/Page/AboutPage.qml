import QtQuick 2.11
import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

import "../.."
import "../Menu" as Menu

Rectangle {
  id: aboutPage

  anchors.fill: parent
  visible: false

  // Need the menu button on this page
  Menu.OpenMenuButton { id: openMenuButton }

  // and a home button
  HomeButton { id: homeButton }

  Text {
    text: qsTr("About")
  }
}
