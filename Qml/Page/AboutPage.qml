import QtQuick 2.11
//import QtQuick.Window 2.3
import QtQuick.Controls 2.4
//import QtQuick.Layouts 1.3

//import "../.."
import "." as HCPage
//import "../Menu" as HCMenu
import "../Button" as HCButton
import io.github.martimm.HikingCompanion.HCStyle 0.1

HCPage.Base {
  id: aboutPage

  Component.onCompleted: {
    pageToolbarRow.insertRowButton(
          "../Button/OpenMenu.qml", {
            "id": "OMOnAbout_0"
          }
          );
    pageToolbarRow.insertRowButton(
          "../Button/Home.qml", {
            "id": "OMOnAbout_1"
          }
          );
  }

  anchors.fill: parent
  visible: false

  //text: qsTr("About")
/*
  Text {
    text: qsTr("About")
    color: HCStyle.textColor
  }
*/
}
