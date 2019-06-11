import "." as HCPage
import "../Button" as HCButton
import "../Parts" as HCParts

import io.github.martimm.HikingCompanion.Config 0.3
import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.Textload 0.1

import QtQuick 2.11
import QtQuick.Controls 2.4

HCPage.Plain {
  id: homePage

  width: parent.width
  height: parent.height
  anchors.fill: parent

  Config { id: config }
  Component.onCompleted: { changeContent(); }

  function changeContent ( ) {
    // Change textual
    //backgroundImage.source = "file://" + config.getFilenameFromPart("Images/background.png");

    //homeText.homeTextData.filename = config.getHtmlPageFilename("homeText");
    homeText.homeTextData.filename = config.getFilenameFromPart("homeText.html");
    console.info('fp: ' + homeText.url);
    homeText.text = homeText.homeTextData.text;
  }

  HCParts.ToolbarRectangle {
    id: pageToolbarRow

    HCParts.ToolbarRow {
      HCButton.OpenMenu { }
      HCButton.Home { }
    }
  }

  HCParts.InfoArea {
    id: homeText

    width: parent.width

    anchors {
      left: parent.left
      right: parent.right
      top: pageToolbarRow.bottom
      bottom: parent.bottom
    }

    property alias homeTextData: homeTextData
    TextLoad {
      id: homeTextData
    }
  }
}
