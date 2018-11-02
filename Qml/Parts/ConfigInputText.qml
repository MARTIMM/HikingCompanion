import QtQuick 2.9
import QtQuick.Controls 2.2

import io.github.martimm.HikingCompanion.Theme 0.1

Item {
  id: control

  width: parent.inputWidth
  height: parent.configHeight
  //  anchors.fill: parent

  property alias inputText: inputText
  property alias placeholderText: inputText.placeholderText

  TextField {
    id: inputText

    width: parent.width
    height: parent.height

    // Show visible clue if input is right or wrong
    onTextChanged: {
      if ( inputText.acceptableInput ) {
        color = Theme.main.color.okText;
      }

      else {
        color = Theme.main.color.notOkText;
      }
    }
  }
}
