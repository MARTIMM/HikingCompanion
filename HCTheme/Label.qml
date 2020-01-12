
import io.github.martimm.HikingCompanion.Theme 0.1
//import io.github.martimm.HikingCompanion.GlobalVariables 0.1
//import io.github.martimm.HikingCompanion.Config 0.3

import QtQuick 2.12
import QtQuick.Controls 2.12
//import QtQuick.Controls.impl 2.12
import QtQuick.Templates 2.12 as T

T.Label {
  id: control

  property QtObject properties: Theme.labelTextProperties
  //property QtObject colors: Theme.appColors
  //property QtObject sizes: Theme.buttonSizes

  color: properties.textColor
  linkColor: properties.textLinkColor
}
