/*
  see also
    https://wiki.qt.io/Qml_Styling
    https://doc.qt.io/qt-5/qtquick-controls-styles-qmlmodule.html
    https://doc.qt.io/qt-5/qml-qtquick-controls-styles-buttonstyle.html
*/
pragma Singleton

import QtQuick 2.8
import QtGraphicalEffects 1.0

QtObject {
  id: themeControl

  function changeClrs ( c ) {

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
          [ "background", "topMargin", "bottomMargin", "leftMargin",
           "rightMargin", "height"
          ],
          component.toolbar
          );

    setSubFields(
          c.toolbar.border,
          [ "width", "color"],
          component.toolbar.border
          );
  }

  function setSubFields ( source, fields, destination) {
    for ( var fi = 0; fi < fields.length; fi++) {
      if ( source[fields[fi]] ) {
        console.log("Field " + fields[fi] + " set");
        destination[fields[fi]] = source[fields[fi]];
      }
      else {
        console.log("Field " + fields[fi] + " not set");
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

    property int rounding:              25
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

    property int rounding:              6

    property QtObject toolbar: QtObject {
      //property color foreground:
      property color background:        "transparent"

      property real topMargin:          6
      property real bottomMargin:       6
      property real leftMargin:         6
      property real rightMargin:        6

      property real height:             28

      property QtObject border: QtObject {
        property int width:             0
        property color color:           "#ff05f0"
      }

      property QtObject button: QtObject {
        property int width:             component.toolbar.height - 5
        property int height:            component.toolbar.height - 5
        property int pixelSize:         18
        //property int radius: 10
        //property int border: 1
      }
    }

    property QtObject buttonRow: QtObject {
      property real topMargin:          6
      property real bottomMargin:       6
      property real leftMargin:         6
      property real rightMargin:        6

      property real height:             40

      property QtObject button: QtObject {
        //property int width:             component.buttonRow.height - 5
        property int height:            component.buttonRow.height - 5
        property int pixelSize:         34
        //property int radius: 10
        //property int border: 1
      }
    }


    property QtObject menu: QtObject {
      property int width:               210
      property int height:              50

      property QtObject button: QtObject {
        property int width:             component.menu.width - 5
        property int height:            component.menu.height
        property int pixelSize:         40
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
*/
  }

  property QtObject pageGradient: QtObject {
    property color g1: Qt.lighter( component.color.foreground, 0.50) //"#be50e0"
    property color g2: Qt.lighter( component.color.foreground, 0.99) //"#fef0f8"
    property color g3: Qt.lighter( component.color.foreground, 0.50) //"#be50e0"
    property color g4: Qt.lighter( component.color.foreground, 0.21) //"#6f305f"
    property color g5: Qt.lighter( component.color.foreground, 0.11) //"#300040"

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

  // Buttons
  property int smallBtWidth: 35
  property int smallBtHeight: 35
  property int smallBtPointSize: 15
  property int smallBtRadius: 10
  property int smallBtBorder: 1
/*
  property font smallBtFont: {
    bold: true
    underline: false
    //pixelSize: 14
    pointSize: smallBtPointSize
    family: "arial"
  }
*/

  //property int largeBtWidth: 100
  //property int largeBtHeight: 40
  //property int largeBtPointSize: 20
  //property int largeBtRadius: 20
  //property int largeBtBorder: 2
/**/
/*
  property font largeBtFont: {
    bold: true
    underline: false
    //pixelSize: 14
    pointSize: 100
    family: "arial"
  }
*/

  //property int menuButtonWidth: 100
  //property int menuButtonHeight: 50
  //property int menuButtonPointSize: 23


  // Text
  property string fontFamily: "Arial"  //: "Source Code Pro"
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
