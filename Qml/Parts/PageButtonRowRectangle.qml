import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.0

Rectangle {

  // Cannot use width or anchors.left because items in the RowLayout child
  // will be stretched over the width
  height: Theme.component.buttonrow.height

  // Row must be kept above page(1)
  z: 50

  anchors {
    right: parent.right
    bottom: parent.bottom

    leftMargin: Theme.component.buttonrow.leftMargin
    rightMargin: Theme.component.buttonrow.rightMargin
    topMargin: Theme.component.buttonrow.topMargin
    bottomMargin: Theme.component.buttonrow.bottomMargin
  }

  color: GlobalVariables.setComponentBgColor(Theme.component.buttonrow)

  border {
    width: Theme.component.buttonrow.border.width
    color: Theme.component.buttonrow.border.color
  }
}
