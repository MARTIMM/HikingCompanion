
import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1
//import io.github.martimm.HikingCompanion.Config 0.3

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Templates 2.12 as T

T.TextField {
  id: control

  property QtObject colors: Theme.appColors
  property QtObject sizes: Theme.buttonSizes

  implicitWidth: implicitBackgroundWidth + leftInset + rightInset
                 || Math.max(contentWidth, placeholder.implicitWidth) + leftPadding + rightPadding
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           contentHeight + topPadding + bottomPadding,
                           placeholder.implicitHeight + topPadding + bottomPadding)

  padding: 6
  leftPadding: padding + 4

  color: control.appColors.text
  selectionColor: control.appColors.highlight
  selectedTextColor: control.appColors.highlightedText
  placeholderTextColor: Color.transparent(control.color, 0.5)
  verticalAlignment: TextInput.AlignVCenter

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

  background: Rectangle {
    implicitWidth: 200
    implicitHeight: 40
    border.width: control.activeFocus ? 2 : 1
    color: control.appColors.base
    border.color: control.activeFocus ? control.appColors.highlight : control.appColors.mid
  }
}
