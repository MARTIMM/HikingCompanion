import io.github.martimm.HikingCompanion.Theme 0.1

import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

Row {
  id: root

  // Row must be kept above page(1)
  width: parent.width
  height: Theme.brHeight
  z: 50

  spacing: 2
  layoutDirection: Qt.RightToLeft

  anchors {
    right: parent.right
    left: parent.left
    bottom: parent.bottom

    rightMargin: Theme.brLRMargin
    leftMargin: Theme.brLRMargin
    topMargin: Theme.brTBMargin
    bottomMargin: Theme.brTBMargin
  }


/*
  Button {
    id: stopButton

    text: qsTr("Exit")
    display: AbstractButton.TextOnly

    //anchors.bottom: parent.bottom
    //anchors.right: parent.right
    //anchors.rightMargin: 10

    onClicked: {
      root.close()
    }
  }

  Button {
    id: saveButton

    text: qsTr("Save Track")
    display: AbstractButton.TextOnly
    enabled: false

    //anchors.bottom: footerRow.top
    //anchors.bottomMargin: 10
  }
*/
}
