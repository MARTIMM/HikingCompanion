import "." as HCPage
import "../Button" as HCButton
import "../Parts" as HCParts

import io.github.martimm.HikingCompanion.Config 0.3
import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.Textload 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.11
import QtQuick.Controls 2.4

HCPage.Plain {
  id: homePage

  width: parent.width
  height: parent.height
  anchors.fill: parent

  Config { id: config }
  Component.onCompleted: {
    // Info text
    homeText.homeTextData.filename = config.getFilenameFromPart("homeText.html");

    // headerMatch[0] is whole regex match
    var text = homeText.homeTextData.text;
    var headerMatch = text.match(/<h1>([^<]+)<\/h1>/i);
    homeText.title = headerMatch[1];
    homeText.text = text.split(headerMatch[0]).join('');
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

  property alias homeText: homeText
  HCParts.InfoArea {
    id: homeText

    width: parent.width

    anchors {
      left: parent.left
      right: parent.right
      top: toolbarButtons.bottom
      bottom: parent.bottom
    }

    property alias homeTextData: homeTextData
    TextLoad {
      id: homeTextData
    }
  }
}
