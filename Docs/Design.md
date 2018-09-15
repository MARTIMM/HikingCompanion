[TOC]

# Designing the application
## Diagrams showing the relations of the classes

Examples of certain classes are shown here: 1) Class inheriting from QObject 2) based on templates are drawn like
```plantuml
class someClass1 << (O,yellow) >>
class someClass2 << (T,lightblue) >>
class someClass3 << (q,#ffee88) >>
```

### Basic structure
The `ConfigData` is a singleton class which is used to keep all data alive and therefore it is not necessary to initialize all data again and again upon instantiation of an object. The `Config` class will become a hook to get to the data from QML.

```plantuml
class "Singleton<ConfigData>" as ConfigData << (S,#FF7700) >>
class Config << (O,yellow) >>
class GpxFiles << (O,yellow) >>
class GpxFile << (O,yellow) >>

class "ApplicationPage" as ap << (q,#ffee88) >>
class "MapPage" as mp << (q,#ffee88) >>
class "TracksPage" as tp << (q,#ffee88) >>
class "ConfigPage" as cp << (q,#ffee88) >>

class call_once << (T,lightblue) >>
class Singleton << (T,lightblue) >>


Config *- ConfigData
'ConfigData *- GpxFiles
GpxFiles *- GpxFile

call_once -- Singleton
Singleton -- ConfigData

ap --> mp
ap -> cp
ap --> tp

cp -> Config
tp -> GpxFiles
tp --> mp
```

# Path settings

# Deployment test on linux
We must try to setup an environment where we can simulate the sharing of data between applications. The main goal is to get a clear view where to place the data and which locations can be used to copy the data to. The tracking app  can also search for the HikingCompanion specific data to see if that program is installed and available for use.

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
Settings are used to store data between runs. There are several catagories to be set. E.g. program settings like a language selection is placed in a **[General]** section.
```
[General]
LanguageIndex=1

[User]
EMail=mt1957@gmail.com
Username=marcel

[HikeList]
t1=Sultanstrail
t2=Sufitrail
t3=HaarlemNHTrips

[Hike.Sultanstrail]
Typex=🚶\x1F6B6🚴\x1F6B4
Type=WB
Version=0.1.0
TranslationXML=
SupportedLang=en
DefaultLang=en
Title=Sultans Trail
ShortDescr=Ancient trail from Vienna to Istanbul
Tracks=Sultanstrail/tracks
GpxFileIndex=-1

[Hike.Sufitrail]
Typex=🚶\x1F6B6
Type=W
Version=0.1.0
TranslationXML=
SupportedLang=en
DefaultLang=en
Title=Sufi's Pilgrimage Route
ShortDescr=Trail from Istanbul to Konya
Tracks=Sufitrail/tracks
GpxFileIndex=5

[Hike.HaarlemNHTrips]
Typex=🚶\x1F6B6🚴\x1F6B4
Type=WB
Version=0.1.0
TranslationXML=
SupportedLang=en
DefaultLang=en
Title=Haarlem Trips
ShortDescr=City trips in and around Haarlem North-Holland, Netherlands
Tracks=HaarlemNHTrips/tracks
GpxFileIndex=-1


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
