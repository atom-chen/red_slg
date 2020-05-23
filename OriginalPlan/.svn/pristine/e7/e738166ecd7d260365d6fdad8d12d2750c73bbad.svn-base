package com.game.lib;

import java.io.InputStream;
import java.util.ArrayList;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserFactory;

//读取xml的类
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
	        //得到 DocumentBuilderFactory 对象, 由该对象可以得到 DocumentBuilder 对象
	        
			XmlPullParserFactory factory;
		    try {
		      factory = XmlPullParserFactory.newInstance();
		      factory.setNamespaceAware(true);
		      XmlPullParser xpp = factory.newPullParser();
		      xpp.setInput(in, "UTF-8");
		      int evtType = xpp.getEventType();
		      // 一直循环，直到文档结束
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
			      	evtType = xpp.next();//获得下一个节点的信息
		      	}
		    } catch (Exception e) {
		      // TODO Auto-generated catch block
		      e.printStackTrace();
		      return false;
		    }
		    return true;
	}
	
}
