import QtQuick 2.9
//import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3

import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import "." as HCPage
import "../Button" as HCButton

Flickable {
  id: flickable

  // take away some space for the vertical scrollbar
  width: parent.width - Theme.sbWidth
  height: parent.height

  contentWidth: parent.width
  contentHeight: pageText.height

  // clip content when going outside content borders
  clip: true

  // anchor to the top and bottom because height is variable
  anchors {
    top: parent.top
    bottom: parent.bottom
    left: parent.left
    leftMargin: 10
    right: parent.right
    rightMargin: Theme.sbWidth
  }

  property alias text: pageText.text
  TextArea {
    id: pageText
    width: parent.width - Theme.sbWidth - 10
    color: GlobalVariables.setComponentFgColor(Theme.component.color)
    wrapMode: Text.WordWrap
    textFormat: Text.RichText
    text: ""
    background: Rectangle {
      color: Qt.rgba(240,240,255,0.75)
      radius: 7

      width: parent.width - Theme.sbWidth
      height: parent.height
      anchors {
        top: parent.top
        bottom: parent.bottom
        left: parent.left
        right: parent.right
      }
    }
  }

  ScrollBar.vertical: ScrollBar {
    width: Theme.sbWidth
    parent: flickable.parent

    anchors.top: flickable.top
    anchors.left: flickable.right
    anchors.bottom: flickable.bottom

    policy: ScrollBar.AlwaysOn
  }
}
