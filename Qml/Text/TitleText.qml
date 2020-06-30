/*
Centered text to show in a horizontal rectangle

Title text theme properties

real    height
color   textColor
color   background

color   borderColor
real    borderWidth
real    textFontPixelSize
string  textFontFamily
bool    textFontBold
*/

import "." as HCText

import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.12

Rectangle {
  id: control

  property string title: ''
  property QtObject properties: Theme.titleTextProperties

  width: parent.width
  height: properties.height
  color: 'transparent'

  HCText.TextTypes {
    id: titleText
    width: parent.width
    anchors {
      leftMargin: 5
      rightMargin: 5
      topMargin: 5
      bottomMargin: 20
    }

    text: control.title
    textColor: properties.textColor
    backgroundColor: properties.background

    textBorderColor: properties.borderColor
    textBorderWidth: properties.borderWidth

    halign: Text.AlignHCenter;
    valign: Text.AlignVCenter;

    textFont {
      pixelSize: properties.textFontPixelSize
      family: properties.textFontFamily
      bold: properties.textFontBold
    }
  }
}
