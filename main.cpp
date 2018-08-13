/*
 * #include "mainwindow.h"
#include "textload.h"
#include "config.h"

#include <QObject>
#include <QApplication>
#include <QQmlApplicationEngine>
//#include <QQmlComponent>
#include <QStyleFactory>
#include <QDebug>
//#include <QQmlProperty>
#include <QQuickWidget>
#include <QQuickStyle>

int main(int argc, char *argv[]) {

  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

  QCoreApplication::setOrganizationName("martimm");
  QCoreApplication::setOrganizationDomain("io.github.martimm");
  QCoreApplication::setApplicationName("HikingCompanion");

  // Styling: http://doc.qt.io/qt-5/qtquickcontrols2-styles.html
  QQuickStyle::setStyle("Fusion");

  QApplication app(argc, argv);

  QString s = "* { color: purple; background: #aff; }";
  app.setStyleSheet(s);

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
        QUrl("qrc:/Qml/HCStyle.qml"),
        "io.github.martimm.HikingCompanion.HCStyle", 0, 1, "HCStyle"
        );

*/
/*
  QQmlEngine engine;
  QQmlComponent component( &engine, "qrc:/Map.qml");
  QObject *object = component.create();

  qDebug() << "Property value:" << QQmlProperty::read( object, "someNumber").toInt();
  QQmlProperty::write( object, "someNumber", 5000);

  qDebug() << "Property value:" << object->property("someNumber").toInt();
  object->setProperty("someNumber", 100);
*/
/*

  MainWindow w;
  w.show();

  // Notfound in tree
  //QQuickWidget *expge = w.findChild<QQuickWidget *>("exitPage");
  //qDebug() << "expge: " << expge;
  //expge->setStyleSheet("* { color: purple; background: #aff; }");

//  QQmlEngine engine;
//  engine.exit(0);

  int appSts = app.exec();
//  delete object;
  return appSts;
}

// =============================================================================
*/

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
/**/
  qmlRegisterSingletonType(
        QUrl("qrc:/Qml/HCStyle.qml"),
        "io.github.martimm.HikingCompanion.HCStyle", 0, 1, "HCStyle"
        );
/**/
  qmlRegisterSingletonType(
        QUrl("qrc:/Assets/Theme/HikingCompanionTheme.qml"),
        "io.github.martimm.HikingCompanion.Theme", 0, 1, "Theme"
        );


  QQmlApplicationEngine engine;
  engine.load(QUrl(QStringLiteral("qrc:/Qml/Main/Application.qml")));
//  engine.load(QUrl(QStringLiteral("qrc:/Assets/Theme/ThemeTest.qml")));

  // Readable after QGuiApplication
  //qDebug() << "List of styles: " << QQuickStyle::availableStyles();


  if ( engine.rootObjects().isEmpty() ) return -1;
  return app.exec();
}
