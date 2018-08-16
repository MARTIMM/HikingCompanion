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

    //menu.setMapPage(mapPage);
    //menu.setCurrentPage(mapPage);
  }

  title: qsTr("Your Hiking Companion")

  visible: true
  width: 640
  height: 480

  HCPage.MapPage { id: mapPage }
  HCPage.ConfigPage { id: configPage }
  HCPage.AboutPage { id: aboutPage }

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
  }
}

