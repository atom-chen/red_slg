
// PlistChange.h : PROJECT_NAME Ӧ�ó������ͷ�ļ�
//

#pragma once

#ifndef __AFXWIN_H__
	#error "�ڰ������ļ�֮ǰ������stdafx.h�������� PCH �ļ�"
#endif

#include "resource.h"		// ������


// CPlistChangeApp:
// �йش����ʵ�֣������ PlistChange.cpp
//

class CPlistChangeApp : public CWinApp
{
public:
	CPlistChangeApp();

// ��д
public:
	virtual BOOL InitInstance();

// ʵ��

	DECLARE_MESSAGE_MAP()
};

extern CPlistChangeApp theApp;