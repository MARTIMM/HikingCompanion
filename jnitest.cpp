#include "jnitest.h"

#include <QDebug>
#include <QtAndroid>
#include <QtAndroidExtras>
#include <QAndroidJniEnvironment>

JniTest::JniTest() {
  qDebug() << "test start: call Java jnitest.java";

  QAndroidJniObject jsTs = QAndroidJniObject::fromString("abcdef");
  jboolean ok = QAndroidJniObject::callStaticMethod<jboolean>(
        // place to find java file and method
        "utils/Jnitest", "jnitest",
        // java args description
        "(Ljava/lang/String;)Z",
        // arguments
        jsTs.object()
        );

  // Catch exceptions from java
  if ( ok ) {
    qDebug() << "JNI Object available and called";
  }

  else {
    qDebug() << "JNI Object not available";
  }
}
