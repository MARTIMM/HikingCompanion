/* ----------------------------------------------------------------------------
  Author: Marcel Timmerman
  License: ...
  Copyright: © Sultanstrail 2018 .. ∞
  Copyright: © Sufitrail 2018 .. ∞
  Copyright: © Marcel Timmerman 2018 .. ∞

  This is the main page where the root of the gui tree is described. This is
  mainly an empty page area wherein pages and a menu are created.
*/
import "../../Qml/Page" as HCPage
import "../../Qml/Parts" as HCParts
import "../../Qml/Button" as HCButton

import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1
import io.github.martimm.HikingCompanion.Config 0.3

import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.3


ApplicationWindow {
  id: root

  Component.onCompleted: {
    GlobalVariables.setMapPage(mapPage);
    GlobalVariables.setCurrentPage(mapPage);
    GlobalVariables.setMenu(menu);
    GlobalVariables.setTracksPage(tracksPage);

    var t = config.getTheme();
    console.log("style: " + t);
    Theme.changeClrs(JSON.parse(t));
  }

  Config { id: config }

  title: qsTr("Your Hiking Companion")

  visible: true

  // Sizes are not important because on mobile devices it always scales
  // to the screen width and height. For desktop I use a scaled
  // Samsung tablet size (2048 x 1536 of Samsung Galaxy Tab S2).
  width: 600
  height: 450

  HCPage.AboutPage { id: aboutPage }
  HCPage.ConfigPage { id: configPage }
  HCPage.ExitPage { id: exitPage }
  HCPage.MapPage { id: mapPage; visible: true }
  HCPage.TracksPage { id: tracksPage }

  // Menu
  HCParts.MenuColumn {
    id: menu

    property alias mapButton: mapButton
    HCButton.MenuButton {
      id: mapButton
//      text: qsTr("🗺 Map")
      text: qsTr("Map")
      onClicked: {
        GlobalVariables.menu.menuEntryClicked(mapPage);
      }
    }

    property alias tracksButton: tracksButton
    HCButton.MenuButton {
      id: tracksButton
//      text: qsTr("🛠 Tracks")
      text: qsTr("Tracks")
      onClicked: {
        GlobalVariables.menu.menuEntryClicked(tracksPage);
      }
    }

    property alias configButton: configButton
    HCButton.MenuButton {
      id: configButton
//      text: qsTr("🛠 Config")
      text: qsTr("Config")
      onClicked: {
        GlobalVariables.menu.menuEntryClicked(configPage);
      }
    }

    property alias aboutButton: aboutButton
    HCButton.MenuButton {
      id: aboutButton
//      text: qsTr("👥 About")
      text: qsTr("About")
      onClicked: {
        GlobalVariables.menu.menuEntryClicked(aboutPage);
      }
    }

    property alias exitButton: exitButton
    HCButton.MenuButton {
      id: exitButton
//      text: qsTr("⏼ Exit")
      text: qsTr("Exit")
      onClicked: {
        GlobalVariables.menu.menuEntryClicked(exitPage);
      }
    }
  }
}
