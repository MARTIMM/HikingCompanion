package utils;

import org.qtproject.qt5.android.QtNative;

import java.lang.String;

import android.util.Log;  // temporary for debugging

import android.app.Service;

import android.content.Intent;

//import android.os.IBinder;
//import android.os.Bundle;

// ----------------------------------------------------------------------------












/*
public class HCAndroidUtils extends Service {
  private static String LOG_TAG = "HC Service";

  // --------------------------------------------------------------------------
  // Defined in the main.cpp file as an entry into the c++ code
  public static native void main2(String path);

  // --------------------------------------------------------------------------
  @Override
  public void onCreate() {
    super.onCreate();
    Log.v( LOG_TAG, "in onCreate");
  }

  // --------------------------------------------------------------------------
  @Override
  public IBinder onBind(Intent intent) {
    Log.i( LOG_TAG, "in onBind");
    return null;
  }

  // --------------------------------------------------------------------------
  @Override
  public void onDestroy() {
    super.onDestroy();
    Log.v( LOG_TAG, "in onDestroy");
  }

  // --------------------------------------------------------------------------
  @Override
  public int onStartCommand (
      Intent installIntent, int flags, int startId
      ) {

    System.loadLibrary("HikingCompanion");
    Bundle AB_dataRootDir = installIntent.getExtras();
    String path = new String(AB_dataRootDir.getCharArray("dataRootDir"));
    new HCAndroidUtils().main2(path);

    Log.d( LOG_TAG, "Returned from main2(): ");

    stopService(installIntent);
    return Service.START_STICKY;
  }
}
*/
