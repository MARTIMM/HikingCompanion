import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls.Material 2.12

T.TextArea {
  id: control

  //property QtObject colors: Theme.appColors
  //property QtObject sizes: Theme.buttonSizes

  property QtObject properties  //: Theme.toolbarProperties

  function init ( type ) {
    console.log("Fn text init(" + type + ")");

    if ( type === GlobalVariables.InfoAreaText )
      properties = Theme.InfoAreaProperties;

    else if ( type === GlobalVariables.MessageAreaText ) {}
    else if ( type === GlobalVariables.WarningAreaText ) {}
    else if ( type === GlobalVariables.SuccessAreaText ) {}
  }



  // Copy from template with substitutions for properties above
  implicitWidth: Math.max(contentWidth + leftPadding + rightPadding,
                          implicitBackgroundWidth + leftInset + rightInset,
                          placeholder.implicitWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(contentHeight + topPadding + bottomPadding,
                           implicitBackgroundHeight + topInset + bottomInset,
                           placeholder.implicitHeight + topPadding + bottomPadding)

  //leftPadding: properties.leftPadding
  //rightPadding: properties.rightPadding
  //topPadding: properties.topPadding
  //bottomPadding: properties.bottomPadding

  //font.family: properties.textFontFamily
  //font.pixelSize: properties.textFontPixelSize

  //color: "#aaa" //properties.textColor
  placeholderTextColor: Color.transparent( control.color, 0.5)
  //selectionColor: properties.textSelectionColor
  //selectedTextColor: properties.textSelectedColor

  PlaceholderText {
    id: placeholder
    x: control.leftPadding
    y: control.topPadding
    width: control.width - (control.leftPadding + control.rightPadding)
    height: control.height - (control.topPadding + control.bottomPadding)

    text: control.placeholderText
    font: control.font
    color: control.placeholderTextColor
    verticalAlignment: control.verticalAlignment
    visible: !control.length && !control.preeditText && (!control.activeFocus || control.horizontalAlignment !== Qt.AlignHCenter)
    elide: Text.ElideRight
    renderType: control.renderType
  }




  /*
  implicitWidth: Math.max(contentWidth + leftPadding + rightPadding,
                          implicitBackgroundWidth + leftInset + rightInset,
                          placeholder.implicitWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(contentHeight + topPadding + bottomPadding,
                           implicitBackgroundHeight + topInset + bottomInset,
                           placeholder.implicitHeight + topPadding + bottomPadding)

  padding: 6
  leftPadding: padding + 4

  color: properties.textColor
  placeholderTextColor: Color.transparent(control.color, 0.5)
  selectionColor: properties.textSelectionColor
  selectedTextColor: properties.textSelectedColor

  PlaceholderText {
    id: placeholder
    x: control.leftPadding
    y: control.topPadding
    width: control.width - (control.leftPadding + control.rightPadding)
    height: control.height - (control.topPadding + control.bottomPadding)

    text: control.placeholderText
    font: control.font
    color: control.placeholderTextColor
    verticalAlignment: control.verticalAlignment
    visible: !control.length && !control.preeditText && (!control.activeFocus || control.horizontalAlignment !== Qt.AlignHCenter)
    elide: Text.ElideRight
    renderType: control.renderType
  }
*/
}
