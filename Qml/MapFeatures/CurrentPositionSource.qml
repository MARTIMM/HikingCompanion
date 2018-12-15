import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.0
import QtPositioning 5.11

//TODO geolocation when no gps is available but internet is there
PositionSource {
  id: location

  //preferredPositioningMethods: PositionSource.SatellitePositioningMethods
  preferredPositioningMethods: PositionSource.AllPositioningMethods
  //name: "SerialPortNmea"
  updateInterval: 1000

  // Turn it on when the MapPage is ready.
  active: false

  // Store coordinate here first, then process it. Timer testTimer can
  // now generate a series of random coordinates to test several functions
  // in this system.
  property var coord
  onPositionChanged: {
    coord = location.position.coordinate;
    processNewPosition();
  }

  function processNewPosition() {
    console.log( "Coordinate: " + coord.longitude + ", " + coord.latitude);

    // change the current location marker but do not center on it!
    currentLocationFeature.center = coord

    // Send to user track page for recording
    var mainWin = GlobalVariables.applicationWindow;
    if ( mainWin && mainWin.userTrackConfigPage ) {
      mainWin.userTrackConfigPage.addCoordinate(
            coord.longitude, coord.latitude, coord.altitude
            // , coord.timestamp, coord.speed
            );
      mainWin.mapPage.featuresMap.wanderOffTrackNotation.setWanderOffTrackNotation();
    }
  }

  // Search for map type and set activeMapType with it
  function setMapSource ( mapType ) {

    var mainWin = GlobalVariables.applicationWindow;
    var suppMapTypes = mainWin.mapPage.hikingCompanionMap.supportedMapTypes;
    for ( var mt in suppMapTypes ) {
      /*
      console.log("---");
      console.log("name: " + supportedMapTypes[mt].name);
      console.log("descr: " + supportedMapTypes[mt].description);
      console.log("mobile: " + supportedMapTypes[mt].mobile);
      console.log("night: " + supportedMapTypes[mt].night);
      console.log("style: " + supportedMapTypes[mt].style);
*/
      /*
From MapType QML component
      MapType.NoMap - No map.
      MapType.StreetMap - A street map.
      MapType.SatelliteMapDay - A map with day-time satellite imagery.
      MapType.SatelliteMapNight - A map with night-time satellite imagery.
      MapType.TerrainMap - A terrain map.
      MapType.HybridMap - A map with satellite imagery and street information.
      MapType.GrayStreetMap - A gray-shaded street map.
      MapType.PedestrianMap - A street map suitable for pedestriants.
      MapType.CarNavigationMap - A street map suitable for car navigation.
      MapType.CycleMap - A street map suitable for cyclists.
      MapType.CustomMap - A custom map type.
*/
      if ( suppMapTypes[mt].style === mapType ) {
        mainWin.mapPage.hikingCompanionMap.activeMapType = suppMapTypes[mt];
        break;
      }
    }
  }
}
