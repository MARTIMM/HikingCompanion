import "../Tests" as HCTest
import "." as HCPage
import "../Button" as HCButton
import "../MapFeatures" as HCMapFeatures
import "../Parts" as HCParts

import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1
import io.github.martimm.HikingCompanion.Config 0.3

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtLocation 5.11
import QtPositioning 5.12
//import Qt.labs.handlers 1.0
import QtQuick.Layouts 1.12

HCPage.Plain {
  id: mapPage

  // Disable (false) when coordinate (gpx) tests are not needed
  property bool coordinateGeneratorOnForTesting: false
  HCTest.TimedCoordinateGenerator { id: generateCoordinates }

  width: parent.width
  height: parent.height
  anchors.fill: parent

  Config { id: config }
  Component.onCompleted: {
    // Turn on the gps coordinate gathering
    location.active = true;
    //location.start();

    hikingCompanionMap.center = location.coordinate
        ? location.coordinate
          //: QtPositioning.coordinate( 59.91, 10.75) // Oslo
        : QtPositioning.coordinate(  52.381543, 4.635727) // Haarlem, grote markt

    hikingCompanionMap.clearData();

    console.log("Map set to " + hikingCompanionMap.activeMapType.description);

    hikingCompanionMap.zoomLevel = Theme.mapParameters.startZoomLevel;


    var currentIndex = config.getGpxFileIndexSetting();
    console.log("Current track index " + currentIndex);
    config.setGpxFileIndexSetting(currentIndex);
    config.loadCoordinatesNoEmit(currentIndex);

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
    console.log("bound set to " + mapPage.hikingCompanionMap.visibleRegion);
    console.log("zoom level set to " + mapPage.hikingCompanionMap.zoomLevel);

    // For safekeeping so we can zoom on it again later
    mapPage.featuresMap.trackCourse.boundary = bounds;

    // Show a line when we wander off track
    mapPage.featuresMap.wanderOffTrackNotation.setWanderOffTrackNotation();

    // Make map visible
    //GlobalVariables.menu.setMapPage();
  }

/*
  HCParts.ToolbarRectangle {
    id: pageToolbarRow
    //color: "transparent"

    HCParts.ToolbarRow {
      HCButton.OpenMenu { }
      HCButton.CurrentLocationButton { }
      HCButton.CurrentTrackButton { }

      //TODO North button
      //TODO Reset tilt
      //TODO Camera button to make a picture
      //TODO Note button to make a note

      property alias poiSearchChoice: poiSearchChoice
      ComboBox {
        id: poiSearchChoice
        model: [ "Food", "Sleep", "History", "Transport", "Your Data"]
        onActivated: {
          var ci = poiSearchChoice.model[poiSearchChoice.currentIndex];
          console.info( "cbx: " + ci);
          if( ci === "Food" || ci === "Sleep" ||
              ci === "History" || ci === "Transport" ) {
            console.log("set search to " + ci);
          }

          else if( ci === "Your Data" ) {
            console.log("show user data");
          }

          else {
          }
        }
      }
    }
  }
*/

  HCParts.ButtonRow {
    id: toolbarButtons

    Component.onCompleted: {
      init(GlobalVariables.ToolbarButton);
      addButton("qrc:Qml/Button/OpenMenuTbButton.qml");
      addButton("qrc:Qml/Button/CurrentLocationTbButton.qml");
      addButton("qrc:Qml/Button/CurrentTrackTbButton.qml");
    }

    anchors.top: parent.top
  }

  property alias location: location
  HCMapFeatures.CurrentPositionSource { id: location }

  // https://doc-snapshots.qt.io/qt5-5.9/location-plugin-osm.html#
  property alias hikingCompanionMap: hikingCompanionMap
  Map {
    id: hikingCompanionMap
    width: parent.width
    height: parent.height
    anchors.fill: parent
    gesture.enabled: true
    z: parent.z + 1
    //zoomLevel: 15
    minimumZoomLevel: Theme.mapParameters.minZoomLevel
    maximumZoomLevel: Theme.mapParameters.maxZoomLevel

    property alias mapSourcePlugin: mapSourcePlugin
    plugin: HCMapFeatures.MapSourcePlugin { id: mapSourcePlugin }

    Component.onCompleted: {
      mapSourcePlugin.setMapSource(MapType.CustomMap);
      // mapSourcePlugin.tileCache.value = config.tileCacheDir();
      //console.info("pp cache: " + mapSourcePlugin.tileCache.value);

/*
      // example check on what a Plugin supports
      // https://www3.sra.co.jp/qt/relation/doc/qtlocation/qml-qtlocation-plugin.html#
      for ( var i = 0; i < 6; i++) {
        console.info("SG[" + i + "]: " + mapSourcePlugin.supportsGeocoding(i));
      }

      for ( i = 0; i < 6; i++) {
        console.info("SM[" + i + "]: " + mapSourcePlugin.supportsMapping(i));
      }

      for ( i = 0; i < 6; i++) {
        console.info("SN[" + i + "]: " + mapSourcePlugin.supportsNavigation(i));
      }

      for ( i = 0; i < 6; i++) {
        console.info("SP[" + i + "]: " + mapSourcePlugin.supportsPlaces(i));
      }

      for ( i = 0; i < 6; i++) {
        console.info("SR[" + i + "]: " + mapSourcePlugin.supportsRouting(i));
      }
*/
    }
  }

  // See also https://doc-snapshots.qt.io/qt5-5.9/location-plugin-itemsoverlay.html
  property alias featuresMap: featuresMap
  //property alias currentLocationFeature: featuresMap.currentLocationFeature
  Map {
    id: featuresMap

    //width: parent.width
    //height: parent.height
    anchors.fill: parent
    plugin: Plugin { name: "itemsoverlay" }
    gesture.enabled: false

    center: hikingCompanionMap.center
    color: 'transparent' // Necessary to make this map transparent
    //opacity: 1 //0.6

    minimumFieldOfView: hikingCompanionMap.minimumFieldOfView
    maximumFieldOfView: hikingCompanionMap.maximumFieldOfView
    minimumTilt: hikingCompanionMap.minimumTilt
    maximumTilt: hikingCompanionMap.maximumTilt
    minimumZoomLevel: hikingCompanionMap.minimumZoomLevel
    maximumZoomLevel: hikingCompanionMap.maximumZoomLevel
    zoomLevel: hikingCompanionMap.zoomLevel
    tilt: hikingCompanionMap.tilt;
    bearing: hikingCompanionMap.bearing
    fieldOfView: hikingCompanionMap.fieldOfView
    z: hikingCompanionMap.z + 1

    // The code below enables SSAA
    layer.enabled: true
    layer.smooth: true
    property int w : hikingCompanionMap.width
    property int h : hikingCompanionMap.height
    //property int pr: Screen.devicePixelRatio
    //layer.textureSize: Qt.size( w  * 2 * pr, h * 2 * pr)

    // Show small blue circle on real location
    property alias currentLocationFeature: currentLocationFeature
    HCMapFeatures.CurrentLocationFeature { id: currentLocationFeature }

    // This object is set from the TrackSelectPage after selecting a track.
    property alias trackCourse: trackCourse
    HCMapFeatures.TrackCourse { id: trackCourse }

    // This object is set each time when a new coordinate comes in from GPS
    // and the user has tracking enabled. Later when ready, it is stored and
    // then selectable from the hike table and is made visible in the
    // trackCourse object
    property alias userTrackCourse: userTrackCourse
    HCMapFeatures.UserTrackCourse { id: userTrackCourse }

    property alias wanderOffTrackNotation: wanderOffTrackNotation
    HCMapFeatures.WanderOffTrackNotation { id: wanderOffTrackNotation }
  }


  // See also https://doc-snapshots.qt.io/qt5-5.9/location-plugin-itemsoverlay.html
  property alias poiMap: poiMap
  Map {
    id: poiMap

    //width: parent.width
    //height: parent.height
    anchors.fill: parent
    plugin: Plugin { name: "itemsoverlay" }
    gesture.enabled: false

    center: hikingCompanionMap.center
    color: 'transparent' // Necessary to make this map transparent
    //opacity: 1 //0.6

    minimumFieldOfView: hikingCompanionMap.minimumFieldOfView
    maximumFieldOfView: hikingCompanionMap.maximumFieldOfView
    minimumTilt: hikingCompanionMap.minimumTilt
    maximumTilt: hikingCompanionMap.maximumTilt
    minimumZoomLevel: hikingCompanionMap.minimumZoomLevel
    maximumZoomLevel: hikingCompanionMap.maximumZoomLevel
    zoomLevel: hikingCompanionMap.zoomLevel
    tilt: hikingCompanionMap.tilt;
    bearing: hikingCompanionMap.bearing
    fieldOfView: hikingCompanionMap.fieldOfView
    z: hikingCompanionMap.z + 1

    property alias poiSearch: poiSearch
    HCMapFeatures.PoiSearch { id: poiSearch }
    property alias poiSearchResult: poiSearchResult
    HCMapFeatures.PoiSearchResult { id: poiSearchResult }

    onBearingChanged: { console.info("Bearing: " + this.bearing); }
    onZoomLevelChanged: { console.info("Zoom level: " + this.zoomLevel); }
    onTiltChanged: { console.info("Tilt: " + this.tilt); }
    onCenterChanged: {
      var vr = hikingCompanionMap.visibleRegion.boundingGeoRectangle();
//      console.info("visibleReagion: " + vr.topLeft + ', ' + vr.bottomRight);
      poiSearch.searchTerm = "Pizza";
      poiSearch.categories = null;

//      console.info("HC center: " + hikingCompanionMap.center);
      poiSearch.searchArea = QtPositioning.rectangle(
            QtPositioning.coordinate(
              vr.topLeft.latitude, vr.topLeft.longitude
              ),
            QtPositioning.coordinate(
              vr.bottomRight.latitude, vr.bottomRight.longitude
              )
      );

      poiSearch.update();
    }

    // The code below enables SSAA
    layer.enabled: true
    layer.smooth: true
    property int w : hikingCompanionMap.width
    property int h : hikingCompanionMap.height
    //property int pr: Screen.devicePixelRatio
    //layer.textureSize: Qt.size( w  * 2 * pr, h * 2 * pr)

/*
    function moveMap ( x, y ) {
      // pick values from set boundary at hikingCompanionMap.visibleRegion.
      // also copy zoomlevel which must be set back at the end.
      //var vr = featuresMap.trackCourse.boundary;
      var vr = hikingCompanionMap.visibleRegion.boundingGeoRectangle();
      var z = hikingCompanionMap.zoomLevel;

      //console.info("w&h m: " + poiMap.w + ", " + poiMap.h);
      //console.info("w&h b: " + vr.width + ', ' + vr.height);

      var xMoved = vr.width * (mArea.oldMx - x) / poiMap.w;
      var yMoved = vr.height * (mArea.oldMy - y) / poiMap.h;
      //console.info("Moved to " + xMoved + ', ' + yMoved);
      setXY( x, y);

      // translate ( latitude northwards, longitude westwards), x = longitude
      vr.translate( -yMoved, xMoved);

      poiSearch.searchArea = QtPositioning.rectangle(vr);
      poiSearch.update();

      // Move map and set zoomlevel
      hikingCompanionMap.visibleRegion = vr;
      hikingCompanionMap.zoomLevel = z;
    }

    function setXY ( x, y ) {
      if( x ) mArea.oldMx = x;
      if( y ) mArea.oldMy = y;
    }
*/
    property alias clickInfoArea: clickInfoArea
    Popup {
      id: clickInfoArea
      width: 200; //min( 300, config.getWindowWidth)
      height: 350; //min( 400, config.getWindowHeight)
      visible: false
      property alias popupText: popupText
      contentItem: Text {
        id: popupText
        //text: "Content"
        textFormat: Text.RichText
        wrapMode: Text.Wrap
      }
    }

/*
    property alias mArea: mArea
    MouseArea {
      id: mArea

      width: parent.width
      height: parent.height
      anchors.fill: parent;

      enabled: true
      acceptedButtons: Qt.AllButtons
      preventStealing: true
      propagateComposedEvents: false
      //drag.target: poiMap;

      property var vr
      property var oldMx
      property var oldMy

      // need this because mouseclick starts popup visible = false
      property bool popupVisible: false

      onClicked: {
        mArea.vr = hikingCompanionMap.visibleRegion.boundingGeoRectangle();
        console.info( "clicked: " + mouse.button +
                     ", ( " + mouse.x + ", " + mouse.y + "), " +
                     mouse.source + ", " + mouse.wasHeld + ", " +
                     vr + ', ' + poiMap.clickInfoArea.visible
                     );
        //mouse.accepted = true;
        //mouse.accepted = false;

        //mArea.wasHeld = false;
        if( popupVisible ) {
          poiMap.clickInfoArea.visible = false;
          popupVisible = false;
        }

        else {
console.info("img: " + ":Assets/Images/Icon/Android/HCLogo-96x96.png");
          poiMap.clickInfoArea.popupText.text = '
<div style="background-color:white;">
<h2>some info</h2>
<p>bla sjhdgf sdjhgsjdgfj sdjfg dsfjgsd die bla</p>
<p>jhgsf jdhgsf sjhdgf sdjhgsjdgfj sdjfg dsfjgsd f
<img src="' + "qrc:Assets/Images/Icon/Android/HCLogo-96x96.png" + '"/>
</p>
</div>
';
          poiMap.clickInfoArea.visible = true;
          popupVisible = true;
          poiMap.clickInfoArea.x = mouse.x;
          poiMap.clickInfoArea.y = mouse.y;
          //poiMap.clickInfoArea.
        }

        poiMap.setXY( mouse.x, mouse.y);
      }

      onPressed: {
        console.info( "pressed: " + mouse.button +
                     ", ( " + mouse.x + ", " + mouse.y + "), " +
                     mouse.source + ", " + mouse.wasHeld
                     );

        //mouse.accepted = true;
        //mouse.accepted = false;
        //poiMap.mArea.pressed(mouse)

        //if( mArea.wasHeld && mouse.button === Qt.LeftButton )
        //  mouse.accepted = false;
        poiMap.setXY( mouse.x, mouse.y)
      }

      onPositionChanged: {
        console.info( "pos changed: " + mouse.button +
                     ", ( " + mouse.x + ", " + mouse.y + "), " +
                     mouse.source + ", " + mouse.wasHeld + ", " +
                     hikingCompanionMap.visibleRegion
                     );
        //mouse.accepted = true;
        //mouse.accepted = false;
        //console.log(hikingCompanionMap.visibleRegion);
        poiMap.moveMap( mouse.x, mouse.y)
      }

      onPressAndHold: {

        console.info( "pressed and hold: " + mouse.button +
                     ", ( " + mouse.x + ", " + mouse.y + "), " +
                     mouse.source + ", " + mouse.wasHeld + ", " +
                     hikingCompanionMap.visibleRegion
                     );

        //mouse.accepted = true;
        //mouse.accepted = false;
        //mArea.wasHeld = mouse.wasHeld;
      }

      onPressAndHoldIntervalChanged: {

        console.info( "pressed and hold int changed: " + mouse.button +
                     ", ( " + mouse.x + ", " + mouse.y + "), " +
                     mouse.source + ", " + mouse.wasHeld + ", " +
                     hikingCompanionMap.visibleRegion
                     );

        //mouse.accepted = true;
        //mouse.accepted = false;
      }

      onPreventStealingChanged:  {
        //console.info( "prevent stealing changed: " );
        //mouse.accepted = true;
        //mouse.accepted = false;
      }
    }
*/
/*
    PinchHandler {
//      target: hikingCompanionMap
//TODO Reactions are too big

      target: null
      minimumPointCount: 2
      //minimumRotation: 3.0
      //minimumScale: 0.5

      property real bearing: 0.0
      property var boundRect
      onActiveChanged: {
        bearing = hikingCompanionMap.bearing;
        boundRect = hikingCompanionMap.visibleRegion.boundingGeoRectangle();
      }

      onScaleChanged: {
        if ( this.scale > 0.0 ) {
          var br = boundRect
          br.width /= this.scale;
          br.height /= this.scale;
          hikingCompanionMap.visibleRegion = br;

          console.info(
                "scale changed: " + this.scale +
                ", z: " + hikingCompanionMap.zoomLevel
                );
        }
      }

      onRotationChanged: {
        console.info("rotation changed: " + this.rotation);
        if ( this.rotation === 0 ) {
          //hikingCompanionMap.bearing = bearing;
          bearing = hikingCompanionMap.bearing;
        }

        hikingCompanionMap.bearing = bearing - this.rotation;
      }

    }
*/
  }
}

