import QtQuick 2.11
import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
//import io.github.martimm.textload 1.0
import io.github.martimm.HikingCompanion.textload 0.1

Row {
  id: buttonRow
  height: 40
  spacing: 1
  layoutDirection: Qt.RightToLeft


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
}
