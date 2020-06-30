import "../Parts" as HCParts
import "../Button" as HCButton

import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2

Dialog {
  property string titleText
  property string messageText

  visible: false
  title: qsTr(titleText)

  Text {
    text: qsTr(messageText)
    color: "navy"
    anchors {
      centerIn: parent
      bottom: footerButtons.top
    }
    //font.pixelSize: 20
  }

  HCParts.ButtonRow {
    id: footerButtons

    Component.onCompleted: {
      init(GlobalVariables.FooterBar);
// TODO 'yes', 'no' or 'ok' depending on arguments to dialog
//      addButton("qrc:Qml/Button/TrackSelectButton.qml");
    }

    anchors.bottom: parent.bottom
  }

/*

  contentItem: Rectangle {
    //color: "lightskyblue"
    implicitWidth: 400
    implicitHeight: 200


HCParts.PageButtonRowRectangle {
      id: pageButtonRow

      HCParts.PageButtonRow {
        anchors.bottom: parent.bottom

        HCButton.ButtonRowButton {
          text: qsTr(button1Text)
          onClicked: {
          }
        }

        HCButton.ButtonRowButton {
          text: qsTr(button2Text)
          onClicked: {
          }
        }
      }
    }
  }
*/
}
