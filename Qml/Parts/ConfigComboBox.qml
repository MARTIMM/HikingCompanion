import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4

import io.github.martimm.HikingCompanion.Style 0.1

Item {
  id: root

  width: parent.width
  height: Style.largeButtonHeight

  property alias selectItems: selectItems
  property alias model: selectItems.model

  ComboBox {
    id: selectItems
    width: parent.width
    padding: 1
/*
    ComboBoxStyle {
      //control: selectItems
      textColor: Style.textColor
      selectedTextColor: Style.selectedTextColor
      selectionColor: Style.selectionTextColor
    }
*/
    background: Rectangle {
      color: Style.compBackgroundColor

      radius: Style.smallButtonRadius
      border {
        color: Style.buttonBorderColor
        width: Style.smallButtonBorder
      }
    }

    font {
      family: Style.fontFamily
      capitalization: Font.MixedCase
      pointSize: Style.cfgTextPointSize
    }
  }

/*
  property alias inputText: inputText
  property alias placeholderText: inputText.placeholderText
  TextField {
    id: inputText

    background: Rectangle {
      color: Style.compBackgroundColor
      width: parent.width
      anchors.fill: parent

      antialiasing: true
      radius: Style.smallButtonRadius
      border {
        color: Style.buttonBorderColor
        width: Style.smallButtonBorder
      }
    }

    color: Style.textColor

    font {
      family: Style.fontFamily
      capitalization: Font.MixedCase
      //bold: true
      pointSize: Style.cfgTextPointSize
    }
  }
*/
}
