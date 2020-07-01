/* ----------------------------------------------------------------------------
  Author: Marcel Timmerman
  License: Artistic 2.0
  Copyright: © Marcel Timmerman 2018 .. ∞

  This is the home page where the text for the current hike is displayed.
  Many variables are set in the Application main page.
---------------------------------------------------------------------------- */
import "." as HCPage
import "../Parts" as HCParts
import "../Text" as HCText

import QtQuick 2.11
import QtQuick.Controls 2.4

HCPage.Plain {
  id: homePage

  Component.onCompleted: {
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

    // enums can only be referred to via QML
    property int btype: ButtonType.ToolbarButton
    Component.onCompleted: {
      init(btype);

      addButton( "qrc:Qml/Button/OpenMenuTbButton.qml",
                { type: "tbb-menu", menu: pageMenu }
                );
      addButton( "qrc:Qml/Button/HomeTbButton.qml", { type: "tbb-home"});
    }

    anchors.top: parent.top
  }

  HCText.TitleText {
    id: title

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
