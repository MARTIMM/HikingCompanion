/* ----------------------------------------------------------------------------
  Author: Marcel Timmerman
  License: ...
  Copyright: © Sultanstrail 2018
  Copyright: © Sufitrail 2018

  This is the main page where the root of the gui tree is described. This is
  mainly an empty page area wherein pages and a menu are created.
*/
import "../../Qml/Page" as HCPage
import "../../Qml/Parts" as HCParts
import "../../Qml/Button" as HCButton

import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.3


ApplicationWindow {
  id: root

  Component.onCompleted: {
    GlobalVariables.setMapPage(mapPage);
    GlobalVariables.setCurrentPage(mapPage);
    GlobalVariables.setMenu(menu);
  }

  title: qsTr("Your Hiking Companion")

  visible: true
  width: 640
  height: 480

  HCPage.MapPage { id: mapPage }
  HCPage.ConfigPage { id: configPage }
  HCPage.AboutPage { id: aboutPage }
  HCPage.ExitPage { id: exitPage }

  // Menu
  HCParts.MenuColumn {
    id: menu

    property alias mapButton: mapButton
    HCButton.MenuButton {
      id: mapButton
      text: qsTr("🗺 Map")
      onClicked: {
        GlobalVariables.menu.menuEntryClicked(mapPage);
        console.log("ME map");
      }
    }

    property alias configButton: configButton
    HCButton.MenuButton {
      id: configButton
      text: qsTr("🛠 Config")
      onClicked: {
        GlobalVariables.menu.menuEntryClicked(configPage);
        console.log("ME config");
      }
    }

    property alias aboutButton: aboutButton
    HCButton.MenuButton {
      id: aboutButton
      text: qsTr("👥 About")
      onClicked: {
        GlobalVariables.menu.menuEntryClicked(aboutPage);
        console.log("ME about");
      }
    }

    property alias exitButton: exitButton
    HCButton.MenuButton {
      id: exitButton
      text: configPage.osType === "android" ?
              qsTr("\u23FD Exit") :
              qsTr("\u23FB Exit")
      onClicked: {
        GlobalVariables.menu.menuEntryClicked(exitPage);
      }
    }
  }
}


/*

// ----------------------------------------------------------------------------
ApplicationWindow {
//Rectangle {
  id: applicationRoot

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

*/
