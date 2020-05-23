#ifndef __UE_UEHELPER_H__
#define __UE_UEHELPER_H__
#include "LuaType.h"
#include "LuaTypedStream.h"
#include "FSUtils.h"

class WordsTable
{
private:
	/*map<string, int> m_files;
	vector<map<int, string>> m_items;
	*/
	LuaValue m_workkey;
	LuaValue m_workValue;

	LuaValue m_tables;
	string m_path;

	string m_msg;

public:
    WordsTable(){}
    ~WordsTable(){}
	// 打开之后又一个工作薄. 工作簿
	bool open(const string& path, bool createIfNoteExists);
	//bool exists(const string& langFilename);
	bool save();
	bool saveAs(const string& path);
	bool clear();
	string getSavePath()const{ return m_path; }

	bool createTmpUE();
	bool createNewUE(const string& filename = "", bool overwrite = true);// can be
	bool existsUE(const string& filename);
	bool saveAsNewUE(const string& filename, bool overwrite);
	bool saveUE();
	bool deleteUE(const string& filename);

	bool setUECurrent(const string& filename);

	int  getNewUEIndex();
	bool setUEString(int idx, const string& str);
	bool getUEString(int idx, string& str);
	string getUEStringDefault(int idx, const string& defaultValue);
	bool deleteUEString(int idx);


	string getErrorInfo();
    static WordsTable* getWordsTable();
	//int getErrorCode();
};

enum TUIType
{
	UI_BASE = 0,
	UI_TEXT = 1,
	UI_BUTTON = 2,
	UI_UISCROLLVIEW = 3,
	UI_DRAWABLE = 4,
	UI_UIEDIT = 5,
	UI_UISCROLLLIST = 6,
	UI_ANIMATION = 7,
	UI_UISCROLLPAGE = 8,
	UI_TREE = 9,
	UI_PROGRESS_BAR = 10,
	UI_FRAME = 11,
	UI_MAX_VALUE = 0xFFFFFFFF,
};


inline int getLength(const string& val)
{
	return (int)(4 + val.length());
}

template<typename T>
inline int getLength(T)
{
	return sizeof(T);
}
#define MK_STR_HELPER(name) #name
#define MK_STR(name) MK_STR_HELPER(name)

struct ButtonEx
{
	string imageDown;
	string imageDisabled;
	string imageChecked;

	bool operator==(const ButtonEx& rhs)const;
	bool operator!= (const ButtonEx& rhs)const;
    ButtonEx();
    void clear();
	int getLength()const;
	bool toBinary(TypedStream* ts);
	bool fromBinary(TypedStream* ts);
	bool toReadable(TypedStream* ts);

	bool toLuaValue(LuaValue& val)const;
	bool fromLuaValue(const LuaValue& val);
};

struct ProgressBarEx
{
	int x;
	int y;
	int width;
	int height;
	string barImage;

	bool operator==(const ProgressBarEx& rhs)const;
	bool operator!= (const ProgressBarEx& rhs)const;

    ProgressBarEx();
    void clear();
	int getLength()const;
	bool toBinary(TypedStream* ts);
	bool fromBinary(TypedStream* ts);
	bool toLuaValue(LuaValue& val)const;
	bool fromLuaValue(const LuaValue& val);
};

class ElemInfo
{
public:	
	short 			type;
	int				frameType;
	string 			cName;
	string 			picName;
	string			data;
	string			audio;

	int 			x;
	int				y;
	int 			width;
	int				height;

	float			scaleX;
	float			scaleY;

	int				scrollAlign;
	int				scrollMargin;

	short 			tag;
	short 			isEnlarge;		//是否扩大点击范围
	short 			isSTensile;  //是否支持拉伸

	string 			text;    
	int				useRTF;
	int				textShade;
	short 			textType;
	int				fontSize;
	int				fontColor;
	int 			align;
public:
	mutable int     textIndex;
public:
	ProgressBarEx 	progressBarEx;
	ButtonEx     	buttonEx;
	bool eq_exist(const ElemInfo& rhs);

	bool operator==(const ElemInfo& rhs)const;
	bool operator!= (const ElemInfo& rhs)const;
    ElemInfo();
    void clear();
	int getLength();
	bool toBinary(TypedStream* ts);
	bool fromBinary(TypedStream* ts);
	bool toLuaValue(LuaValue& val, const string& textName)const;
	bool fromLuaValue(const LuaValue& val, const string& textName);
};

struct UIDataItem
{
public:
	int 	len;
	bool 	m_available;

	ElemInfo m_eleInfo;
public:
	UIDataItem();
    UIDataItem(const ElemInfo& ele);
	bool operator==(const UIDataItem& rhs)const;
	bool operator!= (const UIDataItem& rhs)const;
	int getLength();
	bool toBinary(TypedStream* ts);
	bool fromBinary(TypedStream* ts);
	bool toLuaValue(LuaValue& val, const string& textName)const;
	bool fromLuaValue(const LuaValue& val, const string& textName);
};

struct UIDataFormat
{
	int32_t len;
	int32_t count;
    int32_t alignment;
	int32_t version;
	uint8_t padding[64]; // GUID.
	vector<UIDataItem> m_item;

	bool operator==(const UIDataFormat& rhs)const;
	bool operator!= (const UIDataFormat& rhs)const;
    UIDataFormat();
    void clear();
    void push_back(const UIDataItem& item);
    void setAlignment(int align);
	int getLength();
	bool toBinary(TypedStream* ts);
	bool fromBinary(TypedStream* ts);
	bool toLuaValue(LuaValue& val, const string& textName)const;
	bool fromLuaValue(const LuaValue& val, const string& textName);
    static bool getUIDataFormatFromLuaFile(const string& path, UIDataFormat& uiData);
    static bool setUIDataFormatToLuaFile(const string& path, const UIDataFormat& uiData);
};

//class WordLoad
//{
//public:
//	bool open(const string& filename);
//	/*
//	vector<string> getTables();
//	typedef map<int, string>::iterator ItemIterator;
//	ItemIterator getTableBegin(const string& tableName);
//	ItemIterator getTableEnd(const string& tableName);
//	*/
//	bool loadFirst();
//	bool loadNext(string& table, int& index, string& word);
//	bool loadEnd();
//	//	bool load(string& table, int& index, string& word);
//	//	bool save(const string& table, int index, const string& word);
//	bool close();
//	string getErrorInfo();
//	operator void*();
//};

#endif