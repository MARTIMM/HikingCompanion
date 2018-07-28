import QtQuick 2.11
import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import io.github.martimm.HikingCompanion.textload 1.0

Rectangle {
  id: exitPage

  width: parent.width
  height: parent.height
  anchors.fill: parent
  visible: false

  // Need the menu button on this page
  property alias openMenuButton: openMenuButton
  OpenMenuButton { id: openMenuButton }

  TextLoad {
    id: exitTextData
    setFilename: ":/Docs/exitText.html"
    onFileRead: {
      exitText.text = TextLoad.text
    }
  }

  property alias headerRow: headerRow
  HeaderRow {
    id: headerRow

    // only anchor to the top. height is known
    anchors.top: parent.top

    headerRowText: qsTr("exit page")
  }

  Flickable {
    id: flickable

    // clip content when going outside content borders
    clip: true

    // take away some space for the vertical scrollbar
    width: parent.width - 10
    height: parent.height - headerRow.height -
            buttonRow.height - footerRow.height

    contentWidth: parent.width - 10
    contentHeight: exitText.height

    // anchor to the top and bottom because height is
    // variable
    anchors.top: headerRow.bottom
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
    anchors.bottom: footerRow.top
  }

  property alias footerRow: footerRow
  FooterRow {
    id: footerRow

    // only anchor to the bottom
    anchors.bottom: parent.bottom

    footerRowText: qsTr("exit page")
  }
}
