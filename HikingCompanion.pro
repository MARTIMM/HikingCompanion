QT += core quick qml widgets quickcontrols2 positioning location network gui webview
CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x050000    # disables all the APIs deprecated before Qt 5.0.0

ProjectRoot = /home/marcel/Projects/Mobile/Projects/HikingCompanion/HikingCompanion
HEADERS += $$files("$$ProjectRoot/Cpp/*.h")
SOURCES +=  $$files("$$ProjectRoot/Cpp/*.cpp")

RESOURCES += qml.qrc extraResources.qrc

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

linux:!android {
  # According to https://wiki.qt.io/Hacking_on_Qt%27s_SSL_Support
  CONFIG += openssl-linked

  QML_IMPORT_PATH += $$(HOME)/Qt/$$QT_VERSION/gcc_64/qml

  # It is important to have a separate directory for this because referring them
  # from /usr/lib directly creates a lot of errors. This is caused by the
  # os installed qt libraries in /usr/lib and /usr/lib64
#  LIBS += -L$$ProjectRoot/libsHack/Linux-lib-1.0.2o -lssl -lcrypto
  LIBS += -lssl -lcrypto
}

android {
  QT += androidextras

  QML_IMPORT_PATH += \
    $$(HOME)/Qt/$$QT_VERSION/android_armv7/qml \
    $$(HOME)/Qt/$$QT_VERSION/android_x86/qml

  DISTFILES += \
    android/AndroidManifest.xml \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat

  DISTFILES += \
    android/res/values/HCLibs.xml

  # See part 'Adding External Libraries' at
  # https://doc.qt.io/qtcreator/creator-deploying-android.html. Following the
  # instructions will result in the contains() line below.
  # Important note: openssl must be compiled against the current use of SDK,
  # NDK (e.g. r17b) and platform (e.g. android-24)
  contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
      ANDROID_EXTRA_LIBS = \
        $$ProjectRoot/libsHack/Android-armv7-r20b-lib-1.1.1d/libcrypto.so \
        $$ProjectRoot/libsHack/Android-armv7-r20b-lib-1.1.1d/libssl.so
    }

  ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
}



