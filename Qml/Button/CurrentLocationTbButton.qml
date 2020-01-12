import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.9
import QtQuick.Controls 2.2

Button {
  text: "🎯"

  Component.onCompleted: {
    init(GlobalVariables.ToolbarButton);
  }

  onClicked: {
    GlobalVariables.applicationWindow.mapPage.featuresMap.currentLocationFeature.zoomOnCurrentLocation();
  }
}
