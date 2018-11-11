/*
  Most variables are set from the application window where everything
  resides. This is an alternative way for having everything singleton.
  Also no components can be creaed when set as a singleton.
*/

pragma Singleton

import QtQuick 2.9

import "Button" as HCButton
import "Page" as HCPage

QtObject {
  property QtObject component: QtObject {
    property QtObject toolbar: QtObject {
      property QtObject button: QtObject {
        property int type:        0
      }
    }

    property QtObject buttonRow: QtObject {
      property QtObject button: QtObject {
        property int type:        1
      }
    }

    property QtObject menu: QtObject {
      property QtObject button: QtObject {
        property int type:        2
      }
    }
  }

  // Currently displayed page.
  property HCPage.Plain currentPage
  function setCurrentPage ( newPage ) {
    currentPage = newPage;
  }

  property var applicationWindow
  function setApplicationWindow ( appWindow ) {
    applicationWindow = appWindow;
  }

  // Open menu button
  property HCButton.OpenMenu openMenu
  function setOpenMenu ( newOpenMenu ) {
    openMenu = newOpenMenu;
  }

  property Column menu
  function setMenu ( newMenu ) {
    menu = newMenu;
  }
}

