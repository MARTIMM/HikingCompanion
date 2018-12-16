import io.github.martimm.HikingCompanion.Theme 0.1

import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Row {
  id: root

  // Row must be kept above page(1)
  width: parent.width
  height: Theme.component.buttonRow.height
  z: 50

  spacing: 2
  layoutDirection: Qt.RightToLeft

  anchors {
    right: parent.right
    left: parent.left
    bottom: parent.bottom

    rightMargin: Theme.component.buttonRow.rightMargin
    leftMargin: Theme.component.buttonRow.leftMargin
    topMargin: Theme.component.buttonRow.topMargin
    bottomMargin: Theme.component.buttonRow.bottomMargin
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
