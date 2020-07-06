[TOC]

# Designing the application
## Use case description

```plantuml
scale 0.8
title Global description of all that is involved

'skinparam rectangle {
'	roundCorner<<Concept>> 25
'}

actor user
cloud "user data\ntransport" as network1
cloud "email\ntransport" as network2
cloud "tiles\ntransport" as network3
node trailServer
node tilesServer
node emailServer
package SufiTrailApp {
  artifact index.html

  folder tracks {
    artifact "user\ntracks"
    artifact "fotos\nnotes"
  }

  folder cache {
    artifact tiles
    artifact features
  }
}

database SufiTrailDB {
  storage dbUsers
  storage dbTracks
}

user -- index.html
SufiTrailApp -- network1
SufiTrailApp -- tracks
SufiTrailApp -- cache
SufiTrailDB -- trailServer
tilesServer -- network3
network3 -- SufiTrailApp
network1 - trailServer
trailServer -- network2
network2 -- emailServer
```

## Diagrams showing the relations of the classes

### Types

Types of classes and other ways of denoting them is shown here. Qml file often look like a box in a box, nesting all types of Qml classes. For those classes it's particularly difficult to use UML symbols to show what the code is like.
W'll start off with the symplest, a real C++ classes followed with a qml object and qml template.

1) C++ classes used to get data from settings, config and external sites. Other actions are sorting, changing, etc to be handled by Qml. There exists only one object of a singleton class. The template is used to instantiate classes of different types with the same class description. The interface class is used here to connect Qml code with the C++ code.

```plantuml
scale 0.8

class SomeClass
class "ConfigData<singleton>" as a
class "Config<template>" as b
class "Textload<interface>" as c
```

2) Qml classes to describe the graphical user interface. Qml has its own property system and uses Javascript for functions and callbacks for signals.
A filename and the toplevel Qml class is shown at the top of the box. In the scheme below **Rectangle** is a Qml object with properties and functions. When an object is used from the library, the filename is used like e.g.**Plain** without the qml extention. When there are any props or subs, a classlike symbol is shown, below e.g. **ApplicationWindow**. The most general properties and functions are not shown like `width` and `height` properties or the init function `Component.onCompleted()`. Only those used by other objects are noted.

```plantuml
scale 0.8
allowmixing
skinparam packageStyle Rectangle

skinparam package {
  FontSize 13
  BackgroundColor<<qml file>> #f0ffff
'  BorderColor<<Apache>> #FF6655
  FontName Courier
  BorderColor black
  BackgroundColor gold
'  ArrowFontName Impact
'  ArrowColor #FF6655
'  ArrowFontColor #777777
}

package Application.qml:ApplicationWindow as ap <<qml file>> {
  class ApplicationWindow << (Q,#ffcc00) >> {
    ...buttonTypes
    ...textTypes
    ...buttonBarTypes

    setWindowSize()
  }

package Rectangle {}
```


3) Classes used as Qml templates for other Qml classes. They all start with `T.` It is as if the objects are inheriting the template.

```plantuml

scale 0.8
allowmixing
skinparam packageStyle Rectangle

skinparam package {
  FontSize 13
  BackgroundColor<<qml file>> #f0ffff
  FontName Courier
  BorderColor black
  BackgroundColor gold
'  ArrowFontName Impact
'  ArrowColor #FF6655
'  ArrowFontColor #777777
}

package "T.Frame" as TFrame {}
package Frame {}

TFrame <|-- Frame
```

### Application structure

The **ConfigData** is a singleton class which is used to keep all data alive and therefore it is not necessary to initialize all data again and again upon instantiation of an object. The **Config** class will is used as a hook to get to the data in and out of QML.

<!-- ======================================================================= -->
### Top level structure

The application qml pages are described separately. Some of the classes are repeated there when those pages directly or indirectly uses them. The `application qml pages` shown below are the separate pages all contained in the **ApplicationWindow**.

```plantuml

!include <tupadr3/common>
!include <tupadr3/font-awesome/clone>

scale 0.8
allowmixing
skinparam packageStyle Rectangle

skinparam package {
  FontSize 13
  BackgroundColor<<qml file>> #f0ffff
  FontName Courier
  BorderColor black
  BackgroundColor gold
}

class "ConfigData<Singleton>" as ConfigData
class "Config<Interface>" as Config {
  setWindowSize()
  getTheme()
  fysLength()
}

class "Textload<Interface>" as Textload

class "main<entry point>" as main
package HikingCompanionTheme as theme {}

package Application.qml:ApplicationWindow as ap <<qml file>> {
  class ApplicationWindow << (Q,#ffcc00) >> {
    ...buttonTypes
    ...textTypes
    ...buttonBarTypes

    properties

    'Component.onCompleted()
    setWindowSize()
  }

  package "MenuColumn" {}
  node AppPages
}

class "call_once<template>" as call_once
class "Singleton<template>" as Singleton

FA_CLONE( AppPages, "application\nqml pages") #e0e0ff

Config *- ConfigData

call_once <-- Singleton
Singleton <-- ConfigData

theme <---* ap
main *---> ap
ApplicationWindow *--> Config
Textload <--* ApplicationWindow

```

<!-- ======================================================================= -->
### Theming

```plantuml
scale 0.8
allowmixing
skinparam packageStyle Rectangle

skinparam package {
  BackgroundColor<<qml file>> #f0ffff
  FontSize 13
  FontName Courier
  BorderColor black
  BackgroundColor gold
}

class "Config<Interface>" as Config {
  pixels()
}

package HikingCompanionTheme.qml:Item as mc <<qml file>> {
  class Item << (Q,#ffcc00) >> {
    toolbarProperties
    buttonRowProperties
    menuProperties
    frameProperties
    infoAreaProperties
    titleTextProperties
    listTextProperties
    labelTextProperties
    comboboxProperties

    changeSettings()
    changeColors()
    setPaletteFields()
    setSubFields()
    setProperties()
    setSubFieldSizes()
  }
}

mc --> Config
```


<!-- ======================================================================= -->
### The Menu
The menu is from every page accessable. When it is opened, a larger field is spread out over the page which accepts mouse events. This is done to have

```plantuml
scale 0.8
allowmixing
skinparam packageStyle Rectangle

skinparam package {
  BackgroundColor<<qml file>> #f0ffff
  FontSize 13
  FontName Courier
  BorderColor black
  BackgroundColor gold
}

class "Config<Interface>" as Config {
  pixels()
}

package MenuColumn.qml:Rectangle as mc <<qml file>> {
  class Rectangle << (Q,#ffcc00) >> {
    properties
    menuOpenedWidth
    menuClosedWidth
    parentWidth

    openMenu()
    closeMenu()
    addButton()
    menuEntryClicked()
  }

  package MouseArea {
    class MouseArea << (Q,#ffcc00) >> {
      width
      height
      anchors.fill

      onClicked()
    }
  }

  package Column {
    class Column << (Q,#ffcc00) >> {
      width
      height
      z
      clip
      spacing
      anchors.left
      menuAnimateOpen
      menuAnimateClose
    }
  }
}

mc --> Config
```

<!-- ======================================================================= -->
### Background build up of a page

All pages make use of the Plain qml object. Here, common things are defined like a background image. The MapPage uses this too but that page will show a map and goes over the background image.

The background image is set in the configuration of the current selected hike. The image is searched using calls to **Config**. If not found it falls back to the image stored in the Hiking Companion configuration.

The **Frame** in `Plain.qml` is inheriting from a template **T.Frame**.

```plantuml

!include <tupadr3/common>
!include <tupadr3/font-awesome/clone>

scale 0.8
allowmixing
skinparam packageStyle Rectangle

skinparam package {
  BackgroundColor<<qml file>> #f0ffff
  FontSize 13
  FontName Courier
  BorderColor black
  BackgroundColor gold
}


class "Config<Interface>" as Config {
  getFilenameFromPart()
}

package "T.Frame" as TFrame {
}

package Plain.qml:Frame as fr <<qml file>> {

  class Frame << (Q,#ffcc00) >> {
    visible
  }

  package Image {
    class Image << (Q,#ffcc00) >> {
      source
      fillMode
      horizontalAlignment
      verticalAlignment
    }
  }

  FA_CLONE( AppPage, "application\nqml page") #e0e0ff
}

TFrame <|--- fr
Image --> Config
```

<!-- ======================================================================= -->
###

All pages make use of the Plain qml object. Here, common things are defined like a background image. The MapPage uses this too but that page will show a map and goes over the background image.

The background image is set in the configuration of the current selected hike. The image is searched using calls to **Config**. If not found it falls back to the image stored in the Hiking Companion configuration.

The **Frame** in `Plain.qml` is inheriting from a template **T.Frame**.

```plantuml

scale 0.8
allowmixing
skinparam packageStyle Rectangle

skinparam package {
  BackgroundColor<<qml file>> #f0ffff
  FontSize 13
  FontName Courier
  BorderColor black
  BackgroundColor gold
}


class "Config<Interface>" as Config {
  getFilenameFromPart()
}

package "T.Frame" as TFrame {
}

package Plain.qml:Frame as fr <<qml file>> {

  class Frame << (Q,#ffcc00) >> {
  }

  package Image {
    class Image << (Q,#ffcc00) >> {
      source
      fillMode
      horizontalAlignment
      verticalAlignment
    }
  }

}

TFrame <|--- fr
Image --> Config
```

<!-- ======================================================================= -->
### Home page
First page to show. It shows the description of the current selected hike.

```plantuml
scale 0.8
allowmixing
skinparam packageStyle Rectangle

skinparam package {
  BackgroundColor<<qml file>> #f0ffff
  FontSize 13
  FontName Courier
  BorderColor black
  BackgroundColor gold
}


class "Config<Interface>" as Config {
  getFilenameFromPart()
}

class "Textload<Interface>" as Textload {
  textData
}

package HomePage:Plain <<qml file>> {
  class Plain << (Q,#ffcc00) >> {
  }

  package ButtonRow {

    package OpenMenuTbButton {
    }

    package HomeTbButton {
    }
  }

  package TitleText {
  }

  package ScrolledText {
  }
}

Config <-- Plain
Textload <-- Plain
```

<!-- ======================================================================= -->


<!-- ======================================================================= -->
### Hike selection page


<!-- ======================================================================= -->
### Track selection page


<!-- ======================================================================= -->
### Configuration page


<!-- ======================================================================= -->
### Users configuration page


<!-- ======================================================================= -->
### About page
Purpose of this page is to show a bit of the work involved and people who have helped to complete the job. Additionally versions of the Hiking Companion and the current hike is displayed. Also a list attributions


<!-- ======================================================================= -->
### Exit page




# Path settings

# Deployment test on linux
We must try to setup an environment where we can simulate the sharing of data between applications. The main goal is to get a clear view where to place the data and which locations can be used to copy the data to. The tracking app  can also search for the HikingCompanion specific data to see if that program is installed and available for use.

The methods to share data is not the same on all OSes. For instance, I have tried to use shared memory to share the path to the public data. On Linux this works fine but on Android, which is also based on a linux version, it does not! The following methods are now used to get sharing possible.
  * **Linux**. Shared memory is not an option anymore because Android didn't work. So I used a more simple method, namely commandline arguments. Normally there is only one argument, the programname. When there are two, the second must be the path.
  * **Android**. The program is started by sending an Intent to perform an action. This call ends up in Java code which must call c++ code using JNI.
  * **Ios**. ?

Data is always shared between the same user. On mobile devices there is only one user which is installing applications etc.

Using the information from [this document here][std paths] and [here][android data], the following path can be of use;

* **QStandardPaths::AppDataLocation**. This field returns a list of directories where an application can keep its data.
  * **Linux**: `~/.local/share`, `/usr/share/kde-settings/kde-profile/default/share`, `/usr/local/share`, `/usr/share`

  * **Android**: Below, `<APPNAME>` is usually the organization name. Similarly, `<APPROOT>` is the location where this application is installed and `<APPDIR>` is the directory containing the application executable.
    On Android this is `<APPROOT>/files` and `<USER>/<APPNAME>/files`.
    On my tablet, where applications are stored at `/data/user/0/` and the application id or `<APPNAME>` is `io.martimm.github.HikingCompanion`, the paths are  `/data/user/0/io.martimm.github.HikingCompanion/files`, `/storage/emulated/0/Android/data/io.martimm.github.HikingCompanion/files`. The first one is private and not reachable by other apprlications but the second can be read or written by all apps.
    To write to the external storage on Android, the android app needs the `WRITE_EXTERNAL_STORAGE` permission.

  * **Ios**:
    `<APPROOT>/Library/Application Support`. There are no examples yet to show.

* **QStandardPaths::GenericDataLocation**. Returns a directory location where persistent data shared across applications can be stored. This is a generic value. The returned path is never empty.

  This might be a better choice because it is one level lower and always writable for any app.

  * **Linux**: `~/.local/share`, `/usr/local/share`, `/usr/share`

  * **Android**: `<USER>` which will become `/storage/emulated/0/Android/data/`.

  * **Ios**: `<APPROOT>/Documents`

# Configuration of settings
Settings are used to store data between runs. There are several categories to be set. E.g. program settings like a language selection is placed in a **[General]** section. The location of this file depends on the system where it is running. For linux it will be `$HOME/.config/martimm/HikingCompanion.conf` and on android `/data/user/0/io.martimm.github.HickingCompanion/files/config/HikingCompanion.conf`.

```
[General]
defaultlang=en                Fallback language when no translation is
                              available. This means that all words must be at
                              least be described in that language.
supportedlang=en,nl           Language codes. Needs to be thought over.
translationfile=              Translation file
languageindex=1               Index in pull-down of languages

selectedhikeindex=0           Index in pull-down from HikeList. Language
                              information is set after selecting a hike. When no
                              hike is available it sets the default to english.

[User]                        User data
consent=false             
email=
username=

[HikeList]                    List of hikes. The hike list can contain one or
                              more tracks. The current user may save their own
                              tracks and will be added to this list. All hikes
                              are coded with h#.
h0=sometrail
h1=...


[h0.sometrail]                Specific information about this hike.
version=
title=                        Title of hike. Make it as unique as possible.
                              The text is used in the hikes pull-down list.
shortdescr=                   Short description
www=                          There might even be a website around the hike.
email=                        Set when user has saved his/her own hike

defaultlang=en                Language information for this hike
supportedlang=en
translationfile=

gpxfileindex=                 Index in a pull-down of tracks about this hike.
ntracks=                      number of tracks, notes, photos and features
nnotes=
nphotos=
nfeatures=

[h0.sometrail.track1]         Information about the first track
fname=                        Gpx file with all coordinates
type=                         bike or walk
title=                        Title of track. The text is used in the
                              tracks list.
shortdescr=                   Short description

length=                       Length in kilometers. Calculated when selected.
minlon=                       Boundaries of track. Calculated when selected.
minlat=
maxlon=
maxlat=

[h0.sometrail.track2]         Second track
...

[h0.sometrail.Releases]       Release notes
0.0.1="Setup hike config"
...

[h1. ...]                     Second hike

...
```

When external hike data must be imported, a path to the directory must be provided where a settings file is stored. This file is named `hike.conf`.

```
[General]
version=                      Version of this track. The hike name and version
                              are compared to check if the data is already
                              installed or needs to be updated.
supportedLang=en
defaultLang=en
translationXML=

hike=                         Name used in the HikeList and table names
title=
shortdescr=
www=

tracksdir=                    Sub-directories where data is stored.
photodir=
notedir=
featuredir=

[track1]                      First track
fname=                        Filename of track
title=
shortdescr=
type=

[track2]                      Second track
...

[Releases]                    Release notes about this hike
0.0.1="Setup hike config"
...

```

# Code snippets
Working with qtcreator based on qt 5.11.1, build on July 17th 2018

## Using QVariantList to populate a QML ComboBox

Snippets to show how to populate a `QML` `ComboBox` from data held in c++. See also [here][cppcombobox] and [here][cppmodels]. In the end the result looks like:
<img src="Images/Screenshot_20180829_121215.png" />

### C++ gpxfiles.h
```
#ifndef GPXFILES_H
#define GPXFILES_H

#include <QObject>
#include <QVariantList>

class GpxFiles : public QObject {

  Q_OBJECT
  Q_PROPERTY( bool readGpxFileInfo READ readGpxFileInfo)

public:
  explicit GpxFiles(QObject *parent = nullptr);
  ~GpxFiles();

  Q_INVOKABLE QVariantList gpxTrackList();

signals:
  void gpxFileListChanged();

public slots:

private:
  void _setGpxFiles();

  QVariantList _gpxTrackList;
};

#endif // GPXFILES_H
```

### C++ gpxfiles.cpp
```
#include "gpxfiles.h"

GpxFiles::GpxFiles( QObject *parent) : QObject(parent) {}

GpxFiles::~GpxFiles() {
  _gpxTrackList.clear();
}

QVariantList GpxFiles::gpxTrackList() {
  return _gpxTrackList;
}

bool GpxFiles::readGpxFileInfo() {
  _setGpxFiles();
  emit gpxFileListChanged();
  return true;
}

void GpxFiles::_setGpxFiles() {

  _gpxTrackList.clear();
  _gpxTrackList.append("Sufi1_01_Istanbul City");
  _gpxTrackList.append("Sufi1_02_Yalova_Gökçedere");
  _gpxTrackList.append("Sufi1_03_Gökçedere_Güneyköy");
  ...
}
```
### The main.cpp file
```
#include "gpxfiles.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>

// ----------------------------------------------------------------------------
int main( int argc, char *argv[]) {

  QGuiApplication app( argc, argv);

  qmlRegisterType<GpxFiles>(
        "io.github.martimm.HikingCompanion.GpxFiles", 0, 1, "GpxFiles"
        );

  QQmlApplicationEngine engine;
  engine.load(QUrl(QStringLiteral("qrc:/test.qml")));

  if ( engine.rootObjects().isEmpty() ) return -1;
  return app.exec();
}
```

### QML file test.qml
```
import io.github.martimm.HikingCompanion.GpxFiles 0.1

import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.3

ApplicationWindow {
  id: root
  visible: true
  width: 500
  height: 200

  Component.onCompleted: {
    // read the data after which the object will emit signal gpxFileListChanged
    gpxf.readGpxFileInfo;
  }

  GpxFiles {
    id: gpxf

    onGpxFileListChanged: {
      cb.model = gpxf.gpxTrackList();
    }
  }

  ComboBox {
    id: cb
    width: parent.width
  }
}
```

## Using QVariantList or QStringList to populate a QML ListView

The following QML file can be used to use a `ListView`. Key here is the use of `delegate` and the `modelData` role which is generated by QT. The result now looks like:
<img src="Images/Screenshot_20180829_120926.png" />.

The type `QVariantList` can also be replaced by `QStringList`.

```
import io.github.martimm.HikingCompanion.GpxFiles 0.1

import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.3


ApplicationWindow {
  id: root
  visible: true
  width: 500
  height: 200

  Component.onCompleted: {
    gpxf.readGpxFileInfo;
  }

  GpxFiles {
    id: gpxf

    onGpxFileListChanged: {
      lv.model = gpxf.gpxTrackList();
    }
  }

  ListView {
    id: lv
    width: parent.width
    height: parent.height
    delegate: Rectangle {
      width: parent.width
      height: 20
      Text { text: modelData }
    }
  }
}
```

<!-- References ------------------------------------------------------------ -->
<!-- Hè hè, finally someone with a working suggestion: -->
[cppcombobox]: https://forum.qt.io/topic/43226/solved-qml-combobox-model-from-c/2
[cppmodels]: http://doc.qt.io/qt-5/qtquick-modelviewsdata-cppmodels.html
[b qt state]: http://blog.qt.io/blog/2009/01/30/qt-state-machine-framework/
[std paths]: http://doc.qt.io/qt-5/qstandardpaths.html
[android data]: https://developer.android.com/training/data-storage/files
