import QtQuick 2.11
import QtQuick.Window 2.3
import QtQuick.Controls 2.4

import io.github.martimm.HikingCompanion.Style 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

Column {
  id: root
  spacing: 2

  width: 0
  height: parent.height
  z: 100
  clip: true

  anchors.right: parent.right


  function insertMenuButton( buttonQml, buttonSpec) {
    var component = Qt.createComponent( buttonQml, root);
    var button = component.createObject( root, buttonSpec);

    if ( button === null ) {
      // Error Handling
      console.log("Error creating object");
    }

    return button
  }
}
