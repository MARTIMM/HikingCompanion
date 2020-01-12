import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.9
import QtQuick.Controls 2.2

// Select button placed on the tracks page.
Button {
  id: exitButton

  Component.onCompleted: {
    init(GlobalVariables.ButtonRowButton);
  }

  text: qsTr("Exit")
  onClicked: {
    //TODO save track when recording
    Qt.exit(0);
  }
}
