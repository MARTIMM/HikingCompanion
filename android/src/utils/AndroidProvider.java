/*
package utils;

import org.qtproject.qt5.android.QtNative;

import java.lang.String;

import android.util.Log;  // temporary for debugging

//import android.app.Service;

//import android.content.Intent;
import android.content.ComponentName;
import android.content.Context;
import android.content.ContentProvider ;
import android.content.ContentResolver;

import android.database.MatrixCursor;
import android.database.Cursor;

//import android.net.Uri.Builder;

//import android.os.IBinder;
//import android.os.Bundle;

// ----------------------------------------------------------------------------
public class AndroidProvider extends ContentProvider {

  // --------------------------------------------------------------------------
  private static String LOG_TAG = "HikingCompanion AndroidProvider";

  private static MatrixCursor _dataPathOnly = new MatrixCursor(["path"]);

  // --------------------------------------------------------------------------
  // Defined in the main.cpp file as an entry into the c++ code
  public static native String getDataRootDir();
  //public static native void moveDataPublic();

  // --------------------------------------------------------------------------
  @Override
  public void onCreate ( ) {
    super.onCreate();
    Log.v( LOG_TAG, "in onCreate");
  }

  // --------------------------------------------------------------------------
  @Override
  public Cursor query (
    Uri uri,
    String[] projection,
    Bundle queryArgs,
    CancellationSignal cancellationSignal
  ) {
    Log.v( LOG_TAG, "in query");

    // Place data in dataRootDir
    //TDAndroidUtils.moveDataPublic();

    // Then setup the row in the table (one column in one row) holding
    // the path to this data
    //if ( dataPathOnly.getCount() == 0 ) {
    //  dataPathOnly.addRow([TDAndroidUtils.getDataRootDir()]);
    //}

    return dataPathOnly;
  }

  // --------------------------------------------------------------------------
  @Override
  public Uri insert (
    Uri uri,
    ContentValues values
  ) {
    Log.v( LOG_TAG, "in insert, ignored");
    return null;
  }

  // --------------------------------------------------------------------------
  @Override
  public int update (
    Uri uri,
    ContentValues values,
    String selection,
    String[] selectionArgs
  ) {
    Log.v( LOG_TAG, "in update, ignored");
    return null;
  }

  // --------------------------------------------------------------------------
  @Override
  public int delete (
    Uri uri,
    String selection,
    String[] selectionArgs
  ) {
    Log.v( LOG_TAG, "in delete, ignored");
    return null;
  }

  // --------------------------------------------------------------------------
  @Override
  public String getType ( Uri uri ) {
    return "plain/text";
  }

  // --------------------------------------------------------------------------
  //@Override
  //public String getStreamTypes ( Uri uri ) {

  //}
}
*/




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
    Bundle AB_dataShareDir = installIntent.getExtras();
    String path = new String(AB_dataShareDir.getCharArray("dataShareDir"));
    new HCAndroidUtils().main2(path);

    Log.d( LOG_TAG, "Returned from main2(): ");

    stopService(installIntent);
    return Service.START_STICKY;
  }
}
*/
