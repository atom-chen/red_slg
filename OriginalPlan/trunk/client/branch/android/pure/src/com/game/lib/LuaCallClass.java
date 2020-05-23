package com.game.lib;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.Random;
import java.util.Timer;
import java.util.TimerTask;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

import org.cocos2dx.lib.Cocos2dxActivity;
import org.cocos2dx.lib.Cocos2dxLuaJavaBridge;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.Signature;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.Uri;
import android.os.Environment; 
import android.telephony.TelephonyManager;
import android.util.Base64;
import android.util.Log;
import android.view.Gravity; 
import android.view.Window;
import android.view.WindowManager;

import com.game.platform.PlatformManager;
import com.wucai.souyou.redclient.MainClient;
//import com.wucai.mjyx.uc.R; 

public class LuaCallClass {
	static private MainClient s_instance; 

	static public void init(MainClient instance) {
		s_instance = instance; 
		//getFacebookHashKey(); 
		// Settings.System.putInt(s_instance.getContentResolver(),Settings.System.ACCELEROMETER_ROTATION,
		// 1);
	} 

	static public int installApk(String apkpath) {
		Log.w("zhangzhen installApk path ", apkpath);
		Intent intent = new Intent(Intent.ACTION_VIEW);
		intent.setDataAndType(Uri.fromFile(new File(apkpath)),
				"application/vnd.android.package-archive");
		Cocos2dxActivity.getContext().startActivity(intent);
		return 1;
	}

	static public void getFacebookHashKey() {
		try {
			PackageInfo info = s_instance.getPackageManager().getPackageInfo(
					s_instance.getPackageName(), PackageManager.GET_SIGNATURES);
			for (Signature signature : info.signatures) {
				MessageDigest md = MessageDigest.getInstance("SHA");
				md.update(signature.toByteArray());
				Log.w("KeyHash:",
						Base64.encodeToString(md.digest(), Base64.DEFAULT));
			}
		} catch (NameNotFoundException e) {
			Log.w("main", "NameNotFoundException");
		} catch (NoSuchAlgorithmException e) {
			Log.w("main", "NoSuchAlgorithmException");
		}
	}

	public static String getdeviceId() {
		String NativePhoneNumber = "";
		try {
			
			if(PlatformManager.canPhoneNumber){
				TelephonyManager telephonyManager = (TelephonyManager) s_instance
						.getSystemService(Context.TELEPHONY_SERVICE);
				
				 NativePhoneNumber = telephonyManager.getLine1Number();//取出MSISDN，很可能为空
				
				 if (NativePhoneNumber.length() == 0) {
					 NativePhoneNumber = telephonyManager.getDeviceId(); // 取出IMEI
				 }
	
				if (NativePhoneNumber.length() == 0) {
					NativePhoneNumber = telephonyManager.getSimSerialNumber(); // 取出ICCID
				}
	
				if (NativePhoneNumber.length() == 0) {
					NativePhoneNumber = telephonyManager.getSubscriberId(); // 取出IMSI
				}
			}

			if (NativePhoneNumber.length() > 50) {
				String no = NativePhoneNumber.substring(0, 49);
				NativePhoneNumber = no;
			} else if (NativePhoneNumber.length() < 3) {
				Random object = new Random();
				object.setSeed(System.currentTimeMillis());
				int randNum = (int) (object.nextDouble() * 100000000)
						+ (int) (object.nextDouble() * 1000000)
						+ (int) (object.nextDouble() * 10000)
						+ (int) (object.nextDouble() * 100)
						+ (int) (object.nextDouble() * 10); 
				NativePhoneNumber = "unknow"
						+ Long.toString(System.currentTimeMillis())
						+ Integer.toString(randNum); 
			}
		} catch (Exception e) { 
			// TODO Auto-generated catch block
			Log.w("getPhoneNumber", "error");
			NativePhoneNumber = "getPhoneNumbererror"  
					+ Long.toString(System.currentTimeMillis());
		}
		Log.w("NativePhoneNumber", NativePhoneNumber);
		return NativePhoneNumber; 
	}

	// 弹出对话框
	static public void showAlertDialog(final String title,
			final String message, final String btn1, final String btn2,
			final int luaCallbackFunction) {

		s_instance.runOnUiThread(new Runnable() {

			@Override
			public void run() {
				AlertDialog alertDialog = new AlertDialog.Builder(s_instance)
						.create();
				alertDialog.setTitle(title);
				alertDialog.setMessage(message);
				alertDialog.setButton(DialogInterface.BUTTON_POSITIVE, btn1,
						new DialogInterface.OnClickListener() {
							@Override
							public void onClick(DialogInterface dialog,
									int which) {
								s_instance.runOnGLThread(new Runnable() {
									@Override
									public void run() {
										Cocos2dxLuaJavaBridge.callLuaFunctionWithString(luaCallbackFunction,"ok");
										Cocos2dxLuaJavaBridge.releaseLuaFunction(luaCallbackFunction);
									}
								});
							}
						});
				if (btn2 != "") { 
					alertDialog.setButton(DialogInterface.BUTTON_NEGATIVE,
							btn2, new DialogInterface.OnClickListener() {
								@Override
								public void onClick(DialogInterface dialog,
										int which) {
									s_instance.runOnGLThread(new Runnable() {
										@Override
										public void run() {
											Cocos2dxLuaJavaBridge.callLuaFunctionWithString(luaCallbackFunction,"cancel");
											Cocos2dxLuaJavaBridge.releaseLuaFunction(luaCallbackFunction);
										}
									});
								}
							});
				}

				alertDialog.setIcon(Utility.getInt("R", "drawable", "icon"));
				alertDialog.setCancelable(false);
				Window window = alertDialog.getWindow();
				window.setGravity(Gravity.CENTER);
				alertDialog.getWindow().setFlags(
						WindowManager.LayoutParams.FLAG_BLUR_BEHIND,
						WindowManager.LayoutParams.FLAG_BLUR_BEHIND);

				alertDialog.show(); 
			}
		});
	}
	
	static public String urlEncodeStr(String str) {
		try{
			String ret = URLEncoder.encode(str, "UTF-8");
			return ret;
		}catch(Exception e){
			return null;
		}
	}
	
	static public String urlDecodeStr(String str) {
		try{
			String ret = URLDecoder.decode(str, "UTF-8");
			return ret;
		}catch(Exception e){ 
			return null;
		}
	}
	
	static public String getSysInfo() {
		String model = android.os.Build.MODEL; // 手机型号
		String release = android.os.Build.VERSION.RELEASE; // android系统版本号
		return model + "&no&" + release;
	}
	
	static public boolean isWifi() {
		ConnectivityManager connectivityManager = (ConnectivityManager) s_instance.getSystemService(Context.CONNECTIVITY_SERVICE);
		NetworkInfo activeNetInfo = connectivityManager.getActiveNetworkInfo();
		if (activeNetInfo != null && activeNetInfo.getType() == ConnectivityManager.TYPE_WIFI) {
			return true; 
		}   
		return false; 
	}
	
	static public boolean isNetAvailable(){
		ConnectivityManager mConnectivityManager = (ConnectivityManager) s_instance.getSystemService(Context.CONNECTIVITY_SERVICE); 
		NetworkInfo mNetworkInfo = mConnectivityManager.getActiveNetworkInfo(); 
		if (mNetworkInfo != null) {  
			return mNetworkInfo.isAvailable(); 
		}  
		return false; 
	}
	
	public static String getGameRootPath(Context ct){
		String state = Environment.getExternalStorageState();
		if (state.equals(Environment.MEDIA_MOUNTED)) { // 可以使用sd卡
			return Environment.getExternalStorageDirectory().getAbsolutePath();
		} else { // 还是得使用手机存储
			return ct.getFilesDir().getAbsolutePath(); // 获取到自己的私有data文件
		}
	}
	
	public static String getGameRootPathEx(Context ct){    
		String state = Environment.getExternalStorageState();
		if (state.equals(Environment.MEDIA_MOUNTED)) { // 可以使用sd卡
			File f = ct.getExternalFilesDir(null);
			if(f==null){
				return ct.getFilesDir().getAbsolutePath();
			}
			return f.getAbsolutePath();
		} else { // 还是得使用手机存储   
			return ct.getFilesDir().getAbsolutePath(); // 获取到自己的私有data文 件 
		}  
	}   
	
	
	 
	public static String getGameResPath(String fName){  
		String resPath;
		try{ 
			String root = getGameRootPath(s_instance); 
			root += File.separator + fName;  
	     
			resPath = root + File.separator + GameResName;
			File tempFile = new File(resPath); 
			if (!tempFile.exists()) {    
				if(!tempFile.mkdirs()) {
					root = getGameRootPathEx(s_instance);
					if(root == null){
						return "error";
					}
					root += File.separator + fName; 
					resPath = root + File.separator + GameResName;
					tempFile = new File(resPath); 
					if (!tempFile.exists()) {     
						if(!tempFile.mkdirs()) {
							return "error";  
						} 
					}
				}
			} 
		}catch (Exception e) { 
            // TODO Auto-generated catch block  
            e.printStackTrace();  
            return "error";  
        }  
		Log.w("getGameResPath", "getGameResPath"+fName);
		return resPath;
	}
	
	public static String getGameTempPath(String fName){ 
		final String tempPath;
		try{
			String root = getGameRootPathEx(s_instance);
			if(root == null){
				return "error";
			}
			root += File.separator + fName;
	  
			tempPath = root + File.separator + GameTempName;
			
			File tempFile = new File(tempPath);
			if (!tempFile.exists()) {
				if(!tempFile.mkdirs()) {
					return "error";
				}
			}
		}catch (Exception e) { 
            // TODO Auto-generated catch block  
            e.printStackTrace();  
            return "error";  
        }
		return tempPath;
	}

	public static final String GameResName = "game";
	public static final String GameTempName = "temp";

}