#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "textload.h"

int main( int argc, char *argv[]) {
  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

  QGuiApplication app( argc, argv);
  app.setApplicationVersion("0.3.0");
  app.setApplicationDisplayName("HikingCompanion");
  //qmlRegisterType<TextLoad>( "io.github.martimm.textload", 1, 0, "TextLoad");
  qmlRegisterType<TextLoad>( "io.github.martimm.HikingCompanion.textload", 1, 0, "TextLoad");

  QQmlApplicationEngine engine;
  engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
  if ( engine.rootObjects().isEmpty() ) return -1;

  return app.exec();
}
