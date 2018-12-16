import "." as HCButton

import io.github.martimm.HikingCompanion.GlobalVariables 0.1

HCButton.ToolbarButton {
  text: "☡"
  onClicked: {
    GlobalVariables.applicationWindow.mapPage.featuresMap.trackCourse.zoomOnCurrentTrack();
  }
}
