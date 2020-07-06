import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.12
import QtQuick.Layouts 1.12

Rectangle {
  id: control

  property QtObject properties

  function init ( type ) {
console.info("button row init: " + type)
    if ( type === GlobalVariables.Toolbar )
      properties = Theme.toolbarProperties;
    else if ( type === GlobalVariables.FooterBar )
      properties = Theme.buttonRowProperties;
  }

  width: parent.width
  height: properties.height
  radius: properties.radius
//  implicitWidth: control.width
//  implicitHeight: control.height

/*
  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                          implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                           implicitContentHeight + topPadding + bottomPadding)
*/
  // Row must be kept above page(1)
  z: 50

  anchors {
    //top: parent.top
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
      //top: parent.top
      //left: parent.left + properties.leftMargin
      //bottom: parent.bottom
      //paddingLeft: properties.leftMargin
//leftMargin: 30//properties.leftMargin
    }
  }
/*
  function ab ( buttonObject ) {
console.log("Add button: " + buttonObject.text)
    buttonObject.createObject(buttonList);
console.log("Add button: " + buttonObject.text)
  }
*/

/*
  function addButtons ( buttonObjects ) {
    for ( var buttonObject in buttonObjects ) {
console.log("Add button: " + buttonObjects[buttonObject].text)
      buttonObjects[buttonObject].createObject(buttonList);
console.log("Add button: " + buttonObjects[buttonObject].text)
    }
  }
*/

/*
  property var b;
  function addButton ( buttonPath ) {
 //   button.createObject(buttonList);
console.info("Add button: " + buttonPath)
    b = Qt.createComponent(buttonPath);
console.info("Add status 1: " + b.status + ", " + Component.Ready + ', ' + b.errorString())
    if ( b.status === Component.Ready )
      finishCreation();
    else
      b.statusChanged.connect(finishCreation);
  }

  function finishCreation ( ) {
//console.log("Add status 2: " + b.status)

    if ( b.status === Component.Ready )
      b.createObject(buttonList);
    else if ( b.status === Component.Error )
      console.warn("Error loading object: " + b.errorString());
  }
*/

  // Add buttons to the button row
  property var _button;
  property var _options;
  function addButton ( path, o ) {
    _options = Object(o);

    _button = Qt.createComponent(path);
//console.info("createComponent: " + _button.status + ' === ' + Component.Ready);
    _finishCreation();
  }

  function _finishCreation ( ) {

    if ( _button.status === Component.Ready ) {
      _button.createObject( buttonList, _options);
//      _button.menu = _options.menu;
console.info("createObject: " + _options.type + ", " + _button.menu);
    }

    else if ( _button.status === Component.Error )
      console.warn("Error loading object: " + _button.errorString());

    else
      _button.statusChanged.connect(_finishCreation);
  }
}
