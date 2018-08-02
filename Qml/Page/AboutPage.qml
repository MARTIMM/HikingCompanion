import QtQuick 2.11
//import QtQuick.Window 2.3
import QtQuick.Controls 2.4
//import QtQuick.Layouts 1.3

import "../.."
//import "../Menu" as HCMenu
import "../Button" as HCButton

Rectangle {
  id: aboutPage

  anchors.fill: parent
  visible: false

  HCButton.PageButtonRow {
    id: row

    // Need the menu button on this page
    HCButton.OpenMenu { }

    // and a home button
    HCButton.Home { }
  }

  Text {
    text: qsTr("About")
  }
}
