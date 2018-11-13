#include "textload.h"
#include "config.h"
#include "trackcoordinates.h"
#include "languages.h"

#if defined(Q_OS_ANDROID)
#include <QtAndroid>
#endif

//#include <QStyleFactory>
#include <QApplication>
#include <QQmlApplicationEngine>
//#include <QQuickStyle>
//#include <QQmlComponent>
#include <QDebug>
//#include <QQmlProperty>
#include <QStandardPaths>
#include <QQmlEngine>
#include <QDir>
#include <QtQml>
#include <QFontDatabase>
#include <QFont>
#include <QSslSocket>

// ----------------------------------------------------------------------------
// Define global variables
QQmlApplicationEngine *applicationEngine;

// ----------------------------------------------------------------------------
int main( int argc, char *argv[]) {

  qDebug() << "SslSupport: " << QSslSocket::supportsSsl();
  qDebug() << "SslLibraryBuildVersion: " << QSslSocket::sslLibraryBuildVersionString();
  qDebug() << "SslLibraryRuntimeVersion: " << QSslSocket::sslLibraryVersionString();

#if defined(Q_OS_ANDROID)
  // On android, we must request the user of the application for the following
  // permissions to create data and access devices
  QStringList permissions = {
    "android.permission.ACCESS_LOCATION_EXTRA_COMMANDS",
    "android.permission.ACCESS_FINE_LOCATION",
    "android.permission.ACCESS_COARSE_LOCATION",
    "android.permission.WRITE_EXTERNAL_STORAGE",
    "android.permission.READ_EXTERNAL_STORAGE"
  };
  QtAndroid::PermissionResultMap rpm = QtAndroid::requestPermissionsSync(
        permissions
        );

  QStringList keys = rpm.keys();
  for ( int rpmi = 0; rpmi < keys.count(); rpmi++) {
    qDebug() << keys[rpmi] << (rpm[keys[rpmi]] == QtAndroid::PermissionResult::Granted ? "ok" : "denied");
  }
#endif

  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

  // Settings used by QSettings to set a location to store its data
  QCoreApplication::setOrganizationName("martimm");
  QCoreApplication::setOrganizationDomain("io.github.martimm");
  QCoreApplication::setApplicationName("HikingCompanion");

  QApplication app( argc, argv);

  Config *cfg = new Config();
  QString hcVersion = cfg->getHCVersion();
  app.setApplicationVersion(hcVersion);
  app.setApplicationDisplayName("HikingCompanion");

  qmlRegisterType<TextLoad>(
        "io.github.martimm.HikingCompanion.Textload", 0, 1, "TextLoad"
        );

  qmlRegisterType<Config>(
        "io.github.martimm.HikingCompanion.Config", 0, 3, "Config"
        );

  qmlRegisterType<TrackCoordinates>(
        "io.github.martimm.HikingCompanion.TrackCoordinates",
        0, 1, "TrackCoordinates"
        );

  qmlRegisterType<Languages>(
        "io.github.martimm.HikingCompanion.Languages", 0, 2, "Languages"
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

  // Add some fonts and set default font
  QFontDatabase::addApplicationFont(":/Assets/fonts/Symbola_font.ttf");
  app.setFont(QFont("Symbola"));

  applicationEngine = new QQmlApplicationEngine();
  applicationEngine->load(QUrl(QStringLiteral("qrc:/Qml/Main/Application.qml")));
//  applicationEngine->load(QUrl(QStringLiteral("qrc:/Assets/Theme/ThemeTest.qml")));
qDebug() << "Root objects:" << applicationEngine->rootObjects();
  if ( applicationEngine->rootObjects().isEmpty() ) return -1;

  return app.exec();
}
