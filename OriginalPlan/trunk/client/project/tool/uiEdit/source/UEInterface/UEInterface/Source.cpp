/**
@brief  test for all
*/
#include <iostream>
#include <sstream>
#include <cassert>
#include <cstdio>
//#include <cctype>
#include <set>
#include <map>
#include <string>
#include <vector>
#include "stream.h"
#include "LuaType.h"
#include "LuaTypedStream.h"
#include "FSUtils.h"
#include "UEHelper.h"
#include "UEInterface.h"
using namespace std;



void test()
{
	char data[] = { "\"111111111111111111\"[=[1]==]=]xxx[bbb]" };
	RandomAccessStream* rwm = new RWMStream(data, sizeof(data));
	LuaTypedStream* ts = new LuaTypedStream(rwm, false);

	string str;
	ts->read_luaString(str, '\"');
	cout << str << endl;
	ts->read_luaEscapeString(str);
	cout << str << endl;
	ts->read_luaName(str);
	cout << str << endl;
	ts->read_luaToken(str);
	cout << str << endl;
	ts->read_luaName(str);
	cout << str << endl;
	ts->read_luaToken(str);
	cout << str << endl;

	for (int i = 0; i < 4; i++)
	{
		int val;
		if (ts->read_int32(val))
		{
			printf("%08X ", val);
		}
		else
		{
		}
	}
	ts->close();
	ts->destroy();
	rwm->destroy();
}

void test_lua()
{
	//char data[] = { "{a={[1]=\"1\",[2]=\"2\"}, b={[1]=\"1\",[2]=\"2\"}, [3]={[1]=\"1\",[2]=\"2\"}, [\"11.aa\"]={[1]=\"的\"}}" };
	char data[] = "{ [\"activation_code\"] = { \"a\", \"b\", \"c:\" } }"; //"{a=\"aa\\naa\"}";
	RandomAccessStream* rwm = new RWMStream(data, sizeof(data));
	LuaTypedStream* ts = new LuaTypedStream(rwm, false);

	LuaValue val;
	if (!ts->read_LuaValue(val))	//, b={[1]=\"1\",[2]=\"2\"}, [3]={[1]=\"1\",[2]=\"2\"}
	{
		cout << "read_luaValue error " + ts->getErrorInfo() << endl;
	}
	else
	{
		cout << val.tostring() << endl;
	}

	ts->close();
	ts->destroy();
	rwm->destroy();
}

void test_WordsTable()
{
	WordsTable wt;
	if (!wt.existsUE("c:\\bb/c/d/.././../../aa.txt"))
	{
		cout << "not exists" << endl;
	}
	LuaValue val;
	val.setTable();
	val[2] = LuaValue();
	val[2].setTable();
	if (!val[2].isTable())
	{
		assert(false);
	}
	LuaValue& v = val[2];
	v.setNone();
}

bool testUIDataConvert(const string& filename)
{
	UIDataFormat uiData1, uiData2;
	if (!UIDataFormat::getUIDataFormatFromLuaFile(filename, uiData1))
	{
		puts("get false");
		return false;
	}

	string outfile = filename + ".out.lua";
	if (!UIDataFormat::setUIDataFormatToLuaFile(outfile, uiData1))
	{
		puts("save false");
		return false;
	}

	if (!UIDataFormat::getUIDataFormatFromLuaFile(outfile, uiData2))
	{
		puts("get false");
		return false;
	}
	if (uiData1 != uiData2)
	{
		puts("not the same");
		return false;
	}
	::remove(outfile.c_str());
	return true;
};

void test_uehelper()
{
	string path = "zh_cn.lua";
	if (FSUtils::FileExists(path.c_str()))
	{
		if (!WordsTable::getWordsTable()->open(path.c_str(), false))
		{
			assert(false && ("语言文件\"" + path + "\" 初始化失败").empty());						
		}
	}


	if (!RWFStream::writeToFile("return {}", path, "wb"))
	{
		assert(false);
	}

	if (!WordsTable::getWordsTable()->open(path.c_str(), false))
	{
		assert(("语言文件\"" + path + "\" 初始化失败").empty());
	}

	WordsTable::getWordsTable()->createTmpUE();
	assert(testUIDataConvert("E:\\program2014\\client\\project\\game\\res\\uilayer\\hero_main.lua"));

	UIDataFormat uiData;

	uiData.alignment = 111;

	for (int i = 0; i < 3; i++)
	{
		ElemInfo elemInfo;
		elemInfo.picName = "picname";
		elemInfo.picName.push_back((char)('0' + i));
		string text = "我是一个人";;
		text.push_back((char)('0' + i));

		elemInfo.text = FSUtils::ansitoutf8(text);
		
		uiData.push_back(elemInfo);
	}
	if (!UIDataFormat::setUIDataFormatToLuaFile("1.lua", uiData))
	{
		assert("save false");
	}

	UIDataFormat uiData2;
	if (!UIDataFormat::getUIDataFormatFromLuaFile("1.lua", uiData2))
	{
		puts("get false");
	}
	if (uiData2 != uiData)
	{
		puts("not the same");
	}


	assert(testUIDataConvert("test_panel1.lua"));	// normal
	assert(testUIDataConvert("test_panel2.lua"));	// string.empty() optimization
	assert(testUIDataConvert("test_panel3.lua"));	// width, height not change optimization
	assert(testUIDataConvert("E:\\program2014\\client\\project\\game\\res\\uilayer\\hero_main.lua"));
	assert(testUIDataConvert("聊天界面2.lua"));
}
#include <windows.h>


void test_ueinterface()
{
	if (!UI_SUCCESS(UIDataLanguageCreate("zh_cn_1.lua", false)))
	{
		printf("error when parse zh_cn_1.lua\n");
	}

	if (!UI_SUCCESS(UIDataLanguageCreate("zh_cn_2.lua", false)))
	{
		printf("error when parse zh_cn_2.lua\n");
	}

	if (!UI_SUCCESS(UIDataLanguageCreate("zh_cn_3.lua", false)))
	{
		printf("error when parse zh_cn_3.lua\n");
	}
	
	if (!UI_SUCCESS(UIDataLanguageCreate("E:\\program2014\\client\\project\\game\\res\\uilayer\\zh_cn.lua", false)))
	{
		printf("error when parse zh_cn_3.lua\n");
	}
}


int main()
{

	//test_WordsTable();


	test_lua();
//	test_uehelper();
	//LoadLibraryA()
//	test_ueinterface();
	
	return 0;
}