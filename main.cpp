#include "textload.h"
#include "config.h"
#include "languages.h"
#include "gpxfiles.h"
#include "hikes.h"

#if defined(Q_OS_ANDROID)
#include <QtAndroid>
#endif

//#include <QStyleFactory>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
//#include <QQuickStyle>
//#include <QQmlComponent>
#include <QDebug>
//#include <QQmlProperty>
#include <QStandardPaths>
//#include <QSharedMemory>

// ----------------------------------------------------------------------------
int main( int argc, char *argv[]) {

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

  // Styling: http://doc.qt.io/qt-5/qtquickcontrols2-styles.html
  //          https://doc.qt.io/qt-5.11/qtquickcontrols2-styles.html
  // Using qtquickcontrols2.conf now instead of
  // 'QQuickStyle::setStyle("Material");'

  QGuiApplication app( argc, argv);
  app.setApplicationVersion("0.9.1");
  app.setApplicationDisplayName("HikingCompanion");

/*
  qDebug() << "App data location:" << QStandardPaths::standardLocations(QStandardPaths::AppDataLocation);
  qDebug() << "App config location:" << QStandardPaths::standardLocations(QStandardPaths::AppConfigLocation);
  qDebug() << "Generic data location:" << QStandardPaths::standardLocations(QStandardPaths::GenericDataLocation);
  qDebug() << "Generic config location:" << QStandardPaths::standardLocations(QStandardPaths::GenericConfigLocation);

  qDebug() << "qApp argc:" << argc;
  for ( int i = 0; i < argc; i++) {
    qDebug() << QString("qApp [%1]").arg(i) << argv[i];
  }
*/

  qmlRegisterType<TextLoad>(
        "io.github.martimm.HikingCompanion.Textload", 0, 1, "TextLoad"
        );

  qmlRegisterType<Config>(
        "io.github.martimm.HikingCompanion.Config", 0, 3, "Config"
        );

  qmlRegisterType<Languages>(
        "io.github.martimm.HikingCompanion.Languages", 0, 2, "Languages"
        );

  qmlRegisterType<Hikes>(
        "io.github.martimm.HikingCompanion.Hikes", 0, 1, "Hikes"
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

// ============================================================================
extern "C" {

#if defined(Q_OS_ANDROID)

#include <QtAndroid>
#include <QAndroidJniEnvironment>

//#include <QAndroidActivityResultReceiver>
//#include <QtAndroidExtras>

/*
// ----------------------------------------------------------------------------
JNIEXPORT void JNICALL Java_utils_Jnitest_main2__Ljava_lang_String_2 (
     JNIEnv *env, jobject obj, jstring jpath
     ) {

  / * Obtain a C-copy of the Java string * /
  jboolean copy = false;
  const char *path = env->GetStringUTFChars( jpath, &copy);

  qDebug() << "Path from hike container:" << path;
  Config *cfg = new Config;
  cfg->installNewData(QString(*path));

  / * Now we are done with str * /
  env->ReleaseStringUTFChars( jpath, path);
}
*/
/*
// ----------------------------------------------------------------------------
JNIEXPORT jstring JNICALL Java_utils_TDAndroidUtils_getDataRootDir_2 (
     JNIEnv *env,
     jobject obj
     ) {
  Q_UNUSED(env)
  Q_UNUSED(obj)

  //QString drd = au->dataRootDir();
  //qDebug() << "Sending" << drd << "to java";
  //QAndroidJniObject jstr = QAndroidJniObject::fromString(drd);
  QAndroidJniObject jstr = QAndroidJniObject::fromString("");

  // qtcreator errors on jstr.object<jstring>(). According to the code
  // a static cast is applied so we do that instead.
  return static_cast<jstring>(jstr.object());
}
*/
/*
// ----------------------------------------------------------------------------
JNIEXPORT void JNICALL Java_utils_TDAndroidUtils_moveDataPublic_2 (
     JNIEnv *env,
     jobject obj
     ) {
  Q_UNUSED(env)
  Q_UNUSED(obj)

  //UtilsInterface *ui = new UtilsInterface();
  //ui->installHikingData();
}
*/

#endif

} // extern "C"
