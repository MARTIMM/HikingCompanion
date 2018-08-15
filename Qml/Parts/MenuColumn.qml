import "../Page" as HCPage

import io.github.martimm.HikingCompanion.Theme 0.1
//import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.11
import QtQuick.Window 2.3
import QtQuick.Controls 2.4

Column {
  id: menu
  spacing: 2

  //width: 0
  width: Theme.mnWidth
  height: parent.height
  //z: 10
  //clip: true

  //anchors.right: parent.right
  anchors.left: parent.left

  Component.onCompleted: {
    console.log("MM Menu WH: " + width + ", " + height);
  }

  //property alias menuEntryClicked: menuEntryClicked
  function menuEntryClicked(requestPage) {
    if ( currentPage !== requestPage ) {
      console.log('current: ' + currentPage + ', request: ' + requestPage);

      currentPage.visible = false;
      requestPage.visible = true;
      setCurrentPage(requestPage);
    }

    menuAnimateClose.start()
  }

  // Current page displayed.
  property HCPage.Plain currentPage
  function setCurrentPage ( newPage ) {
    currentPage = newPage;
  }

  // Map page to go to from other places
  property HCPage.MapPage mapPage
  function setMapPage ( newMapPage ) {
    mapPage = newMapPage;
  }

  // Set page to home page. The home pages will not have this button.
  function setHomePage() {
console.log("homeButton clicked");
console.log('current: ' + currentPage);
    currentPage.visible = false;
    mapPage.visible = true;
    setCurrentPage(mapPage);
        //openMenu.visible = true
  }

  // Open and close menu animation
  property alias menuAnimateOpen: menuAnimateOpen
  SequentialAnimation {
    id: menuAnimateOpen
    NumberAnimation {
      target: menu
      property: "width"
      duration: 1000
      from: 0
      to: Theme.mnWidth
      easing.type: Easing.OutBounce
    }
  }

  property alias menuAnimateClose: menuAnimateClose
  SequentialAnimation {
    id: menuAnimateClose
    NumberAnimation {
      target: menu
      property: "width"
      duration: 1000
      from: Theme.mnWidth
      to: 0
      easing.type: Easing.OutBounce
    }

          /*
      onStopped: {
        currentPage.openMenu.visible = true;
      }
  */
  }
}
