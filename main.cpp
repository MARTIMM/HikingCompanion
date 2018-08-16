//#include <QStyleFactory>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
//#include <QQuickStyle>
//#include <QQmlComponent>
#include <QDebug>
//#include <QQmlProperty>

#include "textload.h"
#include "config.h"

// ----------------------------------------------------------------------------
int main( int argc, char *argv[]) {

  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

  QCoreApplication::setOrganizationName("martimm");
  QCoreApplication::setOrganizationDomain("io.github.martimm");
  QCoreApplication::setApplicationName("HikingCompanion");

  // Styling: http://doc.qt.io/qt-5/qtquickcontrols2-styles.html
  //          https://doc.qt.io/qt-5.11/qtquickcontrols2-styles.html
  // Using qtquickcontrols2.conf now instead of
  // 'QQuickStyle::setStyle("Material");'

  QGuiApplication app( argc, argv);
  app.setApplicationVersion("0.6.0");
  app.setApplicationDisplayName("HikingCompanion");

  // See also http://doc.qt.io/qt-5/qguiapplication.html#platformName-prop
  // For me it could be: android, ios or xcb (x11 on linux)
  qDebug() << "platform name: " << app.platformName();


  // set stylesheet
  qmlRegisterType<TextLoad>(
        "io.github.martimm.HikingCompanion.Textload", 0, 1, "TextLoad"
        );
  qmlRegisterType<Config>(
        "io.github.martimm.HikingCompanion.Config", 0, 2, "Config"
        );

  qmlRegisterSingletonType(
        QUrl("qrc:/Qml/GlobalVariables.qml"),
        "io.github.martimm.HikingCompanion.GlobalVariables", 0, 1,
        "GlobalVariables"
        );

  qmlRegisterSingletonType(
        QUrl("qrc:/Assets/Theme/HikingCompanionTheme.qml"),
        "io.github.martimm.HikingCompanion.Theme", 0, 1, "Theme"
        );
  qmlRegisterSingletonType(
        QUrl("qrc:/Assets/Theme/HCTheme1.qml"),
        "io.github.martimm.HikingCompanion.HCTheme1", 0, 1, "HCTheme1"
        );



  QQmlApplicationEngine engine;
  engine.load(QUrl(QStringLiteral("qrc:/Qml/Main/Application.qml")));
//  engine.load(QUrl(QStringLiteral("qrc:/Assets/Theme/ThemeTest.qml")));

  // Readable after QGuiApplication
  //qDebug() << "List of styles: " << QQuickStyle::availableStyles();


  if ( engine.rootObjects().isEmpty() ) return -1;
  return app.exec();
}
