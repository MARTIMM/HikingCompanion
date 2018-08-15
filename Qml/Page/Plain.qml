import QtQuick 2.11
//import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

//import io.github.martimm.HikingCompanion.HCStyle 0.1
//import io.github.martimm.HikingCompanion.GlobalVariables 0.1

//import "../Button" as HCButton

Frame {
  id: root

  width: parent.width
  height: parent.height
  anchors.fill: parent

/*
  property alias flickable: flickable
  Flickable {
    id: flickable

    property alias text: pageText.text

    // clip content when going outside content borders
    clip: true

    // take away some space for the vertical scrollbar
    width: parent.width - 10
    height: parent.height - pageToolbarRow.height // -
            //buttonRow.height - footer.height

    contentWidth: width //parent.width - 10
    contentHeight: pageText.height

    // anchor to the top and bottom because height is
    // variable
    anchors.top: pageToolbarRow.bottom
    anchors.bottom: buttonRow.top

    property alias pageText: pageText
    Text {
      id: pageText
      width: parent.width
//      height: parent.height

      anchors.top: parent.top
      anchors.bottom: parent.bottom

      //anchors.fill: parent

      wrapMode: Text.WordWrap
      //text: exitTextData.text
      font.pixelSize: 18
      color: HCStyle.textColor
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
*/
}
