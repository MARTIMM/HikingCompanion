/* ----------------------------------------------------------------------------
  Author: Marcel Timmerman
  License: Artistic 2.0
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

import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Window 2.11


ApplicationWindow {
  id: root

  Component.onCompleted: {
    GlobalVariables.setApplicationWindow(this);
    GlobalVariables.setCurrentPage(homePage);
    GlobalVariables.setMenu(menu);

    config.setWindowSize( width, height);

    // Get the hiking companion settings for default colors and
    // to specify sizes and other properties.
    var t = config.getTheme(true);
    //console.log("style: " + t);
    Theme.changeSettings(JSON.parse(t));

    // Change colors only for specific hike when different
    t = config.getTheme(false);
    //console.log("style: " + t);
    Theme.changeColors(JSON.parse(t));
  }

  Config { id: config }

  title: qsTr("Your Hiking Companion")

  visible: true

  // Sizes are not important because on mobile devices it always scales
  // to the screen width and height. For desktop I use a scaled
  // Samsung tablet size (2048 x 1536 of Samsung Galaxy Tab S2).
  width: 600
  height: 450

  // The changes are only fired in desktop apps
  onXChanged: { setWindowSize(); }
  onYChanged: { setWindowSize(); }
  onWidthChanged: { setWindowSize(); }
  onHeightChanged: { setWindowSize(); }
  function setWindowSize () {
    config.setWindowSize( width, height);

    console.log("width x height in mm: "
                + config.fysLength(width) + ", " + config.fysLength(height)
                );
  }

  property alias homePage: homePage
  HCPage.HomePage { id: homePage; visible: true }

  property alias hikeSelectPage: hikeSelectPage
  HCPage.HikeSelectPage { id: hikeSelectPage }

  property alias trackSelectPage: trackSelectPage
  HCPage.TrackSelectPage { id: trackSelectPage }

  property alias mapPage: mapPage
  HCPage.MapPage { id: mapPage; backgroundImage.visible: false }

  property alias configPage: configPage
  HCPage.ConfigPage { id: configPage }

  property alias userTrackConfigPage: userTrackConfigPage
  HCPage.UserTrackConfigPage { id: userTrackConfigPage }

  property alias aboutPage: aboutPage
  HCPage.AboutPage { id: aboutPage }

  property alias exitPage: exitPage
  HCPage.ExitPage { id: exitPage }

  // Menu
  HCParts.MenuColumn {
    id: menu

    property alias homeButton: homeButton
    HCButton.MenuButton {
      id: homeButton
      //text: qsTr("⌂ Home")
      text: qsTr(" Home")
      onClicked: {
        GlobalVariables.menu.menuEntryClicked(homePage);
      }
    }

    property alias hikeSelectButton: hikeSelectButton
    HCButton.MenuButton {
      id: hikeSelectButton
      //text: qsTr("🚶 Hikes")
      text: qsTr(" Hikes")
      onClicked: {
        GlobalVariables.menu.menuEntryClicked(hikeSelectPage);
      }
    }

    property alias tracksButton: tracksButton
    HCButton.MenuButton {
      id: tracksButton
      //text: qsTr("🚶 Tracks")
      text: qsTr(" Tracks")
      onClicked: {
        GlobalVariables.menu.menuEntryClicked(trackSelectPage);
      }
    }

    property alias mapButton: mapButton
    HCButton.MenuButton {
      id: mapButton
      //text: qsTr("🌍 Map")
/*
      Image {
        source: "qrc:/Assets/Images/Icon/Buttons/Map.svg"
      }
*/
      text: qsTr(" Map")
      onClicked: {
        GlobalVariables.menu.menuEntryClicked(mapPage);
      }
    }

    property alias configButton: configButton
    HCButton.MenuButton {
      id: configButton
      //text: "🛠 " + qsTr("Config")
      text: qsTr(" Config")
      onClicked: {
        GlobalVariables.menu.menuEntryClicked(configPage);
      }
    }

    property alias userTrackConfigButton: userTrackConfigButton
    HCButton.MenuButton {
      id: userTrackConfigButton
      //text: qsTr("📡 Recording")
      text: qsTr(" Recording")

      onClicked: {
        GlobalVariables.menu.menuEntryClicked(userTrackConfigPage);
      }
    }

    property alias aboutButton: aboutButton
    HCButton.MenuButton {
      id: aboutButton
      //text: qsTr("👥 About")
      text: qsTr(" About")
      onClicked: {
        GlobalVariables.menu.menuEntryClicked(aboutPage);
      }
    }

    property alias exitButton: exitButton
    HCButton.MenuButton {
      id: exitButton
/*
      Component.onCompleted: {
        if ( Qt.platform.os == "Android" ) {
          txt = "■ ";
        }

        else {
          txt = "⏻ ";
        }
        txt += qsTr("Exit");
      }

      property string txt
      text: txt
*/
      //text: qsTr("⏻ Exit")
      text: qsTr(" Exit")
      onClicked: {
        GlobalVariables.menu.menuEntryClicked(exitPage);
      }
    }
  }
}
