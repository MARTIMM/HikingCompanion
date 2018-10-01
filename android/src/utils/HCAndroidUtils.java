package utils;

import org.qtproject.qt5.android.QtNative;

import android.app.Service;
import android.content.Intent;
import android.os.IBinder;
import android.util.Log;
import android.os.Bundle;
import java.lang.String;

// ----------------------------------------------------------------------------
public class HCAndroidUtils extends Service {

  // --------------------------------------------------------------------------
  // Defined in the main.cpp file as an entry into the c++ code
  public static native void main2(String path);

  // --------------------------------------------------------------------------
  @Override
  public int onStartCommand (
      Intent installIntent, int flags, int startId
      ) {

    System.loadLibrary("HikingCompanion");
    Bundle AB_dataRootDir = installIntent.getExtras();
    String path = new String(AB_dataRootDir.getCharArray("dataRootDir"));
    new HCAndroidUtils().main2(path);

    Log.d( "HC Java object", "Returned from main2(): ");

    stopService(installIntent);
    return Service.START_STICKY;
  }

  // --------------------------------------------------------------------------
  @Override
  public IBinder onBind(Intent arg0) {
    Log.i( "HC Java object", "Service onBind");
    return null;
  }
}
