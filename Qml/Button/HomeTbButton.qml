//import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.9
import QtQuick.Controls 2.2

Button {
  text: "🌍"
/*
  // Image created in field of 200x200 mm with inkscape
  property QtObject properties: Theme.toolbarProperties
  Image {
    fillMode: Image.PreserveAspectFit
    source: "qrc:Assets/Images/Icon/Buttons/map.svg"
    sourceSize.width: properties.buttonIconWidth
    sourceSize.height: properties.buttonIconHeight
    width: properties.height
    height: parent.height
    verticalAlignment: Image.AlignVCenter
  }
*/
  Component.onCompleted: {
    init(GlobalVariables.ToolbarButton);
  }

  onClicked: {
    currentPage.visible = false;
    mapPage.visible = true;
    setCurrentPage(mapPage);
  }
}
