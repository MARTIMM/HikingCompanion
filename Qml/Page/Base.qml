import QtQuick 2.0
//import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

import io.github.martimm.HikingCompanion.Style 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import "../Button" as HCButton

Rectangle {
  id: root

  property alias pageButtonRow: pageButtonRow
  property alias text: flickable.text

  width: parent.width
  height: parent.height

  //anchors.fill: parent
  color: Style.appBackgroundColor

  HCButton.PageButtonRow { id: pageButtonRow }

  property alias flickable: flickable
  Flickable {
    id: flickable

    property alias text: pageText.text

    // clip content when going outside content borders
    clip: true

    // take away some space for the vertical scrollbar
    width: parent.width - 10
    height: parent.height - pageButtonRow.height // -
            //buttonRow.height - footer.height

    contentWidth: width //parent.width - 10
    contentHeight: pageText.height

    // anchor to the top and bottom because height is
    // variable
    anchors.top: pageButtonRow.bottom
    anchors.bottom: buttonRow.top

    property alias pageText: pageText
    Text {
      id: pageText
/**/
      width: parent.width
//      height: parent.height

      anchors.top: parent.top
      anchors.bottom: parent.bottom

      //anchors.fill: parent

      wrapMode: Text.WordWrap
      //text: exitTextData.text
      font.pixelSize: 18
      color: Style.textColor
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
}
