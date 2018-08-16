/*
  Purpose of this file is to define application specific measurements like
  positions and fonts. Available as 'Theme'

  import io.github.martimm.HikingCompanion.Theme 0.1
*/
pragma Singleton

import QtQuick 2.8

QtObject {

  // Toolbar properties
  property real tbTBMargin: 6
  property real tbLRMargin: 6
  property real tbHeight: 28

  // Toolbar button properties
  property int tbBtWidth: tbHeight - 5
  property int tbBtHeight: tbHeight - 5
  property int tbBtPixelSize: 18
  //property int tbBtRadius: 10
  //property int tbBtBorder: 1


  // Buttonrow properties
  property real brTBMargin: 6
  property real brLRMargin: 6
  property real brHeight: 40

  // Toolbar button properties
  property int brBtWidth: brHeight - 5
  property int brBtHeight: brHeight - 5
  property int brBtPixelSize: 34
  //property int tbBtRadius: 10
  //property int tbBtBorder: 1

  // Menu properties
  property int mnWidth: 210
  //property int mnHeight: 50

  // Menu button properties
  property int mnBtWidth: mnWidth - 5
  property int mnBtHeight: 50
  property int mnBtPixelSize: 40
  //property int mnBtRadius: 10
  //property int mnBtBorder: 1




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

  property int largeBtWidth: 100
  property int largeBtHeight: 40
  property int largeBtPointSize: 20
  property int largeBtRadius: 20
  property int largeBtBorder: 2
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
  property int menuButtonHeight: 50
  property int menuButtonPointSize: 23


  // Text
  property string fontFamily: "Arial"  //: "Source Code Pro"
  property color textColor: "#fff0fa"
  property color okTextColor: "#a0ffa0"
  property color nokTextColor: "#ffa0a0"
  property color selectedTextColor: "#efa0ca"
  property color selectionTextColor: "#efbfcf"
  property int textPointSize: 18

  property int cfgTextPointSize: 16
  property int cfgTextHeight: 20

  property int sbWidth: 10
}
