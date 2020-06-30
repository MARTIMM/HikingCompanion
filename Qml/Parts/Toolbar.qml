import io.github.martimm.HikingCompanion.Theme 0.1
//import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.12
import QtQuick.Layouts 1.12

Rectangle {

//  property QtObject colors: Theme.appColors
  property QtObject properties: Theme.toolbarProperties

  width: parent.width
  height: properties.height
  radius: properties.radius

  // Row must be kept above page(1)
  z: 50

  anchors {
    top: parent.top
    left: parent.left
    right: parent.right

    leftMargin: properties.leftMargin
    rightMargin: properties.rightMargin
    topMargin: properties.topMargin
    bottomMargin: properties.bottomMargin
  }

  color: properties.background

  border {
    width: properties.borderWidth
    color: properties.borderColor
  }

  property alias buttonList: buttonList
  RowLayout {
    id: buttonList
    spacing: properties.spacing

    // Cannot use anchors.fill or anchors.right because items in the RowLayout
    // child will be stretched or spread over its width
    anchors {
      top: parent.top
      left: parent.left
      bottom: parent.bottom
    }
  }

  function addButtons ( buttonObjects ) {
    for ( var buttonObject in buttonObjects ) {
console.log("Add button: " + buttonObjects[buttonObject].text)
      buttonObjects[buttonObject].createObject(buttonList);
console.log("Add button: " + buttonObjects[buttonObject].text)
    }
  }

/*
  property var b;
  function addButton ( buttonPath ) {
    //button.createObject(buttonList);
console.log("Add button: " + buttonPath)
    b = Qt.createComponent(buttonPath);
console.log("Add status 1: " + b.status + ", " + Component.Ready + ', ' + b.errorString())
    if ( b.status === Component.Ready )
      finishCreation();
    else
      b.statusChanged.connect(finishCreation);
  }

  function finishCreation ( ) {
console.log("Add status 2: " + b.status)

    if ( b.status === Component.Ready )
      b.createObject(buttonList);
    else if ( b.status === Component.Error )
      console.warn("Error loading object: " + b.errorString());
  }
}
*/

  property var button;
  property var options;
  function addButton ( path, o ) {
    options = Object(o);

    button = Qt.createComponent(path);
console.info("createComponent: " + button.status + ' === ' + Component.Ready);
    finishCreation();
  }

  function finishCreation ( ) {

    if ( button.status === Component.Ready ) {
      button.createObject( buttonList, options);
console.info("createObject: " + button.status + ", " + options);
}
    else if ( button.status === Component.Error )
      console.warn("Error loading object: " + button.errorString());

    else
      button.statusChanged.connect(finishCreation);
  }
}
