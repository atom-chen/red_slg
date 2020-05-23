
// PlistChangeDlg.cpp : 实现文件
//

#include "stdafx.h"
#include "PlistChange.h"
#include "PlistChangeDlg.h"
#include "afxdialogex.h"
#include<stdio.h>  
#include<stdlib.h>  
#include<string.h>  

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CPlistChangeDlg 对话框



CPlistChangeDlg::CPlistChangeDlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(CPlistChangeDlg::IDD, pParent)
	, pathName(_T(""))
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CPlistChangeDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
	DDX_Text(pDX, IDC_EDIT1, pathName);
}

BEGIN_MESSAGE_MAP(CPlistChangeDlg, CDialogEx)
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BTN_CONFIRM, &CPlistChangeDlg::OnBnClickedBtnConfirm)
	ON_BN_CLICKED(IDC_BTN_CLOSE, &CPlistChangeDlg::OnBnClickedBtnClose)
END_MESSAGE_MAP()


// CPlistChangeDlg 消息处理程序

BOOL CPlistChangeDlg::OnInitDialog()
{
	CDialogEx::OnInitDialog();

	// 设置此对话框的图标。当应用程序主窗口不是对话框时，框架将自动
	//  执行此操作
	SetIcon(m_hIcon, TRUE);			// 设置大图标
	SetIcon(m_hIcon, FALSE);		// 设置小图标

	// TODO: 在此添加额外的初始化代码

	return TRUE;  // 除非将焦点设置到控件，否则返回 TRUE
}

// 如果向对话框添加最小化按钮，则需要下面的代码
//  来绘制该图标。对于使用文档/视图模型的 MFC 应用程序，
//  这将由框架自动完成。

void CPlistChangeDlg::OnPaint()
{
	if (IsIconic())
	{
		CPaintDC dc(this); // 用于绘制的设备上下文

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// 使图标在工作区矩形中居中
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// 绘制图标
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialogEx::OnPaint();
	}
}

//当用户拖动最小化窗口时系统调用此函数取得光标
//显示。
HCURSOR CPlistChangeDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}



void CPlistChangeDlg::OnBnClickedBtnConfirm()
{
	// TODO: 在此添加控件通知处理程序代码
	UpdateData(true);
	
	this->ScanDiskFile(pathName);
	AfxMessageBox("Done!");
	SendMessage(WM_CLOSE);
}


void CPlistChangeDlg::OnBnClickedBtnClose()
{
	// TODO: 在此添加控件通知处理程序代码
	SendMessage(WM_CLOSE);
	
}


void CPlistChangeDlg::ScanDiskFile(const CString& strPath)
{
	CFileFind find;
	CString path = strPath;
	CString lpszPath =  path;
	//AfxMessageBox(lpszPath);
	if('\\' != strPath[strPath.GetLength() - 1]) 
	{
		//AfxMessageBox("'\\' != strPath[strPath.GetLength()]");
		//CString temp; temp.Format('%c', strPath[strPath.GetLength()]);
		//AfxMessageBox(temp);
		lpszPath = lpszPath + '\\';
	}
	//AfxMessageBox(lpszPath);
	path = path + "\\*.*";
	BOOL IsFind = find.FindFile(path);
	while(IsFind )
	{
	IsFind=find.FindNextFile();
		//如果是"."则不扫描
		if(find.IsDots())
			 continue;
		//是目录,继续扫描此目录
		else if(find.IsDirectory())
		{
			CString strPath = lpszPath + find.GetFileName();
			ScanDiskFile(strPath);
		}
		//文件
		else
		{
			//获得文件的路径
			CString fileName = find.GetFileName();
			CString extend = fileName.Right(fileName.GetLength() - fileName.ReverseFind('.') - 1);//取得扩展名
			if (extend == "plist")//查找plist文件
			{
				//AfxMessageBox("fileName");
				//AfxMessageBox(fileName);
				//TODO
				CString totalFileName = lpszPath + fileName;
				this->changePlist(totalFileName);
			}
		}
	}
	find.Close();
	
}


void CPlistChangeDlg::changePlist(const CString& fileName)
{
	char linebuffer[2048] = {0};  
    //char buffer1[2048] = {0};  
    //char buffer2[2048] = {0};  
      
    int line_len = 0;  
    int len = 0;  
      
	CString findTarget("<string>$TexturePacker:SmartUpdate:");
	int targetLen = findTarget.GetLength() - 1;
    /* 
     * cc.cfg是文件名，r+代表可以读写文件 
     */  
	
    FILE *fp = 0;
	//
	//AfxMessageBox(fileName);
	fopen_s(&fp, fileName, "r+");
    if(fp == NULL)  
    {  
        AfxMessageBox("open error");  
        return ;  
    }  
    while(fgets(linebuffer, 2048, fp))  
    {  
        line_len = strlen(linebuffer);  
        len += line_len;  
      
		CString lineStr(linebuffer);
		int index = lineStr.Find( findTarget,0);
        if( -1 != index )  
        {  
            /* 
             * 由于已经找到所需要写的位置，所以需要写位置的“头” 
             */  
            len -= strlen(linebuffer);  
            /* 
             * 实现文件位置的偏移，为写文件做准备 
             */  
            int res = fseek(fp, len, SEEK_SET);  
            if(res < 0)  
            {  
                AfxMessageBox("fseek error");  
                return ;  
            }  

			index = index + targetLen;
			int lineStrLength = lineStr.GetLength();
			for (int i = index + 1; i < index + 32 + 1; ++i)
			{
				lineStr.SetAt(i, '0');
			}

            
            /* 
             * 写文件，存入所需的内容 
             */  
            fprintf(fp, "%s", lineStr);  
            fclose(fp);  
            return;  
        }  
    }  
}
