package com.game.platform;

import org.cocos2dx.lib.Cocos2dxActivity;

import com.xiaomi.gamecenter.sdk.MiCommplatform;
import com.xiaomi.gamecenter.sdk.MiErrorCode;
import com.xiaomi.gamecenter.sdk.OnLoginProcessListener;
import com.xiaomi.gamecenter.sdk.entry.MiAccountInfo;
import com.xiaomi.gamecenter.sdk.entry.MiAppInfo;
import com.xiaomi.gamecenter.sdk.entry.ScreenOrientation;

public class MiPlatform extends PlatformBase {
	
	
	public boolean canGetPhoneNumber(){
		return false; 
	}
	
	@Override
	public void onCreate(Cocos2dxActivity act){  
		super.onCreate(act);     
		MiAppInfo appInfo = new MiAppInfo();
		appInfo.setAppId("2882303761517315237");
		appInfo.setAppKey("5231731528237"); 
		appInfo.setOrientation(ScreenOrientation.horizontal);
		MiCommplatform.Init( mainAct, appInfo );
	}

	
	//是否有平台登录 接口
	public boolean hasPlatformLoginAPI(){
		return true;
	} 
		
	//是否有选服api
	public boolean hasChangeServerAPI(){
		return false;
	}
		
	//平台登录
	public void platformLogin(){
		mainAct.runOnUiThread(new Runnable() {  
			public void run() {    
				MiCommplatform.getInstance().miLogin( mainAct, 
						new OnLoginProcessListener()
				{
					@Override
					public void finishLoginProcess( int code ,MiAccountInfo arg1)
					{
						String arg = "error"+"#:unknow";
						switch( code )
						{
							  case MiErrorCode.MI_XIAOMI_PAYMENT_SUCCESS:
								       // 登陆成功
								   //获取用户的登陆后的UID（即用户唯一标识）
								   long uid = arg1.getUid();
								             
								   /**以下为获取session并校验流程，如果是网络游戏必须校验，如果是单机游戏或应用可选**/
								   //获取用户的登陆的Session（请参考5.3.3流程校验Session有效性）
								   String session = arg1.getSessionId();
								   //请开发者完成将uid和session提交给开发者自己服务器进行session验证
								   arg = "ok"+"#:"+uid + "#|1#|0123456789abcdef0132456789abcdef#|" + session + "#|1";
							   		break;
							  case MiErrorCode.MI_XIAOMI_PAYMENT_ERROR_LOGIN_FAIL:
							   		// 登陆失败
								  	arg = "error"+"#:loginFail";
							   		break;
							  case MiErrorCode.MI_XIAOMI_PAYMENT_ERROR_CANCEL:
									// 取消登录
								  	arg = "error"+"#:loginCancel";
									break;
							  case MiErrorCode.MI_XIAOMI_PAYMENT_ERROR_ACTION_EXECUTED:	
								  //登录操作正在进行中
								  	break;		
							  default:
								  	arg = "error"+"#:loginFail";
						  					// 登录失败
							      	break;
							      	
						}
						callLuaFunction("platformLoginEnd",arg);
					}
				} ); 
			};     
		});
	}
	
	public boolean hasChangeAccount(){
		return false;
	}
	
	@Override
	public void changeAccount(){
		platformLogin();
	}


}




