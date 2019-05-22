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

  Image {
    width: parent.width
    height: parent.height
    source: "qrc:/Assets/Pages/Images/map-of-the-world-429784_960_720.jpg"
    anchors.fill: parent
  }

  Config { id: config }
  Component.onCompleted: { changeContent(); }

  function changeContent ( ) {
    homeText.homeTextData.filename = config.getHtmlPageFilename("homeText");
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
