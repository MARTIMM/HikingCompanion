#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "textload.h"
#include "config.h"

// ----------------------------------------------------------------------------
int main( int argc, char *argv[]) {
  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

  QGuiApplication app( argc, argv);
  app.setApplicationVersion("0.6.0");
  app.setApplicationDisplayName("HikingCompanion");

  qmlRegisterType<TextLoad>(
        "io.github.martimm.HikingCompanion.Textload", 0, 1, "TextLoad"
        );
  qmlRegisterType<Config>(
        "io.github.martimm.HikingCompanion.Config", 0, 1, "Config"
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

// Config *c = new Config();
// qDebug() << "osType: " << c->osType();

  QQmlApplicationEngine engine;
  engine.load(QUrl(QStringLiteral("qrc:/Qml/Main/Application.qml")));

qDebug() << engine.rootObjects();

  if ( engine.rootObjects().isEmpty() ) return -1;
  return app.exec();
}
