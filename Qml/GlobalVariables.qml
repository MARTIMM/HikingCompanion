/*
  Most variables are set from the application window where everything
  resides. This is an alternative way for having everything singleton.
  Also no components can be creaed when set as a singleton.
*/

pragma Singleton

import io.github.martimm.HikingCompanion.Theme 0.1

import "Button" as HCButton
import "Page" as HCPage

import QtQuick 2.9

// moved to Application main page
QtObject {
  // Button types. buttonType is set by the onCompletion() of a specific button
  // when created in a Toolbar or ButtonRow. The button template checks the type
  // and sets sizes or whatever.
  enum ButtonType { ToolbarButton, ButtonRowButton, MenuButton }

  // Likewise there are other types
  enum TextType {
    InfoAreaText,     // larger on page texts
    MessageAreaText,  // small messages
    WarningAreaText,  // warning text messages
    SuccessAreaText,  // success text messages

    LabelText,        // texts on labels, buttons, combo boxes etc.
    EnabledText,      // enabled widgets === LabelText
    DisabledText,     // disabled widgets

    TitleText,        // titles
    ListText          // list entries
  }

  enum ButtonBar { Toolbar, FooterBar, MenuBar }

//  enum TrailType { Walk, Bike }


/*
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
  property HCButton.OpenMenuTbButton openMenu
  function setOpenMenu ( newOpenMenu ) {
    openMenu = newOpenMenu;
  }

  property Column menu
  function setMenu ( newMenu ) {
    menu = newMenu;
console.info('set menu to ' + menu);
  }
*/

}

