/*
  Purpose of this file is to define HCTheme1 specific colors and a few other
  things. It is available as 'HCTheme1'. This file should only be used by
  styled components in directory 'qrc:/HCTheme1'.

  import io.github.martimm.HikingCompanion.HCTheme1 0.1

  prefixes etc
  br    buttonrow
  bt    button
  cbx   combobox
  cmpt  component
  lbl   label
  mn    menu
  sb    scrollbar
  tb    toolbar
  txt   text
  txta  textarea
  txtf  textfield

  bg    background
  d     darker
  fg    foreground
  l     lighter
  rdng  rounding

  see also
    https://wiki.qt.io/Qml_Styling
    https://doc.qt.io/qt-5/qtquick-controls-styles-qmlmodule.html
    https://doc.qt.io/qt-5/qml-qtquick-controls-styles-buttonstyle.html
*/

pragma Singleton

import QtQuick 2.9
import QtGraphicalEffects 1.0


QtObject {

  property QtObject main: QtObject {
    // Main page
    property QtObject color: QtObject {
      property color foreground:        "#500040"
      property color foregroundLight:   Qt.lighter( foreground, 2.0)
      property color foregroundDark:    Qt.darker( foreground, 2.0)

      property color background:        "#afafaf"
      property color backgroundLight:   Qt.lighter( background, 2.0)
      property color backgroundDark:    Qt.darker( background, 2.0)
    }

    property int rounding:              25
  }

  property QtObject component: QtObject {
    // Components like buttons etc
    property QtObject color: QtObject {
      property color foreground:        "#dfa0ef"
      property color foregroundLight:   Qt.lighter( foreground, 3.0)
      property color foregroundDark:    Qt.darker( foreground, 2.0)

      property color background:        "#8f0070"
      property color backgroundLight:   Qt.lighter( background, 2.0)
      property color backgroundDark:    Qt.darker( background, 2.0)
    }

    property int rounding:              6
  }

  property QtObject pageGradient: QtObject {
    property color g1:        "#be50e0"
    property color g2:        "#fef0f8"
    property color g3:        "#be50e0"
    property color g4:        "#6f305f"
    property color g5:        "#300040"

    property real p1:         0.0
    property real p2:         0.02
    property real p3:         0.07
    property real p4:         0.5
    property real p5:         1.0
  }
}
