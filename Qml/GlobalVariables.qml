pragma Singleton

import QtQuick 2.0

//import "Menu" as HCMenu
import "Button" as HCButton
import "Page" as HCPage

Item {
  id: root

  // Maximum width of the menu. Must be saved
  property int columnWidth: 210

  // Map page to go to from other places
  property HCPage.MapPage mapPage
  function setMapPage ( newMapPage ) {
    mapPage = newMapPage;
  }


  property Rectangle currentPage: Rectangle {id: emptyCurrentPage}
  function setCurrentPage ( newPage ) {
    currentPage = newPage;
  }

  property HCButton.OpenMenu openMenu
  function setOpenMenu ( newOpenMenu ) {
    openMenu = newOpenMenu;
  }

  property Column menu
  function setMenu ( newMenu ) {
    menu = newMenu;
  }


  // Open and close menu animation
  SequentialAnimation {
    id: menuAnimateOpen
    NumberAnimation {
      target: menu
      property: "width"
      duration: 1000
      from: 0
      to: GlobalVariables.columnWidth
      easing.type: Easing.OutBounce
    }
  }

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
}
