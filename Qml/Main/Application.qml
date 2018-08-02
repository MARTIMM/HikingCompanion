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

import "../Page" as HCPage
import "../Button" as HCButton
//import "../Menu" as HCMenu
//import ".."
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

// ----------------------------------------------------------------------------
Window {
  id: root

  Component.onCompleted: {
    GlobalVariables.setMapPage(mapPage);
    GlobalVariables.setMenu(menu);
  }

  visible: true
  width: 640
  height: 480

  title: qsTr("Your Hiking Companion")

  // Cannot be placed in MenuEntry because every button would get
  // this property. Comparing with new page will always be the same then.
  //property Rectangle currentPage: Rectangle {id: emptyCurrentPage}

  // alias must be defined here because the animation must work on the
  // Column properties
  //property alias openMenuButton: openMenuButton
  //HCButton.OpenMenu { id: openMenu }

  // Pages are in separate files
  //property alias mapPage: mapPage
  HCPage.MapPage { id: mapPage }

  //property alias configPage: configPage
  HCPage.ConfigPage { id: configPage }

  //property alias aboutPage: aboutPage
  HCPage.AboutPage { id: aboutPage }

  //property alias exitPage: exitPage
  HCPage.ExitPage { id: exitPage }


  // Menu
  Column {
    id: menu
    clip: true

    width: 0
    height: parent.height
    anchors.right: parent.right

    property alias mapButton: mapButton
    HCButton.MenuEntry {
      id: mapButton
      text: qsTr("🗺 Map")
      anchors.top: parent.top
      onClicked: { mapButton.menuEntryClicked(mapPage); }
    }

    property alias configButton: configButton
    HCButton.MenuEntry {
      id: configButton
      text: qsTr("🛠 Config")
      anchors.top: mapButton.bottom
      onClicked: { configButton.menuEntryClicked(configPage); }
    }

    property alias aboutButton: aboutButton
    HCButton.MenuEntry {
      id: aboutButton
      text: qsTr("👥 About")
      anchors.top: configButton.bottom
      onClicked: { aboutButton.menuEntryClicked(aboutPage); }
    }

    property alias exitButton: exitButton
    HCButton.MenuEntry {
      id: exitButton
      text: configPage.osType == "android" ?
              qsTr("\u23FD Exit") :
              qsTr("\u23FB Exit")
      anchors.bottom: parent.bottom
      anchors.bottomMargin: 1
      onClicked: { exitButton.menuEntryClicked(exitPage); }
    }
  }
}
