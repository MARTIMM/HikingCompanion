import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.9
import QtQuick.Controls 2.2

Button {
//  height: Theme.menuProperties.height

  Component.onCompleted: {
    init(GlobalVariables.MenuButton);
  }
}
