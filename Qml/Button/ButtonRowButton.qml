import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.9
import QtQuick.Controls 2.2

Button {
  Component.onCompleted: {
    init(GlobalVariables.component.buttonRow.button.type);
  }
}
