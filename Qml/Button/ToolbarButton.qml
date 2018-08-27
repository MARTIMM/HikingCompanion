import io.github.martimm.HikingCompanion.Theme 0.1

import QtQuick 2.9
import QtQuick.Controls 2.2

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
