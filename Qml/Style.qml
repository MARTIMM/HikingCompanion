pragma Singleton

import QtQuick 2.0

// Non visible settings
QtObject {
  objectName: "HCStyle"

  // Areas
  property color appBackgroundColor: "#500040"

  property color compBackgroundColor: "#8f0070"
  property int compRounding: 25

  // Buttons
  property color buttonBorderColor: "#fff0fa"

  property int smallButtonRadius: 10
  property int smallButtonBorder: 1

  property int largeButtonRadius: 20
  property int largeButtonBorder: 2

  // Text
  property color textColor: "#fff0fa"


}
