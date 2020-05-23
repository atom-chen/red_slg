package com.game.platform;

import org.cocos2dx.lib.Cocos2dxActivity;
import org.json.JSONException;
import org.json.JSONObject;

import com.game.lib.Utility;

import android.content.Intent;
import android.view.KeyEvent;

//import com.wucai.mjyx.uc.R;
public class PlatformManager {
	private static PlatformBase platform = null;

	public static boolean canPhoneNumber = true;

	// 平台初始化
	static public void init() {
		String thisPackageName = PlatformManager.class.getPackage().getName();
		String platformName = thisPackageName + "." + Utility.getString("R", "string", "platformClass");
		System.out.print(platformName);
		try {
			Class<?> c = Class.forName(platformName);

			platform = (PlatformBase) c.newInstance();// new UC9GamePlatform();
		} catch (Exception e) {
			e.printStackTrace();
		}

		canPhoneNumber = platform.canGetPhoneNumber();
	}

	static public void onCreate(Cocos2dxActivity act) {
		platform.onCreate(act);
	}

	static public void onStart() {
		platform.onStart();
	}

	static public void onStop() {
		platform.onStart();
	}

	static public void gameLogoutFinish() {
		platform.gameLogoutFinish();
	}

	static public void onDestroy() {
		platform.onDestroy();
	}

	static public void loginNotifySDK(JSONObject params) {
		platform.loginNotifySDK(params);
	}

	static public void notifySDK(JSONObject params) {
		platform.notifySDK(params);
	}

	static public void onResume() {  
		platform.onResume();
	}

	static public void onPause() {  
		platform.onPause();
	}

	public static void charge(JSONObject json) throws JSONException{   
		platform.charge(json);
	}
	
	public static void uploadUserData(JSONObject params) {
		platform.uploadUserData(params);
	}

	static public boolean onKeyDown(int keyCode, KeyEvent event) {
		return platform.onKeyDown(keyCode, event);
	}

	static public void onActivityResult(int requestCode, int resultCode, Intent data) {
		platform.onActivityResult(requestCode, resultCode, data);
	}

	static public void onNewIntent(Intent intent) {
		platform.onNewIntent(intent);
	}

	// ----------------------------------------------------------------------------------------------------------------
	// 设置lua回调方法
	static public void setLuaCallback(final int callback) {
		platform.setLuaCallback(callback);
	}

	static public boolean isVisitor() { // 是否是访客
		return platform.isVisitor();
	}

	static public String reqChannelId() {
		return platform.reqChannelId();
	}

	// app启动
	static public void platformLaunch() {
		platform.platformLaunch();
	}

	// 平台是否有 登录的api
	static public boolean hasPlatformLoginAPI() {
		return platform.hasPlatformLoginAPI();
	}

	// 平台账号登录
	static public void platformLogin() {
		platform.platformLogin();
	}

	static public void exit(JSONObject params) {
		// platform.platformLogout();
		platform.exit(params);
	}

	// 切换账号
	static public void changeAccount() {
		platform.changeAccount();
	}

	// 设置用户信息
	static public void setUserInfo(String uid, String uname, String attach) {
		platform.setUserInfo(uid, uname, attach);
	}

	// 平台是否有 选服的api
	static public boolean hasChangeServerAPI() {
		return platform.hasChangeServerAPI();
	}
	
	static public String callStringMethod(String funcName, String params) {
		if (funcName == null) {
			System.out.println("PlatformManager static public String callStringMethod funcName is null");
			return "{exist=false}";
		}
		if (params == null) {
			System.out.println("PlatformManager static public String callStringMethod params is null");
			return "{exist=false,args=false}";
		}
		try {
			System.out
					.println("PlatformManager static public String callStringMethod(" + funcName + ", " + params + ")");
		} catch (Exception e) {
			e.printStackTrace(System.out);
		}

		return platform.callStringMethod(funcName, params);
	}

	// 选服
	static public void changeServer() {
		platform.changeServer();
	}

	// 游戏登录
	static public void loginGameServer(String sId, String sName) {
		platform.loginGameServer(sId, sName);
	}

	// 游戏登录之后通知sdk 已登录.
	static public void loginGameServerEnd(String sId, String sName) {
		platform.loginGameServerEnd(sId, sName);
	}

	// 游客绑定用户
	static public void bindUser() {
		platform.bindUser();
	}

	// 客服
	static public void csCenter(String roleName) {
		platform.csCenter(roleName);
	}

	// 是否显示平台图标
	static public void showPlatformIcon(boolean flag) {
		platform.showPlatformIcon(flag);
	}

	static public void antiAddicition() {
		platform.antiAddicition();
	}

	static public void realNameRegister() {
		platform.realNameRegister();
	}

}
