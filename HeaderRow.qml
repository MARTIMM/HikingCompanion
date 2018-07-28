import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
/*
import QtQuick.Window 2.3
import io.github.martimm.HikingCompanion.textload 1.0
*/

// row placed on top of a page
Row {
  id: headerRow

  property var headerRowText: qsTr("Undefined page")

  width: parent.width
  height: 20

  anchors.topMargin: 5
  anchors.bottomMargin: 5

  Text {
    text: headerRowText
    horizontalAlignment: Text.AlignHCenter
  }
}
