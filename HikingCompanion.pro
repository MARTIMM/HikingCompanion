#QT += quick gui widgets core qml quickwidgets quickcontrols2
QT += core quick qml widgets quickcontrols2 positioning
CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x050000    # disables all the APIs deprecated before Qt 5.0.0

#INCLUDEPATH += /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.181.b15-0.fc28.x86_64/include/jni.h

HEADERS += \
    textload.h \
    config.h \
    configdata.h \
    gpxfile.h \
    singleton.h \
    call_once.h \
    languages.h \
    gpxfiles.h \
    hikes.h

SOURCES += \
    main.cpp \
    textload.cpp \
    config.cpp \
    configdata.cpp \
    gpxfile.cpp \
    languages.cpp \
    gpxfiles.cpp \
    hikes.cpp

RESOURCES += qml.qrc extraResources.qrc
# $$files(*.qml) $$files(Assets/Theme/*)

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Location where quick controls config theme is defined
# See also https://doc.qt.io/qt-5/qtquickcontrols2-environment.html
#QT_QUICK_CONTROLS_CONF = ":/Assets/Theme/qtquickcontrols2.conf"
#QT_QUICK_CONTROLS_STYLE = ":/Assets/Theme/HCTheme1"

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

android {
  QT += androidextras

  DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/res/values/HCLibs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat

  ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
}

