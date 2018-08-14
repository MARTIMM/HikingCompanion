import "../../Qml/Page" as HCPage
import io.github.martimm.HikingCompanion.Theme 0.1

import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.Window 2.3

ApplicationWindow {
  id: root

  title: qsTr("Your Hiking Companion")

  visible: true
  width: 640
  height: 480

  HCPage.ToolbarBasePage {
    id: ptbr

    //    HCPage.ToolbarBasePage.pageToolbarRow {
    //      Button { text: "abc" }
    //     Button { text: "def" }
    //    }

    //width: parent.width
    //height: Theme.tbHeight

    Text {
      id: testText
      text: "Burp"
      anchors {
        top: ptbr.pageToolbarRow.bottom
      }
    }

    Button {
      id: testButton
      text: "Hoi"
      anchors {
        top: testText.bottom
      }
    }
  }
}

