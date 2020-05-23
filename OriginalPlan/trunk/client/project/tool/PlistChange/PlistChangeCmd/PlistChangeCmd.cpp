// PlistChangeCmd.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include "PlistChangeCmd.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// 唯一的应用程序对象

CWinApp theApp;

using namespace std;

void ChangePlist(const CString& fileName)
{
	char linebuffer[2048] = {0};  
      
    int line_len = 0;  
    int len = 0;  
      
	CString findTarget("<string>$TexturePacker:SmartUpdate:");
	int targetLen = findTarget.GetLength() - 1;
    /* 
     * cc.cfg是文件名，r+代表可以读写文件 
     */  
	
    FILE *fp = 0;
	
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

void ScanDiskFile(const CString& strPath)
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
				ChangePlist(totalFileName);
			}
		}
	}
	find.Close();
	
}

int _tmain(int argc, TCHAR* argv[], TCHAR* envp[])
{
	int nRetCode = 0;

	HMODULE hModule = ::GetModuleHandle(NULL);

	if (hModule != NULL)
	{
		// 初始化 MFC 并在失败时显示错误
		if (!AfxWinInit(hModule, NULL, ::GetCommandLine(), 0))
		{
			// TODO: 更改错误代码以符合您的需要
			_tprintf(_T("错误: MFC 初始化失败\n"));
			nRetCode = 1;
		}
		else
		{
			// TODO: 在此处为应用程序的行为编写代码。
			if (argc == 2 )
			{
				printf(argv[1]);
				ScanDiskFile(argv[1]);
				printf("done!");
			}		
		}
	}
	else
	{
		// TODO: 更改错误代码以符合您的需要
		_tprintf(_T("错误: GetModuleHandle 失败\n"));
		nRetCode = 1;
	}

	return nRetCode;
}





