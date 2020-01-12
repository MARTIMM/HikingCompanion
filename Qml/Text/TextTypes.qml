import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.0

Rectangle {
  id: control

  property string text

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
/*
  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           implicitContentHeight + topPadding + bottomPadding)
*/
  width: parent.width
  height: properties.height
  radius: properties.radius

  anchors {
    left: parent.left
    right: parent.right
    top: parent.top

    leftMargin: properties.leftMargin
    rightMargin: properties.rightMargin
    topMargin: properties.topMargin
    bottomMargin: properties.bottomMargin
  }

  property color bg: properties.background
  color: bg//Qt.rgba( bg.r, bg.g, bg.b, properties.bgTransparency)

  border {
    color: properties.borderColor
    width: properties.borderWidth
  }

  property alias textArea: textArea
  Text {
    id: textArea

    height: properties.height
    anchors.fill: parent
    anchors.leftMargin: properties.leftMargin

    text: control.text

    color: properties.textColor

    font {
      pixelSize: properties.textFontPixelSize
      family: properties.textFontFamily
      bold: properties.textFontBold
    }
  }
}
