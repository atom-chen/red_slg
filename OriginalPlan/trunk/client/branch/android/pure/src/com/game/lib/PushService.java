package com.game.lib;

import java.io.File;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.R.integer;
import android.app.LocalActivityManager;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.os.Binder;
import android.os.IBinder;
import android.text.format.Time;
import android.util.Log;

//import com.wucai.mjyx.uc.R;
import com.wucai.souyou.redclient.MainClient;

//推送服务
public class PushService extends Service {
	private static PushService that = null;
	private Map<String, Long> m_time = new HashMap<String, Long>();
	public static PushService getService(){
		return that;
	}
	@Override
	public IBinder onBind(Intent arg0) { 
		// TODO Auto-generated method stub
		Log.d("PushService", "onBind");
		return new Binder();
	}
	
	
	@Override
	public boolean onUnbind(Intent intent){
		Log.d("PushService", "onUnbind");
		return super.onUnbind(intent);
	} 
	
	 @Override
	    public void onCreate()
	    {  
		 Log.d("PushService", "onCreate");
	        super.onCreate();
	        that = this;
	        Notification notification = new Notification();
	        startForeground(0, notification);//该方法已创建通知管理器，设置为前台优先级后，点击通知不再自动取消
	        
	        new Thread(new Runnable() {   
	            @SuppressWarnings("deprecation")
				@Override  
	            public void run() {  
	                try {  
	                    while(true){   
	                        Thread.sleep(10000);
	                        
	                        XmlCfg cfg = getPushCfg();
	                        if(cfg != null){
	                        	ArrayList<String> timeList = pushXml.getKeyList();
	                        	ArrayList<String> tipList = pushXml.getValueList();
	                        	
	                        	Time t=new Time(); // or Time t=new Time("GMT+8"); 加上Time Zone资料。  
	                        	t.setToNow(); // 取得系统时间。  
	                        	int year = t.year;  
	                        	int month = t.month;  
	                        	int date = t.monthDay; 
	                        	int hour = t.hour; // 0-23  
	                        	int minute = t.minute;  
	                        	///*
	                        	int i = 0;
	                        	for(;i<timeList.size();i++){
	                        		String time = timeList.get(i);
	                        		String[] timeSplit = time.split(":");
	                        		int h = Integer.parseInt(timeSplit[0]);  //小时
	                        		int m = Integer.parseInt(timeSplit[1]);  //分钟
	                        		if(h == hour && minute >= m && minute < m+5){
	                        			String newTime = ""+year+":"+month+":"+date+":"+h+":"+m;
	                        			if( !newTime.equals(lastTipTime) ){
	                        				setLastTipTime(newTime);
	                        				
	                        				String tip = tipList.get(i);
	                        				//获取到通知管理器  
	        		                        NotificationManager mNotificationManager=(NotificationManager)getSystemService(Context.NOTIFICATION_SERVICE);  
	        		                        
	        		                        //定义内容  
	        		                        int notificationIcon= that.getApplicationContext().getResources().getIdentifier("icon", "drawable", that.getApplicationContext().getPackageName());
	        		                        int id = that.getApplicationContext().getResources().getIdentifier("app_name", "string", that.getApplicationContext().getPackageName());
	        		                        String appName = getResources().getString(id);
	        		                        CharSequence notificationTitle= appName;
	        		                        long when = System.currentTimeMillis();  
	        		                        
	        		                        Notification notification=new Notification(notificationIcon, notificationTitle, when);  
	        		                          
	        		                        notification.defaults=Notification.DEFAULT_ALL;
	        		                        notification.defaults |= Notification.FLAG_AUTO_CANCEL;
	        		                        notification.flags |= Notification.FLAG_AUTO_CANCEL ;// add to auto cancel
	        		                        
	        		                        Intent intent=new Intent(getApplicationContext(),MainClient.class);  
	        		                        intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
	        		                        PendingIntent pendingIntent=PendingIntent.getActivity(getApplicationContext(), 0, intent, 0);  
	        		                        notification.setLatestEventInfo(getApplicationContext(),appName, tip,pendingIntent);  
	        		                          
	        		                        mNotificationManager.notify(100, notification);
	        		                        break;
	                        			}
	                        		}
	                        	}
	                        	startInstNotification();
	                        	//*/
	                        }
	                    }
	                      
	                } catch (InterruptedException e) {  
	                    // TODO Auto-generated catch block  
	                    e.printStackTrace();  
	                }  
	  
	            }  
	        }).start();
	    } 
	 
	private void addNotification(int index,String tip){
           NotificationManager mNotificationManager=(NotificationManager)getSystemService(Context.NOTIFICATION_SERVICE);  
           
           //定义内容  
              
           int notificationIcon= Utility.getInt("R", "drawable", "icon");//R.drawable.icon;  
           String appName = getResources().getString(Utility.getInt("R", "string", "app_name"));
           CharSequence notificationTitle= appName;
           long when = System.currentTimeMillis();  
           
           Notification notification=new Notification(notificationIcon, notificationTitle, when);  
             
           notification.defaults=Notification.DEFAULT_ALL;
           notification.defaults |= Notification.FLAG_AUTO_CANCEL;
           notification.flags |= Notification.FLAG_AUTO_CANCEL ;// add to auto cancel
           
           Intent intent=new Intent(getApplicationContext(),MainClient.class);  
           intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
           PendingIntent pendingIntent=PendingIntent.getActivity(getApplicationContext(), 0, intent, 0);  
           notification.setLatestEventInfo(getApplicationContext(),appName, tip, pendingIntent);  
             
           mNotificationManager.notify(index, notification);
           
		
	} 
	
	private void cancelNotification(int index){
		NotificationManager mNotificationManager=(NotificationManager)getSystemService(Context.NOTIFICATION_SERVICE);
		mNotificationManager.cancel(index);
	}
	private void startInstNotification(){
		Integer index = 2;
		String str = Utility.getLocalData(this, "notify", "inst");
		if(str.equals("")){
			return ;
		}
		
		try {
			JSONObject jsonObject = new JSONObject(str);
			JSONArray array = jsonObject.getJSONArray("inst");
			String desc = "";
			long latest = 0;
			long arrivedTime =  jsonObject.getLong("arrivedTime");
			Time t=new Time(); // or Time t=new Time("GMT+8"); 加上Time Zone资料。  
        	t.setToNow();
        	long cur = t.toMillis(true)/1000;
        	System.out.println(String.format(" cur time %d %d", arrivedTime, cur));
			for (int i=0; i < array.length(); i++)
			{
				JSONObject json = (JSONObject) array.get(i);
				long left = json.getLong("leftTime");
				long finish = arrivedTime + left;
				
            	if (finish <= cur)
            	{
            		if (latest < finish)
            		{
            			latest = finish;
            			desc = json.getString("desc");
            		}
            	//	break;
            	}
			}
			long saveLatest = -1;

			
			if (m_time.containsKey(index.toString()))
			{
				saveLatest = (long)m_time.get(index.toString());
			}
			
			System.out.println(String.format("startInstNotification (%s) saveLatest:%d latest:%d", desc, saveLatest, latest));
			
			if (latest > 0 && saveLatest != latest)
			{
				addNotification(index, desc);
				m_time.put(index.toString(), latest);
				saveLatestTime();
			}
			else if(latest == 0)
			{
				cancelNotification(index);
			}
			
			
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
		
	
	
	private void saveLatestTime()
	{
		for (String key:m_time.keySet()){
			Long latest = (Long)m_time.get(key);
			Utility.saveLocalData(this, "latest", key, latest.toString());
		}
	}
	 
	private void initLatestTime()
	{
		for (int i = 2; i < 3; i++)
		{
			String key = String.format("%d", i);
			String s = Utility.getLocalData(this, "latest", key);
			if (s == null || s.equals(""))
			{
				continue;
			}
			
			long lastest = 0;
			try {
				lastest = Long.parseLong(s);
			} catch (Exception e) {
				// TODO: handle exception
			}
			m_time.put(key, lastest);
		}
	}
	 private String lastTipTime = "";
	 private XmlCfg pushXml = null;
	 private XmlCfg getPushCfg(){
		if(pushXml == null){
//	        String resPath = LuaCallClass.getGameResPath(this);
//	        String xmlPath = resPath + File.separator + "res"+File.separator+"push.xml";
	        InputStream in = null;//Utility.getSDCardFile(xmlPath);
	        if(in != null){  //有这个文件了
	        	pushXml = new XmlCfg(in);
	        }else{
	        	in = Utility.getAssetsFile(this, "res"+File.separator+"push.xml");
	        	if(in != null){
	        		pushXml = new XmlCfg(in);
	        	}
	        }
	        lastTipTime = Utility.getLocalData(this, "pushInfo", "lastTipTime");  //上一次提示的时间
		 }
		 initLatestTime();
		 return pushXml;
	 }
	 
	 private void setLastTipTime(String newTime){
		 lastTipTime = newTime;
		Utility.saveLocalData(this, "pushInfo", "lastTipTime",lastTipTime);
	 }
	 
	 @Override
    public void onDestroy()
    {
	 	Log.d("PushService", "onDestroy");
	 	NotificationManager mNotificationManager=(NotificationManager)getSystemService(Context.NOTIFICATION_SERVICE);
	 	mNotificationManager.cancel(1);
	 	mNotificationManager.cancel(0);
	 	//stopForeground(false);
	 	stopForeground(true);
        super.onDestroy();
    }


}
