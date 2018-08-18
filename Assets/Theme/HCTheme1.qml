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
*/

pragma Singleton

import QtQuick 2.11

// Non visible settings
QtObject {

  // Areas like rectangles
  property color mainFgColor:         "#500040"
  property color mainFgColorL:        Qt.lighter( mainBgColor, 2.0)
  property color mainFgColorD:        Qt.darker( mainBgColor, 2.0)

  property color mainBgColor:         "#afafaf"
  property color mainBgColorL:        "#e0e0e0"   //Qt.lighter( mainBgColor, 2.0)
  property color mainBgColorD:        "#4f4f4f"   //Qt.darker( mainBgColor, 2.0)

  property int mainRdng:              25

  // Components like buttons etc
  property color cmptBgColor:         "#8f0070"
  property color cmptBgColorL:        Qt.lighter( cmptBgColor, 2.0)
  property color cmptBgColorD:        Qt.darker( cmptBgColor, 2.0)

  property color cmptFgColor:         "#dfa0ef"
  property color cmptFgColorL:        Qt.lighter( cmptFgColor, 2.0)
  property color cmptFgColorLL:       Qt.lighter( cmptFgColor, 3.0)
  property color cmptFgColorD:        Qt.darker( cmptFgColor, 2.0)

  property int cmptRdng:              12
}
