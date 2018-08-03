import QtQuick 2.11
import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

import io.github.martimm.HikingCompanion.config 0.1
import "../.."
//import "../Menu" as HCMenu
import "../Button" as HCButton
import "." as HCPage
import io.github.martimm.HikingCompanion.Style 0.1


HCPage.Base {
  id: configPage

  property string osType

  Component.onCompleted: {
    pageButtonRow.insertRowButton(
          "../Button/OpenMenu.qml", {
            "id": "OMOnAbout_0"
          }
          );
    pageButtonRow.insertRowButton(
          "../Button/Home.qml", {
            "id": "OMOnAbout_1"
          }
          );

    configPage.osType = config.osType
    console.log("osType: " + configPage.osType)
  }

  anchors.fill: parent
  visible: false

  Config {
    id: config
  }

  text: qsTr("Config")
/*
  Text {
    text: qsTr("Config")
    color: Style.textColor
  }
*/
}
