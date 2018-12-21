import io.github.martimm.HikingCompanion.Theme 0.1

import QtQuick 2.9
import QtQuick.Layouts 1.3

RowLayout {
  // Row must be kept above page(1)
  //width: parent.width
  //height: parent.height
  z: 10

  spacing: 2

  anchors {
    fill: parent
/*
    leftMargin: Theme.component.toolbar.leftMargin
    rightMargin: Theme.component.toolbar.rightMargin
    topMargin: Theme.component.toolbar.topMargin
    bottomMargin: Theme.component.toolbar.bottomMargin
*/
  }
}


