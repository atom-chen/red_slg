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
	private String gamename = "��������֮ս";
	���ǣ�����ʱ�����޸�AsdkPublisher.txt���ֵΪasdk_hbtr_001
///**/

///* test
	private String cpid = "100079";
	private String gameid = "100122";
	private String gamekey = "12fhd5748sasuh47";
	private String gamename = "��������֮ս";
	//������ʶ��asdk_test_001
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
							//	Toast.makeText(mainAct, "��¼ʧ��", Toast.LENGTH_SHORT).show();
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

		// ��ȥ��������Ӧ�ó�������֣�
	//	mainAct.requestWindowFeature(Window.FEATURE_NO_TITLE);
	//	mainAct.setContentView(Utility.getInt("R", "layout", "first"));
		
		// ��ȥ״̬������(��ص�ͼ���һ�����β���)
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
	 * ��¼
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
	 * ��ֵ
	 * @param view
	 */

	protected long lastClickTime;

	// ��Ч����¼�
	// 3�����ظ������Ч
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
	//ƽ̨��¼ override
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
					//�����ţ��ص�URL����ֵ����Ʒ��������Ϸ�Զ������
					m_out.pay(mainAct, System.currentTimeMillis() + "" + json.getString("money"), json.getString("payUrl"), json.getString("money"), "���", "ttf", gamekey);
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
//		PaymentInfo pInfo = new PaymentInfo(); //����Payment�������ڴ��ݳ�ֵ��Ϣ
//		pInfo.setAllowContinuousPay(true); //���óɹ��ύ�������Ƿ������û�����		��ֵ��Ĭ��Ϊtrue��
//		
//		//pInfo.setCustomInfo("custOrderId=PX299392#ip=139.91.192.29#... "); 
//		//���ó�ֵ�Զ���������˲��������κδ����ڳ�ֵ��ɺ�֪ͨ��Ϸ��������ֵ���ʱԭ�ⲻ������
//		//��Ϸ���������˲���Ϊ��ѡ������Ĭ��Ϊ�ա�
//		
//		//pInfo.setServerId(json.getInt("serverId")); 
//		//���ó�ֵ����Ϸ������ID����Ϊ��ѡ������Ĭ����0����
//	//	���û�����Ϊ0 ʱ�� ��ʹ�ó�ʼ��ʱ���õķ�����ID�� ����ʹ����ȷ��IDֵ��UC�����serverId��
//	//	�ſ��Դ�֧��ҳ�档��ʹ����ȷID���޷���ʱ�����ڿ���ƽ̨����Ƿ��Ѿ������˶�Ӧ����
//	//	��ӦID�Ļص���ַ�����������ã����е����޷�֧������ϵUC�����ӿ��ˡ�
//	
//		pInfo.setRoleId(json.getString("roleId")); 
//		//�����û�����Ϸ��ɫ��ID�� ��Ϊ��ѡ������ �����ʵ��ҵ
//	//	�����ݴ�����ʵ����
//	
//		pInfo.setRoleName(json.getString("roleName")); //�����û�����Ϸ��ɫ���֣� ��Ϊ��ѡ������ �����ʵ��ҵ�����ݴ�����ʵ����
//		//pInfo.setGrade(json.getString("roleLevel")); //�����û�����Ϸ��ɫ�ȼ�����Ϊ��ѡ����
//		
//		float amount = (float)json.getDouble("money");
//		pInfo.setAmount(amount);
//		
//		final PaymentInfo ppInfo = pInfo;
//		//���������ֵ�Ľ���Ϊ��ѡ������Ĭ��Ϊ0�������
//		//���˴˽�Ϊ0�����ʾֻ�����û���ָ������ֵ�������ָ������ָ��Ϊ0�����ʾ�û�
//		//�ڳ�ֵʱ��������ѡ�������ϣ������Ľ�
//	//	pInfo.setTransactionNumCP("XXXXXX"); // ����CP���еĶ����ţ���Ϊ��ѡ����
//		mainAct.runOnUiThread(new Runnable(){
//				public void run(){
//					try {
//						m_sdk.pay(mainAct.getApplicationContext(), ppInfo,
//						new UCCallbackListener<OrderInfo>() {
//							@Override
//							public void callback(int statuscode,OrderInfo orderInfo) {
//							//	println("pay callback"+statuscode+" "+orderInfo.toString());
//								if (statuscode == UCGameSDKStatusCode.NO_INIT) {
//								//û�г�ʼ���ͽ��е�¼���ã���Ҫ��Ϸ����SDK��ʼ������    
//								}
//								if (statuscode == UCGameSDKStatusCode.SUCCESS){
//									//�ɹ���ֵ
//									if (orderInfo != null) {
////										String ordered = orderInfo.getOrderId(); //��ȡ������
////										float amount = orderInfo.getOrderAmount(); //��ȡ������� 
////										int payWay = orderInfo.getPayWay(); //��ȡ��ֵ���ͣ�����ɲο�֧��ͨ�������б� 
////										String payWayName = orderInfo.getPayWayName(); //��ֵ���͵���������
//										 
//									}
//								}
//								if (statuscode == UCGameSDKStatusCode.PAY_USER_EXIT) {
//								//�û��˳���ֵ���档
//								}
//							}
//						});
//					} catch (UCCallbackListenerNullException e) {
//						//�쳣����
//						e.printStackTrace(System.out);
//					}catch(Exception e){
//						e.printStackTrace(System.out);
//					} 
//				}
//		}); 
	}
	
	
}