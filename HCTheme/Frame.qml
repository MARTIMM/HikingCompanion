import io.github.martimm.HikingCompanion.Theme 0.1

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Templates 2.12 as T

T.Frame {
  id: control

  property QtObject colors: Theme.appColors
  property QtObject properties: Theme.frameProperties


  // Copy from template with substitutions for properties above
  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          contentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           contentHeight + topPadding + bottomPadding)


  padding: properties.padding

  background: Rectangle {
    width: control.width
    height: control.height

    color: properties.background
    border {
      color: properties.borderColor
      width: properties.borderWidth
    }
  }
}
