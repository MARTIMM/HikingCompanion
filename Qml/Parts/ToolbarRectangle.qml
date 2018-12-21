import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.0

Rectangle {

  // Cannot use width or anchors.right because items in the RowLayout child
  // will be stretched over the width
  height: Theme.component.toolbar.height

  // Row must be kept above page(1)
  z: 50

  anchors {
    top: parent.top
    left: parent.left

    leftMargin: Theme.component.toolbar.leftMargin
    rightMargin: Theme.component.toolbar.rightMargin
    topMargin: Theme.component.toolbar.topMargin
    bottomMargin: Theme.component.toolbar.bottomMargin
  }

  color: GlobalVariables.setComponentBgColor(Theme.component.toolbar)

  border {
    width: Theme.component.toolbar.border.width
    color: Theme.component.toolbar.border.color
  }
}
