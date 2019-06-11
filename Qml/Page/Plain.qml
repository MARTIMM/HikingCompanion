/* ----------------------------------------------------------------------------
  Basic page setup where all pages are by default invisible
*/

import QtQuick 2.9
import QtQuick.Controls 2.4

import io.github.martimm.HikingCompanion.GlobalVariables 0.1

// ----------------------------------------------------------------------------
Frame {
  id: root

  width: parent.width
  height: parent.height
  anchors.fill: parent
  visible: false

  property alias backgroundImage: backgroundImage
  Image {
    id: backgroundImage
    source: "file://" + config.getFilenameFromPart("Images/background.png");
    fillMode: Image.PreserveAspectCrop
    horizontalAlignment: Image.AlignHCenter
    verticalAlignment: Image.AlignVCenter
    width: parent.width
    height: parent.height
  }

  MouseArea {
    width: parent.width
    height: parent.height
    anchors.fill: parent

    onClicked: {
      if ( menu.width !== 0 ) GlobalVariables.menu.menuAnimateClose.start();
    }
  }
}
