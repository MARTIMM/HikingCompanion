/* ----------------------------------------------------------------------------
  Author: Marcel Timmerman
  License: Artistic 2.0
  Copyright: © Marcel Timmerman 2018 .. ∞

  This is the main page where the root of the gui tree is described. This is
  mainly an empty page area wherein pages and a menu are created.
---------------------------------------------------------------------------- */
import "../../Qml/Page" as HCPage
import "../../Qml/Parts" as HCParts
//import "../../Qml/Button" as HCButton

import io.github.martimm.HikingCompanion.Theme 0.1
//import io.github.martimm.HikingCompanion.GlobalVariables 0.1
import io.github.martimm.HikingCompanion.Config 0.3
import io.github.martimm.HikingCompanion.Textload 0.1

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.11

// ----------------------------------------------------------------------------
ApplicationWindow {
  id: root

  // Button types. buttonType is set by the onCompletion() of a specific button
  // when created in a Toolbar or ButtonRow. The button template checks the type
  // and sets sizes or whatever.
  enum ButtonType { ToolbarButton, ButtonRowButton, MenuButton }

  // Likewise there are other types
  enum TextType {
    InfoAreaText,     // larger on page texts
    MessageAreaText,  // small messages
    WarningAreaText,  // warning text messages
    SuccessAreaText,  // success text messages

    LabelText,        // texts on labels, buttons, combo boxes etc.
    EnabledText,      // enabled widgets === LabelText
    DisabledText,     // disabled widgets

    TitleText,        // titles
    ListText          // list entries
  }

  enum ButtonBar { Toolbar, FooterBar, MenuBar }

  // Much used objects from C++
  Config { id: config }
  TextLoad { id: textData }

  // set the current page to the home page and store window size and
  // load theme data
  property HCPage.Plain  currentPage
  Component.onCompleted: {
    currentPage = homePage;

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

  // set some properties
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

  // Instantiate all pages of which only the home page will be visible
  HCPage.HomePage { id: homePage; visible: true }
  HCPage.MapPage { id: mapPage; backgroundImage.visible: false }
/*
  HCPage.HikeSelectPage { id: hikeSelectPage }
  HCPage.TrackSelectPage { id: trackSelectPage }
  HCPage.ConfigPage { id: configPage }
  HCPage.UserTrackConfigPage { id: userConfigPage }
*/
  HCPage.AboutPage { id: aboutPage }
  HCPage.ExitPage { id: exitPage }

  // Setup menu
  HCParts.MenuColumn {
    id: pageMenu
    Component.onCompleted: {
      addButton( "qrc:Qml/Button/MenuButton.qml",
                { type: "m-intro", page: homePage,
                  menu: pageMenu, text: qsTr(" Home")
//text: qsTr("⌂ Home")
                }
                );

      addButton( "qrc:Qml/Button/MenuButton.qml",
                { type: "m-map", page: mapPage,
                  menu: pageMenu, text: qsTr(" Map")
//text: qsTr("🌍 Map")
//image: Image {source: "qrc:/Assets/Images/Icon/Buttons/Map.svg"}
                }
                );

/*
      addButton( "qrc:Qml/Button/MenuButton.qml",
                { type: "m-hikes", page: hikeSelectPage,
                  menu: pageMenu, text: qsTr(" Hikes")
//text: qsTr("🚶 Hikes")
                }
                );

      addButton( "qrc:Qml/Button/MenuButton.qml",
                { type: "m-tracks", page: trackSelectPage,
                  menu: pageMenu, text: qsTr(" Tracks")
//text: qsTr("🚶 Tracks")
                }
                );

      addButton( "qrc:Qml/Button/MenuButton.qml",
                { type: "m-config", page: configPage,
                  menu: pageMenu, text: qsTr(" Config")
//text: "🛠 " + qsTr("Config")
                }
                );

      addButton( "qrc:Qml/Button/MenuButton.qml",
                { type: "m-tracks-config", page: userTrackConfigPage,
                  menu: pageMenu, text: qsTr(" Recording")
//text: qsTr("📡 Recording")
                }
                );
*/
      addButton( "qrc:Qml/Button/MenuButton.qml",
                { type: "m-about", page: aboutPage,
                  menu: pageMenu, text: qsTr(" About")
//text: qsTr("👥 About")
                }
                );

      addButton( "qrc:Qml/Button/MenuButton.qml",
                { type: "m-exit", page: exitPage,
                  menu: pageMenu, text: qsTr(" Exit")
//text: qsTr("⏻ Exit")
                }
                );
    }
  }
}
