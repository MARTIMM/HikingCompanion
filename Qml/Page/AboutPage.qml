import QtQuick 2.11
//import QtQuick.Window 2.3
import QtQuick.Controls 2.4
//import QtQuick.Layouts 1.3

//import "../.."
//import "." as HCPage
//import "../Menu" as HCMenu
//import "../Button" as HCButton
import io.github.martimm.HikingCompanion.Theme 0.1

Rectangle {
  id: aboutPage

  /*
  Row {
    id: root

    height: Theme.largeButtonHeight + 2
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
      id: pageToolbarRow

      Button {
        id: OMOnAbout
      }
    }
*/
  /*
  Component.onCompleted: {
    pageToolbarRow.insertRowButton(
          //"../Button/OpenMenu.qml", {
            "qrc:OpenMenu.qml", {
            "id": "OMOnAbout_0"
          }
          );
    pageToolbarRow.insertRowButton(
          "qrc:Home.qml", {
            "id": "OMOnAbout_1"
          }
          );
  }
*/
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
