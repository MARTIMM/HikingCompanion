import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4

import io.github.martimm.HikingCompanion.Style 0.1
import io.github.martimm.HikingCompanion.Config 0.2

Item {
  id: root

  Component.onCompleted: {

  }

  width: parent.width
  height: Style.largeButtonHeight

  property alias selectItems: selectItems
  property alias model: selectItems.model
  property alias currentText: selectItems.currentText
  property alias currentIndex: selectItems.currentIndex

  ComboBox {
    id: selectItems
    width: parent.width
    padding: 1
    //flat: false
/*
    style: ComboBoxStyle {
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
}
