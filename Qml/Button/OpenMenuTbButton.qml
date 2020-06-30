import "../../Qml/Parts" as HCParts

import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.9
import QtQuick.Controls 2.2

Button {
  id: control

  text: "☰"

  property var menu

  Component.onCompleted: {
    init(GlobalVariables.ToolbarButton);
    console.info("OpenMenuTbButton whz: " + width + ', ' + height + ', ' + z);
    console.info("OpenMenuTbButton menu: " + menu);
  }

  onClicked: {
    console.info("OpenMenuTbButton wh click: " + width + ', ' + height + ', ' + z);
    console.info("OpenMenuTbButton menu click: " + menu);
    if ( menu.width === 0 ) {
      console.info("open menu: " + menu.width);
      menu.openMenu();
    }

    else {
      console.info("close menu: " + menu.width);
      menu.closeMenu();
    }
  }
}
