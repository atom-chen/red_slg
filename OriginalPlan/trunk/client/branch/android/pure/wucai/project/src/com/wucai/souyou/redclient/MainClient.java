/****************************************************************************
Copyright (c) 2010-2012 cocos2d-x.org

http://www.cocos2d-x.org

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
 ****************************************************************************/
package com.wucai.souyou.redclient;

import org.cocos2dx.lib.Cocos2dxActivity;

import android.content.ComponentName;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.view.KeyEvent;

import com.game.lib.LuaCallClass;
import com.game.lib.PushService;
import com.game.platform.PlatformManager;

public class MainClient extends Cocos2dxActivity {

	private static Cocos2dxActivity that = null;

	public static Cocos2dxActivity getThis() {
		return that;
	}

	@Override
	public void onCreate(Bundle savedInstanceState) {
		System.out.println("public void onCreate(Bundle savedInstanceState)");
		super.onCreate(savedInstanceState);
		that = this;

		Intent service = new Intent(this, PushService.class); // 启动推送服务
		startService(service);

		LuaCallClass.init(this);
		if (Build.VERSION.SDK_INT >= 9) {
			setRequestedOrientation(6); // sdk 大于9的 支持 翻转
		}

		PlatformManager.init();
		PlatformManager.onCreate(this);
	}

	@Override
	protected void onDestroy() {
		Log.d("MainClient", "onDestroy");
		// Intent service = new Intent(this, PushService.class);
		// stopService(service);
		super.onDestroy();

		PlatformManager.onDestroy();
	}

	@Override
	protected void onStart() {
		super.onStart();
		PlatformManager.onStart();
	}

	@Override
	protected void onStop() {
		super.onStop();
		PlatformManager.onStop();
	}

	@Override
	protected void onResume() {
		super.onResume();
		PlatformManager.onResume();
	}

	@Override
	protected void onPause() {
		super.onPause();
		PlatformManager.onPause();
	}

	@Override
	public ComponentName getCallingActivity() {
		return this.getComponentName();
	}

	static {   
		try {    
			System.loadLibrary("game");                         
		} catch (Exception e) {          
			e.printStackTrace();         
			System.exit(0);
			// TODO: handle exception
		}
	}

	protected void onNewIntent(Intent intent) {                           
		super.onNewIntent(intent);
		PlatformManager.onNewIntent(intent);     
	}

	// // 重写return键
	// @Override
	// public boolean onKeyDown(int keyCode, KeyEvent event) {
	// if (keyCode == KeyEvent.KEYCODE_BACK){
	//// super.onKeyBackDown();
	// return false;
	// }
	// boolean flag = PlatformManager.onKeyDown(keyCode, event);
	// return flag;
	// }

	@Override
	public boolean dispatchKeyEvent(KeyEvent event) {         
		boolean flag = super.dispatchKeyEvent(event);
		if (event.getKeyCode() == KeyEvent.KEYCODE_BACK && event.getAction() == KeyEvent.ACTION_DOWN) {
			super.onKeyBackDown();
			return true;  
		}
		return flag;
	}

	// @Override
	// public void onBackPressed() {
	// super.onKeyBackDown();
	// return;
	// }

	@Override
	public void onActivityResult(int requestCode, int resultCode, Intent data) {
		super.onActivityResult(requestCode, resultCode, data);
		PlatformManager.onActivityResult(requestCode, resultCode, data);
	}

}
