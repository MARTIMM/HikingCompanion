import QtQuick 2.11
import QtQuick.Controls 2.2

import io.github.martimm.HikingCompanion.HCStyle 0.1

Item {
  id: root

  width: parent.width
  height: HCStyle.largeButtonHeight
  //  anchors.fill: parent

  property alias inputText: inputText
  property alias placeholderText: inputText.placeholderText

  TextField {
    id: inputText
    //Setting focus will show keyboard to early focus: true

    width: parent.width
/*
    background: Rectangle {
      color: HCStyle.compBackgroundColor

      antialiasing: true
      radius: HCStyle.smallButtonRadius
      border {
        color: HCStyle.buttonBorderColor
        width: HCStyle.smallButtonBorder
      }
    }

    // Lets assume the text is still wrong or empty
    color: HCStyle.nokTextColor

    font {
      family: HCStyle.fontFamily
      capitalization: Font.MixedCase
      //bold: true
      pointSize: HCStyle.cfgTextPointSize
    }
*/
    // Show visible clue if input is right or wrong
    onTextChanged: {
      console.log("Acceptable: " + inputText.acceptableInput);
      if ( inputText.acceptableInput ) {
        color = HCStyle.okTextColor;
      }

      else {
        color = HCStyle.nokTextColor;
      }
    }
  }
}
