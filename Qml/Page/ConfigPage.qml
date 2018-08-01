import QtQuick 2.11
import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

import io.github.martimm.HikingCompanion.config 0.1
import "../.."
import "../Menu" as Menu


Rectangle {
  id: configPage

  anchors.fill: parent
  visible: false

  // Need the menu button on this page
  Menu.OpenMenuButton { id: openMenuButton }

  Config {
    id: config
  }

  property string osType

  Component.onCompleted: {
    configPage.osType = config.osType
    console.log("osType: " + configPage.osType)
  }

  Text {
    text: qsTr("Config")
  }
}
