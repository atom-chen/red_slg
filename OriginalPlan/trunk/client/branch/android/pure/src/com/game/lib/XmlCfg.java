package com.game.lib;

import java.io.InputStream;
import java.util.ArrayList;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserFactory;

//��ȡxml����
public class XmlCfg {
	private ArrayList<String> keyList = new ArrayList<String>();
	private ArrayList<String> valueList = new ArrayList<String>();
	public XmlCfg(InputStream in){
		if(in!=null){
			this.setInputStream(in);
		}
	}
	
	public ArrayList<String> getKeyList(){
		return keyList;
	}
	
	public ArrayList<String> getValueList(){
		return valueList;
	}
	
	public boolean setInputStream(InputStream in){
	        //�õ� DocumentBuilderFactory ����, �ɸö�����Եõ� DocumentBuilder ����
	        
			XmlPullParserFactory factory;
		    try {
		      factory = XmlPullParserFactory.newInstance();
		      factory.setNamespaceAware(true);
		      XmlPullParser xpp = factory.newPullParser();
		      xpp.setInput(in, "UTF-8");
		      int evtType = xpp.getEventType();
		      // һֱѭ����ֱ���ĵ�����
		      while (evtType != XmlPullParser.END_DOCUMENT) {
			      switch (evtType) { 
			      		case XmlPullParser.START_TAG:
			      		//	String nodeName=xpp.getName();
			      			if(xpp.getAttributeCount() == 2){
			      				keyList.add(xpp.getAttributeValue(0));
				      			valueList.add(xpp.getAttributeValue(1));
			      			} 
			      			break;
			      		case XmlPullParser.END_TAG:
			      			break;
			      		default:
			      			break;
			      	}
			      	evtType = xpp.next();//�����һ���ڵ����Ϣ
		      	}
		    } catch (Exception e) {
		      // TODO Auto-generated catch block
		      e.printStackTrace();
		      return false;
		    }
		    return true;
	}
	
}
