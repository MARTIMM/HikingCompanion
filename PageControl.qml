import QtQuick 2.0

Item {
/*
  id: pageControl
  property Rectangle currentPage: Rectangle {id: emptyCurrentPage}

  function setHomePage() {
    console.log("homeButton clicked");
    console.log('current: ' + currentPage + ', request: ' + requestPage);
    if ( currentPage !== mapPage ) {
      currentPage.visible = false;
      mapPage.visible = true;
      currentPage = mapPage;
    }
  }

  function menuEntryClicked(requestPage) {
    if ( currentPage !== requestPage ) {
      console.log('current: ' + currentPage + ', request: ' + requestPage);

      currentPage.visible = false;
      requestPage.visible = true;
      currentPage = requestPage;
    }

    menuAnimateClose.start()
  }

  // Open and close menu animation
  SequentialAnimation {
    id: menuAnimateOpen
    NumberAnimation {
      target: menu
      property: "width"
      duration: 1000
      from: 0
      to: columnWidth
      easing.type: Easing.OutBounce
    }
  }

  SequentialAnimation {
    id: menuAnimateClose
    NumberAnimation {
      target: menu
      property: "width"
      duration: 1000
      from: columnWidth
      to: 0
      easing.type: Easing.OutBounce
    }

    onStopped: {
      openMenu.visible = true
    }
  }
*/
}
