import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.9
import QtGraphicalEffects 1.0
import QtQuick.Templates 2.1 as T

T.Button {
  id: control

  // Initialization function to keep the buttons as simple as possible.
  // The function is called with a type which is declared in GlobalVariables.
  // When pushed to the extreme, the buttons are very clean and Types import
  // will not be necessary anymore in those modules.
  function init ( type ) {
    //console.log("Fn init(" + type + ")");
    if ( type === GlobalVariables.component.toolbar.button.type ) {
      font.pixelSize = Theme.component.toolbar.button.pixelSize;
      font.family = Theme.fontFamily;
      width = Theme.component.toolbar.button.width;
      height = Theme.component.toolbar.button.height;
    }

    else if ( type === GlobalVariables.component.buttonRow.button.type ) {
      font.pixelSize = Theme.component.buttonRow.button.pixelSize;
      font.family = Theme.fontFamily;
      // width depends on font size
      width = textMetrics.boundingRect.width + 20;
      height = Theme.component.buttonRow.button.height;
    }

    else if ( type === GlobalVariables.component.menu.button.type ) {
      font.pixelSize = Theme.component.menu.button.pixelSize;
      font.family = Theme.fontFamily;
      width = Theme.component.menu.button.width;
      height = Theme.component.menu.button.height;
      anchors.topMargin = 1;
      anchors.left = parent.left;
      textItem.horizontalAlignment = Text.AlignLeft
      textItem.verticalAlignment = Text.AlignVCenter
    }
  }

  font {
    bold: true
    underline: false
    //pixelSize: 14
    //pointSize: Theme.largeBtPointSize
    family: "arial"
  }

  //width: textMetrics.boundingRect.width + 30
  //height: Theme.largeBtHeight

  leftPadding: 2
  rightPadding: 2

  background: Rectangle {
    id: btBackground

    anchors.fill: parent

    opacity: enabled ? 1 : 0.7

    color: Theme.component.color.backgroundDark
    border {
      color: Theme.component.color.foregroundLight
      width: 1
    }
    radius: Theme.component.rounding
/*
    layer.effect: DropShadow {
      horizontalOffset: 15
      verticalOffset: 20
      color: Theme.component.color.backgroundDark //control.visualFocus ? "#330066ff" : "#aaaaaa"
      samples: 17
      radius: 8
      spread: 0.5
    }
*/
/*
    LinearGradient {
      anchors.fill: parent
      start: Qt.point( 0, 0)
      end: Qt.point( 0, width)
      gradient: Gradient {
        GradientStop {
          id: g0; position: 0.0
          color: Theme.component.color.backgroundLight
        }
        GradientStop {
          id: g1; position: 1.0
          color: Theme.component.color.backgroundDark
        }
      }
    }
*/
    // radius doesn't work with gradients
//    radius: Theme.cmptRdng
/*
    states: [
      State {
        name: "normal"
        when: !control.down
        PropertyChanges { target: btBackground}
      },

      State {
        name: "down"
        when: control.down
        PropertyChanges {
          target: btBackground
          color: Theme.component.color.background
        }

        PropertyChanges {
          target: g0
          color: Theme.component.color.backgroundDark
        }
        PropertyChanges {
          target: g1
          color: Theme.component.color.backgroundLight
        }

      }
    ]
*/
}

  property alias textMetrics: textMetrics
  TextMetrics {
    id: textMetrics
    //font.family: root.font.family
    //font.pointSize: Theme.largeBtPointSize
    font: control.font
    elide: Text.ElideNone
    //elideWidth: 100
    text: control.text
  }

  property color txtColor: Theme.component.color.foregroundLight
  property alias textItem: textItem
  contentItem: Text {
    id: textItem
    text: control.text

    font: control.font
    opacity: enabled ? 1.0 : 0.3
    color: Theme.component.color.foregroundLight
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    //elide: Text.ElideRight
/*
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
          color: Theme.cmptFgColor
        }
      }
    ]
*/
  }
}
