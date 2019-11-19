import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.0
import QtLocation 5.9
import QtPositioning 5.11

PlaceSearchModel {
  id: placeSearchModel

  plugin: GlobalVariables.applicationWindow.mapPage.hikingCompanionMap.mapSourcePlugin
  //plugin: backendPlugin

  //searchTerm: "Pizza,Haarlem"
  //searchTerm: "Pizza"
//  searchArea: QtPositioning.circle(QtPositioning.coordinate( 10, 10))
/*
  searchArea: QtPositioning.circle(
        GlobalVariables.applicationWindow.mapPage.hikingCompanionMap.center
        );
*/

  Component.onCompleted: {
    update();
  }
}
