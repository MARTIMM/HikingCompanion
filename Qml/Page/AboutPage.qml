import "." as HCPage
import "../Button" as HCButton
import "../Parts" as HCParts

import io.github.martimm.HikingCompanion.Config 0.3
import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.Textload 0.1

import QtQuick 2.9
import QtQuick.Controls 2.2

HCPage.Plain {
  id: aboutPage

  width: parent.width
  height: parent.height
  anchors.fill: parent

  HCParts.ToolbarRectangle {
    id: pageToolbarRow

    HCParts.ToolbarRow {
      HCButton.OpenMenu { }
      HCButton.Home { }

      Text {
        text: qsTr(" About page")
      }
    }
  }

  Component.onCompleted: { changeContent(); }

  function changeContent ( ) {
    aboutText.aboutTextData.filename = config.getHtmlPageFilename("aboutText");
    aboutText.text = aboutTextData.text;
  }

  HCParts.InfoArea {
    id: aboutText

    Config { id: config }


    width: parent.width
    height: parent.height
    //anchors.fill: parent

    anchors {
      left: parent.left
      right: parent.right
      top: pageToolbarRow.bottom
      bottom: parent.bottom
    }

    property alias aboutTextData: aboutTextData
    TextLoad {
      id: aboutTextData
      //filename: ":Assets/Pages/aboutText.html"
    }

    //text: aboutTextData.text
  }
}
