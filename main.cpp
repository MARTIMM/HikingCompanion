#include <QApplication>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QInputMethod>

#include "textload.h"
#include "config.h"

// ----------------------------------------------------------------------------
int main( int argc, char *argv[]) {
  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

  QCoreApplication::setOrganizationName("martimm");
  QCoreApplication::setOrganizationDomain("io.github.martimm");
  QCoreApplication::setApplicationName("HikingCompanion");

  QApplication app( argc, argv);
  app.setApplicationVersion("0.6.0");
  app.setApplicationDisplayName("HikingCompanion");
//  app.

  // See also http://doc.qt.io/qt-5/qguiapplication.html#platformName-prop
  // For me it could be: android, ios or xcb (x11 on linux)
//qDebug() << "platform name: " << app.platformName();

//qDebug() << app.inputMethod.isVisible();


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
        QUrl("qrc:/Qml/Style.qml"),
        "io.github.martimm.HikingCompanion.Style", 0, 1, "Style"
        );

  QQmlApplicationEngine engine;
  engine.load(QUrl(QStringLiteral("qrc:/Qml/Main/Application.qml")));

qDebug() << "root objects: " << engine.rootObjects();

  if ( engine.rootObjects().isEmpty() ) return -1;
  return app.exec();
}
