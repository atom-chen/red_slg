#include "UEHelper.h"
#include "UEInterface.h"

char* string2p(const string& str)
{
	if (str.empty())
	{
		return new char[2]();
	}
	char* p = new char[str.size() + 2];
	memcpy(p, str.c_str(), str.size());
	p[str.size()] = '\0';
	return p;
}
void string2pFree(char* p)
{
	if (!p)
		return;

	delete[] p;
}

string p2string(const char* p)
{
	return p ? p : "";
}

bool ElemInfo2UIElement(const ElemInfo& eleInfo, UIElement_t* uiElement)
{
	if (!uiElement)
		return false;

	uiElement->type = eleInfo.type;
	uiElement->frameType = eleInfo.frameType;

	uiElement->cName = string2p(eleInfo.cName);
	uiElement->picName = string2p(eleInfo.picName);
	uiElement->data = string2p(eleInfo.data);
	uiElement->audio = string2p(eleInfo.audio);

	uiElement->x = eleInfo.x;
	uiElement->y = eleInfo.y;
	uiElement->width = eleInfo.width;
	uiElement->height = eleInfo.height;

	uiElement->scaleX = eleInfo.scaleX;
	uiElement->scaleY = eleInfo.scaleY;

	uiElement->scrollAlign = eleInfo.scrollAlign;
	uiElement->scrollMargin = eleInfo.scrollMargin;

	uiElement->tag = eleInfo.tag;
	uiElement->isEnlarge = eleInfo.isEnlarge;
	uiElement->isSTensile = eleInfo.isSTensile;

	uiElement->text = string2p(eleInfo.text);

	uiElement->useRTF = eleInfo.useRTF;
	uiElement->textShade = eleInfo.textShade;
	uiElement->textType = eleInfo.textType;
	uiElement->fontSize = eleInfo.fontSize;
	uiElement->fontColor = eleInfo.fontColor;
	uiElement->align = eleInfo.align;

	switch (eleInfo.type)
	{
	case UI_PROGRESS_BAR:
		uiElement->progressBarEx.x = eleInfo.progressBarEx.x;
		uiElement->progressBarEx.y = eleInfo.progressBarEx.y;
		uiElement->progressBarEx.width = eleInfo.progressBarEx.width;
		uiElement->progressBarEx.height = eleInfo.progressBarEx.height;
		uiElement->progressBarEx.barImage = string2p(eleInfo.progressBarEx.barImage);
		break;
	case UI_BUTTON:
		uiElement->buttonEx.imageDown = string2p(eleInfo.buttonEx.imageDown);
		uiElement->buttonEx.imageDisabled = string2p(eleInfo.buttonEx.imageDisabled);
		uiElement->buttonEx.imageChecked = string2p(eleInfo.buttonEx.imageChecked);
		break;
	}

	return true;
}

bool UIElement2ElemInfo(const UIElement_t* uiElement, ElemInfo& eleInfo)
{
	eleInfo.type = uiElement->type;
	eleInfo.frameType = uiElement->frameType;

	eleInfo.cName = p2string(uiElement->cName);
	eleInfo.picName = p2string(uiElement->picName);
	eleInfo.data = p2string(uiElement->data);
	eleInfo.audio = p2string(uiElement->audio);
	

	eleInfo.x = uiElement->x;
	eleInfo.y = uiElement->y;
	eleInfo.width = uiElement->width;
	eleInfo.height = uiElement->height;

	eleInfo.scaleX = uiElement->scaleX;
	eleInfo.scaleY = uiElement->scaleY;

	eleInfo.scrollAlign = uiElement->scrollAlign;
	eleInfo.scrollMargin = uiElement->scrollMargin;

	eleInfo.tag = uiElement->tag;
	eleInfo.isEnlarge = uiElement->isEnlarge;
	eleInfo.isSTensile = uiElement->isSTensile;

	eleInfo.text = p2string(uiElement->text);
	eleInfo.useRTF = uiElement->useRTF;
	eleInfo.textShade = uiElement->textShade;
	eleInfo.textType = uiElement->textType;
	eleInfo.fontSize = uiElement->fontSize;
	eleInfo.fontColor = uiElement->fontColor;
	eleInfo.align = uiElement->align;

	switch (eleInfo.type)
	{
	case UI_PROGRESS_BAR:
		eleInfo.progressBarEx.x = uiElement->progressBarEx.x;
		eleInfo.progressBarEx.y = uiElement->progressBarEx.y;
		eleInfo.progressBarEx.width = uiElement->progressBarEx.width;
		eleInfo.progressBarEx.height = uiElement->progressBarEx.height;
		eleInfo.progressBarEx.barImage = p2string(uiElement->progressBarEx.barImage);
		break;
	case UI_BUTTON:
		eleInfo.buttonEx.imageDown = p2string(uiElement->buttonEx.imageDown);
		eleInfo.buttonEx.imageDisabled = p2string(uiElement->buttonEx.imageDisabled);
		eleInfo.buttonEx.imageChecked = p2string(uiElement->buttonEx.imageChecked);
		break;
	}

	return true;
}


#define puts(str) puts(str), fflush(stdout)

string g_LanguageDir = "./";

int __stdcall UIDataSetLanguageDir(const char* path)
{
	if (!path || !path[0])
	{
		g_LanguageDir = "./";
		return 0;
	}
	else
	{
		g_LanguageDir = path;
		if (g_LanguageDir.back() != '\\' || g_LanguageDir.back() != '/')
		{
			g_LanguageDir.push_back('/');
		}
	}
	return 0;
}

int __stdcall UIDataLanguageCreate(const char* path, int createIfNotExist)
{
	//freopen("log.txt", "a+", stdout);
	puts("in");
	if (!path || path[0] == '\0')
		return -1;

	string pathstr = path;
	bool isroot = false;
	if (pathstr.size() >= 1 && pathstr[0] == '\\' || pathstr[0] == '/')
	{
		isroot = true;
	}

	if (pathstr.size() >= 2)
	{
		if ((pathstr[0] >= 'A' && pathstr[0] <= 'Z') || (pathstr[0] >= 'a' && pathstr[0] <= 'z') && pathstr[1] == ':')
		{
			isroot = true;
		}
	}

	if (!isroot)
	{
		pathstr = g_LanguageDir + path;
	}

	if (WordsTable::getWordsTable()->open(pathstr.c_str(), false))
	{
		puts("open");
		goto SUCCESS_CREATE;
	}
	else if (!createIfNotExist)
	{ 
		puts("not exist and not set create");
		return -1;
	}
	
	if (!RWFStream::writeToFile("return {}", pathstr.c_str(), "wb"))
	{
		puts("write to file error");
		return -1;
	}

	if (!WordsTable::getWordsTable()->open(pathstr.c_str(), false))
	{		
		puts("reopen error");
		return -1;
	}
	
SUCCESS_CREATE:
	if (!WordsTable::getWordsTable()->createTmpUE())
	{
		puts("create tmp ue error");
		return -1;
	}
	
	puts("success");
	return 0;
}
int __stdcall UIDataLanguageClose()
{
	//if (!WordsTable::getWordsTable()->save())
	//	return -1;
	return 0;
}

int __stdcall UIDataCreate(UIData_t** pUIData)
{	
	if (!pUIData)
		return -1;

	*pUIData = 0;
	if (*pUIData)
	{
		UIDataClose(pUIData);
	}

	UIDataFormat* p = new UIDataFormat();
	*(UIDataFormat**)pUIData = p;

	return 0;
}

int __stdcall UIDataClear(UIData_t* pUIData)
{
	if (!pUIData)
		return -1;

	UIDataFormat* p = (UIDataFormat*)pUIData;
	p->clear();

	return 0;
}

int __stdcall UIDataClose(UIData_t** pUIData)
{
	if (!pUIData)
		return 0;

	UIDataFormat* p = (UIDataFormat*)pUIData;
	delete p;

	return 0;
}

//int __stdcall UIDataElementCreate(UIElement_t** pUIElement);
//int __stdcall UIDataElementClear(UIElement_t* pUIElement);

// for UIDataGetElement
int __stdcall UIDataElementFree(UIElement_t** pUIElement)
{
	string2pFree(0);
	if (0 == pUIElement)
		return 0;

	
	UIElement_t *uiElement = *pUIElement;
	if (!uiElement)
		return 0;


	string2pFree(uiElement->cName);
	string2pFree(uiElement->picName);
	string2pFree(uiElement->data);

	string2pFree(uiElement->text);


	switch (uiElement->type)
	{
	case UI_PROGRESS_BAR:
		string2pFree(uiElement->progressBarEx.barImage);
		break;
	case UI_BUTTON:
		string2pFree(uiElement->buttonEx.imageDown);
		string2pFree(uiElement->buttonEx.imageDisabled);
		string2pFree(uiElement->buttonEx.imageChecked);
		break;
	}
	delete uiElement;
	*pUIElement = 0;

	return 0;
}

int __stdcall UIDataAddElement(UIData_t* pUIData, UIElement_t* pUIElement)
{
	if (!pUIData || !pUIElement)
		return -1;
	
	UIDataFormat* p = (UIDataFormat*)pUIData;
	ElemInfo ele;
	if (!UIElement2ElemInfo(pUIElement, ele))
		return -1;

	p->push_back(ele);
	return 0;
}
int __stdcall UIDataGetElement(const UIData_t* pUIData, int index, UIElement_t** pUIElement)
{
	if (!pUIElement)
		return -1;

	*pUIElement = 0;
	if (!pUIData)
		return -1;

	UIDataFormat* p = (UIDataFormat*)pUIData;
	if (index < 0 || index >= p->count || static_cast<size_t>(index) >= p->m_item.size())
		return -1;

	*pUIElement = new UIElement_t;
	if (!ElemInfo2UIElement((p->m_item)[index].m_eleInfo, *pUIElement))
		return -1;

	return 0;
}
int __stdcall UIDataGetElementCount(const UIData_t* pUIData, short* count)
{
	if (!pUIData)
		return -1;

	printf("%d\n", sizeof(count));
	fflush(stdout);
	UIDataFormat* p = (UIDataFormat*)pUIData;
	int cnt = p->count;
	int item_cnt = static_cast<int>(p->m_item.size());
	if (count)
	{
		*count = static_cast<short>(cnt > item_cnt ? item_cnt : cnt);
	}
	return 0;
}

int __stdcall UIDataSetAlignment(UIData_t* pUIData, int align)
{
	if (!pUIData)
		return -1;

	UIDataFormat* p = (UIDataFormat*)pUIData;
	p->alignment = align;
	return 0;
}
int __stdcall UIDataGetAlignment(UIData_t* pUIData, int* align)
{
	if (!pUIData)
		return -1;

	UIDataFormat* p = (UIDataFormat*)pUIData;
	if (align)
	{
		*align = p->alignment;
	}
	
	return 0;
}

int __stdcall UIDataSaveToFile(const UIData_t* pUIData, const char* path)
{
	if (!pUIData || !path)
		return -1;

	UIDataFormat* p = (UIDataFormat*)pUIData;

	if (!UIDataFormat::setUIDataFormatToLuaFile(path, *p))
		return -1;

	return 0;
}

int __stdcall UIDataGetFromFile(UIData_t* pUIData, const char* path)
{
	if (!pUIData || !path)
		return -1;

	UIDataFormat* p = (UIDataFormat*)pUIData;

	if (!UIDataFormat::getUIDataFormatFromLuaFile(path, *p))
		return -1;

	return 0;
}