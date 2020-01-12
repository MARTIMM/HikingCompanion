import "." as HCPage
import "../Button" as HCButton
import "../Parts" as HCParts

import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.Textload 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

HCPage.Plain {
  id: hikeSelectPage

  width: parent.width
  height: parent.height
  anchors.fill: parent

  Component.onCompleted: {
    // Get the hike list. Here it is prepared on startup
    changeHikeList();
  }

  // This function is called from other places too. Do not
  // move code to 'Component.onCompleted {}' above.
  function changeHikeList ( ) {

  }




  HCParts.ButtonRow {
    id: toolbarButtons

    Component.onCompleted: {
      init(GlobalVariables.ToolbarButton);
      addButton("qrc:Qml/Button/OpenMenuTbButton.qml");
      addButton("qrc:Qml/Button/HomeTbButton.qml");
    }

    anchors.top: parent.top
  }

  HCParts.ButtonRow {
    id: footerButtons

    Component.onCompleted: {
      init(GlobalVariables.FooterBar);
//      addButton("qrc:Qml/Button/ExitApp.qml");
    }

    anchors.bottom: parent.bottom
  }
}
