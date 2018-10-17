import QtQuick 2.9
import QtQuick.Controls 2.2

//import io.github.martimm.HikingCompanion.HCTheme1 0.1
import io.github.martimm.HikingCompanion.Theme 0.1

Rectangle {
  id: root

  width: parent.width
  height: Theme.largeButtonHeight

  //color: HCTheme1.cmptBgColor
  color: "black"

  property bool checked;
  signal switched()

  property alias text: switchText.text
  Switch {
    id: switchText

    width: parent.width
    height: parent.height
    anchors.right: parent.right

    scale: 0.8

    text: ""
    background: Rectangle {
      //color: HCTheme1.cmptBgColor
      color: "black"
    }

    contentItem: Text {
      id: textItem
      text: switchText.text

      opacity: enabled ? 1.0 : 0.3
      //color: HCTheme1.cmptFgColorLL
      color: "black"
      horizontalAlignment: Text.AlignRight
      //verticalAlignment: Text.AlignVCenter
      //elide: Text.ElideRight
    }

    onClicked: {
console.log("Switched: " + switchText.checked);
      root.checked = switchText.checked;
      root.switched();
    }

    //width: parent.width
    //height: parent.height
    //anchors.fill: parent
  }
}
