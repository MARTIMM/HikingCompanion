/* ----------------------------------------------------------------------------
  Show a menu. The top rectangle will cover the screen completely to be able
  to receive clicks to close the menu if no menubutton is clicked. The nested
  rectangle is the real menu background wherin the buttons are placed.
---------------------------------------------------------------------------- */

//import "../Page" as HCPage

import io.github.martimm.HikingCompanion.Theme 0.1
//import io.github.martimm.HikingCompanion.GlobalVariables 0.1
//import io.github.martimm.HikingCompanion.Config 0.3

import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
  id: control

  property QtObject properties: Theme.menuProperties
  property int menuOpenedWidth: config.pixels(parseFloat(40.0))
  property int menuClosedWidth: 0
  property real parentWidth: parent.width

//  Config { id: config }

/*
  Component.onCompleted: {
    console.info("MM Menu WH: " + width + ", " + height + ', ' + z + ', ' + menu);
    console.info("menuOpenedWidth: 40mm === " + menuOpenedWidth + " pix");
  }
*/
  width: control.menuClosedWidth
  height: parent.height
  z: 100
  color: "transparent"

  MouseArea {
    width: parent.width
    height: parent.height
    anchors.fill: parent

    onClicked: {
      closeMenu();
    }
  }

  // Functions to open and close the the menu
  function openMenu ( ) {
    control.width = control.parentWidth;
    menu.menuAnimateOpen.start();
  }

  function closeMenu ( ) {
    control.width = 0;
    menu.menuAnimateClose.start();
  }


  // Add buttons to the menu
  // Save some data which is used in _finishCreation
  property var _button;
  property var _options;
  function addButton ( path, o ) {
    _options = Object(o);
    _button = Qt.createComponent(path);
    _finishCreation();
  }

  // function called recursively when not ready and no error
  function _finishCreation ( ) {

    if ( _button.status === Component.Ready ) {
      _button.createObject( menu, _options);
    }

    else if ( _button.status === Component.Error )
      console.warn("Error loading object: " + _button.errorString());

    else
      _button.statusChanged.connect(_finishCreation);
  }

  // function called when clicked on a menu button
  function menuEntryClicked(requestPage) {
    console.log('current: ' + currentPage + ', request: ' + requestPage);
    if ( currentPage !== requestPage ) {
      currentPage.visible = false;
      requestPage.visible = true;
      currentPage = requestPage;
    }

    closeMenu();
  }

/*
    // Current page displayed.
    //property HCPage.Plain currentPage
    function setCurrentPage ( newPage ) {
      currentPage = newPage;
    }

    // Map page to go to from other places
    property HCPage.MapPage mapPage
    function setMapPage ( newMapPage ) {
      mapPage = newMapPage;
    }

    // Set page to map page. The map page will not have this button.
    function setMapPage() {
      currentPage.visible = false;
      mapPage.visible = true;
      setCurrentPage(mapPage);
    }
*/




  // Menu rectangle
  Column {
    id: menu

    width: menuClosedWidth
    height: parent.height
    z: 200      // Menu must be kept above page(1) and button rows(50)
    clip: true  // Buttons must be clipped so they disappear when menu closes
    //color: "transparent"
    spacing: 2

    //anchors.right: parent.right
    anchors.left: parent.left



    // Open and close menu animation
    property alias menuAnimateOpen: menuAnimateOpen
    PropertyAnimation {
      id: menuAnimateOpen

      target: menu
      property: "width"
      duration: 300
      from: control.menuClosedWidth
      to: control.menuOpenedWidth
      easing.type: Easing.InOutQuad //OutBounce
/*
      onStarted: {
        //currentPage.openMenu.visible = true;
        console.info("Started open width = " + menu.width);
      }

      onFinished: {
        //currentPage.openMenu.visible = true;
        console.info("Stopped open width = " + menu.width);
      }
*/
    }

    property alias menuAnimateClose: menuAnimateClose
    PropertyAnimation {
      id: menuAnimateClose

      target: menu
      property: "width"
      duration: 300
      from: control.menuOpenedWidth
      to: control.menuClosedWidth
      easing.type: Easing.InOutQuad //OutBounce
/*
      onStarted: {
        //currentPage.openMenu.visible = true;
        console.info("Started close width = " + menu.width);
      }

      onFinished: {
        //currentPage.openMenu.visible = true;
        console.info("Stopped close width = " + menu.width);
      }
*/
    }
  }
}

