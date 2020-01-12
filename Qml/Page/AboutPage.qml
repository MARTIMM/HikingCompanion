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
  id: aboutPage

  Config { id: config }
  Component.onCompleted: {
    // Info text
    aboutText.aboutTextData.filename = config.getFilenameFromPart("aboutText.html");
    var versionList = config.getVersions();

    // headerMatch[0] is whole regex match
    var text = aboutText.aboutTextData.text;
    var headerMatch = text.match(/<h1>([^<]+)<\/h1>/i);
    aboutText.title = headerMatch[1];

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
      addButton("qrc:Qml/Button/OpenMenuTbButton.qml");
      addButton("qrc:Qml/Button/HomeTbButton.qml");
    }

    anchors.top: parent.top
  }

  property alias aboutText: aboutText
  HCParts.InfoArea {
    id: aboutText

    width: parent.width
    anchors {
      left: parent.left
      right: parent.right
      top: toolbarButtons.bottom
      bottom: parent.bottom
    }

    property alias aboutTextData: aboutTextData
    TextLoad {
      id: aboutTextData
    }
  }
}
