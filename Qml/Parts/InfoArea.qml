import QtQuick 2.11
//import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

import io.github.martimm.HikingCompanion.Style 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import "." as HCPage
import "../Button" as HCButton

Rectangle {
  id: root

  width: parent.width - Style.scrollbarWidth
  height: parent.height

/*
  anchors.fill: parent
*/
  color: Style.appBackgroundColor

  property alias text: flickable.text
  property alias flickable: flickable
  Flickable {
    id: flickable

    Component.onCompleted: {
      console.log("H: " + height + ", " + contentHeight);
    }

    // take away some space for the vertical scrollbar
    width: parent.width - Style.scrollbarWidth
    height: parent.height

    contentWidth: parent.width
    contentHeight: pageText.height

    // clip content when going outside content borders
    clip: true

    // anchor to the top and bottom because height is
    // variable
    anchors {
      top: parent.top
      bottom: parent.bottom
      left: parent.left
      right: parent.right
      rightMargin: Style.scrollbarWidth
    }

    property alias text: pageText.text
    Text {
      id: pageText
      width: parent.width

      anchors.fill: parent

      wrapMode: Text.WordWrap
      font.pointSize: Style.textPointSize
      color: Style.textColor
    }

    ScrollBar.vertical: ScrollBar {
      width: Style.scrollbarWidth
      parent: flickable.parent

      anchors.top: flickable.top
      anchors.left: flickable.right
      anchors.bottom: flickable.bottom

      policy: ScrollBar.AlwaysOn
    }
  }
}
