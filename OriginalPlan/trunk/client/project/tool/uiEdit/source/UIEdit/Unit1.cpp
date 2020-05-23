//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop


#include <System.IOUtils.hpp>


#include "Unit1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"

// for action on xml files below
#include <XMLDoc.hpp>
#include <xmldom.hpp>
#include <XMLIntf.hpp>
#include "EditUtils.h"
#include <vector>
#include <set>
TUIEditForm *UIEditForm;

//#include "UEHelper.h"
#include "UEInterfaceImport.h"
#include "UIFrame.h"

#include <list>
#include <set>

#include "XMLPath.h"
using namespace std;


// $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
// 全局数据区

enum TUIType
{
	UI_BASE = 0,
	UI_TEXT = 1,
	UI_BUTTON = 2,
	UI_UISCROLLVIEW = 3,
	UI_GRID = 4,
	UI_UIEDIT = 5,
	UI_UISCROLLLIST = 6,
	UI_NODE = 7,
	UI_UISCROLLPAGE = 8,
	UI_TREE = 9,
	UI_PROGRESS_BAR = 10,
	UI_FRAME = 11,
};

bool g_bWireFrameState = false;



// Xml block variables
AnsiString GameTDJpath;//只能是AnsiString类型
AnsiString gamepath = "ResourcePath";//只能是AnsiString类型
_di_IXMLDocument XmlNetbargpp = NewXMLDocument(); //新建一个对像
//XmlNetbargpp->Active = true;

std::set<UnicodeString> g_dirSet;
std::set<UnicodeString> g_newDirSet;

namespace _UI_Configs_
{
	System::UnicodeString UIRes_picsConfigFileName    = "UIEditorConfig.xml";
	System::UnicodeString UIRes_spritesConfigFileName = "UIEditorConfig.xml";
	System::UnicodeString UIRes_EffectPathName = "..\Res\SpecialEffect.png";
	vector<System::UnicodeString>  UIRes_spritesPathAndName;
	_di_IXMLDocument xmlConfigDocument;
	_di_IXMLNode xmlConfigRoot;

	void InitConfigs();
	_di_IXMLDocument GetConfigDocument();
};

_di_IXMLDocument _UI_Configs_::GetConfigDocument()
{
	if (0 == xmlConfigDocument)
	{
		xmlConfigDocument = NewXMLDocument();
	}
	return xmlConfigDocument;
}

void _UI_Configs_::InitConfigs()
{
	GetConfigDocument();
	xmlConfigDocument->LoadFromFile(ExtractFilePath(Application->ExeName) + UIRes_picsConfigFileName);
	xmlConfigRoot = xmlConfigDocument->DocumentElement;
}

int getAnimationIDByName(System::UnicodeString animName)
{
	int pos = 0;
	vector<System::UnicodeString>::iterator itor = _UI_Configs_::UIRes_spritesPathAndName.begin();
	while(itor != _UI_Configs_::UIRes_spritesPathAndName.end())
	{
		if (*itor == animName) {
            return pos;
		}
		pos++;
		itor++;
	}
	return -1;
}

// 工具函数声明区
void UpdateWireFrameModeBtnCaption();

//
#define selUI GetSelUI()

int gScreenWidth = 960;
int gScreenHeight = 640;

int gDragPicID = -1;

bool UsedBILI = false;

TList      * g_picRects       = new TList;
TList      * g_pics           = new TList;
TStringList* g_stringList     = new TStringList;
TList      * g_selList        = new TList;

bool moveCanvas = false;

enum ResizeType
{
	RT_NONE,
	RT_LEFT_RIGHT,
	RT_TOP_BOTTOM,
	RT_ALL,
};

ResizeType gResizeType;

const int LEFT   = (1<<0);
const int TOP    = (1<<1);
const int RIGHT  = (1<<2);
const int BOTTOM = (1<<3);
const int FLP_X  = (1<<4);
const int FLP_Y  = (1<<5);

const int ALIGN_LEFT	= (1<<0);
const int ALIGN_HCENTER = (1<<1);
const int ALIGN_RIGHT	= (1<<2);
const int ALIGN_TOP		= (1<<3);
const int ALIGN_VCENTER = (1<<4);
const int ALIGN_BOTTOM	= (1<<5);


struct AttachRect{int x, y, width, height;};
struct UIBase
{
	System::UnicodeString name;
	bool IsExpand;
	bool IsLaShen;
	int x;
	int y;
	int width;
	int height;
	int type;
    int frameType;

	int select;
	short align;
	short tag;
	int picID;

    int picWidth;
    int picHeight;

	int useRTF;
	int textShade;
	System::UnicodeString text;
	System::UnicodeString resName;
	System::UnicodeString audio;

    float scaleX;
    float scaleY;

	int scrollAlign;
	int scrollMargin;


	int fontSize;
	int fontColor;

	System::UnicodeString fontColorName;

	// progress bar. bgimage:resName; barimage:progressBarImage;
    System::UnicodeString progressBarImage;
    int progressBarValue;
    AttachRect progressBarRect;

	int buttonStatus; // 0: up; 1:down; 2: disabled;
	// buttonUpName == resName
	System::UnicodeString buttonDownName;
	System::UnicodeString buttonDisabledName;
	System::UnicodeString buttonCheckedName;

    mutable set<char*> mem_memo;
	UIBase()
	{
		clear();
	}
    ~UIBase()
    {
        clear();
    }
	void clear()
	{
		name = "";
		resName = "";
		text = "";
		progressBarImage = "";
		buttonDownName = "";
		buttonDisabledName = "";
		buttonCheckedName = "";

        picWidth = 0;
        picHeight = 0;
        frameType = 0;
		textShade = 0;
        useRTF = 0;
		IsExpand = false;
		IsLaShen = true;
		type = 0;

        scaleX = 0, scaleY = 0;
        audio = "";

		x = 0, y = 0, width = 0, height = 0;

        tag = 0;

		scrollAlign = 0;
		scrollMargin = 0;

		select = 0;
		align = 4;
	   //	picID = -1;

		fontSize = 30;
		fontColor = 0;
		buttonStatus = 0;
		progressBarValue = 100;

		progressBarRect.x = 0;
		progressBarRect.y = 0;
		progressBarRect.width = 0;
		progressBarRect.height = 0;
		fontColorName = "clBlack";
        set<char*>::iterator it = mem_memo.begin();
        for (; it != mem_memo.end(); ++it)
        {
            if (*it) {
                delete [](*it);
            }
        }
	}
    char* string2p(const string& str)const
    {
        char* p = 0;
        if (str.empty())
        {
            p = new char[2];
            memset(p, 0, 2);
            mem_memo.insert(p);
            return p;
        }
        p = new char[str.size() + 2];
        memcpy(p, str.c_str(), str.size());
        p[str.size()] = '\0';
        mem_memo.insert(p);
        return p;
    }
    void string2pFree(char* p)const
    {
        if (!p)
            return;

        delete[] p;
    }

    char* tostring(const UnicodeString& str)const
    {
        return string2p(::tostring(str));
    }

	bool toElemInfo(UIElement_t& ele)const
	{
		ele.type = type;

		ele.cName = tostring(name);
		ele.picName = tostring(resName);
		ele.audio = tostring(audio);
		ele.scaleX = scaleX;
		ele.scaleY = scaleY;

		int w = picWidth, h = picHeight;
		switch (type)
		{
			case UI_TEXT:
			case UI_NODE:
            case UI_GRID:
            case UI_UIEDIT:
			case UI_UISCROLLVIEW:
			case UI_UISCROLLLIST:
			case UI_UISCROLLPAGE:
			{
				ele.width = width;
				ele.height = height;
				w = width;
				h = height;
			}
			break;
			default:
			{
				if (w == width && h == height)
				{
					ele.width = -1;
					ele.height = -1;
				}
				else
				{
					ele.width = width;
					ele.height = height;
					w = width;
					h = height;
				}
			}
		}

		ele.frameType = frameType;

		ele.x = x;
		ele.y = -(y+h);          // y = - (ele.y-h)

		ele.tag = tag;
		ele.isEnlarge = IsExpand ? 1 : 0;		//是否扩大点击范围
		ele.isSTensile = IsLaShen ? 1 : 0;  //是否支持拉伸


		ele.scrollAlign = scrollAlign;
		ele.scrollMargin = scrollMargin;

		ele.text = tostring(text);
		ele.textShade = textShade;
        ele.useRTF = useRTF;
		ele.textType = 0;
		ele.fontSize = fontSize;
		ele.fontColor = fontColor;
		ele.align = align;

		switch (type)
		{
			case UI_BUTTON:
			{
				ele.buttonEx.imageDown = tostring(buttonDownName);
				ele.buttonEx.imageDisabled = tostring(buttonDisabledName);
				ele.buttonEx.imageChecked = tostring(buttonCheckedName);
			}
			break;
			case UI_PROGRESS_BAR:
			{
				ele.progressBarEx.x 		= 	progressBarRect.x;
				ele.progressBarEx.y 		= 	progressBarRect.y;
				ele.progressBarEx.width 	= 	progressBarRect.width;
				ele.progressBarEx.height 	= 	progressBarRect.height;
				ele.progressBarEx.barImage  = 	tostring(progressBarImage);
			}
			break;
			default:
			break;
		}
		return true;
	}

	bool fromElemInfo(const UIElement_t& ele)
	{
        this->clear();

		type = ele.type;

		name = toUnicodeString(ele.cName);
		resName = toUnicodeString(ele.picName);
		audio = toUnicodeString(ele.audio);
		scaleX = ele.scaleX;
		scaleY = ele.scaleY;

        if (picID == -1) {
            AnsiString as = name + "的图片" + resName + "未找到";
            MessageBoxA(0, as.c_str(), "警告", 0);
            return false;
        }
        if (picID != -1)
        {
            TWICImage* img = (TWICImage*)(g_pics->Items[picID]);

            frameType = ele.frameType;

            int w = img->Width;
            int h = img->Height;

            picWidth = w;
            picHeight = h;

            if (ele.width < 0 || ele.height < 0)
            {
                width = w;
                height = h;
            }
            else
            {
                width = ele.width;
                height = ele.height;
            }
        }
        else
        {
            width = ele.width < 0 ? 100 : ele.width;
            height = ele.height < 0 ? 100 : ele.height;
        }

        x = ele.x;
        y = -ele.y-height;

		tag = ele.tag;
		IsExpand = ele.isEnlarge ? true : false;		//是否扩大点击范围
		IsLaShen = ele.isSTensile ? true : false;  //是否支持拉伸
		scrollAlign = ele.scrollAlign;
		scrollMargin = ele.scrollMargin;

		text = toUnicodeString(ele.text);

		textShade = (ele.textShade > 0 ? ele.textShade : 0);
        useRTF = (ele.useRTF == 1 ? 1 : 0);
		//0 = ele.textType;
		fontSize = ele.fontSize;
		fontColor = ele.fontColor;
		align = ele.align;

		switch (type)
		{
			case UI_BUTTON:
			{
				buttonDownName = toUnicodeString(ele.buttonEx.imageDown);
				buttonDisabledName = toUnicodeString(ele.buttonEx.imageDisabled);
				buttonCheckedName = toUnicodeString(ele.buttonEx.imageChecked);
			}
			break;
			case UI_PROGRESS_BAR:
			{
				progressBarRect.x			=	ele.progressBarEx.x;
				progressBarRect.y			=	ele.progressBarEx.y;
				progressBarRect.width		=	ele.progressBarEx.width;
				progressBarRect.height		=	ele.progressBarEx.height;
				progressBarImage			=	toUnicodeString(ele.progressBarEx.barImage);
			}
			break;
		}
		return true;
	}
	//Load();
	//Save();
};

System::UnicodeString gPath = "D:/war/";              //wjl mark 图片资源路径

//int    selUI = -1;
//TList* UIs       = new TList;
enum SINGLEUI_ALIGNMENT
{
	SINGLEUI_ALIGNMENT_CENTER = 0,
	SINGLEUI_ALIGNMENT_TOP,
	SINGLEUI_ALIGNMENT_TOPRIGHT,
	SINGLEUI_ALIGNMENT_RIGHT,
	SINGLEUI_ALIGNMENT_DOWNRIGHT,
	SINGLEUI_ALIGNMENT_DOWN,
	SINGLEUI_ALIGNMENT_LEFTDOWN,
	SINGLEUI_ALIGNMENT_LEFT,
	SINGLEUI_ALIGNMENT_LEFTTOP
};

struct SingleUI
{
	int alignment;
	TList* UIs;
	SingleUI() : alignment(SINGLEUI_ALIGNMENT_CENTER)
	{
		UIs = new TList;
	}
	~SingleUI()
	{
		delete UIs;
		UIs = 0;
    }
};

SingleUI* g_oneUI       = new SingleUI();
TList* g_tempUIs        = new TList;
TList* g_tempUIs2       = new TList;

bool IsSelUI(int sel);

int GetSelUI( )
{
   if (g_selList->Count <= 0 ) {
		return -1;
   }

   return (int)g_selList->Items[0]; // change 1 to 0. 2014/06/13
}

int gX = 0;
int gY = 0;
UIBase* dragUI = NULL;

int gN = 1;
System::Sysutils::TFileName gFileName;


void PaintUIs();
TWICImage* GetImage(const System::UnicodeString& name);
int GetImageID(const System::UnicodeString& name);

static bool gSet = false;

void SetNewType()
{
    UIEditForm->ComboBox_fontName->Items->Clear();
	for(int i=0;i<4;i++)
	{
		UIEditForm->ComboBox_fontName->Items->Add(i);
	}
	UIEditForm->ComboBox_fontName->ItemIndex = 0;
}
void InitData()
{
	gResizeType = RT_NONE;
	g_oneUI->UIs->Clear();

	gX = UIEditForm->ScrollBox1->Width / 2;
	gY = UIEditForm->ScrollBox1->Height / 2;

	dragUI = NULL;

	gN = 1;
	gSet = false;

	gDragPicID = -1;

	//g_picRects->Clear();
	//g_pics->Clear();
	//g_stringList->Clear();

	moveCanvas = false;
	gFileName = "";

	g_selList->Clear();

	g_bWireFrameState = false;
	UpdateWireFrameModeBtnCaption();
}

void SaveData( int p, bool value )
{
	FileWrite(p, &value, 2 );
}

void SaveData( int p, short value )
{
	FileWrite(p, &value, 2 );
}

void SaveData( int p, int value )
{
	FileWrite(p, &value, 4 );
}

void SaveData( int p, System::UnicodeString value )
{
	//int len =  value.Length();
	char data[1024];
	int len = 1024;

	WideChar* wChars = value.c_str();
	len = WideCharToMultiByte(CP_ACP,0, wChars,-1,data, 1024,NULL,0);

	/*
	WideChar* str = value.c_str();

	char data[1024];

	for (int i = 0; i < len; i++) {
    	data[i] = str[i];
	}
	*/

	len --;

	if (len<0) {
       len = 0;
	}

	SaveData(p, len);
	FileWrite(p, data, len);

}

void LoadData( AnsiChar*&p, int& value )
{
	value = *((int*)p);
	p+=4;
}

void LoadData( AnsiChar*&p, short& value )
{
	value = *((short*)p);
	p+=2;
}

void LoadData( AnsiChar*&p, bool& value )
{
	value = *((bool*)p);
	p+=2;
}

void LoadData( AnsiChar*&p, System::UnicodeString& value )
{
	int len;
	LoadData(p, len);

	char buf[1024] = {0};
	memcpy(buf,p,len);
	buf[len] = '\0';
	buf[len+1] = '\0';
	p += len;

	if (len == 0) {
		value = "";
		return;
	}

	WideChar data[1024] = {0};

	MultiByteToWideChar(CP_ACP,0,buf,-1,data,1024);
	//data[len] = 0;

	value =  data;
}



void SaveFile(const System::UnicodeString& FileName)
{
	//int p = FileCreate(FileName);

	/*
	SaveData( p, g_stringList->Count );
	for (int i=0; i<g_stringList->Count; i++ )
	{
		SaveData( p, (*g_stringList)[i] );
	}
	//*/
	UIData_t* uiData;
    UIDataCreate(&uiData);


	if (g_oneUI->UIs->Count > 0)
	{
		g_oneUI->alignment = 0;
        //= ((1 << (UIEditForm->ComboBox6->ItemIndex))
		 //			        | (1 << (UIEditForm->ComboBox7->ItemIndex + 3)));

        UIDataSetAlignment(uiData, g_oneUI->alignment);
		//SaveData( p, g_oneUI->alignment );
    }
	for (int i=0; i<g_oneUI->UIs->Count; i++ )
	{
		UIElement_t elemInfo;

		UIBase* pUI = (UIBase*)(g_oneUI->UIs->Items[i]);

		if (!pUI->toElemInfo(elemInfo))
			continue;
			/*
		SaveData( p, pUI->name );
		SaveData( p, pUI->x );
		SaveData( p, pUI->y );
		SaveData( p, pUI->width );
		SaveData( p, pUI->height );
		SaveData( p, pUI->type );
		SaveData( p, pUI->select );
		SaveData( p, pUI->align );
		SaveData( p, pUI->tag );
		SaveData( p, (*g_stringList)[pUI->picID] );
		SaveData( p, pUI->text );
		SaveData( p, pUI->IsExpand);
		pUI->IsExpand = pUI->IsExpand & 0x00000001;

		SaveData( p, pUI->IsLaShen);


		if (UI_NODE == pUI->type)
		{
			//SaveData( p, pUI->m_AnimID);
		}
		*/
		UIDataAddElement(uiData, &elemInfo);
	}
    PaintUIs();
	//FileClose(p);

	if (UIDataSaveToFile(uiData, toansi(FileName).c_str()))
	{

	}
/*
    string path = tostring(FileName);
    string name;
    if (!FSUtils::ExtractFilename(path, name))
    {
        ShowMessage("文件名错误");
    }

    if (!WordsTable::getWordsTable()->saveAsNewUE(name, true))
    {
        ShowMessage("语言文件保存错误");
    }*/

	UIEditForm->Caption = FileName;
}
UIBase* newUIBase()
{
    char data[1024] = {0};
    UIBase* pUI = new UIBase();
    return pUI;
}

void __stdcall newUIBase1(void** pUI)
{
    //*pUI = new UIBase();
}
bool LoadFile(const System::UnicodeString& FileName)
{
/*
	int iFileHandle = FileOpen(FileName, fmOpenRead);
	int iFileLength = FileSeek(iFileHandle, 0, 2);
	FileSeek(iFileHandle,0,0);
	AnsiChar* pszBuffer = new AnsiChar[iFileLength+1];
	int len = FileRead(iFileHandle, pszBuffer, iFileLength);
	FileClose(iFileHandle);

	char* p = pszBuffer;

	int count = 0;


	LoadData( p, count );
	for (int i=0; i<count; i++ )
	{
		System::UnicodeString value;
		LoadData( p, value );

		GetImage( value );
	}
	//*/
/*
	// string utf8path = tostring(FileName);
	// string utf8filename;
    // WordsTable* wt = WordsTable::getWordsTable();
	// if (!FSUtils::ExtractFilename(utf8path, utf8filename))
	// {
		// utf8filename = utf8path;
	// }
    // if (wt->existsUE(utf8filename))
    // {

         // if (MB_OK != MessageBoxW(0 , L"存在同名ue文件。如果打开， 将会覆盖语言文件。\r\n确定继续打开？",   L"警告", MB_OKCANCEL);
         // {
            // return false;
         // }
    // }
    WordsTable::getWordsTable()->createNewUE(utf8filename, true);
*/

    AnsiString AnsiFilename = FileName;
    UIData_t* uiData;
    UIDataCreate(&uiData);

	if (!UI_SUCCESS(UIDataGetFromFile(uiData, AnsiFilename.c_str())))
	{
	    ShowMessage(AnsiFilename+"data error");
		return false;
	}

    int cnt = 0;
	if (!UI_SUCCESS(UIDataGetElementCount(uiData, &cnt)))
	{
		ShowMessage(AnsiFilename+" get count error");
		return false;
	}

    for (int i = 0; i < cnt; i++)
    {
        UIElement_t* ele = 0;
        UIBase* pUI = new UIBase();


        if (!UI_SUCCESS(UIDataGetElement(uiData, i, &ele)))
        {
            continue;
        }

		pUI->picID = GetImageID(toUnicodeString(ele->picName));

        if (false == pUI->fromElemInfo(*ele))
        {
            UIDataElementFree(&ele);
            continue;
        }
        UIDataElementFree(&ele);


        //if (pUI->picID >= 0 )
       // {
       g_oneUI->UIs->Add(pUI);
	   //	}
    }

    /*
	LoadData( p, count );
	if (count > 0)
	{
		LoadData(p, g_oneUI->alignment);
	}
	//g_oneUI->alignment = 1;
	for (int i=0; i<count; i++ )
	{
		UIBase* pUI = new UIBase();

		LoadData( p, pUI->name );
		LoadData( p, pUI->x );
		LoadData( p, pUI->y );
		LoadData( p, pUI->width );
		LoadData( p, pUI->height );
		LoadData( p, pUI->type );
		LoadData( p, pUI->select );
		LoadData( p, pUI->align );
        LoadData( p, pUI->tag );
		LoadData( p, pUI->resName );
		pUI->picID = GetImageID( pUI->resName );
		LoadData( p, pUI->text );
		LoadData( p, pUI->IsExpand );
		pUI->IsExpand = pUI->IsExpand & 0x00000001;

		LoadData( p, pUI->IsLaShen);

	   //	pUI->IsExpand = false;    // this is for translate old resource to new release
		if (UI_NODE == pUI->type)
		{
			//LoadData( p, pUI->m_AnimID );
		}

		if (pUI->picID >= 0 ) {
			//g_oneUI->alignment = 1<<0;
			g_oneUI->UIs->Add(pUI);
		}
	}

	delete[] pszBuffer;
                              */
	UIEditForm->Caption = FileName;
    return true;
}


void SetUIData( )
{
	gSet = true;

	if ( GetSelUI() ==  -1 ) {
		UIEditForm->Edit_cName->Text = "";
		UIEditForm->Edit_resourceName->Text = "";
		UIEditForm->Edit2->Text = "";
		UIEditForm->Edit3->Text = "";
		UIEditForm->Edit4->Text = "";
		UIEditForm->Edit5->Text = "";
		UIEditForm->Edit_text->Text = "";
		UIEditForm->Edit_audio->Text = "";
		UIEditForm->Edit_scaleX->Text = "0";
        UIEditForm->Edit_scaleY->Text = "0";
		UIEditForm->ComboBox_type->ItemIndex = 0;

		UIEditForm->ComboBox_fontAlign->ItemIndex = 1;
		UIEditForm->ComboBox_fontVAlign->ItemIndex = 1;
		UIEditForm->ComboBox_fontName->ItemIndex = 0;

		UIEditForm->SpinEdit1->Value = 100;
		UIEditForm->SpinEdit2->Value = 100;
		//UIEditForm->SpinEdit_group->Value = 0;
		UIEditForm->PanelAllHide();
	}
	else
	{
		UIBase* p = (UIBase*)(g_oneUI->UIs->Items[ GetSelUI() ]);

		UIEditForm->Edit_cName->Text = p->name;
		UIEditForm->Edit2->Text = IntToStr(p->x);
		UIEditForm->Edit3->Text = IntToStr(p->y);
		UIEditForm->Edit4->Text = IntToStr(p->width);
		UIEditForm->Edit5->Text = IntToStr(p->height);
		UIEditForm->Edit_text->Text = p->text;
		UIEditForm->Edit_resourceName->Text = p->resName;
		UIEditForm->Edit_audio->Text = p->audio;
		UIEditForm->Edit_scaleX->Text = p->scaleX;
		UIEditForm->Edit_scaleY->Text = p->scaleY;

		//char buf[234] = {0};
		//sprintf(buf, "%d   %d  %d", p->x,p->y,p->type);
		//MessageBoxA(NULL,buf,"aa",0);

		   //	UIEditForm->AnimNameComboBox->ItemIndex = getAnimationIDByName(p->resName);

		UIEditForm->ComboBox_type->ItemIndex = p->type;
        //第一次进来的时候，type只有一个默认值
		UIEditForm->CheckBox_ExpandSelectRange->Checked = false;
		UIEditForm->LaShenSelectRange->Checked = true;

		if(p->type == UI_BUTTON)
		{
			UIEditForm->CheckBox_ExpandSelectRange->Checked = p->IsExpand;
			UIEditForm->LaShenSelectRange->Checked = p->IsLaShen;
		}

		UIEditForm->ComboBox_fontAlign->ItemIndex = p->align >= 0 ? p->align % 3 : 1;
		UIEditForm->ComboBox_fontVAlign->ItemIndex = (p->align >=0 && p->align < 9) ? p->align / 3 : 1;
		UIEditForm->ComboBox_fontName->ItemIndex = p->select < 0 ? 0 : p->select;
		TWICImage* img = (TWICImage*)(g_pics->Items[p->picID]);

		UIEditForm->SpinEdit1->Value = p->width * 100 / img->Width ;
		UIEditForm->SpinEdit2->Value = p->height * 100 / img->Height;

		UIEditForm->SpinEdit_tag->Value = p->tag;

		if (p->fontColor > 256*256*256) 
		{
			p->fontColor = 0;
		}
        UIEditForm->ColorBox_fontColor->Selected = p->fontColor;
		gSet = true ;
		unsigned int r = p->fontColor%256;//Edit_R->Text.toInt()
		unsigned int g = (p->fontColor/256)%256;//Edit_G->Text.toInt()
		unsigned int b = (p->fontColor/65536)%256;//Edit_B->Text.toInt()
		UIEditForm->Edit_R->Text = r;
		UIEditForm->Edit_G->Text = g;
		UIEditForm->Edit_B->Text = b;
		gSet = false ;
        if (p->fontColor != -1) {

//            UIEditForm->ColorBox_fontColor->ItemIndex = UIEditForm->ColorBox_fontColor->Items->IndexOf(p->fontColorName);
        }


        UIEditForm->ComboBox_fontSize->ItemIndex = UIEditForm->ComboBox_fontSize->Items->IndexOf(p->fontSize < 0 ? 30 : p->fontSize);

		switch (p->type)
		{

    	}

		UIEditForm->PanelShow(p->type);

		UIEditForm->ComboBox_useRTF->ItemIndex = p->useRTF;
		UIEditForm->ComboBox_textShade->ItemIndex = p->textShade;

		switch (p->type)
		{
			case UI_BUTTON:
            {
				UIEditForm->ComboBox_buttonStatus->ItemIndex = p->buttonStatus;
				UIEditForm->Edit_buttonDown->Text = p->buttonDownName;
				UIEditForm->Edit_buttonDisabled->Text = p->buttonDisabledName;
				UIEditForm->Edit_buttonChecked->Text = p->buttonCheckedName;


            }
			break;
			case UI_PROGRESS_BAR:
            {
				UIEditForm->ProgressBarChangePending = true;
				UIEditForm->Edit_progressBarImage->Text = p->progressBarImage;
				UIEditForm->ComboBox_progressBarValue->ItemIndex = 100 - p->progressBarValue;
				UIEditForm->Edit_progressBarX->Text = p->progressBarRect.x;
				UIEditForm->Edit_progressBarY->Text = p->progressBarRect.y;
				UIEditForm->Edit_progressBarWidth->Text = p->progressBarRect.width;
				UIEditForm->Edit_progressBarHeight->Text = p->progressBarRect.height;
				UIEditForm->ProgressBarChangePending = false;
            }
			break;
            case UI_FRAME:
            {
                UIEditForm->ComboBox_frameType->ItemIndex = p->frameType;
            }
            break;
			case UI_UISCROLLLIST:
            {
				UIEditForm->ComboBox_scrollListAlign->ItemIndex = p->scrollAlign;
				UIEditForm->Edit_scrollListMargin->Text = p->scrollMargin;
            }
            break;
			case UI_UISCROLLVIEW:
            {
				UIEditForm->ComboBox_scrollViewAlign->ItemIndex = p->scrollAlign;
            }
            break;
			case UI_UISCROLLPAGE:
			{
				UIEditForm->ComboBox_scrollPageAlign->ItemIndex = p->scrollAlign;
				UIEditForm->Edit_scrollPageMargin->Text = p->scrollMargin;
			}
			break;
			case UI_TEXT:
			{

			}
			break;
			default:
				break;
		}
	}

	gSet = false;
}

int _StrToInt(const System::UnicodeString& name )
{
	if (name=="") {
		return 0;
	}

	if (!IsInteger(name))
		return 0;

	int n = 0;

	n = StrToInt(name);

    return n;
}

float UnicodeStringToFloat(UnicodeString text, float defaultFloat)
{
	float t = defaultFloat;
	AnsiString as = text;
	if (1 == sscanf(as.c_str(), "%f", &t))
		return t;

    return defaultFloat;
}

int UnicodeStringToInt(UnicodeString text, int defaultInt)
{
    int val = defaultInt;

    if (text.Length() > 0)
    {
		if (! IsInteger(text))
			return defaultInt;

		return text.ToInt();
    }

    return val;
}

void GetUIData( )
{
	if (gSet) {
        return;
	}

	if ( GetSelUI() !=  -1 ) {
	    UIBase* p = (UIBase*)(g_oneUI->UIs->Items[GetSelUI()]);

		p->audio = UIEditForm->Edit_audio->Text;
		p->scaleX = UnicodeStringToFloat(UIEditForm->Edit_scaleX->Text, 0);
		p->scaleY = UnicodeStringToFloat(UIEditForm->Edit_scaleY->Text, 0);

		p->name = UIEditForm->Edit_cName->Text;
        p->resName = UIEditForm->Edit_resourceName->Text;
        int tmpPicId = GetImageID(p->resName);
        if (tmpPicId >= 0) {
            p->picID = tmpPicId;
        }
		p->x = UnicodeStringToInt(UIEditForm->Edit2->Text, 0);
		p->y = UnicodeStringToInt(UIEditForm->Edit3->Text, 0);

		p->tag = _StrToInt(UIEditForm->SpinEdit_tag->Text);

		if (UsedBILI) {
        	TWICImage* img = (TWICImage*)(g_pics->Items[p->picID]);

			p->width = UIEditForm->SpinEdit1->Value * img->Width  / 100;
			p->height = UIEditForm->SpinEdit2->Value * img->Height / 100;
		}
		else
		{
			TWICImage* img = (TWICImage*)(g_pics->Items[p->picID]);
            p->picWidth = img->Width;
            p->picHeight = img->Height;
			p->width = _StrToInt(UIEditForm->Edit4->Text);
			p->height = _StrToInt(UIEditForm->Edit5->Text);

			if (p->width < 1) {
		   		p->width = 1;
			}

			if (p->height < 1) {
			   p->height = 1;
			}

			//UIEditForm->SpinEdit1->Value = p->width;// * 100 / img->Width;
			//UIEditForm->SpinEdit2->Value = p->height;// * 100 / img->Height;
		}

		p->text = UIEditForm->Edit_text->Text;

		if (UIEditForm->ComboBox_type->ItemIndex != p->type)
		{
			// 旧类型的处理
			switch (p->type)
			{
				case UI_BUTTON:
				{
					p->buttonDownName = u"";
					p->buttonDisabledName = u"";
					p->buttonCheckedName = u"";
					p->buttonStatus = 0;

                    UIEditForm->Label_optionalMsg->Caption = "";
				}
				break;
                case UI_PROGRESS_BAR:
                {
                    p->progressBarImage = "";
                    AttachRect ar = {0, 0, 0, 0};
                    p->progressBarRect = ar;
                    p->progressBarValue = 100;
                }
                break;
				case UI_UISCROLLLIST:
				case UI_UISCROLLPAGE:
				case UI_UISCROLLVIEW:
				{
					p->scrollAlign = 1;
					p->scrollMargin = 0;
				}
                break;
                case UI_FRAME:
                {
                }
                break;
				case UI_TEXT:
				{

				}
				break;
			}

			p->textShade = 0;
			p->useRTF = 0;
			p->type = UIEditForm->ComboBox_type->ItemIndex;

			//新类型的处理。 初始化.
            UIEditForm->PanelShow(p->type);
			switch (p->type)
			{
				case UI_BUTTON:
				{
                   // UIEditForm->ProgressBarHide();
                   // UIEditForm->ButtonShow();

				   	p->buttonStatus = 0;

					p->buttonDownName = "";
					p->buttonDisabledName = "";
					p->buttonCheckedName = "";

                    UIEditForm->ButtonEventPending(true);
					UIEditForm->ComboBox_buttonStatus->ItemIndex = p->buttonStatus;
					UIEditForm->Edit_buttonDown->Text = p->buttonDownName;
					UIEditForm->Edit_buttonDisabled->Text = p->buttonDisabledName;
					UIEditForm->Edit_buttonChecked->Text = p->buttonCheckedName;
                    UIEditForm->ButtonEventPending(false);

				}
				break;
				case UI_PROGRESS_BAR:
				{
					p->progressBarImage = p->resName;
                    AttachRect ar = {0, 0, p->width, p->height};
                    p->progressBarRect = ar;
					p->progressBarValue = 100;

					UIEditForm->ProgressBarChangePending = true;
                    UIEditForm->Edit_progressBarImage->Text = p->progressBarImage;
					UIEditForm->ComboBox_progressBarValue->ItemIndex = 100 - p->progressBarValue;
					UIEditForm->Edit_progressBarX->Text = p->progressBarRect.x;
                    UIEditForm->Edit_progressBarY->Text = p->progressBarRect.y;
					UIEditForm->Edit_progressBarWidth->Text = p->progressBarRect.width;
                    UIEditForm->Edit_progressBarHeight->Text = p->progressBarRect.height;
					UIEditForm->ProgressBarChangePending = false;
				}
				break;
				case UI_UISCROLLLIST:
                {
					p->scrollAlign = 1;
					p->scrollMargin = 0;
					UIEditForm->ComboBox_scrollListAlign->ItemIndex = p->scrollAlign;
					UIEditForm->Edit_scrollListMargin->Text = p->scrollMargin;
                }
                break;
				case UI_UISCROLLPAGE:
                {
					p->scrollAlign = 1;
					p->scrollMargin = 0;
					UIEditForm->ComboBox_scrollPageAlign->ItemIndex = p->scrollAlign;
					UIEditForm->Edit_scrollPageMargin->Text = p->scrollMargin;
                }
                break;
				case UI_UISCROLLVIEW:
				{
					p->scrollAlign = 1;
					p->scrollMargin = 0;
					UIEditForm->ComboBox_scrollViewAlign->ItemIndex = p->scrollAlign;
				}
				break;
                case UI_FRAME:
                {
                    UIEditForm->ComboBox_frameType->ItemIndex = 0;
                    p->frameType = 0;
                }
                break;
				case UI_TEXT:
				{

				}
				break;
                default:
                    break;
			}
			UIEditForm->ComboBox_textShade->ItemIndex = 0;
			p->textShade = 0;
			UIEditForm->ComboBox_useRTF->ItemIndex = 0;
			p->useRTF = 0;
		}
        else
        {
			switch (p->type)
			{
				case UI_BUTTON:
				{
					p->buttonStatus = UIEditForm->ComboBox_buttonStatus->ItemIndex;
					p->buttonDownName = UIEditForm->Edit_buttonDown->Text;
					p->buttonDisabledName = UIEditForm->Edit_buttonDisabled->Text;
					p->buttonCheckedName = UIEditForm->Edit_buttonChecked->Text;
				}
				break;
				case UI_PROGRESS_BAR:
				{
					p->progressBarImage = UIEditForm->Edit_progressBarImage->Text;
					int rx = 0, ry = 0, width = p->width, height = p->height;
                    rx = UnicodeStringToInt(UIEditForm->Edit_progressBarX->Text, 0);
                    ry = UnicodeStringToInt(UIEditForm->Edit_progressBarY->Text, 0);
                    width = UnicodeStringToInt(UIEditForm->Edit_progressBarWidth->Text, p->width);
                    height = UnicodeStringToInt(UIEditForm->Edit_progressBarHeight->Text, p->height);

                    AttachRect ar = {rx, ry, width, height};
					p->progressBarRect = ar;
					p->progressBarValue = 100 - UIEditForm->ComboBox_progressBarValue->ItemIndex;
				}
				break;
				case UI_UISCROLLLIST:
                {
                    p->scrollAlign = UIEditForm->ComboBox_scrollListAlign->ItemIndex;
					p->scrollMargin = UIEditForm->Edit_scrollListMargin->Text.Length() ? UIEditForm->Edit_scrollListMargin->Text.ToInt() : 0;
                }
                break;
				case UI_UISCROLLPAGE:
                {
                    p->scrollAlign = UIEditForm->ComboBox_scrollPageAlign->ItemIndex;
					p->scrollMargin = UIEditForm->Edit_scrollPageMargin->Text.Length() ? UIEditForm->Edit_scrollPageMargin->Text.ToInt() : 0;
                }
                break;
				case UI_UISCROLLVIEW:
				{
					p->scrollAlign = UIEditForm->ComboBox_scrollViewAlign->ItemIndex;
				}
                break;
                case UI_FRAME:
                {
                    p->frameType = UIEditForm->ComboBox_frameType->ItemIndex;
                }
				break;
				case UI_TEXT:
				{

				}
				break;
				default:
					break;
            }
			p->textShade = UIEditForm->ComboBox_textShade->ItemIndex;
			p->useRTF = UIEditForm->ComboBox_useRTF->ItemIndex;
        }


		p->align = (UIEditForm->ComboBox_fontAlign->ItemIndex
			+ UIEditForm->ComboBox_fontVAlign->ItemIndex * 3);
		p->select = UIEditForm->ComboBox_fontName->ItemIndex;

		//p->fontColor = UIEditForm->ColorBox_fontColor->Selected;
		
		unsigned int r = UIEditForm->Edit_R->Text.ToInt();
		unsigned int g = UIEditForm->Edit_G->Text.ToInt();
		unsigned int b = UIEditForm->Edit_B->Text.ToInt() ;
		p->fontColor = b*65536 + g*256 + r;
		UIEditForm->Label_fontColor->Font->Color = p->fontColor;
        int idx = UIEditForm->ColorBox_fontColor->ItemIndex;
        idx = idx < 0 ? 0 : idx;
		p->fontColorName = UIEditForm->ColorBox_fontColor->ColorNames[idx];
        //ShowMessage(p->fontColorName);
		p->fontSize = UIEditForm->ComboBox_fontSize->Text.ToInt();
        PaintUIs();
	}
    else
    {
        UIEditForm->PanelAllHide();
    }

}



UIBase* AddTextUI( const System::UnicodeString& text, int x, int y )
{
  	UIBase* p = new UIBase();

	p->text = text;

	g_oneUI->UIs->Add(p);

	return p;
}

void DeleteUI( )
{
	if (GetSelUI() >= 0 ) {

		g_tempUIs->Clear();

		for (int i = 0; i < g_oneUI->UIs->Count; i++) {

			if (IsSelUI(i)) {

			}
			else
			{
				g_tempUIs->Add(g_oneUI->UIs->Items[i]);
			}
		}

		g_oneUI->UIs->Clear();
		g_selList->Clear();

		for (int i = 0; i < g_tempUIs->Count; i++) {
			g_oneUI->UIs->Add(g_tempUIs->Items[i]);
		}

		PaintUIs();
		SetUIData();
	}
}



void UpUI()                      //wjl mark 底层
{
	if (GetSelUI() >= 0 ) {

		int pos = 0;

		g_tempUIs->Clear();
		g_tempUIs2->Clear();

		for (int i = 0; i < g_selList->Count; i++) {
		   int index = (int)g_selList->Items[i];
		   if (pos < index) {
		       pos  =  index;
		   }
		}

		for (int j = 0; j < g_oneUI->UIs->Count; j++) {
           bool found = false;

		   for (int i = 0; i < g_selList->Count; i++) {
			   int index = (int)g_selList->Items[i];
			   if (j == index) {
				   found = true;
				   break;
			   }
		   }

		   if (found) {
			   g_tempUIs->Add(g_oneUI->UIs->Items[j]);
		   }
		   else
		   {
               g_tempUIs2->Add(g_oneUI->UIs->Items[j]);
           }
		}

		int count = g_selList->Count;
		int startPos = pos-count+1 + 1;

		if (startPos + count >= g_oneUI->UIs->Count) {
          	startPos = g_oneUI->UIs->Count - count;
		}

		g_selList->Clear();
		for (int i = 0; i < count; i++) {
		   g_selList->Add((void*)(startPos+i));
		}

		g_oneUI->UIs->Clear();

		bool setData = false;
		for (int i = 0; i < g_tempUIs2->Count; i++) {



			if (startPos == i) {
				setData = true;
			   for (int j = 0; j < g_tempUIs->Count; j++) {
               		g_oneUI->UIs->Add(g_tempUIs->Items[j]);
               }
			}

				g_oneUI->UIs->Add(g_tempUIs2->Items[i]);
        }

		if (!setData) {
        	for (int j = 0; j < g_tempUIs->Count; j++) {
               		g_oneUI->UIs->Add(g_tempUIs->Items[j]);
               }
		}

		PaintUIs();
	}
}

void DownUI()
{
	if (GetSelUI() >= 0 ) {

		int pos = 10000;

		g_tempUIs->Clear();
		g_tempUIs2->Clear();

		for (int i = 0; i < g_selList->Count; i++) {
		   int index = (int)g_selList->Items[i];
		   if (pos > index) {
			   pos  =  index;
		   }
		}

		for (int j = 0; j < g_oneUI->UIs->Count; j++) {
           bool found = false;

		   for (int i = 0; i < g_selList->Count; i++) {
			   int index = (int)g_selList->Items[i];
			   if (j == index) {
				   found = true;
				   break;
			   }
		   }

		   if (found) {
			   g_tempUIs->Add(g_oneUI->UIs->Items[j]);
		   }
		   else
		   {
               g_tempUIs2->Add(g_oneUI->UIs->Items[j]);
           }
		}

		int count = g_selList->Count;
		int startPos = pos-1;

		if (startPos < 0 ) {
			startPos = 0;
		}

		g_selList->Clear();
		for (int i = 0; i < count; i++) {
		   g_selList->Add((void*)(startPos+i));
		}

		g_oneUI->UIs->Clear();

		bool setData = false;
		for (int i = 0; i < g_tempUIs2->Count; i++) {

			if (startPos == i) {
				setData = true;
			   for (int j = 0; j < g_tempUIs->Count; j++) {
               		g_oneUI->UIs->Add(g_tempUIs->Items[j]);
               }
			}
			g_oneUI->UIs->Add(g_tempUIs2->Items[i]);

		}

		if (!setData) {
        	for (int j = 0; j < g_tempUIs->Count; j++) {
               		g_oneUI->UIs->Add(g_tempUIs->Items[j]);
               }
		}

		PaintUIs();
	}
}


UIBase* AddPicUI( int id, int x, int y )
{
	if (id < 0) {
        return NULL;
	}

	UIBase* p = new UIBase();
    TWICImage* img = (TWICImage*)(g_pics->Items[id]);

	p->picID = id;
	p->x = x;
	p->y = y;
	p->width  = img->Width;
	p->height = img->Height;
	p->picWidth = img->Width;
	p->picHeight = img->Height;

	UnicodeString str = (*g_stringList)[id];
	p->resName = str;

	str = str.SubString(0,str.Length()-4);



	for (int i=1; i < 10000; i++) {


		UnicodeString name = str + i;

		bool found = false;
		for(int j=0; j<g_oneUI->UIs->Count; j++ )
		{
			UIBase* pUI = (UIBase*)(g_oneUI->UIs->Items[j]);

			if (name == pUI->name) {
                found = true;
				break;
			}
		}

		if (!found) {
			p->name = name;
			break;
		}
	}

	p->align = 1 + 1 * 3;
	p->tag = 0;

	g_oneUI->UIs->Add(p);
	return p;
}




void ResizeSet(int x, int y )
{
	const int RS_SIZE = 3;

	if (GetSelUI()>=0 && g_selList->Count == 1) {

		UIBase* p = (UIBase*)(g_oneUI->UIs->Items[GetSelUI()]);

		int dx = (x - p->x-p->width);
		int dy = (y - p->y-p->height);

		dx = abs(dx);
		dy = abs(dy);

		if ( dx < RS_SIZE && dy < RS_SIZE )
		{
			gResizeType = RT_ALL;
			UIEditForm->Image1->Cursor = crSizeNWSE;
		}
		else if (dx <RS_SIZE) {
			gResizeType = RT_LEFT_RIGHT;
			UIEditForm->Image1->Cursor = crSizeWE;
		}
		else if (dy <RS_SIZE) {
			gResizeType = RT_TOP_BOTTOM;
			UIEditForm->Image1->Cursor = crSizeNS;
		}
		else
		{
			gResizeType = RT_NONE;
			UIEditForm->Image1->Cursor = crDefault;
        }
	}
	else
	{
		gResizeType = RT_NONE;
		UIEditForm->Image1->Cursor = crDefault;
    }
}

bool IsSelUI(int sel)
{
  		for (int i = 0; i < g_selList->Count; i++) {
		   int index = (int)g_selList->Items[i];
		   if (sel == index) {
			   return true;
		   }
		}

		return false;
}

UIBase* AddSel( int sel, bool add );
UIBase* SelectUI( int x, int y )
{
	int value = GetKeyState( VK_CONTROL );
	bool Ctrl = value < 0 ;


	int sel =  -1;

	for (int n =0; n < g_oneUI->UIs->Count; n++) {

		int i = g_oneUI->UIs->Count - n - 1;

		/*
		if (selUI >= 0) {
			i = (selUI+n) % UIs->Count;
		}
		*/

		UIBase* p = (UIBase*)(g_oneUI->UIs->Items[i]);

		if ( (x > p->x)
			&& (y > p->y)
			&& (x < p->x+p->width)
			&& (y < p->y+p->height)
			)
		{
			sel = i;
			break;
		}
	}

    /*
	if ( selUI != i) {
				selUI = i;
				SetUIData();
				return p;
			}
			else
			{
				return (UIBase*)UIs->Items[selUI];
			}
		*/
//UIEditForm->PanelHide();
	 if (sel == -1)
	 {
		if ( GetSelUI() != -1 )
		{
			g_selList->Clear();
			SetUIData();
		}

		return NULL;
	 }
	 else
	 {
		 return AddSel( sel, Ctrl );
     }

}

UIBase* AddSel( int sel, bool add )
{
	bool found = false;
	for (int i = 0; i < g_selList->Count; i++) {
		   int n = (int)g_selList->Items[i];
		   if (sel == n) {
			   found = true;
		   }
	}

	if (add) {
		if (found) {
        	return (UIBase*)(g_oneUI->UIs->Items[sel]);
		}

		g_selList->Add((void*)sel);

	}
	else
	{
		if (found) {
           return (UIBase*)(g_oneUI->UIs->Items[sel]);
		}

		g_selList->Clear();
		g_selList->Add((void*)sel);
		SetUIData();
	}
	return (UIBase*)(g_oneUI->UIs->Items[sel]);
}

TBitmap* gBuf = new TBitmap;


void BrushCopyEx( TCanvas* canvas, TRect& des, TWICImage* img, TRect& src )
{
	HRGN MyRgn;

	MyRgn = ::CreateRectRgn(des.left,des.top,des.right,des.bottom);
	::SelectClipRgn(canvas->Handle,MyRgn);

	canvas->Draw( des.left - src.left,  des.top - src.top, img);

	::SelectClipRgn(canvas->Handle,NULL);
	::DeleteObject(MyRgn);
}

bool rechangeList = true;
void PaintUIs()
{
	//static bool drawFocus = false;
	if ( dragUI != NULL )
	{
		static TList* rectList       = new TList;


		for (int i = 0; i < rectList->Count; i++) {

			TRect* rt = (TRect*)rectList->Items[i];
			UIEditForm->Image1->Canvas->DrawFocusRect(*rt);

			delete rt;
		}

		rectList->Clear();

		for (int i = 0; i < g_selList->Count; i++)
		{
			int index  = (int)g_selList->Items[i];
			UIBase* p = (UIBase*)(g_oneUI->UIs->Items[index]);

			TRect* rt = new TRect();

			rt->init( p->x + gX, p->y + gY,
			p->x + p->width + gX, p->y + p->height + gY );

			UIEditForm->Image1->Canvas->DrawFocusRect(*rt);

			rectList->Add(rt);
        }

		return;
	}

	if (rechangeList) {
		UIEditForm->ListBox1->Clear();

		int left  =  99999;
		int top   =  99999;
		int bottom = -99999;
		int right = -99999;

		for (int i =0; i < g_oneUI->UIs->Count; i++) {
			int index = g_oneUI->UIs->Count-1-i;
			UIBase* p = (UIBase*)(g_oneUI->UIs->Items[index]);

			UIEditForm->ListBox1->Items->Add(p->name) ;

			if (left > p->x) {
				left = p->x;
			}

			if (top > p->y) {
				top = p->y;
			}

			if (bottom < p->y + p->height) {
				bottom = p->y + p->height;
			}

			if (right < p->x + p->width) {
				right = p->x + p->width;
			}

			if (IsSelUI(index) ){
            	UIEditForm->ListBox1->Selected[i] = true;
			}
		}

		System::UnicodeString str =  "(";
		UIEditForm->Label11->Caption = str + left + "," + top
										+ "), " + (right-left) + "*" + (bottom-top);
	}


	if ((gBuf->Width != UIEditForm->Image1->ClientWidth )
		|| (gBuf->Height != UIEditForm->Image1->ClientHeight ) )
	{
		gBuf->SetSize(UIEditForm->Image1->ClientWidth, UIEditForm->Image1->ClientHeight);

	}

	TCanvas* canvas = gBuf->Canvas;

	canvas->Brush->Color = 0xFFFFFF;
	canvas->Pen->Color = 0xFFFFFF;
	canvas->Rectangle(0,0,gBuf->Width,gBuf->Height);

	canvas->Pen->Color = 0x8F8F8F;

	canvas->Rectangle(  gX - gScreenWidth/2, gY - gScreenHeight/2,
						gX + gScreenWidth/2 , gY + gScreenHeight/2);

	canvas->Pen->Color = 0xFFFF00;
	canvas->MoveTo(0,gY);
	canvas->LineTo(gBuf->Width,gY);
	canvas->MoveTo(gX,0);
	canvas->LineTo(gX,gBuf->Height);


   //	Form2->CheckListBox1->Items->Clear();
	for (int i =0; i < g_oneUI->UIs->Count; i++)
	{
		UIBase* p = (UIBase*)(g_oneUI->UIs->Items[i]);
   //		Form2->CheckListBox1->Items->Add(p->name);
		if( p->picID >= 0 )
		{
            int picID = p->picID;
            if (p->type == UI_BUTTON && p->buttonStatus != 0)
            {
                for (;;)
                {
                    int tmpPicID = picID;
                    if (p->buttonStatus == 1 && (tmpPicID = GetImageID(p->buttonDownName)) >= 0)
                    {
                        picID = tmpPicID;
                        break;
                    }
                    if (p->buttonStatus == 2 && (tmpPicID = GetImageID(p->buttonDisabledName)) >= 0)
                    {
                        picID = tmpPicID;
                        break;
                    }
					if (p->buttonStatus == 3 && (tmpPicID = GetImageID(p->buttonCheckedName)) >= 0)
                    {
                        picID = tmpPicID;
                        break;
                    }
                    break;
                }
            }
			TWICImage* img = picID < 0 ? 0 : (TWICImage*)(g_pics->Items[picID]);
			TRect* rects = picID < 0 ? 0 : (TRect*)(g_picRects->Items[picID]);
			#if 1

			if (rects != NULL ) {
				TRect drawRect;
				drawRect.left = gX+p->x;
				drawRect.top =  gY+p->y;
				drawRect.right =  gX+p->x+p->width;
				drawRect.bottom = gY+p->y+p->height;

				TRect cRect;
				cRect.left = drawRect.left +  rects[0].Width();
				cRect.top =  drawRect.top +  rects[0].Height();
				cRect.right = drawRect.right -  rects[8].Width();
				cRect.bottom = drawRect.bottom -  rects[8].Height();

				for (int i = cRect.left; i < cRect.right; i+=rects[4].Width() ) {
					for (int j = cRect.top; j < cRect.bottom; j+=rects[4].Height() ) {
						TRect des;
						TRect src;

						des.init( i, j,
							i+rects[4].Width(), j+rects[4].Height() );

						src = rects[4];


						if ( des.right > cRect.right ) {
							des.right = cRect.right;
							src.right = src.left + des.Width();
						}

						if ( des.bottom > cRect.bottom ) {
							des.bottom = cRect.bottom;
							src.bottom = src.top + des.Width();
						}

						BrushCopyEx( canvas, des, img, src  );
					}
                }

				for (int i = cRect.left; i < cRect.right; i+=rects[1].Width() ) {

					TRect des;
					TRect src;

					des.init( i, drawRect.top,
						i+rects[1].Width(), drawRect.top+rects[1].Height() );

					src = rects[1];


					if ( des.right > cRect.right ) {
						des.right = cRect.right;
						src.right = src.left + des.Width();
					}

					BrushCopyEx( canvas, des, img, src  );

					des.init( i, cRect.bottom,
						i+rects[7].Width(), cRect.bottom+rects[7].Height() );

					src = rects[7];


					if ( des.right > cRect.right ) {
						des.right = cRect.right;
						src.right = src.left + des.Width();
					}

					BrushCopyEx( canvas, des, img, src  );

				}

				for (int i = cRect.top; i < cRect.bottom; i+=rects[3].Height() ) {

					TRect des;
					TRect src;

					des.init( drawRect.left, i,
						drawRect.left+rects[3].Width(), i+rects[3].Height() );

					src = rects[3];


					if ( des.bottom > cRect.bottom ) {
						des.bottom = cRect.bottom;
						src.bottom = src.top + des.Height();
					}

					BrushCopyEx( canvas, des, img, src  );

					des.init( cRect.right, i,
						cRect.right+rects[5].Width(), i+rects[5].Height() );

					src = rects[5];


					if ( des.bottom > cRect.bottom ) {
						des.bottom = cRect.bottom;
						src.bottom = src.top + des.Height();
					}

					BrushCopyEx( canvas, des, img, src  );

				}

				TRect des;
				des.init(drawRect.left,drawRect.top,cRect.left,cRect.top);
				BrushCopyEx( canvas, des, img, rects[0]  );

				des.init(drawRect.left,cRect.bottom,cRect.left,drawRect.bottom);
				BrushCopyEx( canvas, des, img, rects[6]  );

				des.init(cRect.right,drawRect.top,drawRect.right,cRect.top);
				BrushCopyEx( canvas, des, img, rects[2]  );

				des.init(cRect.right,cRect.bottom,drawRect.right,drawRect.bottom);
				BrushCopyEx( canvas, des, img, rects[8]  );


			}
			else
			{

				TRect rect;
				rect.left = gX+p->x;
				rect.top =  gY+p->y;
				rect.right =  gX+p->x+p->width;
				rect.bottom = gY+p->y+p->height;
				if (img)
				{
					canvas->StretchDraw( rect,img);
				}
				else
				{

				}
			}
			#else
			if (img)
			{
				canvas->Draw( gX+p->x, gY+p->y, img);
			}
			#endif

			// draw progress bar

			switch (p->type)
			{
			case UI_PROGRESS_BAR:
			{
				int barPicID = GetImageID(p->progressBarImage);
				if (barPicID < 0)
				{
					break;
				}
				TWICImage* barImage = (TWICImage*)(g_pics->Items[barPicID]);
				float percentProgress = (p->progressBarValue) / 100.0f;

				TRect rect;
				rect.left = gX+p->x+p->progressBarRect.x;
				rect.bottom = gY+p->y+p->height-p->progressBarRect.y;
				rect.top =  rect.bottom-p->progressBarRect.height;
				rect.right =  rect.left+p->progressBarRect.width * percentProgress;

				canvas->StretchDraw(rect, barImage);
			}
			break;
            case UI_FRAME:
            {
                UIFrameRect rect = UIFrameRect::getContentRect(p->frameType, p->x, p->y, p->width, p->height);
                UIFrameRect* r = &rect;
                canvas->Pen->Color = 0x0000FF;
				canvas->MoveTo(r->x+gX, r->y+gY);
				canvas->LineTo(r->x+gX+r->width, r->y+gY );
				canvas->LineTo(r->x+gX+r->width, r->y+gY+r->height );
				canvas->LineTo(r->x+gX, r->y+gY+r->height );
				canvas->LineTo(r->x+gX, r->y+gY);
            }
            break;
			}


			if (g_bWireFrameState)
			{
                canvas->Pen->Color = 0x00FF5A;
				canvas->MoveTo(p->x+gX, p->y+gY);
				canvas->LineTo(p->x+gX+p->width, p->y+gY );
				canvas->LineTo(p->x+gX+p->width, p->y+gY+p->height );
				canvas->LineTo(p->x+gX, p->y+gY+p->height );
				canvas->LineTo(p->x+gX, p->y+gY);
			}
		}



		if( p->text != "" )
		{
			int bsstyle = canvas->Brush->Style;
			int fontSize = canvas->Font->Size;
            int fontColor = canvas->Font->Color;
			canvas->Brush->Style = bsClear;
            canvas->Font->Name = "Marker Felt";
			canvas->Font->Size = p->fontSize * 0.75;
			canvas->Font->Color = p->fontColor;

			int x = p->x+gX;
			int y=  p->y+gY;

			int h = canvas->TextHeight(p->text);
			int w = canvas->TextWidth(p->text);

			switch ( p->align %3 ) {
			case 1:
				x += p->width/2 - w/2;
				break;
			case 2:
				x += p->width - w;
				break;
			}

			switch ( p->align /3 ) {
			case 1:
				y += p->height/2 - h/2;
				break;
			case 2:
				y += p->height - h;
				break;
			}

			canvas->TextOutW( x, y,  p->text );

			canvas->Brush->Style = bsstyle;
			canvas->Font->Size = fontSize * 0.75;
			canvas->Font->Color = fontColor;
		}


		if ( IsSelUI( i ) )
		{
			UIBase* pSelected = (UIBase*)(g_oneUI->UIs->Items[i]);
			canvas->Pen->Color = 0x0000FF;
			canvas->MoveTo(pSelected->x+gX, pSelected->y+gY);
			canvas->LineTo(pSelected->x+gX+p->width, pSelected->y+gY );
			canvas->LineTo(pSelected->x+gX+p->width, pSelected->y+gY+p->height );
			canvas->LineTo(pSelected->x+gX, pSelected->y+gY+p->height );
			canvas->LineTo(pSelected->x+gX, pSelected->y+gY);
		}
	}

   //	Form2->paintBox->Repaint();
	UIEditForm->Image1->Canvas->Draw(0,0,gBuf);
}



int GetImageID(const System::UnicodeString& name)
{
	for (int i=0; i < g_stringList->Count; i++) {
		if ( (*g_stringList)[i] == name) {
			return i;
		}
	}

	return -1;
}

TRect* GetImageRect9(const System::UnicodeString& name, TWICImage* p)
{
	//ScanLine
	int len = name.Length();
	UnicodeString fileName = name.SubString(0, len-4);
    fileName +=	".txt";


	int iFileHandle = FileOpen(fileName, fmOpenRead);

	if (iFileHandle < 0) {
        return NULL;
	}

	int iFileLength = FileSeek(iFileHandle, 0, 2);
	FileSeek(iFileHandle,0,0);
	AnsiChar* pszBuffer = new AnsiChar[iFileLength+1];
	FileRead(iFileHandle, pszBuffer, iFileLength);
	FileClose(iFileHandle);

	TRect* rects = new TRect[9];

	int n[4] = {0};

	//int m = 0;
	int pos = 0;
	for (int i = 0; i < iFileLength; i++) {
		if ( (pszBuffer[i] == ',' )
			//|| (pszBuffer[i] == '\n' )
			) {
			//n[pos] = m;
			//m = 0;
			pos++;
		}
		else if (pszBuffer[i]>='0' && pszBuffer[i]<='9') {

			n[pos] = n[pos] * 10 + pszBuffer[i] - '0';
        }
	}


	delete[] pszBuffer;

	int x1 = n[0];
	int x2 = n[2];
	int x3 = p->Width;
	int y1 = n[1];
	int y2 = n[3];
	int y3 = p->Height;


	rects[0].init(0,0,x1,y1);
	rects[1].init(x1,0,x2,y1);
	rects[2].init(x2,0,x3,y1);

	rects[3].init(0,y1,x1,y2);
	rects[4].init(x1,y1,x2,y2);
	rects[5].init(x2,y1,x3,y2);

	rects[6].init(0,y2,x1,y3);
	rects[7].init(x1,y2,x2,y3);
	rects[8].init(x2,y2,x3,y3);


	return rects;
}

TWICImage* GetImage(const System::UnicodeString &resPath, const System::UnicodeString& name)
{
	int index = GetImageID(name);

	if ( index >= 0 ) {
		return (TWICImage*)(g_pics->Items[index]);
	}
	else
	{
		TWICImage* p = new TWICImage();
		p->LoadFromFile(name);
		p->Transparent = true;

		//TBitmap* bitmap = new TBitmap();
		//	bitmap->Transparent   =   true;
		//bitmap->Assign(p);

		//delete p;

		g_pics->Add(p);
		int len = resPath.Length();
		System::UnicodeString fileName = name.SubString(len+1,name.Length()-len);
		System::UnicodeString checker = "\Res";
		int pos =  fileName.Pos(checker);
		if (0 < pos)
		{
			System::UnicodeString otherfileName = fileName.SubString(pos + 4, fileName.Length());
			g_stringList->Add(otherfileName);
			if (0 < otherfileName.Pos("PanelType1")) {
				int i = 0;
			}

		}
		else
		{
			g_stringList->Add(fileName);
		}

		TRect* rects = GetImageRect9(name,p);
		g_picRects->Add( rects  );

		return p;
	}
}

bool InitConfig()
{
    return true;
}

bool LoadLanguage(TUIEditForm* self)
{
	TDirectory * dir = new TDirectory ;

	XmlNetbargpp->Active = true;

	//读取
    System::UnicodeString configXmlPath = ExtractFilePath(Application->ExeName) + _UI_Configs_::UIRes_picsConfigFileName;
	XmlNetbargpp->LoadFromFile(configXmlPath);
	_di_IXMLNode root = XmlNetbargpp->DocumentElement;


//	XmlNetbargpp->DocumentElement->ChildNodes

	_di_IXMLNode UILanguagePathNode = root->ChildNodes->FindNode("LanguagePath");

    //bool existLanguageFile = false;
	for(int j = 0; j < UILanguagePathNode->GetChildNodes()->GetCount(); j++)
	{
	    if (UILanguagePathNode->GetChildNodes()->Nodes[j]->GetNodeName() != "path")
            continue;

		System::UnicodeString pathstr = UILanguagePathNode->GetChildNodes()->Nodes[j]->GetText();

        pathstr = DirClear(pathstr);
        string clearpath;
		AnsiString path = pathstr;
        if (!FSUtils::GetClearPath(path.c_str(), clearpath))
        {
            clearpath = path.c_str();
        }
        if (FSUtils::DirectoryExists(clearpath.c_str()))
        {
            if (!UI_SUCCESS(UIDataSetLanguageDir(clearpath.c_str())))
            {
                return false;
            }
           // existLanguageFile = true;
            break;
        }
	}
	/*
    if (!existLanguageFile)
    {
        _di_IXMLNode node = UILanguagePathNode->AddChild("path");
        node->SetText("zh_cn.lua");
        if (!UI_SUCCESS(UIDataLanguageCreate("zh_cn.lua", true)))
        {
          //  ShowMessage("创建初始化语言文件zh_ch.lua失败");
            return false;
        }
    }*/



    XmlNetbargpp->SaveToFile(configXmlPath);
	XmlNetbargpp->Active=false;
    return true;
}

void LoadSpecialEffectIcon()
{
   //_UI_Configs_::UIRes_EffectPathName;
}

int LoadSeperatePics(int StartIndex, TUIEditForm* self, const System::UnicodeString &resPath, ::System::TStringDynArray files, int len)
{
	int CorrectCount = 0;
    TBitmap* bitmap = new TBitmap();
	bitmap->SetSize(64,64);

	int n = 0;

	for (int i=0; i < files.Length; i++) {
		UnicodeString name = files[i].SubString(len+1,files[i].Length()-len);
		const UnicodeString DownStr= "_down.png";
		if (name.Length() > DownStr.Length() ) {
			int n = DownStr.Length();
			UnicodeString subName = name.SubString( name.Length() - n+1,  n );

			if (subName == DownStr) {
               	continue;
			}
		}

		int index = GetImageID( name );
		if (index >= 0) {
            continue;
		}
        CorrectCount++;
		TWICImage* p = GetImage(resPath, files[i] );

		if (p != NULL) {

			TRect rt(0,0,64,64);
			bitmap->Canvas->FillRect(rt);

			if (p->Width > p->Height) {
				rt.SetHeight( rt.Height() * p->Height / p->Width );
			}
			else
			{
				rt.SetWidth( rt.Width() * p->Width / p->Height );
            }

			bitmap->Canvas->StretchDraw(rt,p);
			self->ImageList1->Add(bitmap,NULL);

			TListItem* it = self->ListView1->Items->Add();
			it->ImageIndex = n + StartIndex;
			it->Caption = name;
			n++;
		}
	}
	delete bitmap;
	return CorrectCount;
}

int g_startIndex = 0;
set<UnicodeString> g_AddedPath; // static
set<UnicodeString> g_StaticPath; // static

void AddDirToTree(TUIEditForm* self, const UnicodeString& dir)
{

	//TTreeNode* node = self->TreeView2->Items->GetFirstNode();
	//ShowMessage(self->TreeView2->Items->Count);
    if (g_AddedPath.find(dir) != g_AddedPath.end())
    {
        return;
    }
    else
    {
        g_AddedPath.insert(dir);
    }
	if (g_StaticPath.find(dir) == g_StaticPath.end())
	{
        if (self->TreeView2->FindChildControl(dir))
            return;
		self->TreeView2->Items->Add(0, dir);
	}
	else
	{
        if (self->TreeView1->FindChildControl(dir))
            return;
		self->TreeView1->Items->Add(0, dir);
	}

}

void ClearDirToTree(TUIEditForm* self)
{
	self->TreeView2->Items->Clear();
	//self->TreeView2->Items->Add(0, "动态目录");
	g_StaticPath.clear();
	g_picRects->Clear();
	g_pics->Clear();
	g_stringList->Clear();
    self->ListView1->Items->Clear();
    self->ImageList1->Clear();
    int i = self->ListView1->ItemIndex;
	//self->ListView1->Clear();
	//self->ListView1->ImageIndex = 0;
	g_dirSet.clear();
	g_newDirSet.clear();
    g_AddedPath.clear();
	g_startIndex = 0;
	//self->ImagePic->Canvas->

}


void LoadPics(TUIEditForm* self)
{
	TDirectory * dir = new TDirectory ;

	XmlNetbargpp->Active = true;

	//读取
    System::UnicodeString configXmlPath = ExtractFilePath(Application->ExeName) + _UI_Configs_::UIRes_picsConfigFileName;
	XmlNetbargpp->LoadFromFile(configXmlPath);
	_di_IXMLNode root = XmlNetbargpp->DocumentElement;
	System::UnicodeString GameTDJpathtext = XmlNetbargpp->DocumentElement->ChildNodes->FindNode(gamepath)->GetAttribute("path");
	gPath = GameTDJpathtext;

//	XmlNetbargpp->DocumentElement->ChildNodes




	System::UnicodeString* pathes = new System::UnicodeString();
	int UIpathCount = 0;

	_di_IXMLNode UIStaticPathNode = root->ChildNodes->FindNode("StaticResourcePath");
	//_di_IXMLNode UIDynamicResPathNode = root->ChildNodes->FindNode("DynamicResourcePath");
	if (!UIStaticPathNode)
	{
		UIStaticPathNode = root->AddChild("StaticResourcePath");
        UIStaticPathNode->SetText("\n");
	}
	for(int j = 0; j < UIStaticPathNode->GetChildNodes()->GetCount(); j++)
	{
        if (UIStaticPathNode->GetChildNodes()->Nodes[j]->GetNodeName() != "path")
            continue;
        System::UnicodeString pathstr = UIStaticPathNode->GetChildNodes()->Nodes[j]->GetText();
        pathstr = DirClear(pathstr);
        g_dirSet.insert(pathstr);
		g_StaticPath.insert(pathstr);
		UIpathCount++;
	}

	_di_IXMLNode UIResPathNode = root->ChildNodes->FindNode("ResourcePath");
	//_di_IXMLNode UIDynamicResPathNode = root->ChildNodes->FindNode("DynamicResourcePath");

	for(int j = 0; j < UIResPathNode->GetChildNodes()->GetCount(); j++)
	{
        if (UIResPathNode->GetChildNodes()->Nodes[j]->GetNodeName() != "path")
            continue;
		//pathes[j] = UIResPathNode->GetChildNodes()->Nodes[j]->GetText();
		//System::UnicodeString pathstr = pathes[j];
        System::UnicodeString pathstr = UIResPathNode->GetChildNodes()->Nodes[j]->GetText();
        pathstr = DirClear(pathstr);
        g_dirSet.insert(pathstr);
/*        if (g_dirSet.find(pathstr) != g_dirSet.end())
        {
            g_newDirSet.insert(pathstr);
        }*/
		UIpathCount++;
	}

   //	XmlNetbargpp->SaveToFile("D:\\a.xml");
    //UIResPathNode->Release();
	//root->Release();

	/*
	int SrpitesPathCount = 0;
	_di_IXMLNode SpritePathNode = root->ChildNodes->FindNode("SpritePath");
	for(int j = 0; j < SpritePathNode->GetChildNodes()->GetCount(); j++)
	{
		System::UnicodeString pathstr = SpritePathNode->GetChildNodes()->Nodes[j]->GetText();
		//SrpitesPathCount++;
	}
	*/


	/*for (int ji = 0; ji < UIpathCount; ji++) {
		System::UnicodeString resPath =  pathes[ji];
		if (dir->Exists(resPath, true)) {
			::System::TStringDynArray files = dir->GetFiles(resPath, "*.png");
			int picCount = files.Length;
			g_startIndex += LoadSeperatePics(g_startIndex, self, resPath, files, resPath.Length());
			int picCount2 = g_pics->Count;
		}
	}
    */

    for (std::set<UnicodeString>::iterator it = g_dirSet.begin(); it != g_dirSet.end(); ++it)
    {
        if (DirectoryExists(*it))
        {
            ::System::TStringDynArray files;
            int picCount = 0;
            int picCount2 = 0;

            files = dir->GetFiles(*it, "*.png");
		    picCount = files.Length;
			g_startIndex += LoadSeperatePics(g_startIndex, self, *it, files, (*it).Length());
			picCount2 = g_pics->Count;

            files = dir->GetFiles(*it, "*.jpg");
            picCount = files.Length;
			g_startIndex += LoadSeperatePics(g_startIndex, self, *it, files, (*it).Length());
			picCount2 = g_pics->Count;

			AddDirToTree(self, *it);
        }
    }

    for (std::set<UnicodeString>::iterator it = g_newDirSet.begin(); it != g_newDirSet.end(); ++it)
    {
        if (DirectoryExists(*it))
        {
            ::System::TStringDynArray files;
            int picCount = 0;
            int picCount2 = 0;

            files = dir->GetFiles(*it, "*.png");
		    picCount = files.Length;
			g_startIndex += LoadSeperatePics(g_startIndex, self, *it, files, (*it).Length());
			picCount2 = g_pics->Count;

            files = dir->GetFiles(*it, "*.jpg");
            picCount = files.Length;
			g_startIndex += LoadSeperatePics(g_startIndex, self, *it, files, (*it).Length());
			picCount2 = g_pics->Count;

            g_dirSet.insert(*it);
            _di_IXMLNode node = UIResPathNode->AddChild("path");
            node->SetText(*it);
			AddDirToTree(self, *it);
       }
    }

    g_newDirSet.clear();
    XmlNetbargpp->SaveToFile(configXmlPath);
	int picCount = g_pics->Count;

	XmlNetbargpp->Active=false;
}
 /*
int LoadOneKindOfSpritesByDir(int StartIndex, TUIEditForm* self, const System::UnicodeString &resPath)
{
	::System::TStringDynArray files = dir->GetFiles(resPath, "*.png");
	int picCount = files.Length;
	return LoadSeperatePics(g_startIndex, self, resPath, files, resPath.Length());
}
*/
void LoadOneKindOfSprites(int StartIndex, TUIEditForm* self, const System::UnicodeString &resPath, ::System::TStringDynArray files, int len)
{
	for (int i=0; i < files.Length; i++) {
		UnicodeString name = files[i].SubString(len+2, files[i].Length()-len);
		System::UnicodeString pathName = resPath + "\\" + name;
		_UI_Configs_::UIRes_spritesPathAndName.push_back(pathName);
		UIEditForm->AnimNameComboBox->Items->Add(name);
	}

	TBitmap* bitmap = new TBitmap();
	bitmap->SetSize(64,64);

	int n = 0;

	/*
	for (int i=0; i < files.Length; i++) {
		UnicodeString name = files[i].SubString(len+1,files[i].Length()-len);
		int index = GetImageID( name );
		if (index >= 0) {
            continue;
		}

		TWICImage* p = GetImage(resPath, files[i] );

		if (p != NULL) {

			TRect rt(0,0,64,64);
			bitmap->Canvas->FillRect(rt);

			if (p->Width > p->Height) {
				rt.SetHeight( rt.Height() * p->Height / p->Width );
			}
			else
			{
				rt.SetWidth( rt.Width() * p->Width / p->Height );
            }

			bitmap->Canvas->StretchDraw(rt,p);
			self->ImageList1->Add(bitmap,NULL);

			TListItem* it = self->ListView2->Items->Add();
			it->ImageIndex = n + StartIndex;
			it->Caption = name;
			n++;
		}
	}
	delete bitmap;
	*/
}

void LoadAllSprites(TUIEditForm* self)
{
   TDirectory * dir = new TDirectory ;
   XmlNetbargpp->Active = true;

	//读取
	XmlNetbargpp->LoadFromFile(ExtractFilePath(Application->ExeName) + _UI_Configs_::UIRes_picsConfigFileName);
	_di_IXMLNode root = XmlNetbargpp->DocumentElement;

	//System::UnicodeString* pathes = new System::UnicodeString();

	int SrpitesPathCount = 0;
	_di_IXMLNode SpritePathNode = root->ChildNodes->FindNode("SpritePath");
	System::UnicodeString* pathes = new System::UnicodeString[SpritePathNode->GetChildNodes()->GetCount()];
	for(int j = 0; j < SpritePathNode->GetChildNodes()->GetCount(); j++) {
		System::UnicodeString pathstr = SpritePathNode->GetChildNodes()->Nodes[j]->GetText();
		pathes[j] = SpritePathNode->GetChildNodes()->Nodes[j]->GetText();
		SrpitesPathCount++;
	}

	_di_IXMLNode targetPathNode = root->ChildNodes->FindNode("SpriteTargetPath");
	System::UnicodeString targetPath = targetPathNode->GetChildNodes()->FindNode("path")->GetText();

	int g_startIndex = self->ListView1->GetCount();
	for (int ji = 0; ji < SrpitesPathCount; ji++)
	{
		System::UnicodeString resPath = pathes[ji];
		int pos = resPath.Pos("Sprite");
		System::UnicodeString resTargetPath = targetPath + resPath.SubString(pos + 7, resPath.Length());
		if (dir->Exists(resPath, true))
		{
			::System::TStringDynArray files = dir->GetFiles(resPath, "*.bsprite");
			LoadOneKindOfSprites(g_startIndex, self, resTargetPath, files, resPath.Length());
			//::System::TStringDynArray picfiles = dir->GetFiles(resPath, "*.png");
			//LoadSeperatePics(g_startIndex, self, resPath, picfiles, resPath.Length());
			g_startIndex += files.Length;
		}
	}
	XmlNetbargpp->Active=false;
}

//---------------------------------------------------------------------------
__fastcall TUIEditForm::TUIEditForm(TComponent* Owner)
	: TForm(Owner)
{

//	DragAcceptFiles(ImageList1->Handle, true);
   //	path->
   fontColorChange = false;
}

//---------------------------------------------------------------------------

void __fastcall TUIEditForm::AcceptFiles(TMessage& Msg)

{
    const int m_nMaxFileNameLen=255;

     int i, m_nCount;

    wchar_t m_sFileName[m_nMaxFileNameLen];

    //ZeroMemory(m_sFileName,m_nMaxFileNameLen+1);

    m_nCount=DragQueryFile((HDROP__*)Msg.WParam, 0xffffffff, m_sFileName , m_nMaxFileNameLen);

    //ZeroMemory(m_sFileName,m_nMaxFileNameLen+1);
	//std::set<UnicodeString> g_dirSet;
	//std::set<UnicodeString> g_newDirSet;
    for (i=0;i<m_nCount;i ++)
    {
        DragQueryFile((HDROP__*)Msg.WParam, i, m_sFileName , m_nMaxFileNameLen);
        UnicodeString dirPath = m_sFileName;

		DWORD fileAttributes = GetFileAttributes(m_sFileName);
		if ((fileAttributes&FILE_ATTRIBUTE_DIRECTORY) == FILE_ATTRIBUTE_DIRECTORY)
		{
			//ShowMessage(m_sFileName);
            dirPath = DirClear(dirPath);
			if (g_dirSet.find(dirPath) == g_dirSet.end())
			{
				g_newDirSet.insert(dirPath);
			}
		}
		else
		{

            dirPath = DirClear(ExtractFileDir(dirPath));
			//ShowMessage(ExtractFileDir(m_sFileName));
			OutputDebugStringW(dirPath.c_str());
			if (g_dirSet.find(dirPath) == g_dirSet.end())
			{
				g_newDirSet.insert(dirPath);
			}
		}
  		//ShowMessage(m_sFileName); UIEditorConfig.xml
//        MessageBox( this->Handle,m_sFileName,"Drop File" ,MB_OK);

        //ZeroMemory(m_sFileName,m_nMaxFileNameLen+1);

    }

    DragFinish ((HDROP__*)Msg.WParam);

	LoadPics(this);
}
//---------------------------------------------------------------------------
void __fastcall TUIEditForm::paintBoxDragOver(TObject *Sender, TObject *Source, int X,
		  int Y, TDragState State, bool &Accept)
{
	static int x = 0;
	static int y = 0;


	{
		if ( State == dsDragEnter ) {


			if ( Sender == Source )
			{
				if (gResizeType != RT_NONE) {

				}
				else if (!moveCanvas)
				{
					dragUI = SelectUI( X-gX, Y-gY );

					//this->Edit1->SetFocus();
				}
            }
			else if (dragUI == NULL)
			{
				//if ( Source == this->ImagePic )

				if (gDragPicID >= 0) {
					moveCanvas = false;
					dragUI = AddPicUI( gDragPicID, X-gX, Y-gY );

					AddSel( g_oneUI->UIs->Count-1, false );
				}
			}
		}
		else if (State == dsDragMove) {


			if (gResizeType == RT_LEFT_RIGHT) {
				UIBase* p = (UIBase*)(g_oneUI->UIs->Items[selUI]);
				p->width += X-x;

				if ( p->width <= 2 )
				{
					p->width = 2;
				}
			}
			else if (gResizeType == RT_TOP_BOTTOM ) {
				UIBase* p = (UIBase*)(g_oneUI->UIs->Items[selUI]);
				p->height += Y-y;

				if ( p->height <= 2 )
				{
					p->height = 2;
				}
			}
			else if (gResizeType == RT_ALL ) {
				UIBase* p = (UIBase*)(g_oneUI->UIs->Items[selUI]);
				p->height += Y-y;
				p->width += X-x;

				if ( p->height <= 1 )
				{
					p->height = 1;
				}

				if ( p->width <= 1 )
				{
					p->width = 1;
                }
			}
			else if (moveCanvas) {
				gX += X-x;
				gY += Y-y;
			}
			else if (dragUI!=NULL) {
				//dragUI->x += X-x;
				//dragUI->y += Y-y;

				for (int i = 0; i < g_selList->Count; i++) {
					int index = (int)g_selList->Items[i];

					UIBase* p = (UIBase*)(g_oneUI->UIs->Items[index]);

					p->x += X-x;
					p->y += Y-y;
				}

			}


            PaintUIs();

		}
		else if (State == dsDragLeave) {
		   //dragUI = NULL;
		   //SetUIData();
		   //PaintUIs();

		   //SelectUI( X-gX, Y-gY );
		   //SetUIData();
		   //PaintUIs();
		}
	}


	x = X;
   	y = Y;

}
//---------------------------------------------------------------------------
void __fastcall TUIEditForm::ScrollBox1Resize(TObject *Sender)         //绘图区域大小拖动
{
	static int width = ScrollBox1->ClientWidth;
	static int height = ScrollBox1->ClientHeight;


	gX = ScrollBox1->ClientWidth * gX / width;
	gY = ScrollBox1->ClientHeight * gY / height;

	width = ScrollBox1->ClientWidth;
	height = ScrollBox1->ClientHeight;

	//Image1-> ->Width = width;
	//Image1->Height = height;

	PaintUIs();
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::paintBoxMouseUp(TObject *Sender, TMouseButton Button, TShiftState Shift,
          int X, int Y)                                    //鼠标右键点击
{

	if (mbRight == Button) {

		moveCanvas = !moveCanvas;

		if (moveCanvas) {
			Image1->Cursor = crSizeAll;
		}
		else
		{
			Image1->Cursor = crDefault;
		}

		//PaintUIs();
	}
}
//---------------------------------------------------------------------------


void __fastcall TUIEditForm::FormShortCut(TWMKey &Msg, bool &Handled)        //小键盘操作，单像素移动UI
{

	if (Msg.Result == 0 ) {
    	return;
	}

    char str[256] = {0};
    sprintf(str, "result:%d, code:%d, keystat:%d", Msg.Result, Msg.CharCode, GetKeyState(VK_MENU));
    OutputDebugStringA(str);
	//if ( MaskEdit1->Focused()
	//	|| ListBox1->Focused() )
	{
	/*
		if ( Msg.CharCode == VK_F5) {
			UpUI();
		}
		else if (  Msg.CharCode == VK_F6 ) {
			DownUI();
		}
		else if (  Msg.CharCode == VK_DELETE ) {
			DeleteUI( );
		}
		*/
	}



	//*
	//*/
	//*
    // left right up down
    //System::word code[4] = {VK_NUMPAD4, VK_NUMPAD6, VK_NUMPAD8, VK_NUMPAD2};
    if (!(GetKeyState(VK_MENU)&0x8000))
    {
        return;
    }
    System::Word code[4] = {VK_LEFT, VK_RIGHT, VK_UP, VK_DOWN};
	if (  Msg.CharCode ==  code[0]) {
		if (selUI >= 0 ) {

			for (int i = 0; i < g_selList->Count; i++) {
				int index = (int)g_selList->Items[i];
				UIBase* p = (UIBase*)(g_oneUI->UIs->Items[index]);
				p->x--;
			}

			PaintUIs();
			SetUIData();
		}
	}
	else if (  Msg.CharCode ==  code[1]) {
		if (selUI >= 0 ) {


			for (int i = 0; i < g_selList->Count; i++) {
				int index = (int)g_selList->Items[i];
				UIBase* p = (UIBase*)(g_oneUI->UIs->Items[index]);
				p->x++;
			}


			PaintUIs();
			SetUIData();
		}
	}
	else if (  Msg.CharCode ==  code[2]) {
    	if (selUI >= 0 ) {


			for (int i = 0; i < g_selList->Count; i++) {
				int index = (int)g_selList->Items[i];
				UIBase* p = (UIBase*)(g_oneUI->UIs->Items[index]);
				p->y--;
			}

			PaintUIs();
			SetUIData();
		}
	}
	else if (  Msg.CharCode ==  code[3]) {
    	if (selUI >= 0 ) {

            for (int i = 0; i < g_selList->Count; i++) {
				int index = (int)g_selList->Items[i];
				UIBase* p = (UIBase*)(g_oneUI->UIs->Items[index]);
				p->y++;
			}

			PaintUIs();
			SetUIData();
		}
	}  ///*/
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::Image1DragDrop(TObject *Sender, TObject *Source, int X, int Y)      //选中UI放手时触发
{

		dragUI = NULL;
		//SetUIData();
		SetUIData();
		PaintUIs();
		this->Edit_resourceNameCheck();
}
//---------------------------------------------------------------------------



void __fastcall TUIEditForm::Edit_textChange(TObject *Sender)                //内容变化
{
	if (!IsInteger(this->Edit2->Text))
		return;

	if (!IsInteger(this->Edit3->Text))
		return;

    GetUIData();
}
//---------------------------------------------------------------------------



void __fastcall TUIEditForm::Button1Click(TObject *Sender)              //上一层按钮
{
	UpUI();
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::BtnDown(TObject *Sender)                   //下一层按钮
{
	DownUI();
}
//---------------------------------------------------------------------------



void __fastcall TUIEditForm::SpeedButton1Click(TObject *Sender)        //保存按钮
{
    if (!CheckcName())
    {
        return;
    }
	Action1Execute( Sender );
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::SpeedButton2Click(TObject *Sender)       //打开按钮
{
	if (OpenDialog1->Execute())
	{
		SetNewType();
		InitData();
		LoadFile(OpenDialog1->FileName);
	  //	UIEditForm->ComboBox6->ItemIndex = (g_oneUI->alignment & 0x7) >> 1;
	//	UIEditForm->ComboBox7->ItemIndex = ((g_oneUI->alignment & 0x38) >> 3) >> 1;
		gFileName = OpenDialog1->FileName;
		PaintUIs();
	}
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::Image1MouseMove(TObject *Sender, TShiftState Shift, int X,     //鼠标在canvas上移动
		  int Y)
{

	ResizeSet( X-gX, Y-gY );

	if (moveCanvas) {
		Image1->Cursor = crSizeAll;
	}

}
//---------------------------------------------------------------------------


void __fastcall TUIEditForm::ListView1SelectItem(TObject *Sender, TListItem *Item,         //选中一个图片
          bool Selected)
{
	int id = Item->ImageIndex;
	TWICImage* p = (TWICImage*)(g_pics->Items[id]);

	if ( p == NULL ) return;

	// clear
	ImagePic->Picture->Bitmap->SetSize(p->Width,p->Height);
	ImagePic->Canvas->Pen->Color = 0xFFFFFF;
	ImagePic->Canvas->Brush->Color = 0xFFFFFF;
	ImagePic->Canvas->Rectangle(0,0,ImagePic->Width,ImagePic->Height);

	ImagePic->Canvas->Draw(0,0,p);

	gDragPicID = id;

	System::UnicodeString str = "";
	Label10->Caption = str + ImagePic->Width + " * "  + ImagePic->Height;
}
//---------------------------------------------------------------------------


void __fastcall TUIEditForm::SpeedButton3Click(TObject *Sender)              //新建按钮
{
    SetNewType();
	InitData();
   // WordsTable::getWordsTable()->createTmpUE();
	PaintUIs();
}
//---------------------------------------------------------------------------



void __fastcall TUIEditForm::settingClick(TObject *Sender)                  //100%按钮
{
	if (selUI >= 0 ) {

			for (int i = 0; i < g_selList->Count; i++) {
				int index = (int)g_selList->Items[i];
				UIBase* p = (UIBase*)(g_oneUI->UIs->Items[index]);

				TWICImage* img = (TWICImage*)(g_pics->Items[p->picID]);

				p->width = img->Width;
				p->height = img->Height;
			}


			PaintUIs();
			SetUIData();
	 }
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::Button5Click(TObject *Sender)                 //顶层按钮
{
	if (GetSelUI() >= 0 ) {



		g_tempUIs->Clear();
		g_tempUIs2->Clear();


		for (int j = 0; j < g_oneUI->UIs->Count; j++) {
           bool found = false;

		   for (int i = 0; i < g_selList->Count; i++) {
			   int index = (int)g_selList->Items[i];
			   if (j == index) {
				   found = true;
				   break;
			   }
		   }

		   if (found) {
			   g_tempUIs->Add(g_oneUI->UIs->Items[j]);
		   }
		   else
		   {
			   g_tempUIs2->Add(g_oneUI->UIs->Items[j]);
           }
		}


		int count = g_selList->Count;
		int startPos = g_tempUIs2->Count;

		g_selList->Clear();
		for (int i = 0; i < count; i++) {
		   g_selList->Add((void*)(startPos+i));
		}

		g_oneUI->UIs->Clear();

		bool setData = false;
		for (int i = 0; i < g_tempUIs2->Count; i++) {
			g_oneUI->UIs->Add(g_tempUIs2->Items[i]);
		}


		for (int j = 0; j < g_tempUIs->Count; j++) {
			 g_oneUI->UIs->Add(g_tempUIs->Items[j]);
		}

		PaintUIs();
	}
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::ButtonNClick(TObject *Sender)                //底层按钮
{
	if (GetSelUI() >= 0 ) {
		g_tempUIs->Clear();
		g_tempUIs2->Clear();

		for (int j = 0; j < g_oneUI->UIs->Count; j++)
		{
           bool found = false;

		   for (int i = 0; i < g_selList->Count; i++)
		   {
			   int index = (int)g_selList->Items[i];
			   if (j == index)
			   {
				   found = true;
				   break;
			   }
		   }

		   if (found)
		   {
			   g_tempUIs->Add(g_oneUI->UIs->Items[j]);
		   }
		   else
		   {
			   g_tempUIs2->Add(g_oneUI->UIs->Items[j]);
           }
		}


		int count = g_selList->Count;

		g_selList->Clear();
		for (int i = 0; i < count; i++)
		{
		   g_selList->Add((void*)i);
		}

		g_oneUI->UIs->Clear();

		for (int j = 0; j < g_tempUIs->Count; j++)
		{
			 g_oneUI->UIs->Add(g_tempUIs->Items[j]);
		}

		for (int i = 0; i < g_tempUIs2->Count; i++)
		{
			g_oneUI->UIs->Add(g_tempUIs2->Items[i]);
		}

		PaintUIs();
	}
}
//---------------------------------------------------------------------------


void __fastcall TUIEditForm::BtnDel(TObject *Sender)                      //删除按钮
{
	DeleteUI( );
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::SpeedButton4Click(TObject *Sender)         //另存为按钮
{
    if (!CheckcName())
    {
        return;
    }
	/*
	if (selUI > 0 ) {
	   UIBase* p = (UIBase*)UIs->Items[selUI];
	   p->flag = p->flag ^ FLP_X;


	   PaintUIs();
	} //*/

   if ( SaveDialog1->Execute() )
	{
		gFileName = SaveDialog1->FileName;

		int len = gFileName.Length();
		int postfixlen = 4;
		char postfix[] = ".lua";
		if (len<=postfixlen)
		{
			gFileName += postfix;
		}
		else
		{
			UnicodeString str = gFileName.SubString(len-postfixlen+1,postfixlen);
			if ( str != postfix)
			{
				gFileName += postfix;
			}
        }

		SaveFile(gFileName);
	}
}
//---------------------------------------------------------------------------



void __fastcall TUIEditForm::SpinEdit1Change(TObject *Sender)             //宽度放缩比例数字调整
{
	UsedBILI = true;
	GetUIData();
    UsedBILI = false;

}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::SpinEdit2Change(TObject *Sender)             //高度放缩比例数字调整
{
    UsedBILI = true;
	GetUIData();
 	UsedBILI = false;

 //	SetUIData();
}
//---------------------------------------------------------------------------


void __fastcall TUIEditForm::ListBox1Click(TObject *Sender)               //当前UI的单个UI的list框
{
	if (ListBox1->ItemIndex >= 0 ) {

		g_selList->Clear();
		for (int i = 0; i < ListBox1->Count; i++)
		{
			if (ListBox1->Selected[i])
			{
				AddSel( ListBox1->Count-1-i, true );
			}

		}

		rechangeList = false;
		PaintUIs();
		rechangeList = true;

		SetUIData();
	}
}
//---------------------------------------------------------------------------

void CenterForm( int cx, int cy )
{
		int left  =  99999;
		int top   =  99999;
		int bottom = -99999;
		int right = -99999;

		for (int i =0; i < g_selList->Count; i++)
		{
			int index = (int)g_selList->Items[i];
			UIBase* p = (UIBase*)(g_oneUI->UIs->Items[index]);
			if (left > p->x)
			{
				left = p->x;
			}

			if (top > p->y)
			{
				top = p->y;
			}

			if (bottom < p->y + p->height)
			{
				bottom = p->y + p->height;
			}

			if (right < p->x + p->width)
			{
				right = p->x + p->width;
			}
		}

		int dx =  -left -  (( right - left) / 2 );
		int dy =  -top -  (( bottom - top) / 2 );

		if (cx == -1)
		{
			dx = -left - gScreenWidth/2;
		}

		if (cx == 1)
		{
			dx = -right + gScreenWidth/2;;
		}

		if (cy == -1)
		{
			dy = -top - gScreenHeight/2;;
		}

		if (cy == 1)
		{
			dy = -bottom + gScreenHeight/2;;
		}


		//gX = UIEditForm->ScrollBox1->Width / 2;
		//gY = UIEditForm->ScrollBox1->Height / 2;

		for (int i =0; i < g_selList->Count; i++)
		{
			int index = (int)g_selList->Items[i];
			UIBase* p = (UIBase*)(g_oneUI->UIs->Items[index]);

			p->x += dx;
			p->y += dy;
		}

		PaintUIs();
		SetUIData();
}



void __fastcall TUIEditForm::FormKeyUp(TObject *Sender, WORD &Key, TShiftState Shift)
{
	int Z = 0;
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::SpinEdit4Change(TObject *Sender)         //UI整体的宽高度调整
{
	if (SpinEdit4->Text == "" )
	{
	   return;
	}
	if (SpinEdit3->Text == "" )
	{
	   return;
	}
	gScreenWidth  =  SpinEdit4->Value;
	gScreenHeight =  SpinEdit3->Value;

	PaintUIs();
}
//---------------------------------------------------------------------------


void __fastcall TUIEditForm::Button2Click(TObject *Sender)          //刷新资源按钮
{
	LoadPics(this);
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::Image1MouseDown(TObject *Sender, TMouseButton Button,
          TShiftState Shift, int X, int Y)
{
	//MaskEdit1->SetFocus();
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::BitBtn1Click(TObject *Sender)          //居中按钮
{
	CenterForm( 0, 0 );
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::BitBtn4Click(TObject *Sender)          //左对齐按钮
{
	CenterForm( -1, 0 );
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::BitBtn2Click(TObject *Sender)          //上对齐按钮
{
	CenterForm( 0, -1 );
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::BitBtn3Click(TObject *Sender)          //左上拐角按钮
{
	CenterForm( -1, -1 );
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::BitBtn5Click(TObject *Sender)          //右上拐角按钮
{
	CenterForm( 1, -1 );
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::BitBtn6Click(TObject *Sender)           //右对齐按钮
{
	CenterForm( 1, 0 );
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::BitBtn7Click(TObject *Sender)           //左下拐角按钮
{
	CenterForm( -1, 1 );
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::BitBtn8Click(TObject *Sender)           //下对齐按钮
{
	CenterForm( 0, 1 );
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::BitBtn9Click(TObject *Sender)           //右下拐角按钮
{
	CenterForm( 1, 1 );
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::Button8Click(TObject *Sender)           //全选按钮
{
	for (int i =0; i < g_oneUI->UIs->Count; i++) {
	   g_selList->Add((void*)i);
	}

	PaintUIs();
	SetUIData();
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::Action1Execute(TObject *Sender)           //保存相关
{
    if (gFileName != ""  || SaveDialog1->Execute())
	{
		if (gFileName == "" ) {
         	gFileName = SaveDialog1->FileName;
		}

		char postfix[] = ".lua";
		int postfixlen = 4;
		int len = gFileName.Length();
		if (len<=postfixlen) {
			gFileName += postfix;
		}
		else
		{
			UnicodeString str = gFileName.SubString(len-postfixlen+1,postfixlen);
			if ( str != postfix) {
				gFileName += postfix;
			}
		}

		SaveFile(gFileName);
	}
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::Action2Execute(TObject *Sender)
{
	for (int i =0; i < g_oneUI->UIs->Count; i++) {
	   g_selList->Add((void*)i);
	}

	PaintUIs();
	SetUIData();
}
//---------------------------------------------------------------------------


void __fastcall TUIEditForm::Action3Execute(TObject *Sender)
{
	DeleteUI( );
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::SpinEdit_groupChange(TObject *Sender)       //组号改变
{
	GetUIData();
}
//---------------------------------------------------------------------------


void __fastcall TUIEditForm::Button6Click(TObject *Sender)          //克隆按钮
{
	if (GetSelUI() >= 0 ) {

		g_tempUIs->Clear();

		int  start = 0;
		for (int i = 0; i < g_oneUI->UIs->Count; i++) {

			if (IsSelUI(i)) {
				start = i;
				g_tempUIs->Add(g_oneUI->UIs->Items[i]);
			}
			else
			{

			}
		}

		g_selList->Clear();

		for (int i = 0; i < g_tempUIs->Count; i++) {
			UIBase* p =  new UIBase();

			*p = *((UIBase*)g_tempUIs->Items[i]);

			p->x = p->x + 20;
			p->y = p->y + 20;

			g_oneUI->UIs->Insert( start + i + 1, p);
			g_selList->Add( (void*)(start+i+1) );
		}

		PaintUIs();
		SetUIData();
	}
}
//---------------------------------------------------------------------------


void __fastcall TUIEditForm::Button9Click(TObject *Sender)
{
	 g_bWireFrameState = !g_bWireFrameState;
	 UpdateWireFrameModeBtnCaption();
}

void UpdateWireFrameModeBtnCaption()
{
	 System::UnicodeString wireFrameModeNotices[2] = {"显示线框", "隐藏线框"};
	 UIEditForm->Button9->Caption = wireFrameModeNotices[g_bWireFrameState];
	 PaintUIs();
}
//---------------------------------------------------------------------------
void __fastcall TUIEditForm::AnimNameComboBoxChange(TObject *Sender)
{
    GetUIData();
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::Edit_audioChange(TObject *Sender)
{
	GetUIData();
	return;
	int selectUIId = GetSelUI();
	if (0 <= selectUIId) {
		UIBase* p = (UIBase*)(g_oneUI->UIs->Items[ selectUIId ]);
		p->audio = UIEditForm->Edit_audio->Text;
		p->scaleX = UnicodeStringToFloat(UIEditForm->Edit_scaleX->Text, 0);
		p->scaleY = UnicodeStringToFloat(UIEditForm->Edit_scaleY->Text, 0);
	}
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::CheckBox_ExpandSelectRangeMouseUp(TObject *Sender, TMouseButton Button,
          TShiftState Shift, int X, int Y)
{
	int selectUIId = GetSelUI();
	if (0 <= selectUIId) {
		UIBase* p = (UIBase*)(g_oneUI->UIs->Items[ selectUIId ]);
		p->type = UI_BUTTON;
		p->IsExpand = !p->IsExpand;
	}
}

void __fastcall TUIEditForm::ListView2SelectItem(TObject *Sender, TListItem *Item,
          bool Selected)
{

	int id = Item->ImageIndex;// + this->ListView1->GetCount();
	TWICImage* p = (TWICImage*)(g_pics->Items[id]);

	if ( p == NULL ) return;

	// clear
	ImagePic->Picture->Bitmap->SetSize(p->Width,p->Height);
	ImagePic->Canvas->Pen->Color = 0xFFFFFF;
	ImagePic->Canvas->Brush->Color = 0xFFFFFF;
	ImagePic->Canvas->Rectangle(0,0,ImagePic->Width,ImagePic->Height);

	ImagePic->Canvas->Draw(0,0,p);

	gDragPicID = id;

	System::UnicodeString str = "";
	Label10->Caption = str + ImagePic->Width + " * "  + ImagePic->Height;
}
//---------------------------------------------------------------------------




void __fastcall TUIEditForm::LaShenSelectRangeMouseUp(TObject *Sender, TMouseButton Button,
          TShiftState Shift, int X, int Y)
{
	int selectUIId = GetSelUI();

	if (0 <= selectUIId) {
		UIBase* p = (UIBase*)(g_oneUI->UIs->Items[ selectUIId ]);

		p->type = UI_BUTTON;
		p->IsLaShen = !p->IsLaShen;
	}
}

//---------------------------------------------------------------------------






void __fastcall TUIEditForm::Panel1Click(TObject *Sender)
{
   /*
	int c = this->ColorBox_fontColor->Selected;
	char str[256] = {0};
	sprintf(str, "%08X", c);
	ShowMessage(str);*/
}
//---------------------------------------------------------------------------




void __fastcall TUIEditForm::ColorBox_fontColorChange(TObject *Sender)
{
    if (fontColorChange) {
        return;
    }
    fontColorChange = true;
    unsigned int color = 0;
    if (UIEditForm->Edit_R->Text.Length() == 0) {
        UIEditForm->Edit_R->Text = 0;
    }
    if (UIEditForm->Edit_G->Text.Length() == 0) {
        UIEditForm->Edit_G->Text = 0;
    }
    if (UIEditForm->Edit_B->Text.Length() == 0) {
        UIEditForm->Edit_B->Text = 0;
    }
    unsigned int r = UIEditForm->Edit_R->Text.ToInt();
	unsigned int g = UIEditForm->Edit_G->Text.ToInt();
	unsigned int b = UIEditForm->Edit_B->Text.ToInt() ;

    UIEditForm->Edit_R->Font->Color = r > 255 ? clRed : clBlack;
    UIEditForm->Edit_G->Font->Color = g > 255 ? clRed : clBlack;
    UIEditForm->Edit_B->Font->Color = b > 255 ? clRed : clBlack;

	color = b*65536 + g*256 + r;
    UIEditForm->Label_fontColor->Font->Color = color;

	GetUIData();
    fontColorChange = false;
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::ComboBox_fontSizeChange(TObject *Sender)
{
    GetUIData();
}
//---------------------------------------------------------------------------


void __fastcall TUIEditForm::LaShenSelectRangeClick(TObject *Sender)
{
	//
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::CheckBox_ExpandSelectRangeClick(TObject *Sender)
{
	//
}
//---------------------------------------------------------------------------

bool onButtonResourceChanged()
{
    bool efficientChange = true;
	AnsiString msg = "";
	if (GetImageID(UIEditForm->Edit_resourceName->Text) < 0)
	{
		msg += UIEditForm->Edit_resourceName->Text;
        efficientChange = false;
	}

	if (UIEditForm->Edit_buttonDown->Text.Length() && GetImageID(UIEditForm->Edit_buttonDown->Text) < 0)
	{
		msg += "按下图片" + UIEditForm->Edit_buttonDown->Text + "不存在,";
        efficientChange = false;
	}

	if (UIEditForm->Edit_buttonDisabled->Text.Length() && GetImageID(UIEditForm->Edit_buttonDisabled->Text) < 0)
	{
		msg += "禁用图片" + UIEditForm->Edit_buttonDisabled->Text + "不存在";
        efficientChange = false;
	}

    if (UIEditForm->Edit_buttonChecked->Text.Length() &&GetImageID(UIEditForm->Edit_buttonChecked->Text) < 0)
	{
		msg += "选中图片" + UIEditForm->Edit_buttonChecked->Text + "不存在";
        efficientChange = false;
	}

    UIEditForm->Label_optionalMsg->Caption = msg;
    return efficientChange;

}
//---------------------------------------------------------------------------


void __fastcall TUIEditForm::Edit_buttonDisabledChange(TObject *Sender)
{
    if (ButtonChangePending)
        return;

	onButtonResourceChanged();
    GetUIData();
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::Edit_buttonDownChange(TObject *Sender)
{
    if (ButtonChangePending)
        return;
	onButtonResourceChanged();
    GetUIData();
}
//---------------------------------------------------------------------------
void __fastcall TUIEditForm::Edit_buttonCheckedChange(TObject *Sender)
{
    if (ButtonChangePending)
        return;

	onButtonResourceChanged();
    GetUIData();
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::ComboBox_buttonStatusChange(TObject *Sender)
{
    GetUIData();
}
//---------------------------------------------------------------------------
void __fastcall TUIEditForm::ProgressBarInit()
{
    ProgressBarChangePending = true;
    vector<TComponent*> Labels;
    UnicodeString labelStrings[] = {"进度条", "进度", "bar：x", "bar：y", "bar：width", "bar：height"};
    struct bound{int x, y, width, height;};
    bound labelBound[] =
    {
        {10, 10, 40, 15},
        {10, 35, 40, 15},
        {10, 60, 40, 15},
        {10, 85, 40, 15},
        {100, 60, 60, 15},
        {100, 85, 60, 15},
    };
   // for (vector<TComponent*>::iterator it = Labels.begin(); it != Labels.end(); ++it)
    int x = 10, y = 10;
    int labelWidth = 60, labelHeight = 15;
    int editHeight = labelHeight - 10;
    size_t i;
	TPanel* panel = GetPanel(UI_PROGRESS_BAR);
    for (i = 0; i != sizeof(labelStrings)/sizeof(*labelStrings); i++)
    {
        //TLable*& label = *it;
        TLabel*& label = labelProgressBar[i];
        label = new TLabel(panel);
        label->Parent = panel;
        label->Caption = labelStrings[i];
        label->Name = UnicodeString("label_progress") + i;
        label->SetBounds(labelBound[i].x, labelBound[i].y, labelBound[i].width, labelBound[i].height);

        //label->SetBounds(x, y+i*(labelHeight+3), labelWidth, labelHeight);
        Labels.push_back(label);
        label->Show();
    }


    i = 0;
    this->Edit_progressBarImage = new TEdit(panel);
    this->Edit_progressBarImage->Parent = panel;
    this->Edit_progressBarImage->SetBounds(labelBound[i].x+2+labelBound[i].width, labelBound[i].y, 100, editHeight);
    this->Edit_progressBarImage->Text = "";
    this->Edit_progressBarImage->OnChange = ProgressBarChanged;

    i++;
    this->ComboBox_progressBarValue = new TComboBox(panel);
    this->ComboBox_progressBarValue->Parent = panel;
    this->ComboBox_progressBarValue->SetBounds(labelBound[i].x+2+labelBound[i].width, labelBound[i].y, 100, editHeight);
    this->ComboBox_progressBarValue->ItemIndex = 0;
    this->ComboBox_progressBarValue->OnChange = ProgressBarChanged;

    i++;
    this->Edit_progressBarX = new TEdit(panel);
    this->Edit_progressBarX->Parent = panel;
    this->Edit_progressBarX->SetBounds(labelBound[i].x+2+labelBound[i].width, labelBound[i].y, 30, editHeight);
    this->Edit_progressBarX->Text = "0";
    this->Edit_progressBarX->NumbersOnly = true;
    this->Edit_progressBarX->OnChange = ProgressBarChanged;

    i++;
    this->Edit_progressBarY = new TEdit(panel);
    this->Edit_progressBarY->Parent = panel;
    this->Edit_progressBarY->SetBounds(labelBound[i].x+2+labelBound[i].width, labelBound[i].y, 30, editHeight);
    this->Edit_progressBarY->Text = "0";
    this->Edit_progressBarY->NumbersOnly = true;
    this->Edit_progressBarY->OnChange = ProgressBarChanged;

    i++;
    this->Edit_progressBarWidth = new TEdit(panel);
    this->Edit_progressBarWidth->Parent = panel;
    this->Edit_progressBarWidth->SetBounds(labelBound[i].x+2+labelBound[i].width, labelBound[i].y, 30, editHeight);
    this->Edit_progressBarWidth->Text = "0";
    this->Edit_progressBarWidth->NumbersOnly = true;
    this->Edit_progressBarWidth->OnChange = ProgressBarChanged;

    i++;
    this->Edit_progressBarHeight = new TEdit(panel);
    this->Edit_progressBarHeight->Parent = panel;
    this->Edit_progressBarHeight->SetBounds(labelBound[i].x+2+labelBound[i].width, labelBound[i].y, 30, editHeight);
    this->Edit_progressBarHeight->Text = "0";
    this->Edit_progressBarHeight->NumbersOnly = true;
    this->Edit_progressBarHeight->OnChange = ProgressBarChanged;

    for (i = 101; i != 0; i--)
    {
        this->ComboBox_progressBarValue->AddItem(i-1, 0);
    }
    this->ComboBox_progressBarValue->ItemIndex = 0;

    ProgressBarChangePending = false;
    //ProgressBarHide();
}
//---------------------------------------------------------------------------
void __fastcall TUIEditForm::ProgressBarHide()
{
    //this->Label_progressBarImage->Hide();
    for (size_t i = 0; i != sizeof(labelProgressBar)/ sizeof(labelProgressBar[0]); i++)
    {
        if (labelProgressBar[i])
        {
            labelProgressBar[i]->Hide();
        }
    }
    TEdit* edits[] = {Edit_progressBarImage, Edit_progressBarX, Edit_progressBarY, Edit_progressBarWidth, Edit_progressBarHeight};
    for (size_t i = 0; i != sizeof(edits)/ sizeof(edits[0]); i++)
    {
        if (edits[i])
        {
            edits[i]->Hide();
        }
    }

    this->ComboBox_progressBarValue->Hide();
}
//---------------------------------------------------------------------------
void __fastcall TUIEditForm::ProgressBarChanged(TObject *Sender)
{
    if (ProgressBarChangePending)
    {
        return;
    }
	AnsiString msg = "";

	if (GetImageID(this->Edit_progressBarImage->Text) < 0)
	{
		msg += "滚动条图片" + this->Edit_progressBarImage->Text + "不存在";
	}

    UIEditForm->Label_optionalMsg->Caption = msg;



    GetUIData();
}
//---------------------------------------------------------------------------
void __fastcall TUIEditForm::ProgressBarShow()
{
    for (size_t i = 0; i != sizeof(labelProgressBar)/ sizeof(labelProgressBar[0]); i++)
    {
        if (labelProgressBar[i])
        {
            labelProgressBar[i]->Show();
        }
    }

    TEdit* edits[] = {Edit_progressBarImage, Edit_progressBarX, Edit_progressBarY, Edit_progressBarWidth, Edit_progressBarHeight};
    for (size_t i = 0; i != sizeof(edits)/ sizeof(edits[0]); i++)
    {
        if (edits[i])
        {
            edits[i]->Show();
        }
    }

    this->ComboBox_progressBarValue->Show();
}
//---------------------------------------------------------------------------
void __fastcall TUIEditForm::ProgressBarDistroy()
{
//
}
//---------------------------------------------------------------------------
void __fastcall TUIEditForm::FormDestroy(TObject *Sender)
{
    FreeUELibrary();
    ProgressBarDistroy();
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::FormCreate(TObject *Sender)
{
// no use now begin
    BitBtn10->Hide();
    this->Label_AnimateName->Hide();
    this->AnimNameComboBox->Hide();

	UIEditForm->ColorBox_fontColor->Hide();


    this->ComboBox_fontName->Hide();
    this->Label_fontName->Hide();
// no use now end

    LoadUELibrary();
	InitData();

	if (!LoadLanguage(this))
        this->Close();

    this->TreeView1->Items->Add(0, "固定目录");
	ClearDirToTree(this);
	LoadPics(this);
	LoadAllSprites(this);
	//SpinEdit_group->Hide();
	//Label_Group->Hide();

	DragAcceptFiles(this->Handle, true);
    this->Label_optionalMsg->Caption = "";

    TPanel* panel = 0;
    TRect tRect = Panel_optional->BoundsRect;
    for (int i = 0; i < 12; i++)
    {
        if (i == UI_BUTTON) {
            m_panel.push_back(0);
            continue;
        }
        panel = new TPanel(Panel1);
        panel->Parent = Panel1;
        panel->BoundsRect = tRect;
        m_panel.push_back(panel);
        panel->DoubleBuffered = true;
    }
    m_panel[UI_BUTTON] = Panel_optional;



    this->ProgressBarInit();
    this->FrameInit();

    int types[] = {UI_UISCROLLLIST, UI_UISCROLLPAGE, UI_UISCROLLVIEW};
    TComboBox** scrollAligns[] = {&ComboBox_scrollListAlign, &ComboBox_scrollPageAlign, &ComboBox_scrollViewAlign};
    for (int i = 0; i < sizeof(types)/sizeof(types[0]); i++) {
        panel = GetPanel(types[i]);
        TComboBox* scrollAlign = new TComboBox(panel);
        *(scrollAligns[i]) = scrollAlign;
        scrollAlign->Parent = panel;
        scrollAlign->BoundsRect = Edit_buttonDown->BoundsRect;
        scrollAlign->OnChange = OnItemChange;

        scrollAlign->Items->Add("水平方向滚动");
        scrollAlign->Items->Add("竖直方向滚动");
        scrollAlign->ItemIndex = 1;
    }

    TLabel* label;

	panel = GetPanel(UI_UISCROLLLIST);
	label = new TLabel(panel);
	label->Parent = panel;
	label->SetBounds(60, 45, 30, 20);
	label->Caption = "间距";
	this->Edit_scrollListMargin = new TEdit(panel);
    this->Edit_scrollListMargin->Parent = panel;
	this->Edit_scrollListMargin->SetBounds(100, 40, 80, 20);
    this->Edit_scrollListMargin->Text = "0";
	this->Edit_scrollListMargin->NumbersOnly = true;
    this->Edit_scrollListMargin->OnChange = OnItemChange;

	panel = GetPanel(UI_UISCROLLPAGE);
	label = new TLabel(panel);
	label->Parent = panel;
	label->SetBounds(60, 45, 30, 20);
	label->Caption = "间距";
	this->Edit_scrollPageMargin = new TEdit(panel);
    this->Edit_scrollPageMargin->Parent = panel;
	this->Edit_scrollPageMargin->SetBounds(100, 40, 80, 20);
    this->Edit_scrollPageMargin->Text = "0";
	this->Edit_scrollPageMargin->NumbersOnly = true;
    this->Edit_scrollPageMargin->OnChange = OnItemChange;

    panel = GetPanel(UI_TEXT);
	/*
    ComboBox_textShade = new TComboBox(panel);
    ComboBox_textShade->Parent = panel;
    ComboBox_textShade->BoundsRect = Edit_buttonDown->BoundsRect;
    ComboBox_textShade->OnChange = OnItemChange;

    ComboBox_textShade->Items->Add("普通字体");
    ComboBox_textShade->Items->Add("字体阴影效果");
    ComboBox_textShade->ItemIndex = 0;
*/
    PanelAllHide();

   // PanelShow(UI_FRAME);
   //  PanelHide(UI_FRAME);
  //    PanelShow(UI_FRAME);

    //this->TreeView2->Items->Add(this->TreeView1->Items[0][0], "first");
   // ProgressBarShow();
 //  ComboBox_color->Hide();
   addColor("black", 0);
   addColor("yellow", 65535);
}
//---------------------------------------------------------------------------
void __fastcall TUIEditForm::addColor(UnicodeString name, int color)
{
    TLabel* label = new TLabel(this);

    label->BoundsRect = TRect(300,3,300,20);
    label->Color = color;
    //label->
    label->Caption = "11";
   // ComboBox_color->AddItem(name, label);
    label->Parent = Panel1;

}
//---------------------------------------------------------------------------
int __fastcall TUIEditForm::findColor(int color)
{
    return 0;
}
//---------------------------------------------------------------------------
void __fastcall TUIEditForm::clearColor()
{
}
//---------------------------------------------------------------------------
bool veccompare(TListItem *Item1,TListItem *Item2)
{
    UnicodeString s = UIEditForm->Edit_searchResource->Text;
    int Compare = wcompare(Item1->Caption,Item2->Caption, s);
	return Compare < 0;
}	
void __fastcall TUIEditForm::Edit_searchResourceChange(TObject *Sender)
{   /*
    //
    //this->ListView1->ItemIndex  = 1;
   // this->Edit_searchResource->Text = this->ListView1->ItemFocused->ToString();
   int cnt = this->ListView1->Items->Count;
 //  std::vector<std::pair<int, int>> v; // first:item index; second: score

    //this->ListView1->Items->Item[0]->Caption;
   for (int i = 0; i < cnt; i++) {

   }
   this->ListView1->Scroll(0, 100);
   if (this->ListView1->ItemFocused) {
    ShowMessage(this->ListView1->ItemFocused->Index);
   }

   ShowMessage(this->ListView1->GetSearchString());
   if (this->ListView1->TopItem) {
        this->ListView1->TopItem->Focused = true;
   }
         */
    //ListView1->Selected = 0;
    //ListView1->ItemIndex = -1;
    ListView1->ClearSelection();
    //ListView1->Top = 0;
	std::vector<TListItem*> vec;
	                                \

	for (int i = 0; i < this->ListView1->Items->Count; i++)
	{
		vec.push_back(this->ListView1->Items->Item[i]);
	}
	std::sort(vec.begin(), vec.end(), veccompare);

    int idx = this->ListView1->Items->IndexOf(vec[0]);
   // this-ListView1->ItemFocused = vec[0];
  //  this-ListView1->ItemFocused = vec[0];
	this->ListView1->Selected = vec[0];
	this->ListView1->ItemIndex = idx;
    char buf[1024] = {0};
    sprintf(buf, "sel:%d, index:%d top:%p", ListView1->Selected, ListView1->ItemIndex, ListView1->TopItem);
    OutputDebugStringA(buf);
    this->ListView1->OnCompare = SortTestCompare;
    this->ListView1->AlphaSort();
    //ListView1->Selected = 0;

    sprintf(buf, "sel:%d, index:%d top:%p", ListView1->Selected, ListView1->ItemIndex, ListView1->TopItem);

	
    if (ListView1->TopItem)
    {
        //ListView1->ItemIndex = ListView1->TopItem->Index;
        sprintf(buf+strlen(buf), " TopIndex:%d", ListView1->TopItem->Index);
    }
    OutputDebugStringA(buf);
    ListView1->ClearSelection();
//    ListView1->Selected = 0;
//    ListView1->ItemIndex = -1;
    //this->ListView1->Scroll(0, -g_startIndex*30);
    //ListView1->Top = 0;
    //this->ListView1->Scroll(0, 0);
    //this->ListView1->Scroll(0, -100);
    //ListView1->Selected = ListView1->TopItem;
   // ListView1->Selected = ListView1->Items->operator [](0);
   // ListView1->SelectAll();
    //ListView1->ScrollBy(0, 0);  // 防止 自动滚动
}
//---------------------------------------------------------------------------
void __fastcall TUIEditForm::SortTestCompare(TObject *Sender, TListItem *Item1,TListItem *Item2, int Data, int &Compare)
{
    UnicodeString s = this->Edit_searchResource->Text;
    Compare = wcompare(Item1->Caption,Item2->Caption, s);
    return;
    int m_nColumnToSort = -1;
    if (m_nColumnToSort == 0)
    {
    //如果列号为0则按列表项Caption属性进行比较
    Compare = CompareText(Item1->Caption,Item2->Caption);
    }
    else
    {
    //如果列号不为0则计算子列的序号并按子列项进行比较
    int ix = m_nColumnToSort-1;
    Compare = CompareText(Item1->SubItems->Strings[ix], Item2->SubItems->Strings[ix]);
    }


}
//---------------------------------------------------------------------------
void __fastcall TUIEditForm::Edit_resourceNameCheck()
{
    // recource check
    if ((GetSelUI() < 0 && (this->Edit_resourceName->Text.Length() == 0)) ||
        GetImageID(this->Edit_resourceName->Text) >= 0)
    {
        this->Edit_resourceName->Font->Color = clBlack;
        this->Label_resourceName->Font->Color = clBlack;
    }
    else
    {
        this->Edit_resourceName->Font->Color = clRed;
        this->Label_resourceName->Font->Color = clRed;
    }
}
//---------------------------------------------------------------------------

//---------------------------------------------------------------------------
void __fastcall TUIEditForm::OnItemChange(TObject *Sender)
{
    if (GetSelUI() != -1)
	{
		GetUIData();
	}
}
//---------------------------------------------------------------------------



void __fastcall TUIEditForm::Edit_resourceNameChange(TObject *Sender)
{
    Edit_resourceNameCheck();
    if (GetSelUI() != -1)
	{
		GetUIData();
	}
}



//---------------------------------------------------------------------------
void __fastcall TUIEditForm::FrameInit()
{
	TPanel* panel = GetPanel(UI_FRAME);
    this->ComboBox_frameType = new TComboBox(panel);
    this->ComboBox_frameType->Parent = panel;
    this->ComboBox_frameType->SetBounds(30, 20, 100, 25);
    this->ComboBox_frameType->ItemIndex = 0;
    this->ComboBox_frameType->OnChange = ComboBox_frameTypeOnChange;

    for (int i = 0; i < 10; i++)
    {
        this->ComboBox_frameType->AddItem(i, 0);
    }
    this->ComboBox_frameType->ItemIndex = 0;
}
//---------------------------------------------------------------------------
void __fastcall TUIEditForm::ComboBox_frameTypeOnChange(TObject *Sender)
{
    //
    if (GetSelUI() != -1)
	{
		GetUIData();
	}
}
//---------------------------------------------------------------------------



void __fastcall TUIEditForm::SpinEdit_tagChange(TObject *Sender)
{
    GetUIData();
}
//---------------------------------------------------------------------------

//---------------------------------------------------------------------------

void __fastcall TUIEditForm::TreeView1Click(TObject *Sender)
{
    //this->TreeView1->GetNodeAt(Sender->)
 //   ShowMessage(this->TreeView1->Selected->Text);
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::MenuItemClearClick(TObject *Sender)
{
    if (this->TreeView2->Selected->Text.Length() == 0) {
        return;
    }
    UnicodeString dirtext = this->TreeView2->Selected->Text;

    System::UnicodeString configXmlPath = ExtractFilePath(Application->ExeName) + _UI_Configs_::UIRes_picsConfigFileName;
    // clear
    XMLResPath xmlResPath(XmlNetbargpp);
    xmlResPath.load(configXmlPath);
    xmlResPath.clearRes(dirtext);
    xmlResPath.save();

    ClearDirToTree(this);
    LoadPics(this);
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::MenuItemClearAllClick(TObject *Sender)
{

    TMenuItem* mi = (TMenuItem*)Sender;
    System::UnicodeString configXmlPath = ExtractFilePath(Application->ExeName) + _UI_Configs_::UIRes_picsConfigFileName;
    XMLResPath xmlResPath(XmlNetbargpp);
    xmlResPath.load(configXmlPath);
    xmlResPath.clearRes();
    xmlResPath.save();

    ClearDirToTree(this);
    LoadPics(this);
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::PopupMenu2Popup(TObject *Sender)
{
    // DISABLE POP UP
    bool disable = (g_oneUI->UIs->Count != 0);
    if (!disable)
    {
        if (this->TreeView2->Selected->Text == "动态目录")
        {
            disable = true;
        }
    }
    if (disable)
    {
        this->MenuItemClear->Enabled = false;
        this->MenuItemClearAll->Enabled = false;
    }
    else
    {
        this->MenuItemClear->Enabled = true;
        this->MenuItemClearAll->Enabled = true;
    }

}
//---------------------------------------------------------------------------



void __fastcall TUIEditForm::Edit_cNameChange(TObject *Sender)
{
    int i;
    for (i = 1; i <= Edit_cName->Text.Length(); i++)
    {
        if (Edit_cName->Text[i] > 127 || Edit_cName->Text[i] < 32) {
            Edit_cName->Font->Color = clRed;
            break;
        }
    }
    if (i > Edit_cName->Text.Length()) {
        Edit_cName->Font->Color = clBlack;
    }

	if (!IsInteger(this->Edit2->Text))
		return;

	if (!IsInteger(this->Edit3->Text))
		return;

    GetUIData();
}
//---------------------------------------------------------------------------


bool __fastcall TUIEditForm::CheckcName()
{
//
	bool unique = true;
	set<UnicodeString> names;
	AnsiString n = "";
	for (int i = 0; i < g_oneUI->UIs->Count; i++)
	{
        UIBase* p = (UIBase*)g_oneUI->UIs->Items[i];
		if (names.find(p->name) == names.end())
		{
			names.insert(p->name);
		}
		else
		{
			unique = false;
			n = p->name;
		}
	}
	if (!unique)
	{
        n = "名字" + n + " 重复";
		MessageBoxA(0, n.c_str(), "错误", 0);
	}
	return unique;
}




void __fastcall TUIEditForm::ComboBox_textShadeChange(TObject *Sender)
{
    this->OnItemChange(Sender);
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::ComboBox_useRTFChange(TObject *Sender)
{
    this->OnItemChange(Sender);
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::Edit_scaleXChange(TObject *Sender)
{
    GetUIData();
    return;

	int selectUIId = GetSelUI();
	if (0 <= selectUIId) {
		UIBase* p = (UIBase*)(g_oneUI->UIs->Items[ selectUIId ]);
		p->audio = UIEditForm->Edit_audio->Text;
		p->scaleX = UnicodeStringToFloat(UIEditForm->Edit_scaleX->Text, 0);
		p->scaleY = UnicodeStringToFloat(UIEditForm->Edit_scaleY->Text, 0);
	}
}
//---------------------------------------------------------------------------

void __fastcall TUIEditForm::Edit_scaleYChange(TObject *Sender)
{
    GetUIData();
    return;
	int selectUIId = GetSelUI();
	if (0 <= selectUIId) {
		UIBase* p = (UIBase*)(g_oneUI->UIs->Items[ selectUIId ]);
		p->audio = UIEditForm->Edit_audio->Text;
		p->scaleX = UnicodeStringToFloat(UIEditForm->Edit_scaleX->Text, 0);
		p->scaleY = UnicodeStringToFloat(UIEditForm->Edit_scaleY->Text, 0);
	}
}
//---------------------------------------------------------------------------






