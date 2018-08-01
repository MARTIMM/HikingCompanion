import QtQuick 2.11
//import QtQuick.Window 2.3
import QtQuick.Controls 2.4

Button {
  id: entryButton


  width: parent.width
  display: AbstractButton.TextOnly

  anchors.topMargin: 1
  anchors.left: parent.left

  font.pointSize: 23
  font.bold: true

  function setHomePage() {
    console.log("homeButton clicked");
    console.log('current: ' + globalVariables.currentPage + ', request: ' + requestPage);
    if ( globalVariables.currentPage !== mapPage ) {
      globalVariables.currentPage.visible = false;
      mapPage.visible = true;
      globalVariables.currentPage = mapPage;
    }
  }

  function menuEntryClicked(requestPage) {
    if ( globalVariables.currentPage !== requestPage ) {
      console.log('current: ' + globalVariables.currentPage + ', request: ' + requestPage);

      globalVariables.currentPage.visible = false;
      requestPage.visible = true;
      globalVariables.currentPage = requestPage;
    }

    menuAnimateClose.start()
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
      globalVariables.openMenuButton.visible = true
    }
  }
}
