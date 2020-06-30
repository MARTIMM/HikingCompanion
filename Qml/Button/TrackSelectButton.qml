import io.github.martimm.HikingCompanion.GlobalVariables 0.1
import io.github.martimm.HikingCompanion.Config 0.3

import QtQuick 2.9
import QtQuick.Controls 2.2

// Select button placed on the tracks page.
Button {
  id: selectButton

  Config {
    id: config

    // Function is triggered when click event on the select button
    // calls loadCoordinates function.
    onCoordinatesReady: {
      // Get the path of coordinates and show on map
      var path = config.coordinateList();
      var mapPage = GlobalVariables.applicationWindow.mapPage;
      mapPage.featuresMap.trackCourse.setPath(path);

      // Get the boundaries of the set of coordinates to zoom in
      // on the track shown on the map. Using boundaries will zoom in until
      // the track touches the edge. To prevent this, zoom out a small bit.
      var bounds = config.boundary();
      mapPage.hikingCompanionMap.visibleRegion = bounds;
      mapPage.hikingCompanionMap.zoomLevel =
          mapPage.hikingCompanionMap.zoomLevel - 0.2;

      // For safekeeping so we can zoom on it again later
      mapPage.featuresMap.trackCourse.boundary = bounds;

      // Show a line when we wander off track
      mapPage.featuresMap.wanderOffTrackNotation.setWanderOffTrackNotation();

      // Make map visible
      GlobalVariables.menu.setMapPage();
    }
  }

  Component.onCompleted: {
    init(GlobalVariables.ButtonRowButton);
  }

  text: qsTr("Select")
  onClicked: {
    // currentIndex is defined and set in TrackSelectPage and
    // is visible here
    config.setGpxFileIndexSetting(currentIndex);

    // Get the coordinates of the selected track and emit a
    // signal when ready. This signal is catched on the mapPage
    // where the coordinates are used.
    config.loadCoordinates(currentIndex);
  }
}
