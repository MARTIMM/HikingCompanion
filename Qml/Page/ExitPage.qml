import QtQuick 2.11
import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

import io.github.martimm.HikingCompanion.textload 0.1
import "../.."
import "../Menu" as Menu
import "../Decoration" as Decoration

Rectangle {
  id: exitPage

  width: parent.width
  height: parent.height
  anchors.fill: parent
  visible: false

  // Need the menu button on this page
  Menu.OpenMenuButton { id: openMenuButton }

  TextLoad {
    id: exitTextData
    setFilename: ":/Docs/exitText.html"
    onFileRead: {
      exitText.text = TextLoad.text
    }
  }

  Decoration.Header {
    id: header

    // only anchor to the top. height is known
    anchors.top: parent.top

    headerText: qsTr("exit page")
  }

  Flickable {
    id: flickable

    // clip content when going outside content borders
    clip: true

    // take away some space for the vertical scrollbar
    width: parent.width - 10
    height: parent.height - header.height -
            buttonRow.height - footer.height

    contentWidth: parent.width - 10
    contentHeight: exitText.height

    // anchor to the top and bottom because height is
    // variable
    anchors.top: header.bottom
    anchors.bottom: buttonRow.top

    Text {
      id: exitText

      width: parent.width
      height: parent.height

      anchors.top: parent.top
      anchors.bottom: parent.bottom

      wrapMode: Text.WordWrap
      text: exitTextData.text
      font.pixelSize: 18
    }

    ScrollBar.vertical: ScrollBar {
      width: 10
      parent: flickable.parent

      anchors.top: flickable.top
      anchors.left: flickable.right
      anchors.bottom: flickable.bottom

      policy: ScrollBar.AlwaysOn
    }
  }

  property alias buttonRow: buttonRow
  ButtonRow {
    id: buttonRow

    // anchor only to the bottom because height of this and
    // footer row are known
    anchors.bottom: footer.top
  }

  Decoration.Footer {
    id: footer
    // only anchor to the bottom
    anchors.bottom: parent.bottom

    footerText: qsTr("exit page")
  }
}
