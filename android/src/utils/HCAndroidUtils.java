package utils;

import org.qtproject.qt5.android.QtNative;

import android.app.Activity;  // ok
import android.content.Intent;  // ok
//import android.content.Context;
//import android.content.pm.ResolveInfo;
//import android.content.pm.PackageManager;
//import android.content.ContentResolver;
//import android.content.ComponentName;  // ok
//import android.database.Cursor;
//import android.provider.MediaStore;
//import android.net.Uri;
import android.util.Log;  // ok
//import android.os.Parcelable;  // ok
//import android.os.Build;
import android.os.Bundle;

//import java.io.FileNotFoundException;
//import java.io.IOException;
//import java.io.InputStream;
//import java.io.FileOutputStream;
//import java.io.File;

import java.lang.String;  // ok
//import java.util.List;
//import java.util.ArrayList;
//import java.util.Comparator;
//import java.util.Collections;

// ----------------------------------------------------------------------------
public class HCAndroidUtils extends Activity {

  // --------------------------------------------------------------------------
  // Defined in the main.cpp file as an entry into the c++ code
  public static native void main2(String path);

  // --------------------------------------------------------------------------
  @Override
  protected void onCreate (Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
  }

  // --------------------------------------------------------------------------
  @Override
  protected void onStart ( ) {

    super.onStart();

    Log.d("HC Android utils", "onStart reseived intent");
/*
    String argv[] = new String[2];
    argv[0] = "HC";
    argv[1] = "/storage/emulated/0";
    main2( argv.length, argv);
*/
/*
    // Get intent, action and MIME type
    Intent intent = new Intent();
    String action = intent.getAction();
    String type = intent.getType();
    String text = intent.getText();

    Log.d("HC Android utils", action);
    Log.d("HC Android utils", type);
    Log.d("HC Android utils", text);

    //if ( QtNative.activity() == null ) return;
*/
  }
}
