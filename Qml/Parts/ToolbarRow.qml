import io.github.martimm.HikingCompanion.Theme 0.1

import QtQuick 2.9

Row {
  spacing: 2

  width: parent.width
  height: parent.height

  anchors {
    fill: parent
/*
    leftMargin: 2
    rightMargin: 2
    topMargin: 3
    bottomMargin: 1
*/
    leftMargin: Theme.component.toolbar.leftMargin
    rightMargin: Theme.component.toolbar.rightMargin
    topMargin: Theme.component.toolbar.topMargin
    bottomMargin: Theme.component.toolbar.bottomMargin
  }
}


