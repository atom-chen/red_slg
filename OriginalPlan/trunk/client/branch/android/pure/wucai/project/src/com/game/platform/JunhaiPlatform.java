package com.game.platform;

import org.cocos2dx.lib.Cocos2dxActivity;
import org.cocos2dx.lib.Cocos2dxLuaJavaBridge;

import com.ijunhai.sdk.common.util.SdkInfo;
import com.ijunhai.sdk.common.util.TimeUtil;

import org.json.JSONException;
import org.json.JSONObject;

import com.game.lib.LuaCallClass;
import com.game.lib.Utility;
import com.loopj.android.http.JsonHttpResponseHandler;
import com.loopj.android.http.RequestParams;

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

import prj.chameleon.channelapi.ChannelInterface;
import prj.chameleon.channelapi.Constants;
import prj.chameleon.channelapi.ExtraActionListener;
import prj.chameleon.channelapi.IAccountActionListener;
import prj.chameleon.channelapi.IDispatcherCb;
import java.util.HashMap;
public class JunhaiPlatform extends PlatformBase {  
		private final static String TAG = "JUNHAI_YOUYUN_TEST";
		private Cocos2dxActivity manActive;          
	    private String channelID = "";
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
	
	
	public JunhaiPlatform(){   
		  // 发送token到服务器，获取access_token, 用户信息等
   
	}
	
	@Override
	public void onStart(){
		super.onStart();   
	}

	public String reqChannelId()
	{
		return ChannelInterface.getChannelID();
	}
	
	@Override
	public boolean isVisitor(){   
		return guest==0;
	}
    
	@Override
	public void onResume(){
		super.onResume();
        ChannelInterface.onResume(manActive, new IDispatcherCb() {
            @Override
            public void onFinished(int retCode, JSONObject jsonObject) {

            }
        });
	} 
	
	@Override
	public void onPause(){        
		super.onPause(); 
		 ChannelInterface.onPause(manActive);
	} 
	
	@Override
	public void onStop() {
		 super.onStop();
		ChannelInterface.onStop(manActive);
	}
	
	public  void onNewIntent(Intent intent) {
        ChannelInterface.onNewIntent(manActive, intent);
	}

	@Override
	public void onDestroy() {
		super.onDestroy();   
		ChannelInterface.onDestroy(manActive);   
	}
	
	private void println(String s){
		System.out.println("==== ====ZhiShangPlatform " + s);  
	}
	
    
	public void onActivityResult(int requestCode,int resultCode, Intent data){
		super.onActivityResult(requestCode, resultCode, data);
		 ChannelInterface.onActivityResult(manActive, requestCode, resultCode, data);
	} 
	@Override
	public void onCreate(Cocos2dxActivity act){  
		super.onCreate(act);    
		manActive = act; 
	} 

	//平台 启动  
	public void platformLaunch(){  
        ChannelInterface.init(manActive, true, new IDispatcherCb(){
            @Override
            public void onFinished(int retCode, JSONObject jsonObject) {    
                Log.d(TAG, "init retCode:" + retCode);
                Log.d(TAG, "init json: " + jsonObject);
                Log.i(TAG, "after init, channel_id: " + ChannelInterface.getChannelID());

                if (Constants.ErrorCode.ERR_OK == retCode) {  
                    // initial ok
            		callLuaFunction("platformLaunchEnd","{status='ok'}");
                    gameId=SdkInfo.getInstance().getGameId();  
            		channelID = ChannelInterface.getChannelID();

                } else {
                    // initial error
                    Log.w(TAG, "init fail");
                }
            }
        });

        // 应用汇的特殊接口：在用户中心打开充值商场
        ChannelInterface.setExtraActionListener(new ExtraActionListener() {
            @Override
            public void onOpenShop(Activity activity) {
                Log.d(TAG, "test call openShop");
            }
        });
	} 
	
	public void platformLogin() {
		Log.d(TAG, "login finished, retCode=" + "sdk  login");
    	
    	mainAct.runOnUiThread( new Runnable(){
			public void run() { 
				try {
					ChannelInterface.login(manActive, new IDispatcherCb() {
						@Override
						public void onFinished(int retCode, JSONObject data) {
							Log.d(TAG, "login finished, retCode=" + retCode);
							Log.d(TAG, "login finished, json: " + data);
							try {
								if (Constants.ErrorCode.ERR_OK == retCode) {
									sdkLoginFinish(data);

								} else {
									Log.d(TAG, "login fail");
									// do something
								}

							}  catch (Exception e) {
								e.printStackTrace();
								Log.e(TAG, " login  exception");
							}
						}
					}, new IAccountActionListener() {
						@Override
						public void preAccountSwitch() {
							Log.d(TAG, "preAccountSwitch");
							// 帐号切换前 会调用这里的代码
						}

						@Override
						public void afterAccountSwitch(int i, JSONObject jsonObject) {
							Log.d(TAG, "afterAccountSwitch");
							// 帐号切换后 会调用这里的代码
						}

						@Override
						public void onAccountLogout() {
							Log.d(TAG, "onAccountLogout");
							// 用户退出. 游戏需要在这里执行退出账号的逻辑

							// 比如清除资源，重新登录等。
							// relogin();
							String arg = "{status='ok' }";
							callLuaFunction(PlatformEvent.GAME_LOGOUT, arg);
							game_logout_flag = 0;

						}

						@Override
						public void onGuestBind(JSONObject jsonObject) {
							Log.d(TAG, "onGuestBind");
							// 游客账户 绑定
						}
					});
				}
				catch (Exception e) {
					e.printStackTrace(System.out);
				}
			}} );
    	
	
	}
	
	public void sdkLoginFinish(JSONObject data)
	{
		try {
				Log.d(TAG, "login SUCCESS");
				channelID = (String) data.get("channel");
				uid = (String) data.get("uid");
				session_id = (String) data.get("session_id");
//				session_id = "adfge234534b\n\t345t aergartg";
				session_id = LuaCallClass.urlEncodeStr(session_id); 
				guest = (int) data.getLong("guest");
				user_name = (String) data.get("user_name");
				others = (String) data.get("others");
				String tempUserId = uid; 
				if (tempUserId == "")  
					tempUserId = user_name;
				String arg = "{status='ok',userInfo={userId='" + tempUserId + "',userType='',md5='" + session_id
						+ "',sessionId='" + session_id + "',status=1,accountid='" + uid + "' ,isEncodeMD5=1},channelID= '"
						+ channelID + "',gameId='" + gameId + "' }";

				callLuaFunction(PlatformEvent.LOGIN_END, arg);

			} 	catch (Exception e) {
				e.printStackTrace(System.out);
			} 

	}
	
	public void gameLogoutFinish(){
		if(game_logout_flag == 1)
		{
            reLogin();
			game_logout_flag = 0;
		}
		
	}
	
	public void antiAddicition()
	{
	  	mainAct.runOnUiThread( new Runnable(){
				public void run() {
					 ChannelInterface.antiAddiction(manActive, new IDispatcherCb() { 
			             @Override
			             public void onFinished(int retCode, JSONObject jsonObject) {       
			                 Log.d(TAG, "code=" + retCode + ", json=" + jsonObject);
			                 if (Constants.ErrorCode.ERR_OK == retCode) {
			                     Log.d(TAG, "antiAddiction ok");
			                     try {
			                    	 JSONObject content = jsonObject.getJSONObject("content");
			                    	 if(content!= null)
			                    	 {
			                    		String starus = (String)content.get("status");//starus :0 无此用户数据  1:未成年 2：已成年
			     						String arg = "{status='ok',result='"+starus + "' }";
			    						callLuaFunction(PlatformEvent.ANTIADDITION, arg);  
			                    	 }
			                   
			                     } catch (JSONException e) {
				                    e.printStackTrace();
				                    Log.e(TAG, "parse login response exception");
				                } catch (Exception e) {
				                    e.printStackTrace();
				                    Log.e(TAG, " login  exception");
				                }    
			                     
			                 } else {
			                     Log.d(TAG, "antiAddiction fail");
			                 }
			             }
			         });
				}});

	}
	
	public void realNameRegister()
	{
	  	mainAct.runOnUiThread( new Runnable(){
				public void run() {
					 ChannelInterface.realNameRegister(manActive, uid,new IDispatcherCb() {
			             @Override
			             public void onFinished(int retCode, JSONObject jsonObject) {       
			                 Log.d(TAG, "code=" + retCode + ", json=" + jsonObject);
			                 if (Constants.ErrorCode.ERR_OK == retCode) {
			                     Log.d(TAG, "realNameRegister ok");
									String arg = "{status='ok' }";
									callLuaFunction(PlatformEvent.REAL_NAME_REGISTRT, arg);  
			                     
			                 } else {
			                     Log.d(TAG, "realNameRegister fail");
			                 }
			             }
			         });   
				}});

	}
	
	public void notifySDK(final JSONObject userdata)
	{
	  	mainAct.runOnUiThread( new Runnable(){
				public void run() { 
			        HashMap<String, Object> data = new HashMap<String, Object>();       
			        
			        try { 
					        data.put(Constants.User.ACTION, userdata.getInt("action")); // 区服id
					        data.put(Constants.User.SERVER_ID, (String) userdata.get("serverID")); // 区服id
					        data.put(Constants.User.SERVER_NAME, (String) userdata.get("serverName")); // 区服名字
					        data.put(Constants.User.ROLE_ID, (String) userdata.get("roleID")); // 角色id
					        data.put(Constants.User.ROLE_NAME, (String) userdata.get("roleName")); // 角色名
					        data.put(Constants.User.ROLE_LEVEL, (String) userdata.get("roleLevel")); // 角色等级
					        data.put(Constants.User.VIP_LEVEL, (String) userdata.get("vipLevel")); // VIP 等级
					        data.put(Constants.User.BALANCE, (String) userdata.get("balance")); // 玩家游戏币总额， 如 100 金币
					        data.put(Constants.User.PARTY_NAME,userdata.getString("partyName")); // 帮派，公会名称。 若无，填 unknown
			        } catch (Exception e) {
			            e.printStackTrace();
			            Log.e(TAG, " login  exception");  
			        }
			        Log.d(TAG, "uploadUserInfo params: " + data.toString());
			        ChannelInterface.uploadUserData(manActive, data);
				}});

	}
	
    private void destroyGame() {  
        Log.d(TAG, "destroyGame");
        // 新版接口
//        ChannelInterface.onDestroy(manActive);
//        System.exit(0);
		String arg = "{status='ok'}";
		callLuaFunction(PlatformEvent.EXIT_GAME, arg);   
    }
    
	public void exit(JSONObject json){
		
		mainAct.runOnUiThread( new Runnable(){
			public void run() { 
				ChannelInterface.exit(manActive, new IDispatcherCb() {
		            @Override
		            public void onFinished(int retCode, JSONObject data) {
		                Log.i(TAG, "exit, retCode: " + retCode + ", json: " + data);
		                switch (retCode) {
		                    case Constants.ErrorCode.EXIT_NO_UI:
		                        Log.d(TAG, "渠道没有退出UI，游戏需要提供退出界面");
		                        // 渠道无退出UI，游戏自行处理
		                        // 示例
		                        final AlertDialog.Builder builder = new AlertDialog.Builder(manActive);
		                        builder.setPositiveButton("继续游戏", new DialogInterface.OnClickListener() {
		                            @Override
		                            public void onClick(DialogInterface dialog, int which) {
		                                dialog.dismiss();
		                            }
		                        }).setNegativeButton("退出游戏", new DialogInterface.OnClickListener() {
		                            @Override
		                            public void onClick(DialogInterface dialog, int which) {
		                                dialog.dismiss();
		                                destroyGame();
		                            }
		                        }).setMessage("确定要退出游戏吗?")  
		                                .create().show();
		                        break;
		                    case Constants.ErrorCode.EXIT_WITH_UI:
		                        Log.d(TAG, "渠道有退出UI，游戏根据 content 的判断用户的选择");
		                        int result = data.optInt("content", Constants.ErrorCode.CONTINUE_GAME);
		                        if (result == Constants.ErrorCode.CONTINUE_GAME) {
		                            // 用户选了 “继续游戏”
		                            Log.i(TAG, "continue game");
		                        } else {
		                            // 用户选了 “退出游戏”
		                            Log.i(TAG, "quit game");
		                            destroyGame();
		                        }
		                        break;
		                    default:
		                        // 出现异常
		                        destroyGame();
		                }
		            }
		        });
			}
		});
	}
	
	 /**
     * 注销账号，回到游戏登录界面
     */
	public void platformLogout() {      
        // 新版接口
	  	mainAct.runOnUiThread( new Runnable(){
				public void run() {   
					
					  ChannelInterface.logout(manActive, new IDispatcherCb() {
				            @Override
				            public void onFinished(int retCode, JSONObject data) {
				            	String arg = "{status='ok' }";
				                // data 一般为 null。调用data前，先断 data == null
				                switch (retCode) {
				                    case Constants.ErrorCode.LOGOUT_SUCCESS:
				                        Log.d(TAG, "channel logout success");
				                        // 清理前一个账户资源等
				            			
				            			callLuaFunction(PlatformEvent.GAME_LOGOUT, arg); 
				            			game_logout_flag = 1;
				                        // 示例。游戏根据实际情况处理
				                        break;
				                    case Constants.ErrorCode.LOGOUT_FAIL:
				                        Log.d(TAG, "channel logout fail");
				                        break;
				                    case Constants.ErrorCode.NO_LOGOUT_API:
				                        Log.d(TAG, "channel not support logout api");
				            			callLuaFunction(PlatformEvent.GAME_LOGOUT, arg); 
				            			game_logout_flag = 1;
				                }
				            }
				        });
				}});
      
    }
	
    private void reLogin() {          
        // 游戏自行处理重新登录的逻辑. 这里只是示例
        Log.i(TAG, "re login");
        platformLogin();
    }
    
	public void loginNotifySDK(final JSONObject params) {
	  	mainAct.runOnUiThread( new Runnable(){
				public void run() { 
					try{
						JSONObject data = new JSONObject();   
						String code = "1";
						String temp = (String)(params.get("ret"));
						if( temp.equals("1") )
							code = "0";
						data.put("code", code);
						JSONObject subdata = new JSONObject();
						subdata.put("uid", params.getJSONObject("content").get("user_id"));
						subdata.put("token",params.getJSONObject("content").get("access_token"));
						data.put("loginInfo",subdata );
					    ChannelInterface.onLoginRsp(data.toString());
					}catch(Exception e){
						e.printStackTrace(System.out);         
					}
				}});

}
    
    private int game_logout_flag = 0;
    public void changeAccount() {                    
        Log.i(TAG, "swithAccount");  
//        直接调用 switchAccount, 或者先判断渠道是否提供切换账号功能
	  	mainAct.runOnUiThread( new Runnable(){
				public void run() {
			        if (ChannelInterface.isSupportSwitchAccount()) {       
			            Log.i(TAG, "isSupportSwitchAccount true");
			            ChannelInterface.switchAccount(manActive, new IDispatcherCb() {  
			                @Override
			                public void onFinished(int retCode, JSONObject jsonObject) {           
			                    Log.d(TAG, "code=" + retCode + ", json=" + jsonObject);
			                    if (Constants.ErrorCode.ERR_OK == retCode) {
			                        Log.d(TAG, "switch account ok");   
			    					String arg = "{status='ok' }";
			    					callLuaFunction(PlatformEvent.GAME_LOGOUT, arg);  
			    					sdkLoginFinish(jsonObject);
			                        // todo
			                    } else {
			                        Log.d(TAG, "switch account fail");
			                    }
			                }
			            });
			        } else {
			        	platformLogout();
			            Log.i(TAG, "isSupportSwitchAccount false");
			        }
				}});

    }
    
    private void realNameRegist() {
	  	mainAct.runOnUiThread( new Runnable(){
				public void run() {
			        ChannelInterface.realNameRegister(manActive, uid, new IDispatcherCb() {
			            @Override
			            public void onFinished(int retCode, JSONObject jsonObject) {
			                Log.d(TAG, "retCode=" + retCode + ", json=" + jsonObject);
			            }
			        });
				}});

    }

    private void antiAddition() {
	  	mainAct.runOnUiThread( new Runnable(){
				public void run() {
				
			        ChannelInterface.antiAddiction(manActive, new IDispatcherCb() {
			            @Override
			            public void onFinished(int retCode, JSONObject jsonObject) {
			                Log.d(TAG, "retCode=" + retCode + ", json=" + jsonObject);
			                Toast.makeText(manActive, "retCode=" + retCode + ", json=" + jsonObject, Toast.LENGTH_LONG).show();
			            }
			        });
				}});

    }
	
    
	public void charge( final JSONObject json) throws JSONException{    

    	mainAct.runOnUiThread( new Runnable(){
			public void run() {         
				try {
			        if (!ChannelInterface.isLogined()) {                   
			            platformLogin();       
			            return;
			        }
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
			        Log.d(TAG, "test buy");      
				} catch (Exception e) {
					e.printStackTrace(System.out);             
				}
			        ChannelInterface.buy(manActive, orderId, roleID,
			                roleName, serverId, productName,
			                productID, payInfo, productCount, realPayMoney, callbackUrl
			                , new IDispatcherCb() {   
			                    @Override
			                    public void onFinished(int retCode, JSONObject jsonObject) {   
//			                        Log.d(TAG, "buy return Code: " + retCode);
//			                        Log.d(TAG, "buy json: " + jsonObject);
//			                        String arg = "{status='fail',productID =  }";
//			                        if (Constants.ErrorCode.ERR_OK == retCode) {
//			                            // 支付成功 以服务器通知为准, 客户端只做参考
//			                        	arg = "{status='ok', productID = '"+productID+"'}";
//			                        } else {
//			                            // 支付失败或正在处理
//			                        	arg = "{status='fail' }";
//			                        }
//			                        
//			    					callLuaFunction(PlatformEvent.CHARGE_END, arg);  
			                    }
			                });
				}
    		});
  
    }
    
}