import io.github.martimm.HikingCompanion.Theme 0.1

import QtQuick 2.11
import QtQuick.Controls 2.4

Button {
  id: root

  width: Theme.tbBtWidth
  height: Theme.tbBtHeight
/*
  btBackground.rounding: Theme.smallBtRadius
  border: {
    size: Theme.smallBtBorder
    color: Theme.tbBorderColor
  }
*/
  font {
    pointSize: Theme.tbBtPixelSize
    bold: true
    underline: false
    family: Theme.fontFamily
  }
}
