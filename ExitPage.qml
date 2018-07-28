import QtQuick 2.11
import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
//import io.github.martimm.textload 1.0
import io.github.martimm.HikingCompanion.textload 1.0

Page {
  id: exitPage

  anchors.fill: parent
  visible: false

  // Need the menu button on this page
  property alias openMenuButton: openMenuButton
  OpenMenuButton { id: openMenuButton }

  //property bool textLoaded: false
  TextLoad {
    id: exitTextData
    setFilename: ":/Docs/exitText.html"
    onFileRead: {
      exitText.text = TextLoad.text
      //textLoaded = true
    }
  }

  contentData: [

    Row {
      id: headerRow

      height: 20

      Text {
        text: qsTr("Exit Page")
        horizontalAlignment: Text.AlignHCenter
      }

      anchors.right: parent.right
      anchors.rightMargin: 0
      anchors.left: parent.left
      anchors.leftMargin: 0
      anchors.top: parent.top
      anchors.topMargin: 0
    },

 //   ColumnLayout {
 /*     ScrollView {
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.interactive: true
        ScrollBar.horizontal.interactive: false
        width: parent.width
*/
    Flickable {

      anchors.top: headerRow.bottom
      anchors.topMargin: 10
      anchors.bottom: saveButton.top
      anchors.bottomMargin: 10
      anchors.rightMargin: 10
      anchors.leftMargin: 10

      Text {
        id: exitText

        width: exitPage.width
        //height: parent.height

        wrapMode: Text.WordWrap
        text: exitTextData.text
        font.pixelSize: 18
      }

      //ScrollBar.vertical: ScrollBar { }
//      }
    },

    Button {
      id: saveButton

      z: 2

      text: qsTr("Save Track")
      visible: true
      display: AbstractButton.TextOnly
      enabled: false

      anchors.right: stopButton.left
      anchors.rightMargin: 10
      anchors.bottom: footerRow.top
      anchors.bottomMargin: 10
    },

    Button {
      id: stopButton

      z: 2

      text: qsTr("Exit")
      display: AbstractButton.TextOnly
      visible: true

      //anchors.bottom: parent.bottom
      anchors.bottom: footerRow.top
      anchors.bottomMargin: 10
      anchors.right: parent.right
      anchors.rightMargin: 10

      onClicked: {
        root.close()
      }
    },

    Row {
      id: footerRow

      height: 20

      Text {
        text: qsTr("Exit Page")
        horizontalAlignment: Text.AlignRight
      }

      anchors.right: parent.right
      anchors.rightMargin: 0
      anchors.left: parent.left
      anchors.leftMargin: 0
      anchors.bottom: parent.bottom
      anchors.bottomMargin: 0
    }
  ]
}
