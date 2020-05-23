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
	    private String callbackUrl = "www.test_callback_url.com"; // ����ӷ�������ȡ, ������д���ڴ�����
	    private String accessToken;
	
	
	public JunhaiPlatform(){   
		  // ����token������������ȡaccess_token, �û���Ϣ��
   
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

	//ƽ̨ ����  
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

        // Ӧ�û������ӿڣ����û����Ĵ򿪳�ֵ�̳�
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
							// �ʺ��л�ǰ ���������Ĵ���
						}

						@Override
						public void afterAccountSwitch(int i, JSONObject jsonObject) {
							Log.d(TAG, "afterAccountSwitch");
							// �ʺ��л��� ���������Ĵ���
						}

						@Override
						public void onAccountLogout() {
							Log.d(TAG, "onAccountLogout");
							// �û��˳�. ��Ϸ��Ҫ������ִ���˳��˺ŵ��߼�

							// ���������Դ�����µ�¼�ȡ�
							// relogin();
							String arg = "{status='ok' }";
							callLuaFunction(PlatformEvent.GAME_LOGOUT, arg);
							game_logout_flag = 0;

						}

						@Override
						public void onGuestBind(JSONObject jsonObject) {
							Log.d(TAG, "onGuestBind");
							// �ο��˻� ��
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
			                    		String starus = (String)content.get("status");//starus :0 �޴��û�����  1:δ���� 2���ѳ���
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
					        data.put(Constants.User.ACTION, userdata.getInt("action")); // ����id
					        data.put(Constants.User.SERVER_ID, (String) userdata.get("serverID")); // ����id
					        data.put(Constants.User.SERVER_NAME, (String) userdata.get("serverName")); // ��������
					        data.put(Constants.User.ROLE_ID, (String) userdata.get("roleID")); // ��ɫid
					        data.put(Constants.User.ROLE_NAME, (String) userdata.get("roleName")); // ��ɫ��
					        data.put(Constants.User.ROLE_LEVEL, (String) userdata.get("roleLevel")); // ��ɫ�ȼ�
					        data.put(Constants.User.VIP_LEVEL, (String) userdata.get("vipLevel")); // VIP �ȼ�
					        data.put(Constants.User.BALANCE, (String) userdata.get("balance")); // �����Ϸ���ܶ �� 100 ���
					        data.put(Constants.User.PARTY_NAME,userdata.getString("partyName")); // ���ɣ��������ơ� ���ޣ��� unknown
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
        // �°�ӿ�
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
		                        Log.d(TAG, "����û���˳�UI����Ϸ��Ҫ�ṩ�˳�����");
		                        // �������˳�UI����Ϸ���д���
		                        // ʾ��
		                        final AlertDialog.Builder builder = new AlertDialog.Builder(manActive);
		                        builder.setPositiveButton("������Ϸ", new DialogInterface.OnClickListener() {
		                            @Override
		                            public void onClick(DialogInterface dialog, int which) {
		                                dialog.dismiss();
		                            }
		                        }).setNegativeButton("�˳���Ϸ", new DialogInterface.OnClickListener() {
		                            @Override
		                            public void onClick(DialogInterface dialog, int which) {
		                                dialog.dismiss();
		                                destroyGame();
		                            }
		                        }).setMessage("ȷ��Ҫ�˳���Ϸ��?")  
		                                .create().show();
		                        break;
		                    case Constants.ErrorCode.EXIT_WITH_UI:
		                        Log.d(TAG, "�������˳�UI����Ϸ���� content ���ж��û���ѡ��");
		                        int result = data.optInt("content", Constants.ErrorCode.CONTINUE_GAME);
		                        if (result == Constants.ErrorCode.CONTINUE_GAME) {
		                            // �û�ѡ�� ��������Ϸ��
		                            Log.i(TAG, "continue game");
		                        } else {
		                            // �û�ѡ�� ���˳���Ϸ��
		                            Log.i(TAG, "quit game");
		                            destroyGame();
		                        }
		                        break;
		                    default:
		                        // �����쳣
		                        destroyGame();
		                }
		            }
		        });
			}
		});
	}
	
	 /**
     * ע���˺ţ��ص���Ϸ��¼����
     */
	public void platformLogout() {      
        // �°�ӿ�
	  	mainAct.runOnUiThread( new Runnable(){
				public void run() {   
					
					  ChannelInterface.logout(manActive, new IDispatcherCb() {
				            @Override
				            public void onFinished(int retCode, JSONObject data) {
				            	String arg = "{status='ok' }";
				                // data һ��Ϊ null������dataǰ���ȶ� data == null
				                switch (retCode) {
				                    case Constants.ErrorCode.LOGOUT_SUCCESS:
				                        Log.d(TAG, "channel logout success");
				                        // ����ǰһ���˻���Դ��
				            			
				            			callLuaFunction(PlatformEvent.GAME_LOGOUT, arg); 
				            			game_logout_flag = 1;
				                        // ʾ������Ϸ����ʵ���������
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
        // ��Ϸ���д������µ�¼���߼�. ����ֻ��ʾ��
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
//        ֱ�ӵ��� switchAccount, �������ж������Ƿ��ṩ�л��˺Ź���
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
//			                            // ֧���ɹ� �Է�����֪ͨΪ׼, �ͻ���ֻ���ο�
//			                        	arg = "{status='ok', productID = '"+productID+"'}";
//			                        } else {
//			                            // ֧��ʧ�ܻ����ڴ���
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