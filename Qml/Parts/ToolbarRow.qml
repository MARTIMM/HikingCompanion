import QtQuick 2.11

import io.github.martimm.HikingCompanion.Theme 0.1

Row {
  id: root
  spacing: 2

  width: parent.width
  height: Theme.tbHeight
  //z: 50

  anchors {
    top: parent.top
    topMargin: Theme.tbTopMargin
    right: parent.right
    rightMargin: Theme.tbLRMargin
    left: parent.left
    leftMargin: Theme.tbLRMargin
  }

  layoutDirection: Qt.RightToLeft

  function insertRowButton( buttonQml, buttonSpec) {
    var component = Qt.createComponent(buttonQml);
    var button = component.createObject( root, buttonSpec);

    if ( button === null ) {
      // Error Handling
      console.log("Error creating object from " + buttonQml);
    }

    return button
  }
}


