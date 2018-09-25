#include "jnitest.h"

#include <QDebug>

JniTest::JniTest() {
  qDebug() << "test";



}

jint Java_jnitestpkg_Jnitest_main2__ILjava_lang_String_2 (
     JNIEnv *env,        /* interface pointer */
     jobject obj,        /* "this" pointer */
     jint i,             /* argument #1 */
     jstring s)          /* argument #2 */
{
     /* Obtain a C-copy of the Java string */
     const char *str = (*env)->GetStringUTFChars(env, s, 0);

     /* process the string */
     //...

     /* Now we are done with str */
     (*env)->ReleaseStringUTFChars(env, s, str);

     return 0;
}
