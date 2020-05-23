
// PlistChangeDlg.cpp : ʵ���ļ�
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


// CPlistChangeDlg �Ի���



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


// CPlistChangeDlg ��Ϣ�������

BOOL CPlistChangeDlg::OnInitDialog()
{
	CDialogEx::OnInitDialog();

	// ���ô˶Ի����ͼ�ꡣ��Ӧ�ó��������ڲ��ǶԻ���ʱ����ܽ��Զ�
	//  ִ�д˲���
	SetIcon(m_hIcon, TRUE);			// ���ô�ͼ��
	SetIcon(m_hIcon, FALSE);		// ����Сͼ��

	// TODO: �ڴ���Ӷ���ĳ�ʼ������

	return TRUE;  // ���ǽ��������õ��ؼ������򷵻� TRUE
}

// �����Ի��������С����ť������Ҫ����Ĵ���
//  �����Ƹ�ͼ�ꡣ����ʹ���ĵ�/��ͼģ�͵� MFC Ӧ�ó���
//  �⽫�ɿ���Զ���ɡ�

void CPlistChangeDlg::OnPaint()
{
	if (IsIconic())
	{
		CPaintDC dc(this); // ���ڻ��Ƶ��豸������

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// ʹͼ���ڹ����������о���
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// ����ͼ��
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialogEx::OnPaint();
	}
}

//���û��϶���С������ʱϵͳ���ô˺���ȡ�ù��
//��ʾ��
HCURSOR CPlistChangeDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}



void CPlistChangeDlg::OnBnClickedBtnConfirm()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	UpdateData(true);
	
	this->ScanDiskFile(pathName);
	AfxMessageBox("Done!");
	SendMessage(WM_CLOSE);
}


void CPlistChangeDlg::OnBnClickedBtnClose()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
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
		//�����"."��ɨ��
		if(find.IsDots())
			 continue;
		//��Ŀ¼,����ɨ���Ŀ¼
		else if(find.IsDirectory())
		{
			CString strPath = lpszPath + find.GetFileName();
			ScanDiskFile(strPath);
		}
		//�ļ�
		else
		{
			//����ļ���·��
			CString fileName = find.GetFileName();
			CString extend = fileName.Right(fileName.GetLength() - fileName.ReverseFind('.') - 1);//ȡ����չ��
			if (extend == "plist")//����plist�ļ�
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
     * cc.cfg���ļ�����r+������Զ�д�ļ� 
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
             * �����Ѿ��ҵ�����Ҫд��λ�ã�������Ҫдλ�õġ�ͷ�� 
             */  
            len -= strlen(linebuffer);  
            /* 
             * ʵ���ļ�λ�õ�ƫ�ƣ�Ϊд�ļ���׼�� 
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
             * д�ļ���������������� 
             */  
            fprintf(fp, "%s", lineStr);  
            fclose(fp);  
            return;  
        }  
    }  
}
