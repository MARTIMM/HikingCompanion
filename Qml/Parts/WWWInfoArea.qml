import QtQuick 2.9
//import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtWebChannel 1.0
import QtWebView 1.1

import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import "." as HCPage
import "../Button" as HCButton

Flickable {
  id: flickable

  // take away some space for the vertical scrollbar
  width: parent.width - Theme.sbWidth
  height: parent.height

  // clip content when going outside content borders
  clip: true


  // anchor to the top and bottom because height is variable
  anchors {
/*
    top: parent.top
    bottom: parent.bottom
    left: parent.left
    right: parent.right
*/
    rightMargin: Theme.sbWidth
  }


  property alias url: webText.url
  WebView {
    id: webText
    visible: true
    width: parent.width //- Theme.sbWidth - 10
    height: parent.height
    url: ""
    onLoadingChanged: function ( s ) {
      console.log("load " + s.url + ': ' + s.errorString
                  + ', ' + s.errorCode + ', ' + this.loadProgress + '%');
    }
  }

  ScrollBar.vertical: ScrollBar {
    width: Theme.sbWidth
    parent: flickable.parent

    anchors.top: flickable.top
    anchors.left: flickable.right
    anchors.bottom: flickable.bottom

    policy: ScrollBar.AlwaysOn
  }
}
