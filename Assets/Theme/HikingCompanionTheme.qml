pragma Singleton

import QtQuick 2.8

QtObject {
  readonly property color gray: "#b2b1b1"
  readonly property color lightGray: "#dddddd"
  readonly property color light: "#ffffff"
  readonly property color blue: "#2d548b"
  property color mainColor: "#17a81a"
  readonly property color dark: "#222222"
  readonly property color mainColorDarker: Qt.darker(mainColor, 1.5)

  property int baseSize: 10

  readonly property int smallSize: 10
  readonly property int largeSize: 16

  property font font: {
    bold: true
    underline: false
    pixelSize: 14
    family: "arial"
  }
  /*
  pragma Singleton

  import QtQuick 2.11

  // Non visible settings
  QtObject {
    objectName: "HCStyle"
*/
  // Areas
  property color appBackgroundColor: "#500040"

  property color compBackgroundColor: "#8f0070"
  property int compRounding: 25

  // Buttons
  property color buttonBackgroundColor: "#af1098"
  property color buttonBorderColor: "#fff0fa"

  property int smallButtonWidth: 35
  property int smallButtonHeight: 35
  property int smallButtonPointSize: 22
  property int smallButtonRadius: 10
  property int smallButtonBorder: 1

  property int largeButtonWidth: 100
  property int largeButtonHeight: 40
  property int largeButtonPointSize: 15
  property int largeButtonRadius: 20
  property int largeButtonBorder: 2

  //property int menuButtonWidth: 100
  property int menuButtonHeight: 50
  property int menuButtonPointSize: 23

  // Text
  property string fontFamily  //: "Source Code Pro"
  property color textColor: "#fff0fa"
  property color okTextColor: "#a0ffa0"
  property color nokTextColor: "#ffa0a0"
  property color selectedTextColor: "#efa0ca"
  property color selectionTextColor: "#efbfcf"
  property int textPointSize: 18

  property int cfgTextPointSize: 16
  property int cfgTextHeight: 20

  property int scrollbarWidth: 10
}
