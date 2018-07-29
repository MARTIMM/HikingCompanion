import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

// row placed at the bottom of a page
Row {
  id: footerRow

  property var footerRowText: qsTr("Undefined page")

  width: parent.width
  height: 20

  anchors.topMargin: 5
  anchors.bottomMargin: 5

  Text {
    text: footerRowText
    horizontalAlignment: Text.AlignRight
  }
}
