package com.game.platform;

import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.concurrent.atomic.AtomicBoolean;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.cocos2dx.lib.Cocos2dxActivity;
import org.json.JSONArray;
import org.json.JSONException;  
import org.json.JSONObject;

import com.android.vending.billing.IInAppBillingService;
import com.example.android.trivialdrivesample.util.IabHelper;
import com.example.android.trivialdrivesample.util.IabResult;
import com.example.android.trivialdrivesample.util.Inventory;
import com.example.android.trivialdrivesample.util.Purchase;
import com.example.android.trivialdrivesample.util.IabHelper.QueryInventoryFinishedListener;
import com.game.lib.Utility;
import com.game.lib.XmlCfg;
import com.google.android.gms.auth.GoogleAuthUtil;
import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GoogleApiAvailability;
import com.google.android.gms.common.Scopes;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.Scope;
import com.google.android.gms.common.api.GoogleApiClient.ServerAuthCodeCallbacks.CheckResult;
import com.google.android.gms.plus.Plus;
import com.google.android.gms.plus.model.people.Person;
import com.wucai.souyou.mjyxgame.MainClient;

import android.accounts.AccountManager;
import android.app.Activity;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.IntentSender;
import android.content.ServiceConnection;
import android.os.Bundle;
import android.os.IBinder;
import android.text.TextUtils;
import android.util.Log;


//台湾晶绮
public class KoreaPlatform extends PlatformBase implements GoogleApiClient.ConnectionCallbacks,GoogleApiClient.OnConnectionFailedListener{ 
	
	private static final String TAG  = "KoreaPlatform";
	
	private IabHelper mHelper;
	
    static final String SKU_GAS = "gas";

    // (arbitrary) request code for the purchase flow
    static final int RC_REQUEST = 10001;
    
    private void setWaitScreen(boolean flag){
    	
    }
	
	@Override
	public boolean canGetPhoneNumber(){
		return false;
	}
	
	private ArrayList<String> SKU_ID_LIST = null;
	@Override
	public void onStart(){
		super.onStart();
		SKU_ID_LIST = new ArrayList<String> ();
		for(int i=1;i<=7;i++){
			SKU_ID_LIST.add("korea_00"+i);
		}
	}
	
	@Override
	public void onStop() { 
        super.onStop();
        if(mGoogleApiClient != null){
        	if(mGoogleApiClient.isConnected() || mGoogleApiClient.isConnecting()){
            	mGoogleApiClient.disconnect();
            }
        }
    }
	
	@Override
	public void onDestroy() {
	    super.onDestroy();
	    if (mHelper != null) {
	    	mHelper.dispose();
	    	mHelper = null;
	    }
	}
	
//--------------------------------------------------------------------------------------	
	
	private GoogleApiClient mGoogleApiClient; 
	
	IabHelper.QueryInventoryFinishedListener mGotInventoryListener = new IabHelper.QueryInventoryFinishedListener() {
        public void onQueryInventoryFinished(IabResult result, Inventory inventory) {
            Log.d(TAG, "Query inventory finished.");

            // Have we been disposed of in the meantime? If so, quit.
            if (mHelper == null) return;

            // Is it a failure?
            if (result.isFailure()) {
            	Log.e(TAG, "Failed to query inventory: " + result);
                return;
            }

            Log.d(TAG, "Query inventory was successful.");
            
            
            Purchase gasPurchase1 = inventory.getPurchase("korea_000");
            if (gasPurchase1 != null ) {
                Log.d(TAG, "We have gas. Consuming it.");
                setWaitScreen(true);
                mHelper.consumeAsync(gasPurchase1, mConsumeFinishedListener);
            }
            
            
            // Check for gas delivery -- if we own gas, we should fill up the tank immediately
            for(String sku_id:SKU_ID_LIST){
	            Purchase gasPurchase = inventory.getPurchase(sku_id);
	            if (gasPurchase != null ) {
	                Log.d(TAG, "We have gas. Consuming it.");
	                setWaitScreen(true);
	                mHelper.consumeAsync(gasPurchase, mConsumeFinishedListener);
	            }
            }
        }
    };
    
 // Called when consumption is complete
    IabHelper.OnConsumeFinishedListener mConsumeFinishedListener = new IabHelper.OnConsumeFinishedListener() {
        public void onConsumeFinished(Purchase purchase, IabResult result) {
            Log.d(TAG, "Consumption finished. Purchase: " + purchase + ", result: " + result);

            // if we were disposed of in the meantime, quit.
            if (mHelper == null) return;

            // We know this is the "gas" sku because it's the only one we consume,
            // so we don't check which sku was consumed. If you have more than one
            // sku, you probably should check...
            if (result.isSuccess()) {
                // successfully consumed, so we apply the effects of the item in our
                // game world's logic, which in our case means filling the gas tank a bit
                Log.d(TAG, "Consumption successful. Provisioning.");
                String payload = purchase.getDeveloperPayload();
                try{
                	JSONObject object = new JSONObject(payload);
                	float gold = (float)object.optDouble("gold");
                	String purchaseStr = "{status='ok',account='"+object.optString("account")+"',srv_id="+object.optInt("srv_id")+",gold="+gold+",";
                	purchaseStr += "orderid='"+purchase.getOrderId()+"',"+"productId='"+purchase.getSku()+"',purchaseToken='"+purchase.getToken()+"'";
  			        
                	callLuaFunction(PlatformEvent.PURCHASE, purchaseStr);
                }catch(Exception x){
                	x.printStackTrace();
                }
            }
            else {
                
            }
            
            Log.d(TAG, "End consumption flow.");
        }
    };
	
	
	//平台 启动  override
	public void platformLaunch(){ 
		String base64EncodedPublicKey = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAi2X5aBLyA7RrsXgCBcMfERBYIBct5d1LxB6CefyofymECUCNIuvt6Ya93hJy6Ojv5iiDmclf9e2JiAxoOksJHwhc8eLxw53CfDBIBg8R4hQBZ3+iHKGQ+2v1ktXS02i4kJdFAdQccxVoDymb4dXbhjWYG6ThqieWNisQY1UhqDqryNi8ARGFmD7CAU0B7BCj8u3ZW6uj9MIgCJFDiShGEnsxkFnycTzGr9ENrDfGp5P2dIB+l1sZf8o+EhPKeCirtyYynHngJLBp27byc2GJqvCj23wTDrr1AOa1Ybi103QGq8LtM/D2/ukucJhB825tqiQTK+wOFMBASIB1riRzjwIDAQAB";
		// Create the helper, passing it our context and the public key to verify signatures with
      Log.d(TAG, "Creating IAB helper.");
      mHelper = new IabHelper(mainAct, base64EncodedPublicKey);

      // enable debug logging (for a production application, you should set this to false).
      mHelper.enableDebugLogging(true);

      // Start setup. This is asynchronous and the specified listener
      // will be called once setup completes.
      Log.d(TAG, "Starting setup.");
      mHelper.startSetup(new IabHelper.OnIabSetupFinishedListener() {
          public void onIabSetupFinished(IabResult result) {
              Log.d(TAG, "Setup finished.");

              if (!result.isSuccess()) {
                  // Oh noes, there was a problem.
              	Log.e(TAG, "Problem setting up in-app billing: " + result);
                  return;
              }

              // Have we been disposed of in the meantime? If so, quit.
              if (mHelper == null) return;

              // IAB is fully set up. Now, let's get an inventory of stuff we own.
              Log.d(TAG, "Setup successful. Querying inventory.");
              mHelper.queryInventoryAsync(mGotInventoryListener);
          }
      });
      
		mGoogleApiClient = buildGoogleApiClient(true);
		callLuaFunction("platformLaunchEnd","{status='ok'}");
	}
	
	// Callback for when a purchase is finished
    IabHelper.OnIabPurchaseFinishedListener mPurchaseFinishedListener = new IabHelper.OnIabPurchaseFinishedListener() {
        public void onIabPurchaseFinished(IabResult result, Purchase purchase) {
            Log.d(TAG, "Purchase finished: " + result + ", purchase: " + purchase);

            // if we were disposed of in the meantime, quit.
            if (mHelper == null) return;

            if (result.isFailure()) {
            	Log.e(TAG, "Error purchasing: " + result);
                return;
            }

            Log.d(TAG, "Purchase successful.");
            mHelper.consumeAsync(purchase, mConsumeFinishedListener);
        }
    };
    
	 
	@Override
	//平台登录 override
	public void platformLogin(){ 
		if (!mGoogleApiClient.isConnecting()) {
			if(mGoogleApiClient.isConnected()){
				mGoogleApiClient.disconnect();
			}
            mGoogleApiClient.connect();
        }
		
	} 
	
	private GoogleApiClient buildGoogleApiClient(boolean useProfileScope) {
		
        GoogleApiClient.Builder builder = new GoogleApiClient.Builder(mainAct).addConnectionCallbacks(this).addOnConnectionFailedListener(this);
        
        if (useProfileScope) {
            builder.addApi(Plus.API).addScope(new Scope("profile"));
        } else {
            builder.addApi(Plus.API, Plus.PlusOptions.builder()
                            .addActivityTypes("http://schemas.google.com/AddActivity",
                                    "http://schemas.google.com/BuyActivity").build())
                    .addScope(Plus.SCOPE_PLUS_LOGIN);
        }
 
        return builder.build();
    }
	
	@Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
//        logVerbose(String.format("onActivityResult - requestCode:%d resultCode:%d", requestCode,
//                resultCode));
		if (!mHelper.handleActivityResult(requestCode, resultCode, data)) {
            // not handled, so handle it ourselves (here's where you'd
            // perform any handling of activity results not related to in-app
            // billing...
            super.onActivityResult(requestCode, resultCode, data);
            return;
        }

        if (requestCode == REQUEST_CODE_SIGN_IN) {
//            mIntentInProgress = false; //Previous resolution intent no longer in progress.

            if (resultCode == -1) {
                // After resolving a recoverable error, now retry connect(). Note that it's possible
                // mGoogleApiClient is already connected or connecting due to rotation / Activity
                // restart while user is walking through the (possibly full screen) resolution
                // Activities. We should always reconnect() and ignore earlier connection attempts
                // started before completion of the resolution. (With only one exception, a
                // connect() attempt started late enough in the resolution flow and it actually
                // succeeded)
                if (!mGoogleApiClient.isConnected()) {
//                    logVerbose("Previous resolution completed successfully, try connecting again");
                    mGoogleApiClient.reconnect();
                }
            } else {
//                mSignInClicked = false; // No longer in the middle of resolving sign-in errors.

                if (resultCode == 0) {
//                    mSignInStatus.setText(getString(R.string.signed_out_status));
                } else {
//                    mSignInStatus.setText(getString(R.string.sign_in_error_status));
                    Log.w(TAG, "Error during resolving recoverable error.");
                }
            }
        }
    }
	
	private String accountId = null; 
    @Override
    public void onConnected(Bundle connectionHint) {   
    	Person person = Plus.PeopleApi.getCurrentPerson(mGoogleApiClient);
        if(person != null){
        	accountId = person.getId(); 
        	Log.d(TAG, "accountId!!! : "+accountId); 
        }
          new Thread(new Runnable() { 
        				@Override  
        	            public void run() {   
        	                try {  
        	                	String oAuthScopes = "oauth2:";
        	                	oAuthScopes += " https://www.googleapis.com/auth/userinfo.profile";
        	                	String googleAccessToken = GoogleAuthUtil.getToken(mainAct.getApplicationContext(), 
        	                			Plus.AccountApi.getAccountName(mGoogleApiClient), oAuthScopes);				
        	                	String arg = "{status='ok',userInfo={userId='"+googleAccessToken + "',userType='',md5='asdfg12345',sessionId='00',status=1}}";
    							callLuaFunction(PlatformEvent.LOGIN_END, arg);
    							
    							JSONObject obj = new JSONObject();
            	                obj.put("gold", 188);
            	                obj.put("serverId", 2);
            	                charge(obj);
            	                
        	                } catch (Exception e) {  
        	                    // TODO Auto-generated catch block  
        	                	e.printStackTrace();
        	                	Log.d(TAG, "Google Access Token  Exception!!! : "+e.toString()); 
        	                	
        	                	String arg = "{status='error'}";
        	                	callLuaFunction(PlatformEvent.LOGIN_END, arg);
        	                }
        	                
        	                
        	            }  
        }).start();
    }

    @Override
    public void onConnectionSuspended(int cause) {
    	Log.w(TAG, "GoogleApiClient onConnectionSuspended");
        mGoogleApiClient.connect();
    } 

    @Override 
    public void onConnectionFailed(ConnectionResult result) {
    	Log.w(TAG,"GoogleApiClient onConnectionFailed, hasResolution: " + result.hasResolution() +"   code: "+result.getErrorCode());
//        if (!mIntentInProgress && mSignInClicked) {
            if (result.hasResolution()) {
                try {
                    result.startResolutionForResult(mainAct, REQUEST_CODE_SIGN_IN);
                } catch (IntentSender.SendIntentException e) {
                    Log.w(TAG, "Error sending the resolution Intent, connect() again.");
                    mGoogleApiClient.connect(); 
                } 
            } else { 
                GoogleApiAvailability.getInstance().showErrorDialogFragment( 
                        mainAct, result.getErrorCode(), REQUEST_CODE_ERROR_DIALOG);
            }  
//        }  
    }
    

	
	//充值    name  游戏角色名
	@Override
	public void charge(JSONObject json) throws JSONException{
		if(this.accountId == null || this.accountId == ""){
			return;
		}
		float gold = (float)json.getDouble("gold");
		int[] arr = {188,120,200,400,1200,2000,4000};
		int index = -1;
		for(int i=0;i<arr.length; i++){
			if(arr[i] == gold){
				index = i;
				break;
			}
		}
		if(index>-1){
			String sukId = this.SKU_ID_LIST.get(index);
			sukId = "korea_002";
			if(sukId !=null && sukId !=""){
				int serverId = json.getInt("serverId");
				JSONObject obj = new JSONObject();
				obj.put("account", this.accountId);
				obj.put("srv_id",serverId);
				obj.put("gold", gold);
				obj.put("fuckyou", Math.random());
				try{
					mHelper.launchPurchaseFlow(mainAct, sukId, "inapp", 1001, mPurchaseFinishedListener, obj.toString());  
				}catch(Exception e){
					
				}
			}
		}
	}
	
//	public void testCharge(){ 
////		if(true){
////		return;
////		}
//		try{
//			String packageName = mainAct.getPackageName();
//			if(mService != null){
//				Log.d(TAG, "mService  yes");
//			}else{
//				Log.d(TAG, "mService  no");
//			}
//			int response1 = mService.isBillingSupported(3, packageName, "inapp");
//			Log.d(TAG, "isBillingSupported  "+response1 +"  packageName: "+packageName);
//			
//			
//			
//			ArrayList<String> skuList = new ArrayList<String> ();
////			skuList.add("korea_002");
//			skuList.add("premiumUpgrade");
//			skuList.add("gas");
//			Bundle querySkus = new Bundle();
//			querySkus.putStringArrayList("ITEM_ID_LIST", skuList);
//			Bundle skuDetails = mService.getSkuDetails(3,packageName, "inapp", querySkus);
//			int response = skuDetails.getInt("RESPONSE_CODE");
//			
//			Log.d(TAG, "getIng response :"+response);
//			Log.d(TAG, "getIng "+skuDetails.toString());
//			if (response == 0) {
//			   ArrayList<String> responseList = skuDetails.getStringArrayList("DETAILS_LIST");
//			   Log.d(TAG, "responseList :"+responseList.size());
//			   for (String thisResponse : responseList) {
//				   Log.d(TAG, "thisResponse :"+thisResponse);
//			      JSONObject object = new JSONObject(thisResponse);
//			      String sku = object.getString("productId");
//			      String price = object.getString("price");
//			      Log.d(TAG, "skuDetails  id: "+sku+"   price :"+price );
//			   }
//			}
//			
//			
//			Bundle buyIntentBundle = mService.getBuyIntent(3, packageName,
//					"korea_002", "inapp", "123123");
//			if(buyIntentBundle == null){
//				Log.d(TAG, "buyIntentBundle  nil " );
//			}else{
//				
//				PendingIntent pendingIntent = buyIntentBundle.getParcelable("BUY_INTENT");
//				if(pendingIntent == null){
//					Log.d(TAG, "pendingIntent  nil " );
//				}else{
//					mainAct.startIntentSenderForResult(pendingIntent.getIntentSender(),
//							   1001, new Intent(), Integer.valueOf(0), Integer.valueOf(0),
//							   Integer.valueOf(0)); 
//				}
//			}
//			
//		}catch(Exception e){
//			e.printStackTrace();
//		}
//	}
	
	
	 private static final int DIALOG_GET_GOOGLE_PLAY_SERVICES = 1;

	    private static final int REQUEST_CODE_SIGN_IN = 1;
	    private static final int REQUEST_CODE_ERROR_DIALOG = 2;

  
}
