/* ----------------------------------------------------------------------------
  Basic page setup where all pages are by default invisible. It provides an
  empty field with a background

  Because each page using this object is declared in Application, the config
  variable set in Application, is available here too.
---------------------------------------------------------------------------- */
//import "../../Qml/Parts" as HCParts
//import "../../Qml/Button" as HCButton

//import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.12
import QtQuick.Controls 2.12

// ----------------------------------------------------------------------------
Frame {
  id: control

  // background image is reachable from here.
  property alias backgroundImage: backgroundImage

  width: parent.width
  height: parent.height
  anchors.fill: parent
  visible: false

  Image {
    id: backgroundImage
    source: "file://" + config.getFilenameFromPart("Images/background.png");
    fillMode: Image.PreserveAspectCrop
    horizontalAlignment: Image.AlignHCenter
    verticalAlignment: Image.AlignVCenter
    width: parent.width
    height: parent.height
  }
}
