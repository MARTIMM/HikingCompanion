/* ----------------------------------------------------------------------------
  Author: Marcel Timmerman
  License: ...
  Copyright: © Sultanstrail 2018
  Copyright: © Sufitrail 2018

  This is the main page where the root of the gui tree is described. This is
  mainly an empty page area wherein pages and a menu are referenced.
*/

import QtQuick 2.11
import QtQuick.Window 2.3
import QtQuick.Controls 2.4

// ----------------------------------------------------------------------------
Window {
  id: root

  visible: true
  width: 640
  height: 480

  title: qsTr("Your Hiking Companion")

  // Cannot be placed in MenuEntryButton because every button would get
  // this property. Comparing with new page will always be the same then.
  property Rectangle currentPage: Rectangle {id: emptyCurrentPage}

  // alias must be defined here because the animation must work on the
  // Column properties
  property alias openMenuButton: openMenuButton
  OpenMenuButton { id: openMenuButton }

  // Some variables to be used in the design. The page references must
  // be placed here because otherwise the pages are shown in the menu
  // when placed below in the Column
  property int columnWidth: 210

  // Pages are in separate files
  property alias mapPage: mapPage
  MapPage { id: mapPage }

  property alias configPage: configPage
  ConfigPage { id: configPage }

  property alias aboutPage: aboutPage
  AboutPage { id: aboutPage }

  property alias exitPage: exitPage
  ExitPage { id: exitPage }

  // Menu
  Column {
    id: menu

    width: 0
    height: parent.height
    anchors.right: parent.right

    property alias mapButton: mapButton
    MenuEntryButton {
      id: mapButton
      text: qsTr("🗺 Map")
      anchors.top: parent.top
      onClicked: { mapButton.menuEntryClicked(mapPage); }
    }

    property alias configButton: configButton
    MenuEntryButton {
      id: configButton
      text: qsTr("🛠 Config")
      anchors.top: mapButton.bottom
      onClicked: { configButton.menuEntryClicked(configPage); }
    }

    property alias aboutButton: aboutButton
    MenuEntryButton {
      id: aboutButton
      text: qsTr("👥 About")
      anchors.top: configButton.bottom
      onClicked: { aboutButton.menuEntryClicked(aboutPage); }
    }

    property alias exitButton: exitButton
    MenuEntryButton {
      id: exitButton
      text: qsTr("⏻ Exit")
      anchors.bottom: parent.bottom
      anchors.bottomMargin: 1
      onClicked: { exitButton.menuEntryClicked(exitPage); }
    }
  }
}
