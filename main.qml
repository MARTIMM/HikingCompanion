/*
  Author: Marcel Timmerman
  License: ...
  Copyright: © Sufitrail 2018

*/

import QtQuick 2.11
import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

Window {
  id: root

  visible: true
  width: 640
  height: 480

  title: qsTr("Your Hiking Companion")

  // some variables to be used in the design
  property int columnWidth: 210
  property Rectangle currentPage: mapPage

  // defined in a file
  property alias openMenuButton: openMenuButton
  OpenMenuButton { id: openMenuButton }

  // Pages are in separate files
  property alias mapPage: mapPage
  MapPage { id: mapPage }

  // Pages are in separate files
  property alias configPage: configPage
  ConfigPage { id: configPage }

  property alias aboutPage: aboutPage
  AboutPage { id: aboutPage }

  property alias exitPage: exitPage
  ExitPage { id: exitPage }

  // Open and close menu animation

  SequentialAnimation {
    id: menuAnimateOpen
    NumberAnimation {
      target: menu
      property: "width"
      duration: 1000
      from: 0
      to: columnWidth
      easing.type: Easing.OutBounce
    }

    onStopped: {
      openMenuButton.visible = false
    }
  }

  SequentialAnimation {
    id: menuAnimateClose
    NumberAnimation {
      target: menu
      property: "width"
      duration: 1000
      from: columnWidth
      to: 0
      easing.type: Easing.OutBounce
    }

    onStopped: {
      openMenuButton.visible = true
    }
  }

  // Menu
  Column {
    id: menu

    y: 0
    width: 0

    anchors.bottom: parent.bottom
    anchors.bottomMargin: 0
    anchors.top: parent.top
    anchors.topMargin: 0
    anchors.right: parent.right
    anchors.rightMargin: 0

    Button {
      id: mapButton

      width: parent.width
      display: AbstractButton.TextOnly

      text: qsTr("🗺 Map")

      anchors.left: parent.left
      //anchors.leftMargin: 0
      anchors.top: parent.top
      anchors.topMargin: 1

      font.pointSize: 23
      font.bold: true

      onClicked: {
        if ( currentPage !== mapPage ) {
          currentPage.visible = false
          mapPage.visible = true
          currentPage = mapPage
        }

        menuAnimateClose.start()
      }
    }

    Button {
      id: configButton

      width: parent.width
      display: AbstractButton.TextOnly

      text: qsTr("🛠 Config")

      anchors.left: parent.left
      //anchors.leftMargin: 0
      anchors.top: mapButton.bottom
      anchors.topMargin: 1

      font.pointSize: 23
      font.bold: true

      onClicked: {
        if ( currentPage !== configPage ) {
          currentPage.visible = false
          configPage.visible = true
          currentPage = configPage
        }

        menuAnimateClose.start()
      }
    }

    Button {
      id: aboutButton

      width: parent.width
      display: AbstractButton.TextOnly

      text: qsTr("👥 About")

      anchors.left: parent.left
      //anchors.leftMargin: 0
      anchors.top: configButton.bottom
      anchors.topMargin: 1

      font.pointSize: 23
      font.bold: true

      onClicked: {
        if ( currentPage !== aboutPage ) {
          currentPage.visible = false
          aboutPage.visible = true
          currentPage = aboutPage
        }

        menuAnimateClose.start()
      }
    }

    Button {
      id: exitButton

      width: parent.width
      display: AbstractButton.TextOnly

      text: qsTr("⏻ Exit")

      anchors.bottom: parent.bottom
      anchors.bottomMargin: 1

      font.bold: true
      font.pointSize: 23

      onClicked: {
        if ( currentPage !== exitPage ) {
          currentPage.visible = false
          exitPage.visible = true
          currentPage = exitPage
        }

        menuAnimateClose.start()
      }
    }
  }


}
