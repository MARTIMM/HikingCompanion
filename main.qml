/*
  Author: Marcel Timmerman
  License: ...
  Copyright: © Sultanstrail 2018
  Copyright: © Sufitrail 2018
*/

import QtQuick 2.11
import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

Window {
  id: root

  visible: true
  width: 640
  height: 480

  title: qsTr("Your Hiking Companion")

  // cannot be placed in MenuEntryButton because every button would get
  // this property. comparing with new page will always be the same then.
  property Rectangle currentPage: Rectangle {id: emptyCurrentPage}

  // alias must be defined here. otherwise the button will
  // be located in the menu when placed elsewhere
  property alias openMenuButton: openMenuButton
  OpenMenuButton { id: openMenuButton }

  // some variables to be used in the design. also these must
  // be placed here because otherwise the pages are placed
  // in the menu when placed below in the Column
  property int columnWidth: 210

  // Pages are in separate files
  property alias mapPage: mapPage
  MapPage { id: mapPage }

  // Pages are in separate files
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
