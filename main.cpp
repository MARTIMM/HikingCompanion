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

  qmlRegisterType<TextLoad>( "io.github.martimm.HikingCompanion.textload", 0, 1, "TextLoad");
  qmlRegisterType<Config>( "io.github.martimm.HikingCompanion.config", 0, 1, "Config");

  // Config *c = new Config();
  // qDebug() << "osType: " << c->osType();

  QQmlApplicationEngine engine;
  engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
  if ( engine.rootObjects().isEmpty() ) return -1;

  return app.exec();
}
