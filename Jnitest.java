package jnitestpkg;

import org.qtproject.qt5.android.QtNative;
import java.lang.String;  // ok

public class Jnitest {

  native int main2( int argc, String argv[]);


  String argv[] = new String[2];
  argv[0] = "HC";
  argv[1] = "/storage/emulated/0";
  main2( argv.length, argv);
}
