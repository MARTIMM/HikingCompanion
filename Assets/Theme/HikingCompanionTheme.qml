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

  function changeSettings ( c ) {

    setSubFields(
          c.main,
          [ "foreground", "background", "okText", "notOkText",
           "selectedText", "selectionText"
          ],
          main.color
          );

    setSubFields( c.component, [ "foreground", "background"], component.color);

    setSubFields(
          c.toolbar,
          [ "background"],
          component.toolbar
          );

    setSubFieldXSizes(
          c.toolbar,
          [ "leftMargin", "rightMargin", "height" ],
          component.toolbar
          );

    setSubFieldYSizes(
          c.toolbar,
          [ "topMargin", "bottomMargin" ],
          component.toolbar
          );

    setSubFieldXSizes(
          c.toolbar.border,
          [ "width"],
          component.toolbar.border
          );

    setSubFields(
          c.toolbar.border,
          [ "color"],
          component.toolbar.border
          );
  }

  function setSubFields ( source, fields, destination) {
    for ( var fi = 0; fi < fields.length; fi++) {
      if ( typeof source[fields[fi]] !== "undefined" ) {
        console.info("Field " + fields[fi] + " set to " + source[fields[fi]]);
        destination[fields[fi]] = source[fields[fi]];
      }
      else {
        console.warning("Field " + fields[fi] + " not set");
      }
    }
  }

  function setSubFieldXSizes ( source, fields, destination) {
    for ( var fi = 0; fi < fields.length; fi++) {
      if ( typeof source[fields[fi]] !== "undefined" ) {
        console.info("Field size " + fields[fi] + ": " + source[fields[fi]] + " mm set to " + config.pixelsX(parseInt(source[fields[fi]])) + " pixels");
        destination[fields[fi]] = config.pixelsX(source[fields[fi]]);
      }
      else {
        console.warning("Field " + fields[fi] + " not set");
      }
    }
  }

  function setSubFieldYSizes ( source, fields, destination) {
    for ( var fi = 0; fi < fields.length; fi++) {
      if ( typeof source[fields[fi]] !== "undefined" ) {
        console.info("Field size " + fields[fi] + ": " + source[fields[fi]] + " mm set to " + config.pixelsY(parseInt(source[fields[fi]])) + " pixels");
        destination[fields[fi]] = config.pixelsY(source[fields[fi]]);
      }
      else {
        console.warning("Field " + fields[fi] + " not set");
      }
    }
  }

  property QtObject main: QtObject {
    // Main page
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

    property int rounding//:              { config.pixels(5.0) }
  }

  property QtObject component: QtObject {

    property QtObject color: QtObject {
      property color foreground:        "#dfa0ef"
      property color foregroundLight:   Qt.lighter( foreground, 3.0)
      property color foregroundDark:    Qt.darker( foreground, 2.0)

      property color background:        "#8f0070"
      property color backgroundLight:   Qt.lighter( background, 2.0)
      property color backgroundDark:    Qt.darker( background, 2.0)
    }

    property int rounding//:              config.pixels(6);

    property QtObject toolbar: QtObject {
      //property color foreground:
      property color background:        "transparent"

      property real topMargin:          0;
      property real bottomMargin:       0;
      property real leftMargin:         0;
      property real rightMargin:        0;

      property real height:             0;

      property QtObject border: QtObject {
        property int width:             0
        property color color:           "#ff05f0"
      }

      property QtObject button: QtObject {
        property int width//:             { component.toolbar.height - config.pixels(5); }
        property int height//:            { component.toolbar.height - config.pixels(5); }
        property int pixelSize//:         { config.pixels(10); }
        //property int radius: 10
        //property int border: 1
      }
    }

    property QtObject buttonRow: QtObject {
      property real topMargin//:          { config.pixels(6); }
      property real bottomMargin//:       { config.pixels(6); }
      property real leftMargin//:         { config.pixels(6); }
      property real rightMargin//:        { config.pixels(6); }

      property real height//:             { config.pixels(30); }

      property QtObject button: QtObject {
        //property int width:             component.buttonRow.height - 5
        property int height//:            { component.buttonRow.height - config.pixels(5); }
        property int pixelSize//:         { config.pixels(30); }
        //property int radius: 10
        //property int border: 1
      }
    }


    property QtObject menu: QtObject {
      property int width//:               { config.pixels(50); }
      property int height//:              { config.pixels(20); }

      property QtObject button: QtObject {
        property int width//:             { component.menu.width - config.pixels(5); }
        property int height//:            component.menu.height
        property int pixelSize//:         { config.pixels(15); }
        //property int mnBtRadius: 10
        //property int mnBtBorder: 1
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
