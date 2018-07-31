import QtQuick 2.11
import QtQuick.Window 2.3
import QtQuick.Controls 2.4

Button {
  id: menuEntryButton


  width: parent.width
  display: AbstractButton.TextOnly

  anchors.topMargin: 1
  anchors.left: parent.left

  font.pointSize: 23
  font.bold: true

  function setHomePage() {
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
      openMenuButton.visible = true
    }
  }
}
