import QtQuick 2.11
import QtQuick.Controls 2.2

import io.github.martimm.HikingCompanion.Style 0.1

Item {
  id: root

  width: parent.width
  height: Style.largeButtonHeight
  //  anchors.fill: parent

  property alias inputText: inputText
  property alias placeholderText: inputText.placeholderText

  TextField {
    id: inputText
    focus: true

    width: parent.width
    background: Rectangle {
      color: Style.compBackgroundColor

      antialiasing: true
      radius: Style.smallButtonRadius
      border {
        color: Style.buttonBorderColor
        width: Style.smallButtonBorder
      }
    }

    // Lets assume the text is still wrong or empty
    color: Style.nokTextColor

    font {
      family: Style.fontFamily
      capitalization: Font.MixedCase
      //bold: true
      pointSize: Style.cfgTextPointSize
    }

    // Show visible clue if input is right or wrong
    onTextChanged: {
      console.log("Acceptable: " + inputText.acceptableInput);
      if ( inputText.acceptableInput ) {
        color = Style.okTextColor;
      }

      else {
        color = Style.nokTextColor;
      }
    }
  }
}
