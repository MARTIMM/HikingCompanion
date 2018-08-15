// See also http://imaginativethinking.ca/make-qml-component-singleton/
// and http://doc.qt.io/qt-5/qml-qtqml-qtobject.html about locating and using
// components from c++
pragma Singleton

import QtQuick 2.11

//import "Menu" as HCMenu
//import "Button" as HCButton
//import "Page" as HCPage

Item {
  id: root
/*
  // Current page displayed.
  property Rectangle currentPage
  function setCurrentPage ( newPage ) {
    currentPage = newPage;
  }
*/
/*
  // Map page to go to from other places
  property HCPage.MapPage mapPage
  function setMapPage ( newMapPage ) {
    mapPage = newMapPage;
  }
*/
/*
  // Set page to home page. The home pages will not have this button.
  function setHomePage() {
    console.log("homeButton clicked");
    console.log('current: ' + currentPage);
    currentPage.visible = false;
    mapPage.visible = true;
    setCurrentPage(mapPage);
    //openMenu.visible = true
  }
*/
/*
  property HCButton.OpenMenu openMenu
  function setOpenMenu ( newOpenMenu ) {
    openMenu = newOpenMenu;
  }
*/
/*
  // Maximum width of the menu. Must be saved
  property int menuWidth: 210

  property Column menu
  function setMenu ( newMenu ) {
    menu = newMenu;
  }

  function menuEntryClicked(requestPage) {
    if ( currentPage !== requestPage ) {
      console.log('current: ' + currentPage + ', request: ' + requestPage);

      currentPage.visible = false;
      requestPage.visible = true;
      setCurrentPage(requestPage);
    }

    menuAnimateClose.start()
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
      to: menuWidth
      easing.type: Easing.OutBounce
    }
  }
*/
/*
  property alias menuAnimateClose: menuAnimateClose
  SequentialAnimation {
    id: menuAnimateClose
    NumberAnimation {
      target: menu
      property: "width"
      duration: 1000
      from: menuWidth
      to: 0
      easing.type: Easing.OutBounce
    }
*/
/*
    onStopped: {
      currentPage.openMenu.visible = true;
    }
  }
*/
}

