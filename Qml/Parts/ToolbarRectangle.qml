import io.github.martimm.HikingCompanion.Theme 0.1

import QtQuick 2.0

Rectangle {

  // Row must be kept above page(1)
  width: parent.width
  height: Theme.component.toolbar.height
  z: 50

  anchors {
    top: parent.top
    right: parent.right
    left: parent.left

    leftMargin: Theme.component.toolbar.leftMargin
    rightMargin: Theme.component.toolbar.rightMargin
    topMargin: Theme.component.toolbar.topMargin
    bottomMargin: Theme.component.toolbar.bottomMargin
  }

  color: "green"
  border {
    width: 1
    color: "#003300"
  }
}
