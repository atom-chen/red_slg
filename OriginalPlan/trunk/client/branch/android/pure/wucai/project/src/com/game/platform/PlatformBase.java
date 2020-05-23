package com.game.platform;

import java.lang.reflect.InvocationTargetException; 
import java.lang.reflect.Method;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import org.cocos2dx.lib.Cocos2dxActivity;
import org.cocos2dx.lib.Cocos2dxLuaJavaBridge;
import org.json.JSONException;
import org.json.JSONObject;

import com.game.lib.PushService; 
import com.game.lib.Utility;

import android.app.AlarmManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.text.format.Time;
import android.util.Log;
import android.view.KeyEvent;

//import android.content.pm.ApplicationInfo;
//import android.content.pm.PackageManager;
//import android.content.pm.PackageManager.NameNotFoundException;
//import android.content.Context;
//import android.content.ContextWrapper;
   
public class PlatformBase {                                         
	protected Cocos2dxActivity mainAct = null;                     
	protected String m_uid;      
	protected String m_uname;           
	protected String m_md5;    
	  
	protected String m_roleId;           
	protected String m_roleName; 
	protected Map<String, String> m_data = new HashMap<String, String>();
	private int luaCallback = 0; 
	private int luaCallbackEx = 1;  
	
	
	public PlatformBase(){     
		  
	}
	 
	//初始化 activity的时候   
	public void onCreate(Cocos2dxActivity act){
		mainAct = act;
		
	}

	
	public void onStart(){
	} 
	 
	public void onResume(){                    
		
	}
	
	public void onPause(){     
		
	}
	
	public void onStop() {
	}
	
	public void onDestroy() { 
	}
	
	public boolean onKeyDown(int keyCode,KeyEvent event){ 
		return false;  
	}
	
	public void onActivityResult(int requestCode, int resultCode, Intent data){
		  
	} 
	
	public  void uploadUserData(JSONObject params)
	{
	
	}
	
	public  void onNewIntent(Intent intent) {
		
	}
	//是否可以获取电话号码  有些平台要求不能获取
	public boolean canGetPhoneNumber(){
		return false;
	}   
	
//-----------------------------------------------------------------------------------------------------------
	public void setLuaCallback(final int callback){
		if(this.luaCallback != 0){
			Cocos2dxLuaJavaBridge.releaseLuaFunction(this.luaCallback);
		}
		this.luaCallback = callback;  
	} 
	
	//平台 启动  
	public void platformLaunch(){ 
		callLuaFunction("platformLaunchEnd","{status='ok'}");
	} 
	
	//平台登录 
	public void platformLogin(){   
		  
	}
	
	public void platformLogout(){    
		
	}
	public void changeAccount(){ 
		  
	} 
	  
	public void antiAddicition() 
	{ 
	      
	} 
	
	public void realNameRegister()
	{ 
	  
	}

	
	public void setUserInfo(String uid, String uname, String attach){
		m_uid = uid;
		m_uname = uname;  
		m_md5 = attach; 
	}
	
	
	public String getData(String name){
		return m_data.get(name); 
	}
	
	//选服
	public void changeServer(){  
		 
	}
	
	//游戏登录
	public void loginGameServer(String sId,String sName){
		
		callLuaFunction("platformLoginGameEnd","{status='ok'}");
	}
	
	//登录服务器成功之后通知 sdk 
	public void loginGameServerEnd(String sId, String sName){
		
	}
		
	//游客绑定 
	public void bindUser(){
		
	}

	
	//客服
	public void csCenter(String roleName){
		 
	}
	 
	//显示隐藏   平台的图标
	public void showPlatformIcon(boolean flag){
		 
	} 
	
	public void restartApp(){
		Intent intent = new Intent(mainAct.getApplicationContext(), com.wucai.souyou.redclient.MainClient.class);  
        PendingIntent restartIntent = PendingIntent.getActivity(    
        		mainAct.getApplicationContext(), 0, intent,     
                Intent.FLAG_ACTIVITY_NEW_TASK); 
	        AlarmManager mgr = (AlarmManager)mainAct.getSystemService(Context.ALARM_SERVICE);    
            mgr.set(AlarmManager.RTC, System.currentTimeMillis() + 10,    
                    restartIntent); // 10毫秒钟后重启应用
            
	        android.os.Process.killProcess(android.os.Process.myPid());     
	}
	 
	
	//调用lua 方法     arg必须是一个字符串格式的tb 或者为空 
	public void callLuaFunction(final String evenName,final String arg){
		System.out.println("============ logplatformbase callLuaFunction:"+evenName + " " + arg);
		mainAct.runOnGLThread(new Runnable() {   
			@Override
			public void run() {                 
				String str = arg;  
				if(str == null || str.equals("")){           
					str = "{}";
				}   
				if(!str.substring(0, 1).equals("{")){   
					Log.e("java call lua", "params error :"+evenName+"   "+str);   
				}  
				str = str.substring(1, str.length());   
				str = "{name='"+evenName+"',"+str;
				Cocos2dxLuaJavaBridge.callLuaFunctionWithString(luaCallback,str); 
			} 
		});
	}
	
	public void callLuaFunctionEx(final String luaTable){  
		mainAct.runOnGLThread(new Runnable() { 
			@Override
			public void run() {  
				String luaArg = luaTable;  
				Log.i("PlatformBase ",luaArg); 
				Cocos2dxLuaJavaBridge.callLuaFunctionWithString(luaCallbackEx,luaTable);
			}  
		});
	}
	
	public String callStringMethod(String FuncName, String paramsJson){
		Class<?> c = this.getClass();// <? extends UC9GamePlatform> 
		try {
			JSONObject params = new JSONObject(paramsJson);
			Method m = c.getMethod(FuncName, JSONObject.class);
			m.setAccessible(true);
			Class<?> retCls = m.getReturnType(); 
			String retName = retCls.getCanonicalName();
			/*
			if(retName.equals("java.lang.String")){
				String ret = (String)m.invoke(this, params); 
				return String.format("{exist=true,result=%s}", ret);
				//return ret;
			}
			else if(retName.equals("void")){
				return "{exist=true}";
			}
			else if(retName.equals("int")){
				int ret = (Integer)m.invoke(this, params);
				return String.format("{exist=true,result=%d}", ret);
			}
			else if(retName.equals("boolean")){
				boolean ret = (Boolean)m.invoke(this, params);
				return String.format("{exist=true,result=%s}", (ret?"true":"false"));
			}
			else{
				Object ret = m.invoke(this, params);
				return "{exist=true,result="+ret.toString()+"}";
			}*/
			if(retName.equals("void")){
				m.invoke(this, params);
				return "{exist=true}";  
			}
			else{
				Object ret = m.invoke(this, params);  
				return "{exist=true,result="+ret.toString()+"}";
			}
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "{exist=false,msg='NoSuchMethodException'}";
			
		} catch (IllegalAccessException e) {   
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "{exist=false,msg='IllegalAccessException'}";
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "{exist=false,msg='IllegalArgumentException'}";
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
			e.getTargetException().printStackTrace();
			return "{exist=false,msg='InvocationTargetException'}";
		} catch (Exception e) {
			e.printStackTrace(System.out);
			return "{exist=false}";//,msg='"+e.getMessage()+"'
		}
		
	//	return "{exist=true}";
	}
	
	public void notifySDK(JSONObject params) {
	
	}
	
	public void logout(JSONObject json){
		
	}
	public void exit(JSONObject json){ 
		
	}
	
	public void charge(JSONObject json) throws JSONException{
		
	}
	
	//获取 平台的邀请好友列表
	public void reqInviteFriendList(JSONObject json){
		//callLuaFunction(PlatformEvent.INVITE_FRIEND_LIST,"{status='ok'}");
	}
	
	public void inviteFriends(JSONObject json) throws JSONException{
		
	}
	
	public boolean isVisitor(){           
		return false;
	} 
	
	public String reqChannelId()
	{
		return "";
	}
	//是否有平台登录 接口  
	public boolean hasPlatformLoginAPI(){   
		return false;
	}
	
	//是否有选服api
	public boolean hasChangeServerAPI(){
		return false;
	}
	
	public void loginNotifySDK(JSONObject params) {

	}
    
	
	//是否支持 切换账号
	public boolean hasChangeAccount(JSONObject json){   
		return true;             
	}
	//是否支持游戏显示的充值页面
	public boolean supportChargeInGame(JSONObject json){
		return true;
	}
	//是否开启充值
	public boolean supportCharge(JSONObject json){
		return true;      
	}
	//是否有客服按钮
	public boolean supportContact(JSONObject json){ 
		return false;
	} 
	//是否有退出游戏界面
	public boolean supportExitGame(JSONObject json){
		return false;
	}
	
	public void gameLogoutFinish(){  
		
	}
	
	public boolean setNotification(JSONObject json){
		System.out.println("public boolean setNotification(JSONObject json){");
		PushService service = PushService.getService();
		Time t=new Time(); // or Time t=new Time("GMT+8"); 加上Time Zone资料。  
    	t.setToNow();
    	try {
			json.put("arrivedTime", t.toMillis(true)/1000);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    		
		Utility.saveLocalData(service, "notify", "inst", json.toString());
		return true;
	}
}
