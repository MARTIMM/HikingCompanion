/*
  see also
    https://wiki.qt.io/Qml_Styling
    https://doc.qt.io/qt-5/qtquick-controls-styles-qmlmodule.html
    https://doc.qt.io/qt-5/qml-qtquick-controls-styles-buttonstyle.html
*/
pragma Singleton

import io.github.martimm.HikingCompanion.Config 0.3

import QtQuick 2.12
import QtGraphicalEffects 1.0

Item {
  id: themeControl

  Config { id: config }

  // Called once from application window to set all modifiable settings
  function changeSettings ( c ) {
    console.info("Set colors and sizes");

    changeColors(c);

    // set properties
    setProperties( c.toolbarProperties, toolbarProperties);
    setProperties( c.buttonRowProperties, buttonRowProperties);
    setProperties( c.menuProperties, menuProperties);
    setProperties( c.frameProperties, frameProperties);
    setProperties( c.infoAreaProperties, infoAreaProperties);
    setProperties( c.titleTextProperties, titleTextProperties);
    setProperties( c.listTextProperties, listTextProperties);
    setProperties( c.labelTextProperties, labelTextProperties);

/*
    setSubFieldSizes(
          c.toolbar,
          [ "leftMargin", "rightMargin", "topMargin", "bottomMargin", "height"],
          component.toolbar
          );

    setSubFieldSizes( c.toolbar.border, [ "width"], component.toolbar.border);

    setSubFieldSizes(
          c.toolbar.button,
          [ "width", "height", "pixelSize", "radius",
            "leftMargin", "rightMargin", "topMargin", "bottomMargin"
          ],
          component.toolbar.button
          );

    setSubFieldSizes(
          c.toolbar.button.border,
          [ "width"],
          component.toolbar.button.border
          );

    // Button row
    setSubFieldSizes(
          c.buttonrow,
          [ "leftMargin", "rightMargin", "topMargin", "bottomMargin", "height"],
          component.buttonrow
          );

    setSubFieldSizes( c.buttonrow.border, [ "width"], component.buttonrow.border);

    setSubFieldSizes(
          c.buttonrow.button,
          [ "width", "height", "pixelSize", "radius",
            "leftMargin", "rightMargin", "topMargin", "bottomMargin"
          ],
          component.buttonrow.button
          );

    setSubFieldSizes(
          c.buttonrow.button.border,
          [ "width"],
          component.buttonrow.button.border
          );

    // Menu
    setSubFieldSizes( c.menu, [ "width", "height"], component.menu);

    setSubFieldSizes(
          c.menu.button,
          [ "width", "height", "pixelSize", "radius",
            "leftMargin", "rightMargin", "topMargin", "bottomMargin"
          ],
          component.menu.button
          );

    setSubFieldSizes( c.menu.button.border, ["width"], component.menu.button.border);
*/
  }

  // Called from Config to set colors only. This can be from the hiking
  // companion app or from an imported trail
  function changeColors ( c ) {
  return;
    console.info("Set colors");
    setPaletteFields(
          c.appColors,
          [ 'alternateBase', 'base', 'brightText', 'button', 'buttonText',
            'text', 'toolTipBase', 'toolTipText', 'window',
            'windowText',

            'dark', 'light', 'mid', 'midlight', 'shadow',

            'highlight', 'highlightedText',
            'link', 'linkVisited',

            "transparent0", "transparent1", "transparent2", "transparent3",
            "transparent4", "transparent5", "transparent6", "transparent7",
            "transparent8", "transparent9", "transparentA", "transparentB",
            "transparentC", "transparentD", "transparentE", "transparentF"

            //'placeholderText', 'noRole'
          ],
          appColors
          );

    setSubFields(
          c.component,
          [ "foreground", "foregroundLight", "foregroundDark",
            "background", "backgroundLight", "backgroundDark",
            "okText", "notOkText", "selectedText", "selectionText"
          ],
          component.color
          );

    setSubFields(
          c.toolbar,
          [ "background", "backgroundLight", "backgroundDark"],
          component.toolbar
          );
/*
    setSubFields( c.toolbar.border, ["color"], component.toolbar.border);
    setSubFields(
          c.toolbar.button,
          [ "foreground", "foregroundLight", "foregroundDark",
            "background", "backgroundLight", "backgroundDark"
          ],
          component.toolbar.button
          );
    setSubFields(
          c.toolbar.button.border,
          ["color"],
          component.toolbar.button.border
          );
*/
    setSubFields(
          c.buttonrow,
          [ "background", "backgroundLight", "backgroundDark"],
          component.buttonrow
          );
    setSubFields( c.buttonrow.border, ["color"], component.buttonrow.border);
    setSubFields(
          c.buttonrow.button,
          [ "foreground", // "foregroundLight", "foregroundDark",
           "background"   //, "backgroundLight", "backgroundDark"
          ],
          component.buttonrow.button
          );
    setSubFields(
          c.buttonrow.button.border,
          ["color"],
          component.buttonrow.button.border
          );

    // Menu
    setSubFields(
          c.menu,
          ["background", "backgroundLight", "backgroundDark"],
          component.menu
          );

    setSubFields(
          c.menu.button,
          [ "foreground", "foregroundLight", "foregroundDark",
           "background", "backgroundLight", "backgroundDark"
          ],
          component.menu.button
          );

    setSubFields( c.menu.button.border, ["color"], component.menu.button.border);
  }

  function setPaletteFields ( source, fields, destination) {
    for ( var fi = 0; fi < fields.length; fi++) {
      if ( typeof source[fields[fi]] !== "undefined" ) {
        //console.log("Field " + fields[fi] + " set to " + source[fields[fi]]);

        destination[fields[fi]] = source[fields[fi]];
      }
    }
  }

  function setProperties ( source, destination) {
    for ( var field in source ) {
//console.log("Source field type of " + field + " is " + typeof source[field]);
      if ( typeof source[field] === "color" ) {
        destination[field] = source[field];
      }

      else {
console.info("Dest field type of " + field + " is " + typeof source[field]);
        if ( typeof destination[field] === 'number' ) {
          destination[field] = config.pixels(parseFloat(source[field]));
        }

        else {
          destination[field] = source[field];
        }
      }
    }
  }


  function setSubFields ( source, fields, destination) {
    for ( var fi = 0; fi < fields.length; fi++) {
//      console.log("Field [" + fi + "]: " + fields[fi].length);

      if ( typeof source[fields[fi]] !== "undefined" ) {
//        console.log("Field " + fields[fi] + " set to " + source[fields[fi]]);

/*
        if ( fields[fi] === "foregroundLight" ) {
          // 0.0 - 1.0 is like darker and < 0.0 is undefined
          if ( parseFloat(source[fields[fi]]) <= 1.0 ) {
            destination[fields[fi]] = destination["foreground"];
          }
          else {
            destination[fields[fi]] = Qt.lighter(
                  destination["foreground"], parseFloat(source[fields[fi]])
                  );
          }
        }

        else if ( fields[fi] === "foregroundDark" ) {
          if ( parseFloat(source[fields[fi]]) <= 1.0 ) {
            destination[fields[fi]] = destination["foreground"];
          }
          else {
            destination[fields[fi]] = Qt.darker(
                  destination["foreground"], parseFloat(source[fields[fi]])
                  );
          }
        }

        else if ( fields[fi] === "backgroundLight" ) {
          if ( parseFloat(source[fields[fi]]) <= 1.0 ) {
            destination[fields[fi]] = destination["background"];
          }
          else {
            destination[fields[fi]] = Qt.lighter(
                  destination["background"], parseFloat(source[fields[fi]])
                  );
          }
        }

        else if ( fields[fi] === "backgroundDark" ) {
          if ( parseFloat(source[fields[fi]]) <= 1.0 ) {
            destination[fields[fi]] = destination["background"];
          }
          else {
            destination[fields[fi]] = Qt.darker(
                  destination["background"], parseFloat(source[fields[fi]])
                  );
          }
        }

        else {
          destination[fields[fi]] = source[fields[fi]];
        }
*/
        if( fields[fi] === "foreground" || fields[fi] === "background" ) {
          destination[fields[fi]] = source[fields[fi]];
        }
      }
/*
      else if ( fields[fi].length > 1 ) {

      }
*/
      else {
        console.warn("Field " + fields[fi] + " not set");
      }
    }
  }

  function setSubFieldSizes ( source, fields, destination) {
    for ( var fi = 0; fi < fields.length; fi++) {
      if ( typeof source[fields[fi]] !== "undefined" ) {
/*
        console.log("Field size " + fields[fi] + ": " + source[fields[fi]]
                      + " mm set to "
                      + config.pixels(parseFloat(source[fields[fi]])) + " pixels"
                      );
*/
        destination[fields[fi]] = config.pixels(parseFloat(source[fields[fi]]));
      }

      else {
        console.warn("Field " + fields[fi] + " not set");
      }
    }
  }
/*
  From https://doc.qt.io/qt-5/qpalette.html

  AlternateBase   Used as the alternate background color in views with alternating row colors (see QAbstractItemView::setAlternatingRowColors()).
  Base            Used mostly as the background color for text entry widgets, but can also be used for other painting - such as the background of combobox drop down lists and toolbar handles. It is usually white or another light color.
  BrightText      A text color that is very different from WindowText, and contrasts well with e.g. Dark. Typically used for text that needs to be drawn where Text or WindowText would give poor contrast, such as on pressed push buttons. Note that text colors can be used for things other than just words; text colors are usually used for text, but it's quite common to use the text color roles for lines, icons, etc.
  Button          The general button background color. This background can be different from Window as some styles require a different background color for buttons.
  ButtonText      A foreground color used with the Button color.
  PlaceholderText	Used as the placeholder color for various text input widgets. This enum value has been introduced in Qt 5.12
  Text            The foreground color used with Base. This is usually the same as the WindowText, in which case it must provide good contrast with Window and Base.
  ToolTipBase     Used as the background color for QToolTip and QWhatsThis. Tool tips use the Inactive color group of QPalette, because tool tips are not active windows.
  ToolTipText   	Used as the foreground color for QToolTip and QWhatsThis. Tool tips use the Inactive color group of QPalette, because tool tips are not active windows.
  Window          A general background color.
  WindowText      A general foreground color.

  Dark            Darker than Button.
  Light           Lighter than Button color.
  Mid             Between Button and Dark.
  Midlight        Between Button and Light.
  Shadow          A very dark color. By default, the shadow color is Qt::black.

  Highlight     	A color to indicate a selected item or the current item. By default, the highlight color is Qt::darkBlue.
  HighlightedText	A text color that contrasts with Highlight. By default, the highlighted text color is Qt::white.

  Link          	A text color used for unvisited hyperlinks. By default, the link color is Qt::blue.
  LinkVisited     A text color used for already visited hyperlinks. By default, the linkvisited color is Qt::magenta.

  NoRole          No role; this special role is often used to indicate that a role has not been assigned.
*/

  property QtObject appColors: appColors
  QtObject {
    id: appColors

    property color alternateBase
    property color base
    property color brightText
    property color button
    property color buttonText
    property color text
    property color toolTipBase
    property color toolTipText
    property color window
    property color windowText

    property color dark
    property color light
    property color mid
    property color midlight
    property color shadow

    property color highlight
    property color highlightedText

    property color link
    property color linkVisited

    property color transparent0
    property color transparent1
    property color transparent2
    property color transparent3
    property color transparent4
    property color transparent5
    property color transparent6
    property color transparent7
    property color transparent8
    property color transparent9
    property color transparentA
    property color transparentB
    property color transparentC
    property color transparentD
    property color transparentE
    property color transparentF

    property color placeholderText
    //property color noRole: '#a0a0a0'

    property color positive
    property color negative
    property color selectedText
    property color selectionText
  }

  /**************************************************************************
    The following *Sizes sections are fixed so as to have all properties
    the same for all trails
  **************************************************************************/

  // toolbar with buttons
  property QtObject toolbarProperties: toolbarProperties
  QtObject {
    // toolbar properties
    id: toolbarProperties

    property color background

    property real height
    property real radius

    property real topMargin
    property real bottomMargin
    property real leftMargin
    property real rightMargin

    property real spacing

    property real topPadding
    property real bottomPadding
    property real leftPadding
    property real rightPadding

    property int borderWidth
    property color borderColor

    // buttons in a toolbar
    property color buttonDark
    property color buttonButton
    property color buttonMid

    //property real buttonWidth
    //property real buttonHeight
    property real buttonRadius
    property real buttonSpacing

    property int buttonFontPixelSize
    property string buttonFontFamily

    property real buttonTopPadding
    property real buttonBottomPadding
    property real buttonLeftPadding
    property real buttonRightPadding

    property color buttonIconLabelBrightText
    property color buttonIconLabelHighlight
    property color buttonIconLabelWindowText
    property color buttonIconLabelButtonText

    property real buttonIconWidth      //: 24
    property real buttonIconHeight     //: 24

    property int buttonBorderWidth
    property color buttonBorderColor
  }

  // button row at bottom of page
  property QtObject buttonRowProperties: buttonRowProperties
  QtObject {
    id: buttonRowProperties

    property color background

    property real height
    property real radius

    property real topMargin
    property real bottomMargin
    property real leftMargin
    property real rightMargin

    property real spacing

    property real topPadding
    property real bottomPadding
    property real leftPadding
    property real rightPadding

    property int borderWidth
    property color borderColor

    // buttons in a button row
    property color buttonDark
    property color buttonButton
    property color buttonMid

    //property real buttonWidth
    //property real buttonHeight
    property real buttonRadius
    property real buttonSpacing

    property int buttonFontPixelSize
    property string buttonFontFamily

    property real buttonTopPadding
    property real buttonBottomPadding
    property real buttonLeftPadding
    property real buttonRightPadding

    property color buttonIconLabelBrightText
    property color buttonIconLabelHighlight
    property color buttonIconLabelWindowText
    property color buttonIconLabelButtonText

    property real buttonIconWidth      //: 24
    property real buttonIconHeight     //: 24

    property int buttonBorderWidth
    property color buttonBorderColor
  }

  // menu on the side of page
  property QtObject menuProperties: menuProperties
  QtObject {
    id: menuProperties

    property color background

    property real width
    property real height
    property real radius

    property real topMargin
    property real bottomMargin
    property real leftMargin
    property real rightMargin

    property real spacing

    property real topPadding
    property real bottomPadding
    property real leftPadding
    property real rightPadding

    property int borderWidth
    property color borderColor

    // buttons in a button row
    property color buttonDark
    property color buttonButton
    property color buttonMid

    //property real buttonWidth
    property real buttonHeight
    property real buttonRadius
    property real buttonSpacing

    property int buttonFontPixelSize
    property string buttonFontFamily

    property real buttonTopPadding
    property real buttonBottomPadding
    property real buttonLeftPadding
    property real buttonRightPadding

    property color buttonIconLabelBrightText
    property color buttonIconLabelHighlight
    property color buttonIconLabelWindowText
    property color buttonIconLabelButtonText

    property real buttonIconWidth      //: 24
    property real buttonIconHeight     //: 24

    property int buttonBorderWidth
    property color buttonBorderColor
  }

  property QtObject frameProperties: frameProperties
  QtObject {
    id: frameProperties

    property color background
    property real padding
    property real topMargin
    property real bottomMargin
    property real leftMargin
    property real rightMargin

    property color borderColor
    property real borderWidth
  }

  property QtObject infoAreaProperties: infoAreaProperties
  QtObject {
    id: infoAreaProperties

    property color background
    property color textColor
    property color textSelectionColor
    property color textSelectedColor

    property real textFontPixelSize
    property string textFontFamily

    property real leftPadding: 1
    property real rightPadding: 1
    property real topPadding: 1
    property real bottomPadding: 1

    property real radius: 6

    property color borderColor
    property real borderWidth
  }

  property QtObject titleTextProperties: titleTextProperties
  QtObject {
    id: titleTextProperties

    property color background
    property real bgTransparency

    property real radius
    property real height

    property color textColor
    property color textSelectedColor
    property real textFontPixelSize
    property string textFontFamily
    property bool textFontBold
    property int horizontalAlignment

    property real topMargin
    property real bottomMargin
    property real leftMargin
    property real rightMargin

    property color borderColor
    property real borderWidth
  }

  property QtObject listTextProperties: listTextProperties
  QtObject {
    id: listTextProperties

    property color background
    property real bgTransparency

    property real radius
    property real height

    property color textColor
    property color textSelectedColor
    property real textFontPixelSize
    property string textFontFamily
    property bool textFontBold

    property real topMargin
    property real bottomMargin
    property real leftMargin
    property real rightMargin

    property color borderColor
    property real borderWidth
  }

  property QtObject labelTextProperties: labelTextProperties
  QtObject {
    id: labelTextProperties

    property color background
    property real bgTransparency

    property real radius
    property real height

    property color textSelectedColor
    property color textColor
    property color textLinkColor
    property real textFontPixelSize
    property string textFontFamily
    property bool textFontBold

    property real topMargin
    property real bottomMargin
    property real leftMargin
    property real rightMargin

    property color borderColor
    property real borderWidth
  }








  // General components
  property QtObject component: QtObject {
    property QtObject color: QtObject {
      property color foreground
      property color foregroundLight
      property color foregroundDark

      property color background
      property color backgroundLight
      property color backgroundDark

      property color okText
      property color notOkText

      property color selectedText
      property color selectionText
    }

    property QtObject toolbar: QtObject {
      property color background
      property color backgroundLight
      property color backgroundDark

      property real topMargin
      property real bottomMargin
      property real leftMargin
      property real rightMargin

      property real height

      property QtObject border: QtObject {
        property int width
        property color color
      }

      property QtObject button: QtObject {
        property int width
        property int height
        property int pixelSize
        property int radius

        property color foreground
        property color foregroundLight
        property color foregroundDark
        property color background
        property color backgroundLight
        property color backgroundDark

        property real topMargin
        property real bottomMargin
        property real leftMargin
        property real rightMargin

        property QtObject border: QtObject {
          property int width
          property color color
        }
      }
    }

    property QtObject buttonrow: QtObject {
      property color background
      property color backgroundLight
      property color backgroundDark

      property real topMargin
      property real bottomMargin
      property real leftMargin
      property real rightMargin

      property real height

      property QtObject border: QtObject {
        property int width
        property color color
      }

      property QtObject button: QtObject {
        property int width
        property int height
        property int pixelSize
        property int radius

        property color foreground
        property color foregroundLight
        property color foregroundDark
        property color background
        property color backgroundLight
        property color backgroundDark

        property real topMargin
        property real bottomMargin
        property real leftMargin
        property real rightMargin

        property QtObject border: QtObject {
          property int width
          property color color
        }
      }
    }

    property QtObject menu: QtObject {
      property int width
      property int height

      property color background
      property color backgroundLight
      property color backgroundDark

      property real topMargin
      property real bottomMargin
      property real leftMargin
      property real rightMargin

      property QtObject border: QtObject {
        property int width
        property color color
      }

      property QtObject button: QtObject {
        property int width
        property int height
        property int pixelSize
        property int radius

        property color foreground
        property color foregroundLight
        property color foregroundDark
        property color background
        property color backgroundLight
        property color backgroundDark

        property real topMargin
        property real bottomMargin
        property real leftMargin
        property real rightMargin

        property QtObject border: QtObject {
          property int width
          property color color
        }
      }
    }
/*
    // Menu properties
    property int mnWidth: 210

    // Menu button properties
    property int mnBtWidth: mnWidth - 5
    property int mnBtHeight: 50
    property int mnBtPixelSize: 40

  property int menuButtonWidth: 100
  property int menuButtonHeight: 50
  property int menuButtonPointSize: 23
*/
  }

  property QtObject pageGradient: QtObject {
/*
    property color g1: Qt.lighter( component.color.foreground, 0.50) //"#be50e0"
    property color g2: Qt.lighter( component.color.foreground, 0.99) //"#fef0f8"
    property color g3: Qt.lighter( component.color.foreground, 0.50) //"#be50e0"
    property color g4: Qt.lighter( component.color.foreground, 0.21) //"#6f305f"
    property color g5: Qt.lighter( component.color.foreground, 0.11) //"#300040"
*/
    property color g1: component.color.foreground //"#be50e0"
    property color g2: Qt.lighter( component.color.foreground, 2.0) //"#fef0f8"
    property color g3: component.color.foreground //"#be50e0"
    property color g4: Qt.darker( component.color.foreground, 1.50) //"#6f305f"
    property color g5: Qt.darker( component.color.foreground, 2.00) //"#300040"

    property real p1:  0.0
    property real p2:  0.02
    property real p3:  0.05
    property real p4:  0.5
    property real p5:  1.0
  }

  property QtObject mapParameters: QtObject {
    property real startZoomLevel: 15
    property real minZoomLevel: 4
    property real maxZoomLevel: 16
  }

  // Grid config measures
  property int cfgFieldMargin: 6
  property int cfgRowHeight: 35

  // Combobox
  property int cbxPixelSize: 35
  //property int cfgtxtPointSize: 16
  //property int cfgtxtHeight: 20

  // Label config properties
  property int lblPixelSize: 20
  property int lblFieldMargin: 6

  // TextField config properties
  property int txtfPixelSize: 20
  property int txtfFieldMargin: 6



  property int baseSize: 10
  readonly property int smallSize: 10
  readonly property int largeSize: 16
/*
  // Areas
  property color appBackgroundColor: "#500040"

  property color compBackgroundColor: "#8f0070"
  property int compRounding: 25

  // Buttons
  property color buttonBackgroundColor: "#af1098"
  property color buttonBorderColor: "#fff0fa"
*/
/*
  // Buttons
  property int smallBtWidth: 35
  property int smallBtHeight: 35
  property int smallBtPointSize: 15
  property int smallBtRadius: 10
  property int smallBtBorder: 1

  property int largeBtWidth: 100
  property int largeBtHeight: 40
  property int largeBtPointSize: 20
  property int largeBtRadius: 20
  property int largeBtBorder: 2
*/
/*
  property font smallBtFont: {
    bold: true
    underline: false
    //pixelSize: 14
    pointSize: smallBtPointSize
    family: Theme.fontFamily
  }
*/

/*
  property font largeBtFont: {
    bold: true
    underline: false
    //pixelSize: 14
    pointSize: 100
    family: Theme.fontFamily
  }
*/


  // Text
  property string fontFamily: "Symbola"
  //property color txtColor: "#fff0fa"
  //property color oktxtColor: "#a0ffa0"
  //property color noktxtColor: "#ffa0a0"
  property color selectedtxtColor: "#efa0ca"
  property color selectiontxtColor: "#efbfcf"
  property int txtPointSize: 18

  //property int cfgtxtPointSize: 16
  //property int cfgtxtHeight: 20

  property int sbWidth: 10
}//
