import "../../Qml/Page" as HCPage
//import "../../Qml/Parts" as HCParts
//import "../../Qml/Button" as HCButton

import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1
import io.github.martimm.HikingCompanion.Config 0.3

import QtQuick 2.9
import QtQuick.Controls 2.2
//import QtQuick.Window 2.3


ApplicationWindow {
  id: root
  title: qsTr("Test Application")

  visible: true

  width: 600
  height: 450

  Component.onCompleted: {
    GlobalVariables.setApplicationWindow(this);
    //GlobalVariables.setCurrentPage(homePage);
    //GlobalVariables.setMenu(menu);

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

  // Show the page to be tested
  HCPage.HomePage {
    visible: true
  }
}

