/****************************************************************************
Copyright (c) 2010-2013 cocos2d-x.org

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
package org.cocos2dx.lib;

import org.cocos2dx.lib.Cocos2dxHelper.Cocos2dxHelperListener;

import android.app.Activity;
import android.content.Context;
import android.content.res.Configuration;
import android.os.Build;
import android.os.Bundle;
import android.os.Message;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.util.Log;
import android.view.ViewGroup;
import android.widget.FrameLayout;


public abstract class Cocos2dxActivity extends Activity implements
		Cocos2dxHelperListener { 
	// ===========================================================
	// Constants
	// ===========================================================

	public static final int GLVIEW_ID = 1000;
	private static final String TAG = Cocos2dxActivity.class.getSimpleName();

	// ===========================================================
	// Fields
	// ===========================================================
	
	private Cocos2dxGLSurfaceView mGLSurfaceView;
	private Cocos2dxHandler mHandler;

	private static Context sContext = null; 
	
	private WakeLock mWakeLock = null;
	
	public static Context getContext() {
		return sContext;
	}
	
	// ===========================================================
	// Constructors
	// ===========================================================
	
	@Override 
	protected void onCreate(final Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		Log.d("Cocos2dxActivity", "Cocos2dxActivity ON CREATE");
		sContext = this;
		if(this.mHandler==null){
			this.mHandler = new Cocos2dxHandler(this);
	    	this.init();
	    	Cocos2dxHelper.init(this, this);
			this.acquireWakeLock();
		}
	}
	
	private void acquireWakeLock() {  
        if (mWakeLock == null) {  
               //Logger.d("Acquiring wake lock");  
               PowerManager pm = (PowerManager) getSystemService(Context.POWER_SERVICE);  
               mWakeLock = pm.newWakeLock(PowerManager.SCREEN_DIM_WAKE_LOCK, this.getClass().getCanonicalName());  
               mWakeLock.acquire();  
           }  
   }  
	
	private void releaseWakeLock() {  
        if (mWakeLock != null && mWakeLock.isHeld()) {  
        	mWakeLock.release();  
        	mWakeLock = null;  
        }  
  
    } 

	// ===========================================================
	// Getter & Setter
	// ===========================================================

	// ===========================================================
	// Methods for/from SuperClass/Interfaces
	// ===========================================================

	public void resumeGame() {
		if(!mIsRunning){
			mIsRunning = true;
			Cocos2dxHelper.onResume();
			this.mGLSurfaceView.onResume();
			Log.d(TAG, "RESUME COCOS2D");
		}
	}
	
	public void pauseGame() {
		if(mIsRunning){
			mIsRunning = false;
			Cocos2dxHelper.onPause();
			this.mGLSurfaceView.onPause();
			Log.d(TAG, "PAUSE COCOS2D");
		}
	}

	private boolean mIsRunning = false;

	@Override
	protected void onResume() {
		super.onResume();
		Log.d(TAG, "ACTIVITY ON RESUME");
		resumeGame();
		this.acquireWakeLock();
	}

	@Override
	protected void onPause() {
		super.onPause();
		Log.d(TAG, "ACTIVITY ON PAUSE");
		pauseGame();
		this.releaseWakeLock();
	}
	
	@Override 
	public void onWindowFocusChanged(final boolean hasWindowFocus){ 
		super.onWindowFocusChanged(hasWindowFocus); 
		Log.d(TAG, "ACTIVITY ON WINDOW FOCUS CHANGED " + (hasWindowFocus ? "true" : "false"));
//		if (hasWindowFocus && !mIsRunning) {
//			resumeGame();
//		}
	}
	
	@Override
	protected void onDestroy(){
		Log.d("Cocos2dxActivity", "onDestroy");
		this.releaseWakeLock();
		super.onDestroy();
	}
	
	@Override
	public void onConfigurationChanged(Configuration newConfig) {
		super.onConfigurationChanged(newConfig);
		Log.i("TAG","I'm Android 2.3");   
   
		}


	@Override
	public void showDialog(final String pTitle, final String pMessage) {
		Message msg = new Message();
		msg.what = Cocos2dxHandler.HANDLER_SHOW_DIALOG;
		msg.obj = new Cocos2dxHandler.DialogMessage(pTitle, pMessage);
		this.mHandler.sendMessage(msg);
	}

	@Override
	public void showEditTextDialog(final String pTitle, final String pContent,
			final int pInputMode, final int pInputFlag, final int pReturnType,
			final int pMaxLength) {
		Message msg = new Message();
		msg.what = Cocos2dxHandler.HANDLER_SHOW_EDITBOX_DIALOG;
		msg.obj = new Cocos2dxHandler.EditBoxMessage(pTitle, pContent,
				pInputMode, pInputFlag, pReturnType, pMaxLength);
		this.mHandler.sendMessage(msg);
	}
	
	@Override
	public void runOnGLThread(final Runnable pRunnable) {
		this.mGLSurfaceView.queueEvent(pRunnable);
	}
	 
	protected static FrameLayout mFrameLayout;
	// ===========================================================
	// Methods
	// ===========================================================
	public void init() {
		
    	// FrameLayout
		ViewGroup.LayoutParams framelayout_params = new ViewGroup.LayoutParams(
				ViewGroup.LayoutParams.FILL_PARENT,
                                       ViewGroup.LayoutParams.FILL_PARENT);
        mFrameLayout = new FrameLayout(this);
        mFrameLayout.setLayoutParams(framelayout_params);

        // Cocos2dxEditText layout
		 ViewGroup.LayoutParams edittext_layout_params =
            new ViewGroup.LayoutParams(ViewGroup.LayoutParams.FILL_PARENT,
                                       ViewGroup.LayoutParams.WRAP_CONTENT);
        Cocos2dxEditText edittext = new Cocos2dxEditText(this);
        edittext.setLayoutParams(edittext_layout_params);

        // ...add to FrameLayout
        mFrameLayout.addView(edittext);

        // Cocos2dxGLSurfaceView
        this.mGLSurfaceView = this.onCreateView();
        //set id for GlSurfaceView, so can find by id and set focus on
        this.mGLSurfaceView.setId(GLVIEW_ID);

        // ...add to FrameLayout
        mFrameLayout.addView(this.mGLSurfaceView);

        // Switch to supported OpenGL (ARGB888) mode on emulator
        if (isAndroidEmulator())
           this.mGLSurfaceView.setEGLConfigChooser(8 , 8, 8, 8, 16, 0);

        this.mGLSurfaceView.setCocos2dxRenderer(new Cocos2dxRenderer());
        this.mGLSurfaceView.setCocos2dxEditText(edittext);

        // Set framelayout as the content view
		setContentView(mFrameLayout);
		this.requestFocusView();
	}
	
    public Cocos2dxGLSurfaceView onCreateView() {
    	return new Cocos2dxGLSurfaceView(this); 
    }
    
    public void requestFocusView(){
    	this.mGLSurfaceView.requestFocus();
    }
    
	public void onKeyBackDown() {
		this.mGLSurfaceView.onKeyBackDown();
		return;
    }

   private final static boolean isAndroidEmulator() {
      String model = Build.MODEL;
      Log.d(TAG, "model=" + model);
      String product = Build.PRODUCT;
      Log.d(TAG, "product=" + product);
      boolean isEmulator = false;
      if (product != null) {
			isEmulator = product.equals("sdk") || product.contains("_sdk")
					|| product.contains("sdk_");
      }
      Log.d(TAG, "isEmulator=" + isEmulator);
      return isEmulator;
   }

	// ===========================================================
	// Inner and Anonymous Classes
	// ===========================================================
}
