/*
  see also
    https://wiki.qt.io/Qml_Styling
    https://doc.qt.io/qt-5/qtquick-controls-styles-qmlmodule.html
    https://doc.qt.io/qt-5/qml-qtquick-controls-styles-buttonstyle.html
*/
pragma Singleton

import io.github.martimm.HikingCompanion.Config 0.3

import QtQuick 2.8
import QtGraphicalEffects 1.0

Item {
  id: themeControl

  Config { id: config }

  // Called from Config to set colors only
  function changeColors ( c ) {
    console.info("Set colors");
    setSubFields(
          c.main,
          [ "foreground", "background", "okText", "notOkText",
           "selectedText", "selectionText"
          ],
          main.color
          );

    setSubFields( c.component, [ "foreground", "background"], component.color);

    setSubFields( c.toolbar, [ "background"], component.toolbar);
    setSubFields(
          c.toolbar.button,
          [ "foreground", "background"],
          component.toolbar.button
          );
    setSubFields( c.toolbar.border, ["color"], component.toolbar.border);

    setSubFields( c.buttonrow, [ "background"], component.buttonrow);
    setSubFields(
          c.buttonrow.button,
          [ "foreground", "background"],
          component.buttonrow.button
          );
    setSubFields( c.buttonrow.border, ["color"], component.buttonrow.border);
  }

  // Called once from application window to set all modifiable settings
  function changeSettings ( c ) {
    console.info("Set colors and sizes");
    setSubFields(
          c.main,
          [ "foreground", "background", "okText", "notOkText",
           "selectedText", "selectionText"
          ],
          main.color
          );

    setSubFields( c.component, [ "foreground", "background"], component.color);

    // Toolbar
    setSubFields( c.toolbar, [ "background"], component.toolbar);
    setSubFieldSizes(
          c.toolbar,
          [ "leftMargin", "rightMargin", "topMargin", "bottomMargin", "height"],
          component.toolbar
          );

    setSubFieldSizes( c.toolbar.border, [ "width"], component.toolbar.border);
    setSubFields( c.toolbar.border, [ "color"], component.toolbar.border);

    setSubFieldSizes(
          c.toolbar.button,
          [ "width", "height", "pixelSize", "radius"],
          component.toolbar.button
          );

    setSubFieldSizes(
          c.toolbar.button.border,
          [ "width"],
          component.toolbar.button.border
          );

    setSubFields(
          c.toolbar.button.border,
          [ "color"],
          component.toolbar.button.border
          );

    // Button row
    setSubFields( c.buttonrow, [ "background"], component.buttonrow);
    setSubFieldSizes(
          c.buttonrow,
          [ "leftMargin", "rightMargin", "topMargin", "bottomMargin", "height"],
          component.buttonrow
          );

    setSubFieldSizes( c.buttonrow.border, [ "width"], component.buttonrow.border);
    setSubFields( c.buttonrow.border, [ "color"], component.buttonrow.border);

    setSubFieldSizes(
          c.buttonrow.button,
          [ "width", "height", "pixelSize", "radius"],
          component.buttonrow.button
          );

    setSubFields(
          c.buttonrow.button,
          [ "foreground", "background"],
          component.buttonrow.button
          );

    setSubFieldSizes(
          c.buttonrow.button.border,
          [ "width"],
          component.buttonrow.button.border
          );

    setSubFields(
          c.buttonrow.button.border,
          [ "color"],
          component.buttonrow.button.border
          );

    // Menu
    setSubFields( c.menu, ["background"], component.menu);
    setSubFieldSizes( c.menu, [ "width", "height"], component.menu);

    setSubFieldSizes(
          c.menu.button,
          [ "width", "height", "pixelSize", "radius"],
          component.menu.button
          );

    setSubFields(
          c.menu.button,
          [ "foreground", "background"],
          component.menu.button
          );

    setSubFieldSizes( c.menu.button.border, ["width"], component.menu.button.border);
    setSubFields( c.menu.button.border, ["color"], component.menu.button.border);
  }

  function setSubFields ( source, fields, destination) {
    for ( var fi = 0; fi < fields.length; fi++) {
      //console.info("Field length of " + fi + ": " + fields[fi].length);
      if ( typeof source[fields[fi]] !== "undefined" ) {
        console.info("Field " + fields[fi] + " set to " + source[fields[fi]]);
        destination[fields[fi]] = source[fields[fi]];
      }
/*
      else if ( fields[fi].length > 1 ) {

      }
*/
      else {
        console.warning("Field " + fields[fi] + " not set");
      }
    }
  }

  function setSubFieldSizes ( source, fields, destination) {
    for ( var fi = 0; fi < fields.length; fi++) {
      if ( typeof source[fields[fi]] !== "undefined" ) {
        console.info("Field size " + fields[fi] + ": " + source[fields[fi]]
                     + " mm set to "
                     + config.pixels(parseInt(source[fields[fi]])) + " pixels"
                     );
        destination[fields[fi]] = config.pixels(source[fields[fi]]);
      }
      else {
        console.info("Field " + fields[fi] + " not set");
      }
    }
  }

  // Main page
  property QtObject main: QtObject {
    property QtObject color: QtObject {
      property color foreground:        "#ffffff"
      property color foregroundLight:   Qt.lighter( foreground, 2.0)
      property color foregroundDark:    Qt.darker( foreground, 2.0)

      property color background:        "#000000"
      property color backgroundLight:   Qt.lighter( background, 2.0)
      property color backgroundDark:    Qt.darker( background, 2.0)

      property color okText:            "#a0ffa0"
      property color notOkText:         "#ffa0a0"

      property color selectedText:      "#efa0ca"
      property color selectionText:     "#efbfcf"
    }
  }

  // General components
  property QtObject component: QtObject {
    property QtObject color: QtObject {
      property color foreground:        "#dfa0ef"
      property color foregroundLight:   Qt.lighter( foreground, 3.0)
      property color foregroundDark:    Qt.darker( foreground, 2.0)

      property color background:        "#8f0070"
      property color backgroundLight:   Qt.lighter( background, 2.0)
      property color backgroundDark:    Qt.darker( background, 2.0)
    }

    property QtObject toolbar: QtObject {
      property color background

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
        property color background

        property QtObject border: QtObject {
          property int width
          property color color
        }
      }
    }

    property QtObject buttonrow: QtObject {
      property color background

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
        property color background

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
        property color background

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
}
