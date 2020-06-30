import io.github.martimm.HikingCompanion.GlobalVariables 0.1
import io.github.martimm.HikingCompanion.Config 0.3

import QtQuick 2.9
import QtQuick.Controls 2.2

// Select button placed on the hike page.
Button {
  id: hikeSelectButton
  text: qsTr("Select")

  Config {
    id: config

    // Function is triggered when click event on the select button
    // calls loadCoordinates function.
    onCoordinatesReady: {
console.log('hike select button, on coord ready');
    }
  }

  Component.onCompleted: {
    init(GlobalVariables.ButtonRowButton);
  }

  onClicked: {
    console.info("I: " + listAreaRectangle.listArea.selectedIndex);

    config.setSetting( "selectedhikeindex", listAreaRectangle.listArea.selectedIndex);
    GlobalVariables.applicationWindow.trackSelectPage.changeTrackList();

    // Change the background image for each page
    var pages = [
          "aboutPage", "configPage", "exitPage", "homePage",
          "trackSelectPage", "hikeSelectPage", "userTrackConfigPage"
        ];
    var fn = function ( page ) {
      GlobalVariables.applicationWindow[page].backgroundImage.source =
          "file://" + config.getFilenameFromPart("Images/background.png");
    }

   // currentIndex is defined and set in HikeSelectPage and
    // is visible here
    //config.setGpxFileIndexSetting(currentIndex);

    // Get the coordinates of the selected track and emit a
    // signal when ready. This signal is catched on the mapPage
    // where the coordinates are used.
//    config.loadCoordinates(currentIndex);
  }
}
