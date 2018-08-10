import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4

import io.github.martimm.HikingCompanion.HCStyle 0.1
import io.github.martimm.HikingCompanion.Config 0.2

Item {
  id: root

  Component.onCompleted: {

  }

  width: parent.width
  height: HCStyle.largeButtonHeight

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
      textColor: HCStyle.textColor
      selectedTextColor: HCStyle.selectedTextColor
      selectionColor: HCStyle.selectionTextColor
    }
*/
/*
    background: Rectangle {
      color: HCStyle.compBackgroundColor

      radius: HCStyle.smallButtonRadius
      border {
        color: HCStyle.buttonBorderColor
        width: HCStyle.smallButtonBorder
      }
    }

    font {
      family: HCStyle.fontFamily
      capitalization: Font.MixedCase
      pointSize: HCStyle.cfgTextPointSize
    }
*/
  }
}
