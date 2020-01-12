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
  id: exitPage

  width: parent.width
  height: parent.height
  anchors.fill: parent

  Component.onCompleted: {
    // Info text
    exitText.exitTextData.filename = config.getFilenameFromPart("exitText.html");

    // headerMatch[0] is whole regex match
    var text = exitText.exitTextData.text;
    var headerMatch = text.match(/<h1>([^<]+)<\/h1>/i);
    exitText.title = headerMatch[1];
    exitText.text = text.split(headerMatch[0]).join('');
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

  property alias exitText: exitText
  HCParts.InfoArea {
    id: exitText

    width: parent.width

    anchors {
      left: parent.left
      right: parent.right
      top: toolbarButtons.bottom
      bottom: footerButtons.top
    }

    property alias exitTextData: exitTextData
    TextLoad {
      id: exitTextData
    }
  }

  HCParts.ButtonRow {
    id: footerButtons

    Component.onCompleted: {
      init(GlobalVariables.FooterBar);
      addButton("qrc:Qml/Button/ExitAppButton.qml");
    }

    anchors.bottom: parent.bottom
  }
}
