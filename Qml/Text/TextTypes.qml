import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.0

Rectangle {
  id: control

  property string text
  property string textColor
  property font textFont
  property color textBorderColor
  property int textBorderWidth
  property color backgroundColor

  property var halign
  property var valign
/*
  property QtObject properties

  function init ( type ) {
    if ( type === GlobalVariables.TitleText ) {
      properties = Theme.titleTextProperties;
      textArea.horizontalAlignment = Text.AlignHCenter;
      textArea.verticalAlignment = Text.AlignVCenter;
    }

    else if ( type === GlobalVariables.ListText ) {
      properties = Theme.listTextProperties;
      textArea.horizontalAlignment = Text.AlignLeft;
    }
  }
*//*
  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           implicitContentHeight + topPadding + bottomPadding)
*/
  width: parent.width
  height: 35 // properties.height
  radius: 5 // properties.radius

  anchors {
    left: parent.left
    right: parent.right
    top: parent.top

    leftMargin: 5 // properties.leftMargin
    rightMargin: 5 // properties.rightMargin
    topMargin: 2 // properties.topMargin
    bottomMargin: 2 // properties.bottomMargin
  }

  //property color bg: properties.background
  color: control.backgroundColor //Qt.rgba( bg.r, bg.g, bg.b, properties.bgTransparency)

  border {
    color: control.textBorderColor
    width: control.textBorderWidth
  }

  property alias textArea: textArea
  Text {
    id: textArea

    // height: properties.height
    anchors.fill: parent
    anchors.leftMargin: 2 // properties.leftMargin

    text: control.text
    horizontalAlignment: control.halign
    verticalAlignment: control.valign

    color: control.textColor //properties.textColor
    font: control.textFont
/*
    font {
      pixelSize: properties.textFontPixelSize
      family: properties.textFontFamily
      bold: properties.textFontBold
    }
*/
  }
}
