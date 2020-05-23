package com.game.platform;

import org.cocos2dx.lib.Cocos2dxActivity;
import org.cocos2dx.lib.Cocos2dxLuaJavaBridge;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.game.lib.LuaCallClass;
import com.game.lib.Utility;

import android.app.Activity;
import android.app.AlertDialog;
import android.os.Handler;
import android.os.RemoteException;
import android.preference.PreferenceActivity.Header;
import android.util.Log;
//import android.widget.Toast;

//import fly.fish.aidl.OutFace;
//import fly.fish.aidl.OutFace.FlyFishSDK;


//import cn.uc.gamesdk.IUCBindGuest;
//import cn.uc.gamesdk.UCBindGuestResult;
//import cn.uc.gamesdk.GameUserLoginResult;
//import cn.uc.gamesdk.IGameUserLogin;
import android.content.ComponentName;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.view.KeyEvent;
import android.widget.Toast;
import java.util.HashMap;
import java.util.Objects;
import java.util.TreeMap;

import com.highgame.sdk.common.util.TimeUtil;
import com.highgame.sdk.union.SDKManager;
import com.highgame.sdk.union.UnionSDK;
import com.highgame.sdk.union.common.Constants;
import com.highgame.sdk.union.iapi.ICallback;
import com.highgame.sdk.union.iapi.IPay;
import com.highgame.sdk.union.network.Key;
import com.highgame.sdk.union.pay.PayParams;
import com.highgame.sdk.union.pay.ui.PayActivityContainer;
import com.highgame.sdk.union.ui.ActionType;
import com.highgame.sdk.union.util.Cryptography;
import com.highgame.sdk.union.util.Time;

public class WuweiPlatform extends PlatformBase {  
		private final static String TAG = "WUCAI_TEST";
		private Cocos2dxActivity manActive;          
	    private String channelID = "100000042";  
	    private String uid = "";
	    private String session_id = "";
	    private int guest = 0;
	    private String user_name  ="";  
	    private String others = "";
	    private String gameId = "";
    
	    private String orderId = "test_order_id";
	    private String roleID = "test_uid_in_game";
	    private String roleName = "test_user_name_in_game";  
	    private String serverId = "test_server_id";
	    private String productName = "test_product_name";
	    private String productID = "test_product_id";   
	    private String payInfo = "test pay info";
	    private int productCount = 22;
	    private int realPayMoney = 20;
	    private String currencyName = "";
	    private int rate;
	    private boolean allowUserChange;
	    private String callbackUrl = "www.test_callback_url.com"; // 建议从服务器获取, 而不是写死在代码里
	    private String accessToken;
	    private static final String app_secrct = "7843506a66ecb06edf6d82f1a03a1506";
	
	public WuweiPlatform(){   
		  // 发送token到服务器，获取access_token, 用户信息等
   
	}
	
	@Override
	public void onStart(){ 
		super.onStart();   
	}

	public String reqChannelId()
	{
		return channelID;
	}
	
	@Override
	public boolean isVisitor(){   
		return guest==0;
	}
    
	@Override
	public void onResume(){
		super.onResume();
		UnionSDK.getInstance().onResume(manActive);
	} 
	
	@Override
	public void onPause(){        
		super.onPause(); 
		UnionSDK.getInstance().onPause(manActive);
	} 
	
	@Override
	public void onStop() {
		 super.onStop();
		 UnionSDK.getInstance().onStop(manActive);
	}
	
	public  void onNewIntent(Intent intent) {
	}

	@Override
	public void onDestroy() {              
		super.onDestroy();     
		UnionSDK.getInstance().onDestroy(manActive);
	}
	
	private void println(String s){      
		System.out.println("==== ====ZhiShangPlatform " + s);  
	}
	
    
	public void onActivityResult(int requestCode,int resultCode, Intent data){
		super.onActivityResult(requestCode, resultCode, data);
		UnionSDK.getInstance().onActivityResult(manActive, requestCode, resultCode, data);
	} 
	@Override
	public void onCreate(Cocos2dxActivity act){   
		super.onCreate(act);    
		manActive = act; 
	} 
	
	public void platformLogin() {  
		Log.d(TAG, "login finished, retCode=" + "sdk  login");  
	  	mainAct.runOnUiThread( new Runnable(){ 
				public void run() {
			        UnionSDK.getInstance().invokeAction(manActive, ActionType.LOGIN, null, new ICallback() {
			            @Override
			            public void onFinished(int retCode, JSONObject data) {
			                Log.d(TAG, "login finished, retCode=" + retCode + ", data=" + data);
			                if (retCode == Constants.User.LOGIN_SUCCESS) { 
			                    // login success
			                    Log.i(TAG, "login success");
			                    String authorizeCode = data.optString(Constants.User.AUTHORIZE_CODE);
			                    Log.i(TAG, "authorize_code: " + authorizeCode);
			                    user_name = data.optString("user_name");   
			                    accessUserInfo(authorizeCode);
			                } else {
			                    Log.i(TAG, "union sdk login fail");
			                    // login fail.
			                    if (data != null) {
			                        String msg = data.optString(Constants.User.MSG);
			                        Log.i(TAG, "login fail, return message is " + msg);      
			                    } 
			                }
			            }
			        });  
					}
				});
	}
	
    private void accessUserInfo(String authorizeCode) {        
        Log.i(TAG, "begin accessUserInfo, authorizeCode: " + authorizeCode); 
        gameId = SDKManager.getInstance().getAppId(); 
        channelID = SDKManager.getInstance().getChannelId();
		String arg = "{status='ok',userInfo={userId='" + uid + "',userType='',md5='" + session_id
		+ "',sessionId='" + session_id + "',status=1,accountid='" + uid + "' ,isEncodeMD5=1},channelID= '"
		+ channelID + "',authorize_code='" + authorizeCode+ "',gameId='" + gameId + "' }";

		callLuaFunction(PlatformEvent.LOGIN_END, arg);    
    }

	
	public void gameLogoutFinish(){

        reLogin();
	}
	
	public void antiAddicition()
	{

	}
	
	public void realNameRegister()
	{

	}
	public void notifySDK(final JSONObject userdata)
	{
	  	mainAct.runOnUiThread( new Runnable(){       
				public void run() { 
			        HashMap<String, Object> data = new HashMap<String, Object>();       
			        
			        try { 
					        TreeMap<String, Object> dataParams = new TreeMap<String, Object>();
					        dataParams.put("ACTIONTYPE", "SETPLAYER"); 
					        dataParams.put("EVENTTAG", "LOGIN"); 
					        dataParams.put("PLAYERNAME", (String) userdata.get("roleName"));
					        dataParams.put("SERVERID", (String) userdata.get("serverID"));
					        dataParams.put("AGE", 0);
					        dataParams.put("LEVEL", (String) userdata.get("roleLevel"));
					        dataParams.put("ROLEID", (String) userdata.get("roleID"));
					        dataParams.put("USERID", uid);
					        UnionSDK.getInstance().sendPlayerInfo(manActive,dataParams);
					        
			        } catch (Exception e) {
			            e.printStackTrace();
			            Log.e(TAG, " login  exception");  
			        }
				}});

	}
	
    private void destroyGame() {    
        Log.d(TAG, "destroyGame");
        // 新版接口
		String arg = "{status='ok'}";  
		callLuaFunction(PlatformEvent.EXIT_GAME, arg);   
    }
    
	public void exit(JSONObject json){
		
//		mainAct.runOnUiThread( new Runnable(){
//			public void run() { 
//				ChannelInterface.exit(manActive, new IDispatcherCb() {
//		            @Override
//		            public void onFinished(int retCode, JSONObject data) {
//		                Log.i(TAG, "exit, retCode: " + retCode + ", json: " + data);
//		                switch (retCode) {
//		                    case Constants.ErrorCode.EXIT_NO_UI:
//		                        Log.d(TAG, "渠道没有退出UI，游戏需要提供退出界面");
//		                        // 渠道无退出UI，游戏自行处理
//		                        // 示例
//		                        final AlertDialog.Builder builder = new AlertDialog.Builder(manActive);
//		                        builder.setPositiveButton("继续游戏", new DialogInterface.OnClickListener() {
//		                            @Override
//		                            public void onClick(DialogInterface dialog, int which) {
//		                                dialog.dismiss();
//		                            }
//		                        }).setNegativeButton("退出游戏", new DialogInterface.OnClickListener() {
//		                            @Override
//		                            public void onClick(DialogInterface dialog, int which) {
//		                                dialog.dismiss();
//		                                destroyGame();
//		                            }
//		                        }).setMessage("确定要退出游戏吗?")  
//		                                .create().show();
//		                        break;
//		                    case Constants.ErrorCode.EXIT_WITH_UI:
//		                        Log.d(TAG, "渠道有退出UI，游戏根据 content 的判断用户的选择");
//		                        int result = data.optInt("content", Constants.ErrorCode.CONTINUE_GAME);
//		                        if (result == Constants.ErrorCode.CONTINUE_GAME) {
//		                            // 用户选了 “继续游戏”
//		                            Log.i(TAG, "continue game");
//		                        } else {
//		                            // 用户选了 “退出游戏”
//		                            Log.i(TAG, "quit game");
//		                            destroyGame();
//		                        }
//		                        break;
//		                    default:
//		                        // 出现异常
//		                        destroyGame();
//		                }
//		            }
//		        });
//			}
//		});
	}
	
	 /**
     * 注销账号，回到游戏登录界面
     */
	public void platformLogout() {        
        // 新版接口
	  	mainAct.runOnUiThread( new Runnable(){
				public void run() {   
					UnionSDK.getInstance().loginOut(manActive);
				}});
    }
	
    private void reLogin() {          
        // 游戏自行处理重新登录的逻辑. 这里只是示例
        Log.i(TAG, "re login");  
        platformLogin();   
    }
    
	public void loginNotifySDK(final JSONObject data) {            
					try{   
						
						String str_data = data.getString("content");
						JSONObject sub_data = new JSONObject(str_data);
						accessToken = (String)sub_data.get("access_token");
						JSONArray arry = sub_data.getJSONArray("data");
						
						    uid = (String) (arry.getJSONObject(0).get("user_id"));
							String arg = "{status='ok',userInfo={userId='" + uid + "',userType='',md5='" + session_id
							+ "',sessionId='" + session_id + "',status=1,accountid='" + uid + "' ,isEncodeMD5=1},channelID= '"
							+ channelID + "',gameId='" + gameId + "' }";
					callLuaFunction(PlatformEvent.SYNCH_ACCOUNT_INFO, arg);
					}catch(Exception e){
						e.printStackTrace(System.out);           
					}
	}
	

    public void changeAccount() {                            
        Log.i(TAG, "swithAccount");  
	  	mainAct.runOnUiThread( new Runnable(){
				public void run() {  
			        	platformLogout();
			            Log.i(TAG, "isSupportSwitchAccount false");
			            String arg = "{status='ok' }";
    					callLuaFunction(PlatformEvent.GAME_LOGOUT, arg);  
			        }
				});

    }
    
	public void charge( final JSONObject json) throws JSONException{    

    	mainAct.runOnUiThread( new Runnable(){
			public void run() {
				long level = 1;

				try {
			        roleID = (String) json.get("roleId");
			        orderId = roleID + TimeUtil.unixTimeString();
			        roleName = (String) json.get("roleName");
			        serverId = Long.toString(json.getLong("serverId"));
			        productName = (String) json.get("productName");
			        productID = Long.toString(json.getLong("productID"));
			        payInfo = (String) json.get("payInfo");
			        productCount = (int)json.getLong("productCount");   
			        realPayMoney = (int)json.getLong("money")*100;         
			        callbackUrl = (String) json.get("url");    
			        level = json.getLong("roleLevel");  
			        Log.d(TAG, "test buy");      
				} catch (Exception e) {
					e.printStackTrace(System.out);             
				}
				
		        TreeMap<String, Object> orderParams = new TreeMap<>();  
		        orderParams.put(PayParams.ORDER_ID, orderId);   
		        orderParams.put(PayParams.PAY_INFO, payInfo); 
		        orderParams.put(PayParams.PRODUCT_ID, productID);
		        orderParams.put(PayParams.PRODUCT_NAME, productName);
		        orderParams.put(PayParams.EXTRA, "extra_data");
		        orderParams.put(PayParams.RATE, 2);
		        orderParams.put(PayParams.AMOUNT, realPayMoney);

		        TreeMap<String,Object> userParams = new TreeMap<>();
		        userParams.put(PayParams.ACCESS_TOKEN,accessToken);
		        userParams.put(PayParams.APP_ROLE_ID,roleID);
		        userParams.put(PayParams.APP_ROLE_NAME,roleName);
		        userParams.put(PayParams.SERVER_ID,serverId);
		        userParams.put(PayParams.USER_LEVEL,level);


		        UnionSDK.getInstance().onPay(manActive, userParams,orderParams, new ICallback() {
		            @Override
		            public void onFinished(int retCode, JSONObject data) {
		                 if (retCode == Constants.Pay.PAY_SUCCESS) {
		                    //
		                    Log.i(TAG, "union sdk pay success");
		                } else {
		                    Log.i(TAG, "union sdk pay fail");
		                }
		            }
		        });
			}
    		});
  
    }
    
}