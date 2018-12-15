import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.0
import QtLocation 5.9
import QtPositioning 5.11

PlaceSearchModel {
  id: root

  plugin: GlobalVariables.applicationWindow.mapPage.hikingCompanionMap.mapSourcePlugin

  searchTerm: "Pizza,Haarlem"
  searchArea: QtPositioning.circle(
                GlobalVariables.applicationWindow.mapPage.hikingCompanionMap.center
                );

  Component.onCompleted: {
    update();
  }

  onStatusChanged: {
    console.log("Status changed: " + root.status);
  }

  onCountChanged: {
    console.log("pizarias: " + data);
  }
}
