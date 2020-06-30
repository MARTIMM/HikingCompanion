import "." as HCPage
import "../Button" as HCButton
import "../Text" as HCText
import "../Parts" as HCParts

import io.github.martimm.HikingCompanion.Theme 0.1
import io.github.martimm.HikingCompanion.Textload 0.1
import io.github.martimm.HikingCompanion.GlobalVariables 0.1

import QtQuick 2.12
//import QtQuick.Window 2.3
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.12

Rectangle {
  id: control

  property QtObject properties: Theme.infoAreaProperties
  property string title: ''
  property int selectedIndex
  property var imageSource

  width: parent.width
  //  height: parent.height
  radius: properties.radius
  //color: properties.background
  color: Qt.rgba(240,240,255,0.50)

  anchors.fill: parent

  // A fixed title from the tracks description on top
  HCText.TextTypes {
    id: titleText

    anchors {
      left: parent.left
      right: parent.right
      top: parent.top
    }

    Component.onCompleted: {
      init(GlobalVariables.TitleText);
    }

    text: control.title
  }

  property alias pageList: pageList
  ListView {
    id: pageList

    width: parent.width
    height: parent.height
    contentWidth: parent.width

    anchors {
      left: parent.left
      right: parent.right
      top: titleText.bottom
      bottom: parent.bottom

      // needed to keep title free
      topMargin: 5
    }
    spacing: 3
    clip: true

    currentIndex: control.selectedIndex

    highlightResizeDuration: 1
    highlightMoveDuration: 400

    // An item from the list
    delegate: Rectangle {
      width: parent.width

      // height from TextArea + wrapperText and a bit more
      height: listTitleText.textArea.height + wrapperText.height + 4
      //z: 3
      radius: 7

      // Parent rectangle gets background color. Here it must be transparent
      // otherwise it gets white.
      //color: Qt.rgba(240,240,255,0.40) //"transparent"

      border {
        //color: properties.textColor
        width: 1
      }

      // A fixed title per entry
      property alias listTitleText: listTitleText
      HCText.TextTypes {
        id: listTitleText
        height: 24
        //textFont.pixelSize: textFont.pixelSize - 2

        anchors {
          left: parent.left
          right: parent.right
          top: parent.top
        }

        Component.onCompleted: {
          init(GlobalVariables.TitleText);
        }

        //text: listTitle  // trackSelectPage.trackTitle
      }

      // Each delegated entry is displayed in a row of two blocks
      property alias rowLayout: rowLayout
      RowLayout {
        id: rowLayout
        anchors {
          left: parent.left
          right: parent.right
          top: listTitleText.bottom
        }

        Flickable {
          id: flickable
          clip: true

        // First block displays an image if there is one
        property alias rowRectangle: rowRectangle
        Rectangle {
          id: rowRectangle
          Layout.minimumWidth: storyImage.width
          //Layout.preferredWidth: 100
          //Layout.maximumWidth:
          Layout.minimumHeight: wrapperText.height

          property alias storyImage: storyImage
          Image {
            id: storyImage
            //source: "file://" + config.getFilenameFromPart("Images/background.png");
            source: control.imageSource
            fillMode: Image.PreserveAspectCrop
            horizontalAlignment: Image.AlignLeft
            verticalAlignment: Image.AlignVCenter
            //width: parent.width
            height: wrapperText.Height
          }
        }

        // Second block shows a text
        Rectangle {
        /*
        Flickable {
          id: flickable
          clip: true
          */

          Layout.minimumWidth: parent.width - storyImage.width
          //Layout.preferredWidth: 100
          //Layout.maximumWidth:
          Layout.minimumHeight: wrapperText.height
          Layout.maximumHeight: 100
          //anchors.fill: parent

          // clip content when going outside content borders
          //clip: true

          property alias wrapperText: wrapperText
          TextArea {
            id: wrapperText

            width: parent.width
            height: Math.min( 100, contentHeight)
            anchors {
              left: parent.left
              right: parent.right
              top: parent.top //listTitleText.bottom
              leftMargin: 10
              rightMargin: 5
              bottomMargin: 15
            }

            //color: properties.textColor
            wrapMode: Text.WordWrap
            textFormat: Text.RichText
            //text: "[" + index + "] <b>" + listTitle + '</b>, ' + listTextFile

            property alias listTextData: listTextData
            TextLoad {
              id: listTextData
              //filename: listTextFile
              onTextReady: {
                // headerMatch[0] is whole regex match
                //var text = listTitleText.text;
                var headerMatch = text.match(/<h1>([^<]+)<\/h1>/i);
                listTitleText.text = headerMatch[1];
                wrapperText.text = text.split(headerMatch[0]).join('');
              }
            }
          }
        }
/*
          ScrollBar.vertical: ScrollBar {
            id: scrollbar

            width: 10 //Theme.sbWidth
            parent: flickable.parent

            anchors {
              top: flickable.top
              left: flickable.right
              bottom: flickable.bottom

              leftMargin: 4
            }

            policy: ScrollBar.AlwaysOn

            contentItem: Rectangle {
              //implicitWidth: 6
              //implicitHeight: 100
              //radius: width / 2
              color: properties.textColor
            }

            background: Rectangle {
              border.color: properties.textSelectionColor
            }
          }
*/
      }
    }

      Component.onCompleted: {
        var md = model.modelData;
        console.info("delegated title: " + md.listTitle);
        console.info("delegated text: " + md.listText);
        console.info("delegated image: " + md.listImage);
        console.info("delegated file: " + md.listFile);
        console.info("delegated hike key: " + md.listHikeKey);

        if( md.listImage !== "" ) {
          console.info("image: " + config.getKeyedFilenameFromPart(
                         md.listHikeKey, md.listImage
                         )
                       );
          //storyImage.source = "file://" + config.getKeyedFilenameFromPart(
          //md.listHikeKey, md.listImage
          //);
          control.imageSource = "file://" + config.getKeyedFilenameFromPart(
          md.listHikeKey, md.listImage
          );
        }

        if( md.listText !== "" ) {
          listTitleText.text = md.listTitle;
          wrapperText.text = "<b>" + md.listTitle + '</b>, ' + md.listText
        }

        else if( md.listTextFile !== "" ) {
          wrapperText.listTextData.filename = config.getKeyedFilenameFromPart(
                md.listHikeKey, md.listTextFile
                );
        }
      }

      MouseArea {
        anchors.fill: parent
        onClicked: {
          control.selectedIndex = index;
          console.info("select: " + index);
        }
      }
    }

    // A selected track
    highlight: Rectangle {

      // Must be higher than 1 otherwise highlighting will be cut outside
      // a certain range. but lower than the item entry
      z: 2

      color: Theme.listTextProperties.textSelectedColor //trackSelectPage.colors.highlight //GlobalVariables.setComponentBgColor(Theme.component.color)
      opacity: 0.2

      border {
        width: Theme.listTextProperties.borderWidth
        color: Theme.listTextProperties.borderColor
      }
    }
  }
}

