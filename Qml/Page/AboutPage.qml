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
  id: aboutPage

  Config { id: config }
//  TextLoad { id: aboutTextData }

  Component.onCompleted: {
//    console.info("WH about page: " + width + ', ' + height + ', ' + z);

    // Info text
    textData.filename = config.getFilenameFromPart("aboutText.html");
    var versionList = config.getVersions();

    // headerMatch[0] is whole regex match
    var text = textData.text;
    var headerMatch = text.match(/<h1>([^<]+)<\/h1>/i);
    title.title = headerMatch[1];

    aboutText.text = text.split(headerMatch[0]).join('') + "
  <p><table width=\"95%\" style=\"margin:auto;\">
  <tr><th colspan=\"2\">Versions of programs and data</th></tr>
  <tr><td>HikingCompanion Program</td><td>" + versionList[0] + "</td></tr>
  <tr><td>Hike Data '" + versionList[1] + "'</td><td>" + versionList[2] +
"</td></tr><tr><td>Hike Data Program for '" + versionList[1] + "'</td><td>" +
versionList[3] + "</td></tr><tr><td colspan=\"2\">" + versionList[4] +
"</td></tr></table></p>";
  }

  width: parent.width
  height: parent.height
  anchors.fill: parent

  HCParts.ButtonRow {
    id: toolbarButtons

    Component.onCompleted: {
      init(GlobalVariables.ToolbarButton);
      addButton( "qrc:Qml/Button/OpenMenuTbButton.qml",
                { type: "tbb-menu", menu: pageMenu }
                );
      addButton( "qrc:Qml/Button/HomeTbButton.qml", {type: "tbb-home"});
    }

    anchors.top: parent.top
  }

  HCText.TitleText {
    id: title

    width: parent.width
    anchors.top: toolbarButtons.bottom
  }

  //  property alias aboutText: aboutText
  HCText.ScrolledText {
    id: aboutText

    width: parent.width
    height: parent.height - toolbarButtons.height - title.height
    anchors.top: title.bottom
    anchors.bottom: parent.bottom
  }
}
