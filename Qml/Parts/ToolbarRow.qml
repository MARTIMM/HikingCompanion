import QtQuick 2.11

import io.github.martimm.HikingCompanion.Theme 0.1

Row {
  id: root
  spacing: 2

  // Row must be kept above page(1)
  width: parent.width
  height: Theme.tbHeight
  z: 50

  anchors {
    top: parent.top
    right: parent.right
    left: parent.left

    leftMargin: Theme.tbLRMargin
    rightMargin: Theme.tbLRMargin
    topMargin: Theme.tbTBMargin
    bottomMargin: Theme.tbTBMargin
  }
}


