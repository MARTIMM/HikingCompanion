package utils;

import org.qtproject.qt5.android.QtNative;
import java.lang.String;
import android.util.Log;

// ----------------------------------------------------------------------------
public class Jnitest {

  // --------------------------------------------------------------------------
  public static native int main2( String s1, String s2);

  // --------------------------------------------------------------------------
  public static boolean jnitest(String testString) {

    System.loadLibrary("HikingCompanion");
    String argv1 = "Test string";
    String argv2 = testString;
    int i = new Jnitest().main2( argv1, argv2);

    Log.d("Returned from main2(): ", Integer.toString(i));
    return true;
  }
}
