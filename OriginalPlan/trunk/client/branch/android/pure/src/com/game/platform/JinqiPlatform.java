package com.game.platform;

import java.util.ArrayList;
import java.util.List;

import org.cocos2dx.lib.Cocos2dxActivity;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.Intent;
import android.net.http.SslError;
import android.os.Bundle;
import android.util.Log;
import android.view.Gravity;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.View;
import android.view.View.OnTouchListener;
import android.webkit.SslErrorHandler;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;

import com.chartboost.sdk.Chartboost;
import com.efunfun.efunfunplatformbasesdk.dto.EfunfunServerInfo;
import com.efunfun.efunfunplatformbasesdk.dto.EfunfunUser;
import com.efunfun.efunfunplatformbasesdk.listener.EfunfunBindListener;
import com.efunfun.efunfunplatformbasesdk.listener.EfunfunChangeServiceListener;
import com.efunfun.efunfunplatformbasesdk.listener.EfunfunCheckVersionListener;
import com.efunfun.efunfunplatformbasesdk.listener.EfunfunLoginListener;
import com.efunfun.efunfunplatformbasesdk.listener.EfunfunPageCloseListener;
import com.efunfun.efunfunplatformbasesdk.listener.EfunfunUserServiceListener;
import com.efunfun.efunfunplatformbasesdk.util.EfunfunBasePlatform;
import com.efunfun.tw.mo.R;
import com.facebook.FacebookException;
import com.facebook.FacebookOperationCanceledException;
import com.facebook.HttpMethod;
import com.facebook.LoggingBehavior;
import com.facebook.Request;
import com.facebook.Response;
import com.facebook.Session;
import com.facebook.Session.OpenRequest;
import com.facebook.Session.StatusCallback;
import com.facebook.SessionState;
import com.facebook.Settings;
import com.facebook.model.GraphObject;   
import com.facebook.widget.WebDialog;
import com.facebook.widget.WebDialog.OnCompleteListener;
//台湾晶绮
public class JinqiPlatform extends PlatformBase { 
	private WebView m_webView = null;  
	private FrameLayout m_webLayout = null;
	private Button m_facebookButton; 
	private RelativeLayout m_bar = null;  
	private Button m_towBtn = null; 
	
	private int startX;    
	private int startY;
	private int lastX = 0;  
	private int lastY = 500;
	
	private int btnW = 52;
	private int btnH = 49; 
	private int barW = 197;
	private int barH = 53;
	
	
	@Override
	public void onStart(){
		super.onStart(); 
		Chartboost.onStart(mainAct);
	}
	
	@Override
	public boolean isVisitor(){
		if(userInfo != null){
			if(userInfo.getState().equals("1")){  //是游客
				return true;
			}else{
				return false;
			} 
		}else{
			return true; 
		}
	}
    
	@Override 
	public void onResume(){ 
		super.onResume();
//		com.facebook.AppEventsLogger.activateApp(mainAct);
		Chartboost.onResume(mainAct);
		switch(curStatus){
		case 1:
			platformLaunch();
			break; 
		case 3:
//			bindUser();
			break;
		case 4:
//			charge(money, roleName);
			break;
		}
	} 
	
	@Override
	public void onPause(){
		super.onPause(); 
//		com.facebook.AppEventsLogger.deactivateApp(mainAct); 
		Chartboost.onPause(mainAct);
	} 
	
	@Override
	public void onStop() {
		 super.onStop();
		 Chartboost.onStop(mainAct);
	}

	@Override
	public void onDestroy() {
		 super.onDestroy();    
		 Chartboost.onDestroy(mainAct);
	}

	
	@Override
	public void onCreate(Cocos2dxActivity act){  
		super.onCreate(act);     
		 
		Chartboost.startWithAppId(act, "54b4d28d04b01651d9521df8", "04f879c576135b261d9a2261bcc41e31afea36ee");
		Chartboost.onCreate(act); 
		
		EfunfunBasePlatform.initPlatform(act);  
	}
	
	@Override
	public boolean canGetPhoneNumber(){
		return false;
	}
	
	public void onActivityResult(int requestCode, int resultCode, Intent data){
		Session.getActiveSession().onActivityResult(mainAct, requestCode, resultCode, data);
	}
	
	private boolean initFBSession() {
		Settings.addLoggingBehavior(LoggingBehavior.INCLUDE_ACCESS_TOKENS);
		Session session = Session.getActiveSession();
		if (session == null) {
			if (session == null) {
				session = new Session(mainAct);
			}
			Session.setActiveSession(session);
			if (session.getState().equals(SessionState.CREATED_TOKEN_LOADED)) {
				session.openForRead(new Session.OpenRequest(mainAct).setCallback(loginCallback));
				return true;
			}
		}
		return false;
	}
	
	private void fbLogin() {
		Session session = Session.getActiveSession();
		if (!session.isOpened() && !session.isClosed()) {
//			Session.OpenRequest a = new Session.OpenRequest(mainAct);
//			List<String> permissions = new ArrayList<String>();
//	        permissions.add("user_friends");
//			a.setPermissions(permissions);
//			a.setCallback(loginCallback);
//			session.openForRead(a);
			session.openForRead(new Session.OpenRequest(mainAct).setCallback(loginCallback));
		} else {
			Session.openActiveSession(mainAct, true, loginCallback);
		}
	}
	
	private StatusCallback loginCallback =  new StatusCallback() {
	       @Override
	       public void call(Session session, SessionState state, Exception exception) {
	    	   Log.d("my facebook","call:"+session.isOpened());
	           if (session.isOpened())
	           {
	        	   reqFriends();
		      }
	       }
	};
	
	private StatusCallback permissionsCallback =  new StatusCallback() {
	       @Override
	       public void call(Session session, SessionState state, Exception exception) {
	    	   Log.d("my facebook","call:"+session.isOpened());
	           if (session.isOpened())
	           {
	        	   getFriends();
		      }
	       }
	};
	       
	private void loginFacebook(){
		boolean isInit = initFBSession();
		Session session = Session.getActiveSession();
		
		if(session == null){
			return;
		}
		if(!isInit){ 
			if (!session.isOpened()) {
				fbLogin();
			} else {
				if(!isInit){
					reqFriends();
				}
			}
		}
	}
	
	private void reqFriends(){
		//LoginManager.getInstance().logInWithReadPermissions(mainAct,Arrays.asList("read_friendlists"));
		
		Session session = Session.getActiveSession();
//		List<String> permissionssession.getPermissions();
		
		if (session.isPermissionGranted("user_friends") ){
			getFriends();
		}else{ 
			Log.d("my facebook","t requestNewReadPermissions");
			List<String> permissions = new ArrayList<String>();
	        permissions.add("user_friends");
	        session.removeCallback(loginCallback); 
	        session.addCallback(permissionsCallback);
	        Session.NewPermissionsRequest newPermissionsRequest = new Session.NewPermissionsRequest(mainAct, permissions);
			session.requestNewReadPermissions(newPermissionsRequest);
		}
	}
	
	private List<String> friendList = new ArrayList<String>();  
	private boolean hasFriendList = false;
	private boolean getFriends(){
		Session session = Session.getActiveSession();
		if (session.isPermissionGranted("user_friends") ){
			new Request(session,"/me/invitable_friends",null,HttpMethod.GET,new Request.Callback() {
				
	     	  	@Override
						public void onCompleted(Response response) {
							Log.d("my facebook Response","Response:"+response.toString());
							String str = "{status = 'error'}";
							GraphObject strTemp = response.getGraphObject();
							if (strTemp != null) {
								JSONObject jsonObject = strTemp.getInnerJSONObject();
								try {
									if (jsonObject.has("data")) {
										hasFriendList = true;
										str = "{status='ok',friends={";
										JSONArray array = jsonObject.getJSONArray("data");
										if (array != null && array.length() > 0) {
											for (int i = 0; i < array.length(); i++) {
												JSONObject fb_user = array.getJSONObject(i);
												if (fb_user.has("name") && fb_user.has("id")) {
													if (!friendList.contains(fb_user.getString("id"))) {
														friendList.add(fb_user.getString("id"));
													}
													
													str += "{id='"+fb_user.getString("id")+"',name='"+fb_user.getString("name")+"'";
													if(fb_user.has("picture")){
														JSONObject picObj = fb_user.getJSONObject("picture");
														if(picObj.has("data")){
															picObj = picObj.getJSONObject("data");
															if(picObj.has("url")){
																str += ",pic='"+picObj.getString("url")+"'";
															}
														}
													}   
													str +="},";
												}  
											} 
//											inviteFriend(friendList);
										} else {
											Log.d("my facebook Response","no friend");
										}
										str += "}}"; 
									}
								} catch (JSONException e) { 
									
								}
							} else { 
								  
							} 
							callLuaFunction(PlatformEvent.INVITE_FRIEND_LIST,str);
						}
	       			}
	     		  ).executeAsync();
			 return true;
		}else{
			return false;
		}
	}
	
	private String getIds(List<String> list) {
		if (list != null) {
			StringBuffer sb = new StringBuffer();
			for (String id : list) {
				sb.append(id);
				sb.append(",");
			}
			return sb.substring(0, sb.length() - 1).toString();
		}
		return "";
	}
	
	
	//获取 平台的邀请好友列表
	public void reqInviteFriendList(JSONObject json){
			mainAct.runOnUiThread(new Runnable() {  
				public void run() {    
					loginFacebook();
				};   
			});
	}
	
	private boolean inviteAll = false;
	private String inviteId = "";
	public void inviteFriends(JSONObject json) throws JSONException{
		final JSONObject js = json;
		mainAct.runOnUiThread(new Runnable() {  
			public void run() {    
			try{
				if(js.has("isAll") && js.getBoolean("isAll")){
					inviteAll = true;
					inviteFriend(friendList,js.getString("des")); 
				}else if(js.has("id")){ 
					inviteAll = false;
					String id = js.getString("id");
					inviteId = id;
					List<String> idList = new ArrayList<String>();
					idList.add(id); 
					inviteFriend(idList,js.getString("des")); 
				}
			}catch(JSONException e){
				
			};
			};
		});
	}
	
	private void inviteFriend(List<String> list,String des) {
		Log.d("my facebook inviteFriend","inviteFriend:"+list.size());
		Bundle params = new Bundle();
		params.putString("message", des);
		params.putString("to", getIds(list));
		WebDialog requestsDialog = (new WebDialog.RequestsDialogBuilder(mainAct, Session.getActiveSession(), params)).setOnCompleteListener(new OnCompleteListener() {
			@Override
			public void onComplete(Bundle values, FacebookException error) {
				if (error != null) {
					Log.d("my facebook inviteFriend","inviteFriend:"+error.toString());
					if (error instanceof FacebookOperationCanceledException) {
						
					} else {
						
					}
				} else {
					String result=null;
					if(inviteAll){
						result = "{status='ok',isAll=true}";
					}else if(inviteId!=null && inviteId != ""){
						result = "{status='ok',isAll=false,id='"+inviteId+"'}";
					}
					if(result!=null){
						callLuaFunction(PlatformEvent.INVITE_FRIEND,result);
					}
//					final String requestId = values.getString("request");
//					if (requestId != null) {
//						
//					} else {
//						
//					}
				}
			}
		}).build();
		requestsDialog.show();
	}
	
	public void loginFacebook1(){
		List<String> permissions = new ArrayList<String>();
        permissions.add("read_friendlists");
        Log.d("my facebook","loginFacebook");
        StatusCallback callback = new StatusCallback() {
		       @Override
		       public void call(Session session, SessionState state, Exception exception) {
		    	   Log.d("my facebook","call:"+session.isOpened());
		           if (session.isOpened())
		           {
		        	   getFriends();
		        	  Log.d("my facebook","token:"+session.getAccessToken());
		             
			      }
		       }
		 };
		
		OpenRequest op = new Session.OpenRequest(mainAct).setPermissions(permissions).setCallback(callback);
        //如果不想出現登入畫面，讓使用者去略過權限，就不加入setLoginBehavior
//        op.setLoginBehavior(SessionLoginBehavior.SUPPRESS_SSO);
       //加入權限
       
       Session session = Session.getActiveSession();
       if(session == null){
    	   session = new Session.Builder(mainAct).build();
//    	   if (SessionState.CREATED_TOKEN_LOADED.equals(session.getState())){
    		   Log.d("my facebook","session:open");
    			Session.setActiveSession(session);
    	   		session.openForPublish(op);
//       		}else{
//       			Log.d("my facebook","session:not open");
//       		}
       }else{
    	   Log.d("my facebook","session: already has");
//    	   if (session.isOpened()) {
//               if (!session.isPermissionGranted(permission)) {
//                   session.requestNewPublishPermissions(new NewPermissionsRequest(
//                           MyActivity.this, PERMISSIONS));
//                   
//           }   
//    	   session.addCallback(callback);
//    	   Session.NewPermissionsRequest newPermissionsRequest = new Session.NewPermissionsRequest(mainAct, permissions);
//    	   session.requestNewPublishPermissions(newPermissionsRequest); 
       } 
	}
	
//--------------------------------------------------------------------------------------	
	private int curStatus = 0;   
	@Override
	public void platformLaunch(){ 
		mainAct.runOnUiThread(new Runnable() {  
			public void run() {    
				initWebLayout();
//				loginFacebook();
			};   
		});
		curStatus = 1;  
		EfunfunBasePlatform.getInstance().efunfunAdAndVersion(mainAct, versionListener);
	}
	 
	//平台监测 版本回调
	private EfunfunCheckVersionListener versionListener = new EfunfunCheckVersionListener(){ 
		@Override
		public void onCheckVersionResult(int resultCode,boolean is_success) { 
			curStatus = 0;
			if (resultCode == 200 && is_success) //成功进入
			{
				callLuaFunction(PlatformEvent.LUANCH_END,"{status='ok'}");
				//版本檢查通過。  
				return;
			}
			 
			if (resultCode == 300 && !is_success)   
			{    
				callLuaFunction(PlatformEvent.LUANCH_END,"{status='verError'}");
				//提示信息用戶並退出遊戲 
				return;    
			}
			if (resultCode == 400 && !is_success)  
			{ 
				callLuaFunction(PlatformEvent.LUANCH_END,"{status='exit'}");
				//游戏本身也要结束
				//退出游戏（）;这里不需要任何信息 
				return;
			}
			
			callLuaFunction(PlatformEvent.LUANCH_END,"{status='ok'}");  //直接进去     游戏有自己的版本控制
		};
	};
	
	@Override
	//平台登录 override
	public void platformLogin(){ 
		EfunfunBasePlatform.getInstance().efunfunLogin(mainAct,loginListener);
	} 
	
	//用户信息
	private EfunfunUser userInfo = null;
	//服务器信息 
	private EfunfunServerInfo serverInfo = null;
	//登录回调
	private EfunfunLoginListener loginListener = new EfunfunLoginListener(){
		@Override
		//登录成功
		public void onLoginResult(EfunfunUser user,EfunfunServerInfo sInfo) {
			userInfo = user;  //保存用户信息
			String arg = "{status='ok',userInfo="+getUserInfoString();
			if(sInfo != null){
				serverInfo = sInfo;
				arg += ",serverInfo="+getServerInfoString();
			}else{
				changeServer();  //没服务器信息  切换到选服
			}
			arg += "}";
			callLuaFunction(PlatformEvent.LOGIN_END,arg);
		};
	};
	
	//切换账号
	@Override
	public void changeAccount(){
		EfunfunBasePlatform.getInstance().efunfunSwitchAccount(mainAct);
	}
	
	//选服
	@Override
	public void changeServer(){
		if(userInfo != null){
			EfunfunBasePlatform.getInstance().efunfunChangeService(mainAct, userInfo,changeServiceListener);
		}
	}
	
	private EfunfunChangeServiceListener changeServiceListener = new EfunfunChangeServiceListener(){
		@Override
		public void changeSuccess(EfunfunServerInfo server){
			serverInfo = server;
			String arg = "{status='ok',serverInfo="+getServerInfoString()+"}";
			callLuaFunction(PlatformEvent.CHANGE_SERVER_END,arg);
		};
	};
	
	//进入游戏服
	public void loginGameServer(String sId,String sName){
		if(userInfo == null || serverInfo == null){
			//这时候没有 用户信息
		}else{
			EfunfunBasePlatform.getInstance().efunfunUserServiceLogin(mainAct, userInfo, serverInfo, gameServerListener);
		} 
	}
	
	private EfunfunUserServiceListener gameServerListener = new EfunfunUserServiceListener(){
		//登录游戏服
		
//		-1 : 驗證錯誤，提示錯誤信息。
//		0：開放 ，進入遊戲（只有此值的時候，讓用戶進入遊戲）
//		1、關閉 ，提示信息
//		2、維護 ，提示信息
//		3、未開服，提示信息 
		public void onUserServiceResult(int resultCode, String message,EfunfunServerInfo sInfo) {
			if(resultCode == 0){  //成功登录
				String arg = "{status='ok'";
				if(sInfo != null){ 
					serverInfo = sInfo;
					arg += ",serverInfo="+getServerInfoString();
				}  
				arg += "}";
				callLuaFunction(PlatformEvent.LOGIN_GAME_END,arg);
			}else{
				String arg = "{status='error',errorCode="+Integer.toString(resultCode)+",errorMsg='"+message+"'}";
				callLuaFunction(PlatformEvent.LOGIN_GAME_END,arg); 
			}
		};
	};
	
	//游客绑定
	public void bindUser(){
		if(userInfo != null){
			curStatus = 3;
			EfunfunBasePlatform.getInstance().efunfunBindGuestUser(mainAct, bindListener,userInfo);
		}
	}
	
	private EfunfunBindListener bindListener = new EfunfunBindListener(){
		public void onBindResult(EfunfunUser user) {
			curStatus = 0;
			if(user == null){  //已经是绑定用户了
				callLuaFunction("bindUserEnd","{status='error'}");
			}else{  //绑定成功 
				userInfo = user;
				String arg = "{status='ok',userInfo="+getUserInfoString()+"}";
				callLuaFunction(PlatformEvent.BING_USER_END,arg);
			}
		};
	};
	
	//充值    name  游戏角色名
	@Override
	public void charge(JSONObject json) throws JSONException{
//		int money = (int)json.getDouble("money");
		String roleName = json.getString("roleName");
		curStatus = 4;
		EfunfunBasePlatform.getInstance().efunfunPay(mainAct,userInfo,serverInfo,roleName,bindListener,chargeListener);	
	}
	
	private EfunfunPageCloseListener chargeListener = new EfunfunPageCloseListener(){
		public void onPageClosed(int code) {  //充值页面关闭
			curStatus = 0; 
			callLuaFunction(PlatformEvent.CHARGE_END,"{status='ok'}"); 
		};
	};
	
	//客服 
	public void csCenter(String roleName){ 
		EfunfunBasePlatform.getInstance().efunfunCSCenter(mainAct,userInfo,serverInfo,roleName,bindListener);
	}
	
	private String getServerInfoString(){
    	if(serverInfo!= null){ 
    		//"serverId","sName","IP","port","md5","status"
    		String sId = analysisServerId(serverInfo.getServerid());
    		return "{serverId="+sId +",sName='"+serverInfo.getName()+"',IP='"+serverInfo.getAddress()+"',port='"+serverInfo.getPort()
					+"',md5='"+serverInfo.getMd5()+"',status='"+serverInfo.getStatus()+"'}";
    	}else{  
    		return ""; 
    	}
    }
    
    private String getUserInfoString(){
    	if(userInfo!= null){
    		return "{userId='"+userInfo.getLoginId()+"',userType='"+userInfo.getUserType()+"',md5='"+userInfo.getValue()
    				+"',sessionId='"+userInfo.getSessionid()+"',status='"+userInfo.getState()+"'}";
    	}else{ 
    		return "";
    	}
    } 
    
    
    private String analysisServerId(String sId){
    	String id = "";
    	for(int i=sId.length()-1;i>=0;i--)
        {
	        char x=sId.charAt(i);
	        if(Character.isDigit(x)==true){
	        	id = x + id;
	        }else{
	        	break;
	        }
        }
    	Log.i("serverId",id);
    	return id;
    }
    
    @Override
    public void showPlatformIcon(boolean flag){
    	final boolean f = flag;
    	mainAct.runOnUiThread(new Runnable() {
			public void run() {  
				if(f){ 
					m_bar.setVisibility(0);
				}else{
					m_bar.setVisibility(8);
				}
			}  
		});
	}

    private void initWebLayout(){      
		if(m_webLayout != null){    
			return;
		}        
		Log.d("jinqi", "initActivity");
		//初始化一个空布局 
	    
		 
        m_webLayout = new FrameLayout(mainAct); 
        FrameLayout.LayoutParams lytp = new FrameLayout.LayoutParams(FrameLayout.LayoutParams.FILL_PARENT,FrameLayout.LayoutParams.FILL_PARENT);
        mainAct.addContentView(m_webLayout, lytp); 
          
        barW = dip2px(barW);  
        barH = dip2px(barH);
        
        m_bar = new RelativeLayout(mainAct); 
        FrameLayout.LayoutParams lypt=new FrameLayout.LayoutParams(FrameLayout.LayoutParams.WRAP_CONTENT, FrameLayout.LayoutParams.WRAP_CONTENT);
        lypt.gravity = Gravity.LEFT|Gravity.TOP; 
        m_webLayout.addView(m_bar,lypt);    
        
		m_facebookButton = new Button(mainAct);  
		m_facebookButton.setBackgroundResource(R.drawable.facebook); 
		
		btnW = dip2px(btnW);
		btnH = dip2px(btnH);
		
		RelativeLayout.LayoutParams lypt2 =new RelativeLayout.LayoutParams(btnW,btnH);
		lypt2.leftMargin = 0;  
		m_facebookButton.setLayoutParams(lypt2); 
		
        lastX = lypt2.width/2;
        lastY = mainAct.getWindowManager().getDefaultDisplay().getHeight()*3/4;
        this.updateBarPos();
        
        m_facebookButton.setOnTouchListener(touchListener);
        m_facebookButton.setLongClickable(true);  
          
        
        m_towBtn = new Button(mainAct);   
        RelativeLayout.LayoutParams lypt3 =new RelativeLayout.LayoutParams(barW,barH);
        lypt3.leftMargin = 0;  
        m_towBtn.setBackgroundResource(R.drawable.facebookbar);
        m_towBtn.setLayoutParams(lypt3);  
		m_bar.addView(m_towBtn);   
		
		
		m_towBtn.setVisibility(8);   
		m_towBtn.setOnTouchListener(touchListener2);
		m_towBtn.setLongClickable(true); 
		
		
		m_bar.addView(m_facebookButton);
		
//		m_bar.getBackground().setAlpha(60);
	} 
	
	private OnTouchListener touchListener2 = new OnTouchListener() {
		@Override
		public boolean onTouch(View v, MotionEvent event) {
			int action = event.getAction();
			 
			int x = (int) event.getX();
			int y = (int) event.getY();  
			
			   
			switch (action) { 
				case MotionEvent.ACTION_UP: 
					int w = m_towBtn.getMeasuredWidth();
					//int h = m_towBtn.getMeasuredHeight();
					if(x > w/3 && x < w*2/3){
						m_url = "https://www.facebook.com/efunfun.moa";
					}else if(x > w*2/3){
						m_url = "http://www.mofang.com.tw/mo/";
					}
					if(m_webView != null){
						m_webView.loadUrl(m_url);
					}else{
						openWebview();
					}
					break;
			}
			return true;
		}
	};
	
	private OnTouchListener touchListener = new OnTouchListener() {
	@Override
		public boolean onTouch(View v, MotionEvent event) {
			// TODO Auto-generated method stub
			int action = event.getAction();
			 
			int x = (int) event.getRawX();
			int y = (int) event.getRawY(); 
			
			  
			switch (action) {
				// 鼠标按下 拖拉动作开始
				case MotionEvent.ACTION_DOWN: 
					startX = x;   
					startY = y; 
				    break;   
				 
				// 鼠标移动 拖拉动作进行中
				case MotionEvent.ACTION_MOVE:
//					m_bar.getBackground().setAlpha(100);
					if( Math.abs(x-startX)+Math.abs(y-startY) > 10){
						if(m_towBtn.getVisibility() == 0){
							m_towBtn.setVisibility(8);
						}
					}
					if(x < btnW/2){
						x = btnW/2;
					} 
					if(y < btnH/2){ 
						y = btnH/2;
					} 
					int screenWidth = mainAct.getWindowManager().getDefaultDisplay().getWidth(); // 屏幕宽（像素，如：480px）  
					int screenHeight = mainAct.getWindowManager().getDefaultDisplay().getHeight();
					int bw = barW;
					if(m_towBtn.getVisibility() != 0){ 
						bw = btnW;
					}
					if( x+ bw/2 > screenWidth){
						x = screenWidth - bw/2; 
					} 
					if( y+ btnH/2 > screenHeight){
						y = screenHeight - btnH/2;
					}  
					 
					lastX = x;  
					lastY = y;
					mainAct.runOnUiThread(new Runnable() {
						public void run() {  
							updateBarPos();
						} 
					});
				    break;
				// 鼠标释放 拖拉动作结束
				case MotionEvent.ACTION_UP:
					if( Math.abs(x-startX)+Math.abs(y-startY) < 10){
						if(m_towBtn.getVisibility() != 0){
							m_towBtn.setVisibility(0);
//							m_bar.getBackground().setAlpha(100);
						}else{
							if(m_webView != null){
								removeWebView();
							}else{
								m_towBtn.setVisibility(8);
//								m_bar.getBackground().setAlpha(60);
							}  
						}
					}
					int sWidth = mainAct.getWindowManager().getDefaultDisplay().getWidth();
					
					if(x < sWidth/2){  //靠近左边
						lastX = btnW/2;	
					}else{ 
						
						if(m_towBtn.getVisibility() == 0){  //可见
							lastX = sWidth - barW + btnW/2;
						}else{
							lastX = sWidth - btnW/2;
						}
					}
					mainAct.runOnUiThread(new Runnable() {
						public void run() {  
							updateBarPos();
						} 
					}); 
					break;
			}
			return true;
		}
	
	};
	
	//重写return键
    public boolean onKeyDown(int keyCode,KeyEvent event)
    {
    	
    	if(m_webView != null && keyCode == KeyEvent.KEYCODE_BACK){
	    	//如果网页能回退则后退，如果不能后退移除WebView
	    	if(m_webView.canGoBack()){
	            m_webView.goBack();
	        }else{
	            removeWebView();
	        }
	    	return true;
    	}
        return false;      
    }
    
    private String m_url;
    //打开页面
    public void openWebview() {
    	if(m_webView != null){ 
    		return;
    	}
    	mainAct.runOnUiThread(new Runnable() {//在主线程里添加别的控件
            public void run() {
                //初始化webView 
                m_webView = new WebView(mainAct);
//                m_webView.setWebViewClient(new WebViewClient(){   
//                	  
//                	public void onReceivedSslError(WebView view, SslErrorHandler handler, SslError error){   
//                	handler.proceed();//接受证书   
//                	};
//                }
//                );
                	
                //设置webView能够执行javascript脚本
                m_webView.getSettings().setJavaScriptEnabled(true);            
                //设置可以支持缩放
                m_webView.getSettings().setSupportZoom(true);//设置出现缩放工具
                m_webView.getSettings().setBuiltInZoomControls(true);
                //载入URL
                m_webView.loadUrl(m_url);
                //使页面获得焦点 
                m_webView.requestFocus(); 
                //如果页面中链接，如果希望点击链接继续在当前browser中响应
                m_webView.setWebViewClient(new WebViewClient(){
                    public boolean shouldOverrideUrlLoading(WebView view, String url) {   
                        if(url.indexOf("tel:")<0){
                            view.loadUrl(url); 
                        }   
                        return true;    
                    }    
                });   
                  
                m_webLayout.addView(m_webView,0); 
//                m_webLayout.removeView(m_facebookButton);
//                m_webLayout.addView(m_facebookButton);
                mainAct.pauseGame();
            } 
        });
    }
    
    //移除webView
    private void removeWebView() {     
    	mainAct.runOnUiThread(new Runnable() {//在主线程里添加别的控件
            public void run() {
            	
            m_webLayout.removeView(m_webView);
	        m_webView.destroy();
	        m_webView=null;
	        
	        mainAct.requestFocusView();
	        
//	        m_webLayout.setVisibility(4);
	        
	        updateBarPos();
	          
	        mainAct.resumeGame();
            }
    	});
        //m_facebookButton.layout(lastX,  lastY, lastX+m_facebookButton.getMeasuredWidth(),  lastY+m_facebookButton.getMeasuredHeight());
    }
     
    private void updateBarPos(){
    	FrameLayout.LayoutParams lypt=new FrameLayout.LayoutParams(LinearLayout.LayoutParams.WRAP_CONTENT, LinearLayout.LayoutParams.WRAP_CONTENT);
        lypt.gravity = Gravity.LEFT|Gravity.TOP; 
//        lypt.width = 100;
//        lypt.height = 100;
        lypt.leftMargin = lastX - btnW/2;
        lypt.topMargin = lastY - btnH/2;
        m_bar.setLayoutParams(lypt);
    }
    
    
    public int dip2px(float dpValue) {  
        final float scale = mainAct.getResources().getDisplayMetrics().density;  
        return (int) (dpValue * scale + 0.5f);  
    }  

    /** 
     * 根据手机的分辨率从 px(像素) 的单位 转成为 dp 
     */  
    public int px2dip(float pxValue) {  
        final float scale = mainAct.getResources().getDisplayMetrics().density;  
        return (int) (pxValue / scale + 0.5f);  
    }  

  
}
