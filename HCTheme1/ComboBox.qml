import QtQuick 2.8
import QtGraphicalEffects 1.0
import QtQuick.Templates 2.1 as T

import io.github.martimm.HikingCompanion.HCTheme1 0.1
import io.github.martimm.HikingCompanion.Theme 0.1

T.ComboBox {
  id: control

  Component.onCompleted: {
    console.log("CBX completed: " + model + ", " + width + ", " + height);
  }

  width: parent.width
  height: Theme.largeButtonHeight
  anchors.fill: parent

  opacity: enabled ? 1 : 0.7

  padding: 1
  z: 50
/*
  font {
    bold: true
    underline: false
    //pixelSize: 14
    //pointSize: Theme.largeBtPointSize
    family: Theme.fontFamily
    pixelSize: Theme.cfgTextPixelSize
  }
*/
  background: Rectangle {
    //color: "#00000000"
    color: HCTheme1.cmptBgColor
    border {
      color: HCTheme1.cmptFgColorL
      width: 1
    }
  }

  //flat: false

  contentItem: Text {
    text: control.textRole
    color: HCTheme1.cmptFgColorL
    font {
      family: Theme.fontFamily
      bold: true
      underline: false
      pixelSize: Theme.cbxPixelSize
    }
  }

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
    color: "#00000000"
  }
*/
/**/
}
