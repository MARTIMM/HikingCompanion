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
import "../Menu" as HCMenu
//import ".."
import io.github.martimm.HikingCompanion.Style 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

// ----------------------------------------------------------------------------
ApplicationWindow {
  id: root

  Component.onCompleted: {
    GlobalVariables.setMapPage(mapPage);
    GlobalVariables.setCurrentPage(mapPage);
    GlobalVariables.setMenu(menu);
  }

  visible: true
  width: 640
  height: 480

  title: qsTr("Your Hiking Companion")

  HCPage.MapPage { id: mapPage }
  HCPage.ConfigPage { id: configPage }
  HCPage.AboutPage { id: aboutPage }
  HCPage.ExitPage { id: exitPage }

  // Menu
  HCMenu.MainMenu {
    id: menu

    property alias mapButton: mapButton
    HCButton.MenuEntry {
      id: mapButton
      text: qsTr("🗺 Map")
      onClicked: { GlobalVariables.menuEntryClicked(mapPage); }
    }

    property alias configButton: configButton
    HCButton.MenuEntry {
      id: configButton
      text: qsTr("🛠 Config")
      onClicked: { GlobalVariables.menuEntryClicked(configPage); }
    }

    property alias aboutButton: aboutButton
    HCButton.MenuEntry {
      id: aboutButton
      text: qsTr("👥 About")
      onClicked: { GlobalVariables.menuEntryClicked(aboutPage); }
    }

    property alias exitButton: exitButton
    HCButton.MenuEntry {
      id: exitButton
      text: configPage.osType == "android" ?
              qsTr("\u23FD Exit") :
              qsTr("\u23FB Exit")
      onClicked: { GlobalVariables.menuEntryClicked(exitPage); }
    }
  }
}
