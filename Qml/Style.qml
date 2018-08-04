pragma Singleton

import QtQuick 2.11

// Non visible settings
QtObject {
  objectName: "HCStyle"

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
  property int largeButtonHeight: 30
  property int largeButtonPointSize: 15
  property int largeButtonRadius: 20
  property int largeButtonBorder: 2

  //property int menuButtonWidth: 100
  property int menuButtonHeight: 50
  property int menuButtonPointSize: 23

  // Text
  property color textColor: "#fff0fa"
  property int textPointSize: 18

  property int scrollbarWidth: 10
}
