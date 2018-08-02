import QtQuick 2.11
//import QtQuick.Window 2.3
//import QtQuick.Controls 2.4

import "." as HCButton
//import ".."
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

HCButton.Base {
  id: root

  width: parent.width
//  display: AbstractButton.TextOnly

  anchors.topMargin: 1
  anchors.left: parent.left

//  font.pointSize: 23
//  font.bold: true

  function setHomePage() {
    console.log("homeButton clicked");
    console.log('current: ' + GlobalVariables.currentPage);
    if ( GlobalVariables.currentPage !== mapPage ) {
      GlobalVariables.currentPage.visible = false;
      mapPage.visible = true;
      GlobalVariables.setCurrentPage(GlobalVariables.mapPage);
    }
  }

  function menuEntryClicked(requestPage) {
    if ( GlobalVariables.currentPage !== requestPage ) {
      console.log('current: ' + GlobalVariables.currentPage + ', request: ' + requestPage);

      GlobalVariables.currentPage.visible = false;
      requestPage.visible = true;
      GlobalVariables.setCurrentPage(requestPage);
    }

    GlobalVariables.menuAnimateClose.start()
  }
/*
  SequentialAnimation {
    id: menuAnimateClose
    NumberAnimation {
      target: menu
      property: "width"
      duration: 1000
      from: GlobalVariables.columnWidth
      to: 0
      easing.type: Easing.OutBounce
    }

    onStopped: {
      GlobalVariables.openMenu.visible = true
    }
  }
*/
}
