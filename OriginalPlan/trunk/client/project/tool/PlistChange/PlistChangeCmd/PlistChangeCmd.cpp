// PlistChangeCmd.cpp : �������̨Ӧ�ó������ڵ㡣
//

#include "stdafx.h"
#include "PlistChangeCmd.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// Ψһ��Ӧ�ó������

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
     * cc.cfg���ļ�����r+������Զ�д�ļ� 
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
		// ��ʼ�� MFC ����ʧ��ʱ��ʾ����
		if (!AfxWinInit(hModule, NULL, ::GetCommandLine(), 0))
		{
			// TODO: ���Ĵ�������Է���������Ҫ
			_tprintf(_T("����: MFC ��ʼ��ʧ��\n"));
			nRetCode = 1;
		}
		else
		{
			// TODO: �ڴ˴�ΪӦ�ó������Ϊ��д���롣
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
		// TODO: ���Ĵ�������Է���������Ҫ
		_tprintf(_T("����: GetModuleHandle ʧ��\n"));
		nRetCode = 1;
	}

	return nRetCode;
}





