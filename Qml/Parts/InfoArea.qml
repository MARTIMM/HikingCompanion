import "." as HCPage
import "../Button" as HCButton
import "../Text" as HCText

import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

//import QtQuick.Window 2.3
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles 1.4
import QtQuick 2.12
import QtQuick.Layouts 1.12

Rectangle {
  id: control

  property QtObject properties: Theme.infoAreaProperties
  property string title: ''
  property string text: ''

  width: parent.width
  radius: properties.radius
  color: properties.background //Qt.rgba(240,240,255,0.70)

  anchors {
    left: parent.left
    right: parent.right
    //top: parent.top
    //bottom: parent.bottom
    top: toolbarButtons.bottom
    bottom: parent.bottom

    leftMargin: 5
    rightMargin: 5
    topMargin: 2
    bottomMargin: 2
  }

  // A fixed title from the tracks description on top
  HCText.TextTypes {
    id: titleText
    Component.onCompleted: {
      init(GlobalVariables.TitleText);
    }

    text: control.title  // trackSelectPage.trackTitle
  }

  Flickable {
    id: flickable

    // take away some space for the vertical scrollbar
    width: parent.width - 10//Theme.sbWidth
    //height: parent.height

    contentWidth: parent.width
    contentHeight: pageText.height

    // clip content when going outside content borders
    clip: true

    // anchor to the top and bottom because height is variable
    anchors {
      top: titleText.bottom
      bottom: parent.bottom
      left: parent.left
      right: parent.right

      topMargin: 5
      bottomMargin: 5
      rightMargin: 10 //Theme.sbWidth
      leftMargin: 10
    }

    property alias text: pageText.text
    TextArea {
      id: pageText

      width: parent.width - 10 - 10 //Theme.sbWidth - 10
      //color: properties.textColor

      wrapMode: Text.WordWrap
      textFormat: Text.RichText
      text: control.text

      background: Rectangle {
        color: Qt.rgba(240,240,255,0.90)
        radius: 7

        width: parent.width - 10 //Theme.sbWidth
        height: parent.height
        anchors.fill: parent
      }
    }

    ScrollBar.vertical: ScrollBar {
      width: 10 //Theme.sbWidth
      parent: flickable.parent

      anchors {
        top: flickable.top
        left: flickable.right
        bottom: flickable.bottom

        leftMargin: 4
      }

      //policy: ScrollBar.AlwaysOn

      contentItem: Rectangle {
        //implicitWidth: 6
        //implicitHeight: 100
        //radius: width / 2
        color: properties.textColor
      }

      background: Rectangle {
        border.color: properties.textSelectionColor
      }
    }
  }
}
