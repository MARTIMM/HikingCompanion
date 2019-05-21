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
/**/


  Config { id: config }
  Component.onCompleted: { changeContent(); }

  function changeContent ( ) {
    homeText.url = "file://" + config.getHtmlPageFilename("frontPage");
    console.info('fp: ' + homeText.url);
/*
    homeText.homeTextData.filename = config.getHtmlPageFilename("frontPage");
console.info('fp: ' + homeText.homeTextData.filename);
console.log('txt: ' + homeText.homeTextData.text);
    homeText.text = homeText.homeTextData.text;
*/
  }
/**/

  HCParts.ToolbarRectangle {
    id: pageToolbarRow
    color: "transparent"
    z: parent.z + 1

    HCParts.ToolbarRow {
      HCButton.OpenMenu { }
      HCButton.Home { }

/*
      Text {
        text: qsTr(" About page")
      }
*/
    }
  }


  HCParts.WWWInfoArea {
    id: homeText

    width: parent.width
    //height: parent.height / 2
    //anchors.fill: parent

    anchors {
      left: parent.left
      right: parent.right
      top: parent.top //pageToolbarRow.bottom
      bottom: parent.bottom
    }
/*
    property alias homeTextData: homeTextData
    TextLoad {
      id: homeTextData
//      filename: ":Assets/Pages/frontPage.html"

//      onTextReady: {
//  console.log("ht: " + homeTextData.text);
//        homeTextT.text = homeTextData.text;
//      }
    }
*/
/*
    property alias homeTextT: homeTextT
    Text {
      id: homeTextT
      textFormat: Text.RichText
    }
 */
  }

/*
  Config { id: config }
  Component.onCompleted: { changeContent(); }

  function changeContent ( ) {
    aboutText.aboutTextData.filename = config.getHtmlPageFilename("aboutText");
    var versionList = config.getVersions();
    //console.log("Versions: " + versionList);

    aboutText.text = aboutTextData.text + "
<p><table width=\"95%\" style=\"margin:auto;\">
  <tr><th colspan=\"2\">Versions of programs and data</th></tr>
  <tr><td>HikingCompanion Program</td><td>" + versionList[0] + "</td></tr>
  <tr><td>Hike Data '" + versionList[1] + "'</td><td>" + versionList[2] +
  "</td></tr><tr><td>Hike Data Program for '" + versionList[1] + "'</td><td>" +
  versionList[3] + "</td></tr><tr><td colspan=\"2\">" + versionList[4] +
  "</td></tr></table></p>";

    //console.log(aboutText.text);
  }

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

  HCParts.InfoArea {
    id: aboutText

    width: parent.width
    //height: parent.height / 2
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
*/
}
