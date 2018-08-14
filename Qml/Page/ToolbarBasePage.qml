import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQml.Models 2.2

import io.github.martimm.HikingCompanion.Theme 0.1
//import io.github.martimm.HikingCompanion.GlobalVariables 0.1

//import "../Button" as HCButton

Frame {
  id: toolbarBasePage

  // Always fit in parents space
  width: parent.width
  height: parent.height
  anchors.fill: parent

  //color: Theme.mainBgColor

  property alias pageToolbarRow: pageToolbarRow
  Row {
    id: pageToolbarRow
    spacing: 2

    width: parent.width
    height: Theme.tbHeight
    //    z: 50

    anchors {
      top: parent.top
      topMargin: Theme.tbTopMargin
      right: parent.right
      rightMargin: Theme.tbLRMargin
      left: parent.left
      leftMargin: Theme.tbLRMargin
    }

    layoutDirection: Qt.RightToLeft
    /*
    Button { text: "abcdefghi" }
    Button { text: "abc"; enabled: false }
*/
    DelegateModel {
      id: visualModel
      model: ListModel {
        ListElement { btText: "Apple" }
        ListElement { btText: "Orange" }
      }
      delegate: Row {
        //height: 25
        //width: 100
        Button { text: btText}
      }
    }

    ListView {
      //anchors.fill: parent
      model: visualModel
    }
  }
}
