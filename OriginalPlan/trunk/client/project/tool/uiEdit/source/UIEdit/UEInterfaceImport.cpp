#include "UEInterfaceImport.h"
#include "windows.h"
#include "stdio.h"
int (__stdcall *UIDataSetLanguageDir)(const char* path);
int (__stdcall *UIDataLanguageCreate)(const char* path, int createIfNotExist);
int (__stdcall *UIDataLanguageClose)();

int (__stdcall *UIDataCreate)(UIData_t** pUIData); //申请资源。
int (__stdcall *UIDataClear)(UIData_t* pUIData);	//恢复初始化
int (__stdcall *UIDataClose)(UIData_t** pUIData); //关闭资源

int (__stdcall *UIDataElementFree)(UIElement_t** pUIElement);

int (__stdcall *UIDataAddElement)(UIData_t* pUIData, UIElement_t* pUIElement);
int (__stdcall *UIDataGetElement)(const UIData_t* pUIData, int index, UIElement_t** pUIElement);
int (__stdcall *UIDataGetElementCount)(const UIData_t* pUIData, int* count);

int (__stdcall *UIDataSetAlignment)(UIData_t* pUIData, int align);
int (__stdcall *UIDataGetAlignment)(UIData_t* pUIData, int* align);

int (__stdcall *UIDataSaveToFile)(const UIData_t* pUIData, const char* path);
int (__stdcall *UIDataGetFromFile)(UIData_t* pUIData, const char* path);

template<typename T, typename AddrPointerT>
T type2target(AddrPointerT p, T)
{
	if (!p)
	{
		DWORD ret = GetLastError();
		printf("%d", ret);
	}
	return (T)p;
}




HMODULE g_module;

#define GETPROC(func) ((func = type2target(GetProcAddress(g_module, #func), func)), func)

bool LoadUELibrary()
{
	if (g_module)
		return true;
		
	g_module = LoadLibraryA("UEInterface.dll");

	if (!g_module)
    {
	    DWORD ret = GetLastError();
        char data[1024];
        sprintf(data, "找不到 UI DLL, 错误:%d", ret);
        MessageBoxA(0, data, "错误", 0);
    	return false;
    }

	if (!GETPROC(UIDataSetLanguageDir)) return false;
	if (!GETPROC(UIDataLanguageCreate)) return false;
	if (!GETPROC(UIDataLanguageClose)) return false;
	if (!GETPROC(UIDataCreate)) return false;
	if (!GETPROC(UIDataClear)) return false;
	if (!GETPROC(UIDataClose)) return false;
	if (!GETPROC(UIDataElementFree)) return false;
	if (!GETPROC(UIDataAddElement)) return false;
	if (!GETPROC(UIDataGetElement)) return false;
	if (!GETPROC(UIDataGetElementCount)) return false;
	if (!GETPROC(UIDataSetAlignment)) return false;
	if (!GETPROC(UIDataGetAlignment)) return false;
	if (!GETPROC(UIDataSaveToFile)) return false;
	if (!GETPROC(UIDataGetFromFile)) return false;
	
	return true;
}

bool FreeUELibrary()
{
	if (!g_module)
		return true;
		
	FreeLibrary(g_module);
	return true;
}