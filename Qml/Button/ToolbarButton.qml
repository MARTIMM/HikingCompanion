import io.github.martimm.HikingCompanion.Theme 0.1

import QtQuick 2.11
import QtQuick.Controls 2.4

Button {
  id: root

  width: Theme.tbBtWidth
  height: Theme.tbBtHeight

  font {
    pixelSize: Theme.tbBtPixelSize
    bold: true
    underline: false
    family: Theme.fontFamily
  }
}
