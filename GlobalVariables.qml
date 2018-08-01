import QtQuick 2.0

import "Qml/Menu"

Item {
  id: globalVariables

  // Cannot be placed in MenuEntryButton because every button would get
  // this property. Comparing with new page will always be the same then.
  property Rectangle currentPage: Rectangle {id: emptyCurrentPage}

  property alias openMenuButton: openMenuButton
  OpenMenuButton { id: openMenuButton }
}
