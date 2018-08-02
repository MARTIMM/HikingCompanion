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

  qmlRegisterSingletonType(
    QUrl("file:////home/marcel/Projects/Mobile/Projects/HikingCompanion/HikingCompanion/Qml/GlobalVariables.qml"),
    "io.github.martimm.HikingCompanion.GlobalVariables", 0, 1, "GlobalVariables"
  );

// Config *c = new Config();
// qDebug() << "osType: " << c->osType();

  QQmlApplicationEngine engine;
  engine.load(QUrl(QStringLiteral("qrc:/Qml/Main/Application.qml")));
qDebug() << engine.rootObjects();

  if ( engine.rootObjects().isEmpty() ) return -1;

  int sts = app.exec();
  qDebug() << "Sts: " << sts;
  return sts;
}
