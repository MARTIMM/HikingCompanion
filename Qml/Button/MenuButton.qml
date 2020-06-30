import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.9
import QtQuick.Controls 2.2

Button {
  id: control

//  property QtObject properties: Theme.menuProperties
  property var menu
  property var page
/*
  anchors {
    topMargin: 5
    //bottomMargin: 5
    leftMargin: 5
    rightMargin: 5
  }
*/

  Component.onCompleted: {
    init(GlobalVariables.MenuButton);
//console.info("MenuButton hwz: " + width + ', ' + height + ', ' + z);
console.info("MenuButton: " + menu + ', ' + page);
  }

  onClicked: {
console.info("MenuButton clicked: " + menu + ', ' + page);
    menu.menuEntryClicked(page);
  }
}
