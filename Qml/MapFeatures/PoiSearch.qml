import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.0
import QtLocation 5.11
import QtPositioning 5.12

PlaceSearchModel {
  id: placeSearchModel

  plugin: mapPage.hikingCompanionMap.mapSourcePlugin

  // searchTerm: Set from mapPage.pageToolbarRow.poiSearchChoice.onActivated()
  // searchArea; Set from mapPage.poiMap.onCenterChanged()
/*
  onSearchAreaChanged: {
    console.info("search area: " + searchArea);
  }
*/
  //Component.onCompleted: {
  //  update();
  //}
}
