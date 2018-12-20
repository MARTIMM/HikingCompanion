import "." as HCButton

import io.github.martimm.HikingCompanion.GlobalVariables 0.1

//import QtQuick 2.9
//import QtQuick.Controls 2.2

HCButton.ToolbarButton {
  text: "🌍"
  onClicked: {
    console.info("goto home page");
    GlobalVariables.menu.setHomePage();
  }
}
