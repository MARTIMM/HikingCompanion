import "." as HCPage
import "../Button" as HCButton
import "../Parts" as HCParts
import "../Text" as HCText

import io.github.martimm.HikingCompanion.Config 0.3
import io.github.martimm.HikingCompanion.Theme 0.1
//import io.github.martimm.HikingCompanion.Textload 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

HCPage.Plain {
  id: exitPage

  Config { id: config }
//  TextLoad { id: textData }

  width: parent.width
  height: parent.height
  anchors.fill: parent

  Component.onCompleted: {
    // Info text
    textData.filename = config.getFilenameFromPart("exitText.html");

    // headerMatch[0] is whole regex match
    var text = textData.text;
    var headerMatch = text.match(/<h1>([^<]+)<\/h1>/i);
    title.title = headerMatch[1];
    exitText.text = text.split(headerMatch[0]).join('');
  }

  HCParts.ButtonRow {
    id: toolbarButtons

    Component.onCompleted: {
      init(GlobalVariables.ToolbarButton);
      addButton( "qrc:Qml/Button/OpenMenuTbButton.qml",
                { type: "tbb-menu", menu: pageMenu }
                );
      addButton( "qrc:Qml/Button/HomeTbButton.qml", { type: "tbb-home"});
    }

    anchors.top: parent.top
  }

  property alias exitText: exitText
  HCText.TitleText {
    id: title

    width: parent.width
    anchors.top: toolbarButtons.bottom
  }

  //  property alias aboutText: aboutText
  HCText.ScrolledText {
    id: exitText

    width: parent.width
    height: parent.height - toolbarButtons.height - title.height
    anchors.top: title.bottom
    anchors.bottom: footerButtons.top //parent.bottom
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
