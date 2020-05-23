package com.game.platform;

import java.util.HashMap;
import java.util.Map;

import org.cocos2dx.lib.Cocos2dxActivity;
import org.json.JSONException;
import org.json.JSONObject;

import cn.uc.gamesdk.UCGameSDK;
import cn.uc.gamesdk.UCLoginFaceType;
import cn.uc.gamesdk.UCOrientation;
import cn.uc.gamesdk.info.FeatureSwitch;
import cn.uc.gamesdk.info.GameParamInfo;
import cn.uc.gamesdk.info.OrderInfo;
import cn.uc.gamesdk.info.PaymentInfo;

import cn.uc.gamesdk.UCCallbackListener;
import cn.uc.gamesdk.UCCallbackListenerNullException;
import cn.uc.gamesdk.UCLogLevel;
import cn.uc.gamesdk.UCGameSDKStatusCode;

//import cn.uc.gamesdk.IUCBindGuest;
//import cn.uc.gamesdk.UCBindGuestResult;
//import cn.uc.gamesdk.GameUserLoginResult;
//import cn.uc.gamesdk.IGameUserLogin;



//台湾晶绮
public class UC9GamePlatform extends PlatformBase { 
	public final Map<String, Boolean> m_api = new HashMap<String, Boolean>();
	private UCGameSDK m_sdk = UCGameSDK.defaultSDK(); 
	
	UC9GamePlatform(){
	}
	
	@Override
	public void onStart(){ 
		super.onStart(); 
	}
						
	
	@Override
	public boolean isVisitor(){
		return false;
	}
    
	@Override
	public void onResume(){
		super.onResume();
	} 
	
	@Override
	public void onPause(){ 
		super.onPause(); 
	} 
	
	@Override
	public void onStop() {
		 super.onStop();
	}

	@Override
	public void onDestroy() {
		m_sdk.destoryFloatButton(mainAct);
		super.onDestroy();   
	}
	
	
	@Override
	public void onCreate(Cocos2dxActivity act){  
		super.onCreate(act);     
				
	}
	
	private void initFloatButton()
	{
		mainAct.runOnUiThread(new Runnable(){
			public void run(){
				try{
					UCCallbackListener<String> sdkListener = new UCCallbackListener<String>() {
						@Override
						public void callback(int statuscode, String data) {
							if(statuscode == UCGameSDKStatusCode.SDK_OPEN){
							//将要打开SDK界面
							}else if(statuscode == UCGameSDKStatusCode.SDK_CLOSE){
							//将要关闭SDK界面，返回游戏画面
							}
						}
					};
					m_sdk.createFloatButton(mainAct,
						sdkListener);
					m_sdk.showFloatButton(mainAct, 100, 50, true);
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
			}
		});
	}
	
	private void initSDK()
	{
		System.out.println("============ loguc9game initSDK=============");
		GameParamInfo gpi = new GameParamInfo();
		gpi.setCpId(0);//0 51894
		gpi.setServerId(0);
		gpi.setGameId(553138);
		gpi.setFeatureSwitch(new FeatureSwitch(true, false));
		
		try{
		//	UCGameSDK.setCurrentActivity(mainAct);

	//		UCCallbackListener<String> ucBindGuest;	// todo
			
		//	m_sdk.bindGuest(ucBindGuest); 
			m_sdk.setOrientation(UCOrientation.LANDSCAPE);
			
			UCCallbackListener<String> logoutListener = new UCCallbackListener<String>() {
				@Override
				public void callback(int statuscode, String data) {
					switch (statuscode) {
					case UCGameSDKStatusCode.NO_INIT:
						System.out.println("============ loguc9game logoutListener NO_INIT=============");
					//	……   
					break;
					case UCGameSDKStatusCode.NO_LOGIN:
					//	……  
						System.out.println("============ loguc9game logoutListener NO_LOGIN=============");
					break;
					case UCGameSDKStatusCode.SUCCESS:
					//		……
						System.out.println("============ loguc9game logoutListener SUCCESS=============");
					break;
					case UCGameSDKStatusCode.FAIL:
					//		……
						System.out.println("============ loguc9game logoutListener FAIL=============");
					break;
					default:
					//			……
						System.out.println("============ loguc9game logoutListener default=============");
					break;
					}
				}
			};
			//对于需要支持账户切换/退出账号的游戏，必须在此设置退出侦听器
			m_sdk.setLogoutNotifyListener(logoutListener);
			
			m_sdk.setLoginUISwitch(UCLoginFaceType.USE_WIDGET);//USE_STANDARD
			
			m_sdk.initSDK(mainAct,
					UCLogLevel.DEBUG, 
					false, 
					gpi, 
					new UCCallbackListener<String>() {
						@Override
						public void callback(int code, String msg) {
							System.out.println("msg:" + msg);//返回的消息
							String result = "{status='error',errorMsg='"+msg+"'}";
							switch (code) {
								case UCGameSDKStatusCode.SUCCESS:
								//初始化成功,可以执行后续的登录充值操作
									initFloatButton();
									System.out.println("============ loguc9game initListener SUCCESS=============");
									result = "{status='ok'}";
								break;
								case UCGameSDKStatusCode.INIT_FAIL:
								//初始化失败,不能进行后续操作
									System.out.println("============ loguc9game initListener INIT_FAIL=============");
								break;
								default:
									System.out.println("============ loguc9game initListener default=============");
//									IUCBindGuest ucBindGuest = new IUCBindGuest() {
//										@Override
//										public UCBindGuestResult bind(String sid) {
//											//将sid传给游戏服务器，由游戏服务器获得UC号（UCID） ，并进行试玩账号绑定
//											//		……
//											UCBindGuestResult bindResult = new UCBindGuestResult();
//											boolean success = true;
//											bindResult.setSuccess(success); //设置绑定成功与否，success是一个布尔值，由游戏服务器的绑定结果决定true或false。
//											return bindResult;
//										}
//									};
								 

								}
							callLuaFunction(PlatformEvent.LUANCH_END, result);
							}
					});
			}catch(Exception e)
			{
				e.printStackTrace();
			}
		
	}
	
	@Override
	public void platformLaunch(){ 
		System.out.println("============ loguc9game platformLaunch=============");
		mainAct.runOnUiThread(new Runnable(){
			public void run(){
				initSDK();
			}
			
		});
	}
	
	@Override
	//平台登录 override
	public void platformLogin(){
		System.out.println("------------------------------paltformLogin");
		mainAct.runOnUiThread(new Runnable() {//在主线程里添加别的控件
            public void run() {
	        //mainAct.resumeGame();
           
				try {
					m_sdk.login(mainAct,
					new UCCallbackListener<String>() {
						@Override
						public void callback(int code, String msg) {
							System.out.println("------------------------------paltformLogin callback("+code+")"+msg);
							String arg = "";
							if (code == UCGameSDKStatusCode.SUCCESS) {
								String sid = m_sdk.getSid();  //保存用户信息
								System.out.println("m_sdk.login sid:"+sid);
								if(sid == null || sid == ""){
									arg = "{status='error'}";
								}else{
									arg = "{status='ok',userInfo={userId='"+sid + "',userType='',md5='asdfg12345',sessionId='" + sid + "',status=1}}";
								}
		//					local userInfo = {"userId","userType","md5","sessionId","status"}
		//						local serverInfo = {"serverId","sName","IP","port","md5","status"}
							}else if (code == UCGameSDKStatusCode.NO_INIT) {
								//没有初始化就进行登录调用，需要游戏调用SDK初始化方法 
								arg = "{status='error'}"; 
							}else{ 
								return; 
							}
							//if (code == UCGameSDKStatusCode.LOGIN_EXIT) {
							//登录界面关闭，游戏需判断此时是否已登录成功进行相应操作
								//arg = "error"+"#:login_exit"+msg;  
							//	return;
							//}							
							callLuaFunction(PlatformEvent.LOGIN_END, arg);
						}
					},
		//			new IGameUserLogin() {
		//				@Override
		//				public GameUserLoginResult process(String userName, String password) {
		//					//根据userName、password参数到“游戏服务器”进行登录验证
		//				//	...
		//					//登录结果
		//					GameUserLoginResult loginResult = new GameUserLoginResult();
		//					if (/*游戏服务器返回登录成功*/) {
		//					//游戏服务器返回结果中应包含sid
		//					loginResult.setLoginResult(UCGameSDKStatusCode.SUCCESS);
		//					loginResult.setSid(/*sid*/);
		//					} else {
		//					loginResult.setLoginResult(UCGameSDKStatusCode.LOGIN_GAME_USER_AUTH_FAIL);
		//					}
		//				return loginResult;
		//				}
		//			}, 
					null,
					"游戏官方账号");
				} catch (UCCallbackListenerNullException e) {
					//异常处理
					System.out.println("------------------------------paltformLogin UCCallbackListenerNullException");
				}
			 }
    	});
	}
	
	@Override
	public void platformLogout(){
		
	}


	public void loginGameServerEnd(String sId, String sName){
		System.out.println("------------------------------loginGameServerEnd sid:" + sId + " sname:" + sName);
		m_sdk.notifyZone(sName, m_roleId, m_roleName);
	}

    
    @Override
    public void showPlatformIcon(boolean flag){
    	final boolean f = flag;
    	mainAct.runOnUiThread(new Runnable() {
			public void run() {  
				try{
					System.out.println("============ loguc9game showPlatformIcon"+ (f?"true":"false"));
					m_sdk.showFloatButton(mainAct, 100, 50, f);
				}catch(Exception e)
				{	
					e.printStackTrace();
				}
			}
		});
	}
    
    @Override
	public void notifySDK(JSONObject params) {
		try{
			JSONObject json = new JSONObject();
			String serverName = params.getString("serverName");
			String roleId = params.getString("roleId");
			String roleName = params.getString("roleName");
			if(roleName.equals("")){
				roleName = "uname";
			}
			json.put("roleId", roleId);
			json.put("roleName", roleName);
			json.put("roleLevel", params.getString("roleLevel"));
			json.put("zoneId", params.getInt("serverId"));
			json.put("zoneName", serverName);
			
			m_sdk.notifyZone(serverName, roleId, roleName);
					 
			m_sdk.submitExtendData("loginGameRole", json);
		}catch(Exception e){
			e.printStackTrace(System.out);
		}
	}
	
	@Override
	public void logout(JSONObject json){
		try{
			m_sdk.logout();
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
	
	@Override
	public void exit(JSONObject json)
	{
		boolean sendToServer;
		try {
			sendToServer = json.getInt("sendToServer") != 0;
		} catch (JSONException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			sendToServer = false;
		}
		final boolean f = sendToServer;
		mainAct.runOnUiThread(new Runnable(){
			public void run(){
				try{
					UCCallbackListener<String> listener = new UCCallbackListener<String>() {
						@Override
						public void callback(int statuscode, String data) {
							System.out.println(String.format("UC9GamePlatform exit %d %s", statuscode, data));
							switch(statuscode){
								case UCGameSDKStatusCode.SDK_EXIT:
								{
									String arg;
									if(f){
										arg = "{status='ok',sendToServer=1}";
									}
									else{
										arg = "{status='ok',sendToServer=0}";
									}
									callLuaFunction(PlatformEvent.EXIT_GAME, arg);
								}
								break;
								case UCGameSDKStatusCode.SDK_EXIT_CONTINUE:
								{
									
								}
								break;
							}
						}
					};
					
					m_sdk.exitSDK(mainAct, listener);
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
				
			}
		});

	}
	
	@Override
	public void charge(JSONObject json) throws JSONException{
		PaymentInfo pInfo = new PaymentInfo(); //创建Payment对象，用于传递充值信息
		pInfo.setAllowContinuousPay(true); //设置成功提交订单后是否允许用户连续		充值，默认为true。
		
		//pInfo.setCustomInfo("custOrderId=PX299392#ip=139.91.192.29#... "); 
		//设置充值自定义参数，此参数不作任何处理，在充值完成后通知游戏服务器充值结果时原封不动传给
		//游戏服务器。此参数为可选参数，默认为空。
		
		//pInfo.setServerId(json.getInt("serverId")); 
		//设置充值的游戏服务器ID，此为可选参数，默认是0，不
	//	设置或设置为0 时， 会使用初始化时设置的服务器ID。 必须使用正确的ID值（UC分配的serverId）
	//	才可以打开支付页面。如使用正确ID仍无法打开时，请在开放平台检查是否已经配置了对应环境
	//	对应ID的回调地址，如无请配置，如有但仍无法支付请联系UC技术接口人。
	
		pInfo.setRoleId(json.getString("roleId")); 
		//设置用户的游戏角色的ID， 此为必选参数， 请根据实际业
	//	务数据传入真实数据
	
		pInfo.setRoleName(json.getString("roleName")); //设置用户的游戏角色名字， 此为必选参数， 请根据实际业务数据传入真实数据
		//pInfo.setGrade(json.getString("roleLevel")); //设置用户的游戏角色等级，此为可选参数
		
		float amount = (float)json.getDouble("money");
		pInfo.setAmount(amount);
		
		final PaymentInfo ppInfo = pInfo;
		//设置允许充值的金额，此为可选参数，默认为0。如果设
		//置了此金额不为0，则表示只允许用户按指定金额充值；如果不指定金额或指定为0，则表示用户
		//在充值时可以自由选择或输入希望充入的金额。
	//	pInfo.setTransactionNumCP("XXXXXX"); // 设置CP自有的订单号，此为可选参数
		mainAct.runOnUiThread(new Runnable(){
				public void run(){
					try {
						m_sdk.pay(mainAct.getApplicationContext(), ppInfo,
						new UCCallbackListener<OrderInfo>() {
							@Override
							public void callback(int statuscode,OrderInfo orderInfo) {
							//	System.out.println("pay callback"+statuscode+" "+orderInfo.toString());
								if (statuscode == UCGameSDKStatusCode.NO_INIT) {
								//没有初始化就进行登录调用，需要游戏调用SDK初始化方法    
								}
								if (statuscode == UCGameSDKStatusCode.SUCCESS){
									//成功充值
									if (orderInfo != null) {
//										String ordered = orderInfo.getOrderId(); //获取订单号
//										float amount = orderInfo.getOrderAmount(); //获取订单金额 
//										int payWay = orderInfo.getPayWay(); //获取充值类型，具体可参考支付通道编码列表 
//										String payWayName = orderInfo.getPayWayName(); //充值类型的中文名称
										 
									}
								}
								if (statuscode == UCGameSDKStatusCode.PAY_USER_EXIT) {
								//用户退出充值界面。
								}
							}
						});
					} catch (UCCallbackListenerNullException e) {
						//异常处理
						e.printStackTrace(System.out);
					}catch(Exception e){
						e.printStackTrace(System.out);
					} 
				}
		}); 
	}
}