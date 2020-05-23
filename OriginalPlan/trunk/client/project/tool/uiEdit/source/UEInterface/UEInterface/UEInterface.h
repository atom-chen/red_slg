#ifndef __UEINTERFACE_H__
#define __UEINTERFACE_H__
extern "C"{
struct ProgressBarEx_t;
struct ButtonEx_t
{
	char* imageDown;
	char* imageDisabled;
	char* imageChecked;
};

struct ProgressBarEx_t
{
	int x;
	int y;
	int width;
	int height;
	char* barImage;
};
#pragma pack(4)
struct UIElement_t
{	
	char* 			cName;
	char* 			picName;
	char*			audio;
	char*			data;

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
	short 			type;
	int				frameType;

	short 			textType;
	short			__padding1;
	char* 			text;
	
	int				useRTF;
	int				textShade;//文字类型：普通，阴影，
	int				fontSize;
	int				fontColor;
	int 			align;
	ProgressBarEx_t	progressBarEx;
	ButtonEx_t     	buttonEx;
};
#pragma pack()


struct UIData_t;

#define UI_SUCCESS(ret) ((ret) == 0)

int __stdcall UIDataSetLanguageDir(const char* path);
int __stdcall UIDataLanguageCreate(const char* path, int createIfNotExist);
int __stdcall UIDataLanguageClose();

int __stdcall UIDataCreate(UIData_t** pUIData); //申请资源。
int __stdcall UIDataClear(UIData_t* pUIData);	//恢复初始化
int __stdcall UIDataClose(UIData_t** pUIData); //关闭资源

//int __stdcall UIDataElementCreate(UIElement_t** pUIElement);
//int __stdcall UIDataElementClear(UIElement_t* pUIElement);

// for UIDataGetElement
int __stdcall UIDataElementFree(UIElement_t** pUIElement);

int __stdcall UIDataAddElement(UIData_t* pUIData, UIElement_t* pUIElement);
int __stdcall UIDataGetElement(const UIData_t* pUIData, int index, UIElement_t** pUIElement);
int __stdcall UIDataGetElementCount(const UIData_t* pUIData, short* count);

int __stdcall UIDataSetAlignment(UIData_t* pUIData, int align);
int __stdcall UIDataGetAlignment(UIData_t* pUIData, int* align);

int __stdcall UIDataSaveToFile(const UIData_t* pUIData, const char* path);
int __stdcall UIDataGetFromFile(UIData_t* pUIData, const char* path);
}
#endif