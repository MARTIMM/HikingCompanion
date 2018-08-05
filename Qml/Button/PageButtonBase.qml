import QtQuick 2.11
//import QtQuick.Controls 2.4
//import QtQuick.Layouts 1.3

import io.github.martimm.HikingCompanion.Style 0.1
import "." as HCButton

HCButton.Base {
  id: root;

  TextMetrics {
    id: textMetrics
    font.family: root.font.family
    font.pointSize: Style.largeButtonPointSize
    elide: Text.ElideNone
    //elideWidth: 100
    text: root.text
  }

  width: textMetrics.boundingRect.width + 30
  height: Style.largeButtonHeight
  pointSize: Style.largeButtonPointSize
  radius: Style.largeButtonRadius
  border {
    width: Style.largeButtonBorder
    color: Style.buttonBorderColor
  }

  /*
  Component.onCompleted: {
    console.log("Sizes(" + root.text + "): " + width + ", " + textMetrics.boundingRect.width);
    console.log("font: " + root.font.family + ", " + textMetrics.font.family);
  }
  */
}
