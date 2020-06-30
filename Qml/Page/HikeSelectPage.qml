import "." as HCPage
import "../Button" as HCButton
import "../Parts" as HCParts

import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.Config 0.3
//import io.github.martimm.HikingCompanion.Textload 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.9
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

HCPage.Plain {
  id: hikeSelectPage

  property QtObject properties: Theme.infoAreaProperties

  width: parent.width
  height: parent.height
  anchors.fill: parent

  Config {
    id: config

    onHikeModelDefined: {
      console.info('model defined 0: ' + config.hikeModel()[0].listTitle);
      listAreaRectangle.listArea.pageList.model = config.hikeModel();
      //hikeModelList = config.hikeModel();
    }
  }

  Component.onCompleted: {
    // Get the hike list. Here it is prepared on startup
    changeHikeList();
  }

  // This function is called from other places too. Do not
  // move code to 'Component.onCompleted {}' above.
  function changeHikeList ( ) {
    config.setHikeModel();

    // Title above list of hikes
    listAreaRectangle.listArea.title = "Available Hikes";
    //listAreaRectangle.listArea.pageListModel = hikeModel;
  }

/*
  ListModel {
    id: hikeModel
    ListElement {
      listTitle: "Sultans Trail"
      listText: "Vienna to Istanbul"
      listImage: ""
    }

    ListElement {
//      listTitle: "Sufi Trail"
      listFileKey: "Sufitrail"
      listTextFile: "hikeListText.html"
      listImage: "Images/popkijktindeverte-176x300.png"
    }

    ListElement {
      listTitle: "Haarlem and surroundings in the Netherlands"
      listText: "bla die bla"
      listImage: ""
    }
  }
*/

  HCParts.ButtonRow {
    id: toolbarButtons

    Component.onCompleted: {
      init(GlobalVariables.ToolbarButton);
      addButton("qrc:Qml/Button/OpenMenuTbButton.qml");
      addButton("qrc:Qml/Button/HomeTbButton.qml");
    }

    anchors.top: parent.top
  }

//  property var hikeModelList;
  property alias listAreaRectangle: listAreaRectangle
  Rectangle {
    id: listAreaRectangle

    width: parent.width
    color: properties.background //Qt.rgba(240,240,255,0.70)
    radius: properties.radius

    anchors {
      //left: parent.left
      //right: parent.right
      top: toolbarButtons.bottom
      bottom: footerButtons.top

      leftMargin: 5
      rightMargin: 5
      topMargin: 2
      bottomMargin: 2
    }

    property alias listArea: listArea
    HCParts.ListArea {
      id: listArea

      anchors.fill: parent
      title: "Available Hikes"
//      pageList.model: hikeModelList;

//      Component.onCompleted: {
//        console.log("W&H: " + width + ', ' + height);
//      }
    }
  }

  HCParts.ButtonRow {
    id: footerButtons

    Component.onCompleted: {
      init(GlobalVariables.FooterBar);
      addButton("qrc:Qml/Button/HikeSelectButton.qml");
    }

    anchors.bottom: parent.bottom
  }
}
