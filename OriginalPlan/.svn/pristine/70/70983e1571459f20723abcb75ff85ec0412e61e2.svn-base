package com.game.lib;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Field;

import com.wucai.souyou.redclient.MainClient;

import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;

public class Utility {
	
	
	public static boolean hasAssetsFile(Context cx,String path){
        InputStream in = getAssetsFile(cx,path);    
        if (in != null){
        	closeStream(in);
        	return true;
        }
		return false;
	}
	
	public static InputStream getAssetsFile(Context cx,String path){
		InputStream in = null;    
        try    
        {    
            in = cx.getResources().getAssets().open(path);    
        }    
        catch (IOException e)    
        {    
            e.printStackTrace();    
        }    
        return in; 
	}
	
	public static InputStream getSDCardFile(String path){
		File file = new File(path);
		if (!file.exists()) {
			return null;
		}else{
			InputStream in = null;
			try{
				in = new FileInputStream(file);
			}catch(IOException e){
				
			}
			return in;
		}
	}
	
	public static void closeStream(InputStream st){
		if (st != null){
    		try{
    			st.close();
            }catch(IOException e){
    			
    		}
    	}
	}
	
	public static void saveLocalData(Context ct,String fileName,String key,String value){
		SharedPreferences settings = ct.getSharedPreferences(fileName, Activity.MODE_PRIVATE);  
		SharedPreferences.Editor editor = settings.edit();  
		editor.putString(key, value);  
		editor.commit();  
	}
	
	public static String getLocalData(Context ct,String fileName,String key){
		SharedPreferences settings = ct.getSharedPreferences(fileName, Activity.MODE_PRIVATE);  
		return settings.getString(key, "");
	}
	
	public static String getPackageName()
	{
		return MainClient.getContext().getPackageName();
	}
	
	public static int getInt(String clsName, String encloseClsName, String fieldName)
	{
		try
		{
			return MainClient.getContext().getResources().getIdentifier(fieldName, encloseClsName, MainClient.getContext().getPackageName());
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return 0;
	}
	
	public static String getString(String clsName, String encloseClsName, String fieldName)
	{
		int res = getInt(clsName, encloseClsName, fieldName);
		return MainClient.getContext().getResources().getString(res);
	}
	
	public static String getPackageMetaData(){
		return "";
	}
	public static String getMetaDataValue(String name, String def) {
	    String value = getMetaDataValue(name);
	    return (value == null) ? def : value;
	}
	 
	public static String getMetaDataValue(String name) {
	 
	    Object value = null;
	 
	    PackageManager packageManager = MainClient.getContext().getPackageManager();
	 
	    ApplicationInfo applicationInfo;
	 
	    try {
	 
	        applicationInfo = packageManager.getApplicationInfo(MainClient.getContext().getPackageName(), 128);
	  
	        if (applicationInfo != null && applicationInfo.metaData != null) 
	        {
	            value = applicationInfo.metaData.get(name);
	        }
	 
	    } 
	    catch (NameNotFoundException e) {
	    	e.printStackTrace();
	    }
	 
	    if (value == null) {
	    	return "";
	    }
	 
	    return value.toString();
	 
	}
}
