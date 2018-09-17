#include "textload.h"
#include "config.h"
#include "languages.h"
#include "gpxfiles.h"

//#include <QStyleFactory>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
//#include <QQuickStyle>
//#include <QQmlComponent>
#include <QDebug>
//#include <QQmlProperty>
#include <QStandardPaths>

// ----------------------------------------------------------------------------
int main( int argc, char *argv[]) {

/*
  qDebug() << "App data location:" << QStandardPaths::standardLocations(QStandardPaths::AppDataLocation);
  qDebug() << "App config location:" << QStandardPaths::standardLocations(QStandardPaths::AppConfigLocation);
  qDebug() << "Generic data location:" << QStandardPaths::standardLocations(QStandardPaths::GenericDataLocation);
  qDebug() << "Download location:" << QStandardPaths::standardLocations(QStandardPaths::DownloadLocation);
  qDebug() << "Documents location:" << QStandardPaths::standardLocations(QStandardPaths::DocumentsLocation);
*/

  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

  // Settings used by QSettings to set a location to store its data
  QCoreApplication::setOrganizationName("martimm");
  QCoreApplication::setOrganizationDomain("io.github.martimm");
  QCoreApplication::setApplicationName("HikingCompanion");

  // Styling: http://doc.qt.io/qt-5/qtquickcontrols2-styles.html
  //          https://doc.qt.io/qt-5.11/qtquickcontrols2-styles.html
  // Using qtquickcontrols2.conf now instead of
  // 'QQuickStyle::setStyle("Material");'

  QGuiApplication app( argc, argv);
  app.setApplicationVersion("0.8.1");
  app.setApplicationDisplayName("HikingCompanion");

  qDebug() << "qApp argc:" << argc;
  for ( int i = 0; i < argc; i++) {
    qDebug() << QString("qApp [%1]").arg(i) << argv[i];
  }

  // If there is an extra argument, it should be a path to new
  // hiking information which must be copied to its proper place
  if ( qApp->arguments().count() == 2 ) {
    Config *cfg = new Config;
    cfg->installNewData(QString(qApp->arguments()[1]));

    return 0;
  }

  qmlRegisterType<TextLoad>(
        "io.github.martimm.HikingCompanion.Textload", 0, 1, "TextLoad"
        );

  qmlRegisterType<Config>(
        "io.github.martimm.HikingCompanion.Config", 0, 3, "Config"
        );

  qmlRegisterType<Languages>(
        "io.github.martimm.HikingCompanion.Languages", 0, 2, "Languages"
        );

  qmlRegisterType<GpxFiles>(
        "io.github.martimm.HikingCompanion.GpxFiles", 0, 1, "GpxFiles"
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

  if ( engine.rootObjects().isEmpty() ) return -1;
  return app.exec();
}
