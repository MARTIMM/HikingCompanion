import "." as HCPage
import "../Button" as HCButton
import "../Parts" as HCParts

import io.github.martimm.HikingCompanion.Theme 0.1

import QtQuick 2.11
import QtQuick.Controls 2.4

HCPage.Plain {
  id: tracksPage

  width: parent.width
  height: parent.height
  anchors.fill: parent
  visible: false

  HCParts.ToolbarRow {
    id: pageToolbarRow

    HCButton.OpenMenu {  }
    HCButton.Home {  }

    Text {
      text: qsTr(" Tracks page")
    }
  }
}
