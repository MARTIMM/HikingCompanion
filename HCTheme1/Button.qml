import QtQuick 2.8
import QtQuick.Templates 2.1 as T

import io.github.martimm.HikingCompanion.Theme 0.1
//import HikingCompanionTheme 0.1 as Theme

T.Button {
  id: control

  Component.onCompleted: {
    console.log("BT");
  }

  font: Theme.font

  implicitWidth: Math.max(background ? background.implicitWidth : 0,
                                       contentItem.implicitWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(background ? background.implicitHeight : 0,
                                        contentItem.implicitHeight + topPadding + bottomPadding)
  leftPadding: 4
  rightPadding: 4

  background: Rectangle {
    id: buttonBackground
    implicitWidth: 100
    implicitHeight: 40
    opacity: enabled ? 1 : 0.3
    border.color: Theme.mainColor
    border.width: 10
    color: Theme.mainColorDarker
    radius: 10

    states: [
      State {
        name: "normal"
        when: !control.down
        PropertyChanges {
          target: buttonBackground
        }
      },
      State {
        name: "down"
        when: control.down
        PropertyChanges {
          target: buttonBackground
          border.color: Theme.mainColorDarker
        }
      }
    ]
  }

  contentItem: Text {
    id: textItem
    text: control.text

    font: control.font
    opacity: enabled ? 1.0 : 0.3
    color: Theme.mainColor
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    elide: Text.ElideRight

    states: [
      State {
        name: "normal"
        when: !control.down
      },
      State {
        name: "down"
        when: control.down
        PropertyChanges {
          target: textItem
          color: Theme.mainColorDarker
        }
      }
    ]
  }
}
