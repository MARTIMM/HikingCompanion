import "." as HCPage
//import "../Button" as HCButton
import "../Parts" as HCParts
import "../Text" as HCText

import io.github.martimm.HikingCompanion.Config 0.3
import io.github.martimm.HikingCompanion.Theme 0.1
//import io.github.martimm.HikingCompanion.Textload 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.11
import QtQuick.Controls 2.4

HCPage.Plain {
  id: homePage

//  Config { id: config }
//  TextLoad { id: textData }

  //property HCParts.MenuColumn

  Component.onCompleted: {
    console.info("home page whz: " + width + ', ' + height + ', ' + z);
    // Info text
    textData.filename = config.getFilenameFromPart("homeText.html");

    // headerMatch[0] is whole regex match
    var text = textData.text;
    var headerMatch = text.match(/<h1>([^<]+)<\/h1>/i);
    title.title = headerMatch[1];
    homeText.text = text.split(headerMatch[0]).join('');
  }

  width: parent.width
  height: parent.height
  anchors.fill: parent

  HCParts.ButtonRow {
    id: toolbarButtons

    Component.onCompleted: {
      init(GlobalVariables.ToolbarButton);
//      console.info("buttonrow home page menu: " + pageMenu);
      addButton( "qrc:Qml/Button/OpenMenuTbButton.qml",
                { type: "tbb-menu", menu: pageMenu }
                );
      addButton( "qrc:Qml/Button/HomeTbButton.qml", { type: "tbb-home"});
    }

    anchors.top: parent.top
  }

//  property alias homeText: homeText

  HCText.TitleText {
    id: title

/*
    Component.onCompleted: {
      console.info("WH home page title: " + width + ', ' + height);
    }
*/

    width: parent.width
    anchors.top: toolbarButtons.bottom
  }

  HCText.ScrolledText {
    id: homeText

    width: parent.width
    height: parent.height - toolbarButtons.height - title.height

    anchors {
      left: parent.left
      right: parent.right
      top: title.bottom
      bottom: parent.bottom
    }
  }
}
