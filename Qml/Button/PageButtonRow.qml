import QtQuick 2.11
import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

import "." as HCButton
//import io.github.martimm.textload 1.0
//import io.github.martimm.HikingCompanion.textload 0.1
import io.github.martimm.HikingCompanion.Style 0.1

Row {
  id: root

  height: Style.largeButtonHeight + 2
  width: parent.width
  z: 50

  spacing: 2
  layoutDirection: Qt.RightToLeft

  anchors {
    right: parent.right
    rightMargin: 14
    left: parent.left
    leftMargin: 6
    topMargin: 4
    bottom: parent.bottom
    bottomMargin: 1
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
