import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1
//import io.github.martimm.HikingCompanion.Config 0.3

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Templates 2.12 as T

T.Button {
  id: control

//  property QtObject colors: Theme.appColors
  property QtObject properties  //: Theme.toolbarProperties

  // Initialization function to keep the buttons as simple as possible.
  // The function is called with a type which is declared in GlobalVariables.
  // When pushed to the extreme, the buttons are very clean and Types import
  // will not be necessary anymore in those modules.
  function init ( type ) {
console.log("Fn button init(" + type + ")");
    if ( type === GlobalVariables.ToolbarButton ) {
      properties = Theme.toolbarProperties;
      control.y = properties.buttonBorderWidth + properties.bottomMargin;
      control.height = parent.height - properties.buttonTopPadding -
          properties.buttonBorderWidth
      control.width = textItem.contentWidth + properties.buttonLeftPadding +
          properties.buttonRightPadding;
//      control.textAlignment = Text.AlignHCenter;
    }

    else if ( type === GlobalVariables.ButtonRowButton ) {
      properties = Theme.buttonRowProperties;
      control.y = properties.buttonBorderWidth + properties.bottomMargin;
      control.height = parent.height - properties.buttonTopPadding -
          properties.buttonBorderWidth
      control.width = textItem.contentWidth + properties.buttonLeftPadding +
          properties.buttonRightPadding;
//      control.textAlignment = Text.AlignHCenter;
//      control.anchors.right = parent.right;
    }

    else if ( type === GlobalVariables.MenuButton ) {
      properties = Theme.menuProperties;
      control.height = properties.height;
      control.width = properties.width;
      control.textItem.horizontalAlignment = Text.AlignLeft;
      control.backgroundArea.anchors.leftMargin = 10;
    }
  }

  Component.onCompleted: {
    console.log("Butt rect parent: " + parent.height + ', ' + height);
  }

  font {
    pixelSize: properties.buttonFontPixelSize
    family: properties.buttonFontFamily
  }

  icon {
    width: properties.buttonIconWidth
    height: properties.buttonIconHeight
    color: control.checked || control.highlighted
              ? control.colors.brightText
              : control.flat && !control.down
                ? ( control.visualFocus
                    ? control.colors.highlight
                    : control.colors.windowText)
                : control.colors.buttonText

  }

  implicitWidth: textItem.contentWidth + properties.buttonLeftPadding + properties.buttonRightPadding
  implicitHeight: properties.height
          ? properties.height
          : parent.height - properties.buttonTopPadding -
            properties.buttonBorderWidth;

/*
  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           implicitContentHeight + topPadding + bottomPadding)
*/
  spacing: properties.buttonSpacing

  property alias textItem: textItem
  contentItem: Text {
    id: textItem

    text: control.text
    textFormat: Text.RichText
    font: control.font

    horizontalAlignment: Text.AlignHCenter // control.textHAlignment //Text.AlignHCenter
    verticalAlignment: Text.AlignBottom

    //opacity: enabled ? 1.0 : 0.3
    //color: "#ff8800" //properties.buttonIconLabelHighlight
    //color: properties.buttonIconLabelHighlight

    color: control.checked || control.highlighted
           ? properties.buttonIconLabelBrightText
           : control.flat && !control.down
             ? ( control.visualFocus
                 ? properties.buttonIconLabelHighlight
                 : properties.buttonIconLabelWindowText)
             : properties.buttonIconLabelButtonText
  }

  // Button background
  property alias backgroundArea: backgroundArea
  background: Rectangle {
    id: backgroundArea
//    implicitWidth: parent.width
//    implicitHeight: parent.height
//  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
//                          implicitContentWidth + leftPadding + rightPadding)
//  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
//                           implicitContentHeight + topPadding + bottomPadding)

    // height is within the button row (parent)
    height: control.height
    width: control.width
    //y: control.y
    radius: properties.buttonRadius

    //anchors.fill: anchors.parent

    visible: !control.flat || control.down || control.checked || control.highlighted
    color: Color.blend( control.checked || control.highlighted
                       ? properties.buttonDark : properties.buttonButton,
                       properties.buttonMid, control.down ? 0.5 : 0.0)
    opacity: enabled ? 1.0 : 0.3
    border {
      color: properties.buttonBorderColor
      width: properties.buttonBorderWidth //control.visualFocus ? 2 : 0
    }
  }
}
