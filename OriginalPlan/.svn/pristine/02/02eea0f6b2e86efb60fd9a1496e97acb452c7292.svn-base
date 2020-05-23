package com.game.platform;

import org.cocos2dx.lib.Cocos2dxActivity;
import org.json.JSONException;
import org.json.JSONObject;

import com.game.lib.Utility;

import android.os.Handler;
import android.os.RemoteException;
//import android.widget.Toast;

import fly.fish.aidl.OutFace;
import fly.fish.aidl.OutFace.FlyFishSDK;


//import cn.uc.gamesdk.IUCBindGuest;
//import cn.uc.gamesdk.UCBindGuestResult;
//import cn.uc.gamesdk.GameUserLoginResult;
//import cn.uc.gamesdk.IGameUserLogin;



public class ZhiShangPlatform extends PlatformBase { 

//
/* normal
	private String cpid = "100079";
	private String gameid = "100189";
	private String gamekey = "bcdb0304efb2f8c4";
	private String gamename = "霍比特人之战";
	谨记：出包时，请修改AsdkPublisher.txt里的值为asdk_hbtr_001
///**/

///* test
	private String cpid = "100079";
	private String gameid = "100122";
	private String gamekey = "12fhd5748sasuh47";
	private String gamename = "霍比特人之战";
	//渠道标识：asdk_test_001
//*/
 
	private OutFace m_out;
	private boolean isinit;
	
	
	ZhiShangPlatform(){
		
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
		super.onDestroy();   
	}
	
	private void println(String s){
		System.out.println("==== ====ZhiShangPlatform " + s);
	}
	
	
	@Override
	public void onCreate(Cocos2dxActivity act){  
		super.onCreate(act);     
		
//		mainAct.runOnUiThread(new Runnable(){
//			public void run(){
//				try{
//					createUI();
//				}
//				catch(Exception e)
//				{
//					e.printStackTrace();
//				}
//			}
//		});
	}
	public FlyFishSDK m_callback = new FlyFishSDK() {

		@Override
		public void initback(String status) throws RemoteException {
			println("initback ----> " + status);
			String result;
			if ("0".equals(status)){
				isinit = true;
				result = "{status='ok'}";
			}
			else
			{
				result = "{status='error',errorMsg='"+status+"'}";
			}
			callLuaFunction(PlatformEvent.LUANCH_END, result);
		}

		
		
		
		@Override
		public void loginback(String sessionid, String accountid, String status, String customstring) throws RemoteException {
			println("loginback ----> " + sessionid + " = " + accountid + " = " + status + " = " + customstring);
			final String sid = sessionid;
			final String uid = accountid;
			final String fstatus = status;
			mainAct.runOnUiThread(new Runnable(){
					public void run(){
						String arg = "{status='error'}";
						try{
							if ("0".equals(fstatus))
							{
								m_handler.sendEmptyMessage(0);
								arg = "{status='ok',userInfo={userId='"+uid + "',userType='',md5='"+sid+"',sessionId='" + sid + "',status=1,accountid='"+uid+"'}}";
							}
							else
							{
							//	Toast.makeText(mainAct, "登录失败", Toast.LENGTH_SHORT).show();
							}
						}
						catch(Exception e)
						{
							e.printStackTrace();
						}
						callLuaFunction(PlatformEvent.LOGIN_END, arg);
					}
				});

		}

		@Override
		public void payback(String msg, String status, String sum, String chargetype, String customorgerid, String customstring) throws RemoteException {
			println("payback ----> " + msg + " = " + status + " = " + sum + "=" + chargetype + " = " + customorgerid + " = " + customstring);
		}

		@Override
		public void queryback(String status, String sum, String chargetype, String customstring) throws RemoteException {
			println("queryback ----> " + status + " = " + sum + "=" + chargetype + " = " + customstring);
		}

	};
	
	Handler m_handler = new Handler() {
		public void handleMessage(android.os.Message msg) {
//				
//				mainAct.runOnUiThread(new Runnable(){
//					public void run(){
//						try{
			
						println("Handler m_handler = new Handler() { set ScrollView }"+msg.what);
							switch (msg.what) {
							case 0:
								m_out.outInGame("");// userinfo
							//	mainAct.setContentView(Utility.getInt("R", "layout", "main"));//Utility.getString("R", "string", "platformClass")
								break;
							case 2:
							//	mainAct.setContentView(Utility.getInt("R", "layout", "first"));
								break;
							default:
								break;
							}
//						}
//						catch(Exception e)
//						{
//							e.printStackTrace();
//						}
////					}
//				});

		};
	};
	
	private void createUI() {

		// 隐去标题栏（应用程序的名字）
	//	mainAct.requestWindowFeature(Window.FEATURE_NO_TITLE);
	//	mainAct.setContentView(Utility.getInt("R", "layout", "first"));
		
		// 隐去状态栏部分(电池等图标和一切修饰部分)
	//	mainAct.getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
		 
		
		m_out = OutFace.getInstance(mainAct);
		try {
			m_out.callBack(m_callback, gamekey);
			m_out.init(cpid, gameid, gamekey, gamename);
			
		} catch (RemoteException e) {
			e.printStackTrace();
		}

	}

	

	/**
	 * 登录
	 * @param view
	 */
	
	public void login1() {
		if (isValidHits()) {
			try {
				if (isinit) {
					println("login");
					m_out.login(mainAct, "yyf", gamekey);
					
					
				} else {
					println("m_out.init(cpid, gameid, gamekey, gamename);");
					m_out.init(cpid, gameid, gamekey, gamename);
				}

			} catch (RemoteException e) {
				e.printStackTrace();
			}catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
	}

	/**
	 * 充值
	 * @param view
	 */

	protected long lastClickTime;

	// 有效点击事件
	// 3秒内重复点击无效
	protected boolean isValidHits() {
		if (System.currentTimeMillis() - lastClickTime > 1000) {
			lastClickTime = System.currentTimeMillis();
			return true;
		}
		return false;
	}

	
	private void initFloatButton()
	{
	}
	
	private void initSDK()
	{
//		String result = "{status='ok'}";
	//	callLuaFunction(PlatformEvent.LUANCH_END, result);
		createUI();
	}
	
	@Override
	public void platformLaunch(){ 
		println("============ loguc9game platformLaunch=============");
		mainAct.runOnUiThread(new Runnable(){
			public void run(){
				initSDK();
			}
		});
	}
	
	
	@Override
	//平台登录 override
	public void platformLogin(){
		println("------------------------------paltformLogin");
		mainAct.runOnUiThread(new Runnable(){
		public void run(){
			try{
				login1();
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
	});
	}
	
	@Override
	public void platformLogout(){
		
	}


	public void loginGameServerEnd(String sId, String sName){
		println("------------------------------loginGameServerEnd sid:" + sId + " sname:" + sName);
		//m_sdk.notifyZone(sName, m_roleId, m_roleName);
		
	}

    
    @Override
    public void showPlatformIcon(boolean flag){
//    	final boolean f = flag;
//    	mainAct.runOnUiThread(new Runnable() {
//			public void run() {  
//				try{
//					println("============ loguc9game showPlatformIcon"+ (f?"true":"false"));
//					m_sdk.showFloatButton(mainAct, 100, 50, f);
//				}catch(Exception e)
//				{	
//					e.printStackTrace();
//				}
//			}
//		});
	}
    
    @Override
	public void notifySDK(JSONObject params) {
		try{
			JSONObject json = new JSONObject();
			String serverName = params.getString("serverName");
			String roleId = params.getString("roleId");
			String roleName = params.getString("roleName");
			String vipLevel = params.getString("vipLevel");
			if(roleName.equals("")){
				roleName = "uname";
			}
			
			json.put("ingot", 0);
			json.put("playerId", roleId);
			json.put("playerName", roleName);
			json.put("playerLevel", params.getString("roleLevel"));
			
			json.put("vipLevel", vipLevel);
			json.put("factionName", "none");
			
			json.put("serverId", params.getInt("serverId"));
			json.put("serverName", serverName);
			println("notify sdk" + json.toString());
			m_out.outInGame(json.toString());

		}catch(Exception e){
			e.printStackTrace(System.out);
		}
	}
	
	@Override
	public void logout(JSONObject json){
		try{
			//m_sdk.logout();
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
					String arg;
					if(f){
						arg = "{status='ok',sendToServer=1}";
					}
					else{
						arg = "{status='ok',sendToServer=0}";
					}
					
					m_out.quit(mainAct);
					callLuaFunction(PlatformEvent.EXIT_GAME, arg);
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
				
			}
		});

	}
	
	
	public void pay(final JSONObject json) {
		if (isValidHits()) {
			try {
				if (isinit) {
					//订单号，回调URL，充值金额，商品描述，游戏自定义参数
					m_out.pay(mainAct, System.currentTimeMillis() + "" + json.getString("money"), json.getString("payUrl"), json.getString("money"), "金币", "ttf", gamekey);
				} else {
					m_out.init(cpid, gameid, gamekey, gamename);
				}

			} catch (RemoteException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	}

	
	
	@Override
	public void charge(JSONObject json) throws JSONException{
			final JSONObject fjson = json;
			mainAct.runOnUiThread(new Runnable(){
			public void run(){
				try{
					pay(fjson);
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
			}
		});
//		PaymentInfo pInfo = new PaymentInfo(); //创建Payment对象，用于传递充值信息
//		pInfo.setAllowContinuousPay(true); //设置成功提交订单后是否允许用户连续		充值，默认为true。
//		
//		//pInfo.setCustomInfo("custOrderId=PX299392#ip=139.91.192.29#... "); 
//		//设置充值自定义参数，此参数不作任何处理，在充值完成后通知游戏服务器充值结果时原封不动传给
//		//游戏服务器。此参数为可选参数，默认为空。
//		
//		//pInfo.setServerId(json.getInt("serverId")); 
//		//设置充值的游戏服务器ID，此为可选参数，默认是0，不
//	//	设置或设置为0 时， 会使用初始化时设置的服务器ID。 必须使用正确的ID值（UC分配的serverId）
//	//	才可以打开支付页面。如使用正确ID仍无法打开时，请在开放平台检查是否已经配置了对应环境
//	//	对应ID的回调地址，如无请配置，如有但仍无法支付请联系UC技术接口人。
//	
//		pInfo.setRoleId(json.getString("roleId")); 
//		//设置用户的游戏角色的ID， 此为必选参数， 请根据实际业
//	//	务数据传入真实数据
//	
//		pInfo.setRoleName(json.getString("roleName")); //设置用户的游戏角色名字， 此为必选参数， 请根据实际业务数据传入真实数据
//		//pInfo.setGrade(json.getString("roleLevel")); //设置用户的游戏角色等级，此为可选参数
//		
//		float amount = (float)json.getDouble("money");
//		pInfo.setAmount(amount);
//		
//		final PaymentInfo ppInfo = pInfo;
//		//设置允许充值的金额，此为可选参数，默认为0。如果设
//		//置了此金额不为0，则表示只允许用户按指定金额充值；如果不指定金额或指定为0，则表示用户
//		//在充值时可以自由选择或输入希望充入的金额。
//	//	pInfo.setTransactionNumCP("XXXXXX"); // 设置CP自有的订单号，此为可选参数
//		mainAct.runOnUiThread(new Runnable(){
//				public void run(){
//					try {
//						m_sdk.pay(mainAct.getApplicationContext(), ppInfo,
//						new UCCallbackListener<OrderInfo>() {
//							@Override
//							public void callback(int statuscode,OrderInfo orderInfo) {
//							//	println("pay callback"+statuscode+" "+orderInfo.toString());
//								if (statuscode == UCGameSDKStatusCode.NO_INIT) {
//								//没有初始化就进行登录调用，需要游戏调用SDK初始化方法    
//								}
//								if (statuscode == UCGameSDKStatusCode.SUCCESS){
//									//成功充值
//									if (orderInfo != null) {
////										String ordered = orderInfo.getOrderId(); //获取订单号
////										float amount = orderInfo.getOrderAmount(); //获取订单金额 
////										int payWay = orderInfo.getPayWay(); //获取充值类型，具体可参考支付通道编码列表 
////										String payWayName = orderInfo.getPayWayName(); //充值类型的中文名称
//										 
//									}
//								}
//								if (statuscode == UCGameSDKStatusCode.PAY_USER_EXIT) {
//								//用户退出充值界面。
//								}
//							}
//						});
//					} catch (UCCallbackListenerNullException e) {
//						//异常处理
//						e.printStackTrace(System.out);
//					}catch(Exception e){
//						e.printStackTrace(System.out);
//					} 
//				}
//		}); 
	}
	
	
}