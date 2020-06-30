//import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles 1.4
import QtQuick 2.12
import QtQuick.Layouts 1.12

Rectangle {
  id: control

  property string text: ''

  width: parent.width
  height: parent.height

  anchors {
    left: parent.left
    right: parent.right
    top: toolbarButtons.bottom
    bottom: parent.bottom

    leftMargin: 5
    rightMargin: 5
    topMargin: 8
    bottomMargin: 2
  }

  radius: 5
  color: Qt.rgba(240,240,255,0.85)

  Flickable {
    id: flickable

    width: parent.width
    height: parent.height

    contentWidth: parent.width
    contentHeight: pageText.height

    clip: true

    TextArea {
      id: pageText

      width: parent.width

      wrapMode: Text.WordWrap
      textFormat: Text.RichText
      text: control.text
    }
  }
}
