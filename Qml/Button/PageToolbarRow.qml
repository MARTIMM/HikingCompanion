import QtQuick 2.11

//import io.github.martimm.HikingCompanion.Style 0.1

Row {
  id: root
  spacing: 2

  //width: parent.width
  height: 40
  z: 50

  anchors {
    top: parent.top
    topMargin: 6
    right: parent.right
    rightMargin: 6
    left: parent.left
    leftMargin: 6
  }

  layoutDirection: Qt.RightToLeft

  function insertRowButton( buttonQml, buttonSpec) {
    var component = Qt.createComponent( buttonQml, root);
    var button = component.createObject( root, buttonSpec);

    if ( button === null ) {
      // Error Handling
      console.log("Error creating object");
    }

    return button
  }
}

