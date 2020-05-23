
// QuickTexturePackerDlg.cpp : ʵ���ļ�
//

#include "stdafx.h"
#include "QuickTexturePacker.h"
#include "QuickTexturePackerDlg.h"
#include "afxdialogex.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CQuickTexturePackerDlg �Ի���



CQuickTexturePackerDlg::CQuickTexturePackerDlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(CQuickTexturePackerDlg::IDD, pParent)
	, m_sSourcePath(_T(""))
	, m_sTargetPath(_T(""))
	, m_sTexturePackerPath(_T(""))
	, m_sCmdParam(_T(""))
	, m_sBatName(_T(""))
	, m_iPackTypeRadio(0)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CQuickTexturePackerDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
	DDX_Text(pDX, IDC_SOURCE_PATH_INPUT, m_sSourcePath);
	DDX_Text(pDX, IDC_TARGET_PATH_INPUT, m_sTargetPath);
	DDX_Text(pDX, IDC_EDIT1, m_sTexturePackerPath);
	DDX_Control(pDX, IDC_FORMAT_COMBO, m_dFormatBox);
	DDX_Control(pDX, IDC_SIZE_CONSTRAINTS_COMBO, m_dSizeConstraintsBox);
	DDX_Control(pDX, IDC_TRIM_MODE_COMBO, m_dTrimModeBox);
	DDX_Text(pDX, IDC_CMD_EDIT, m_sCmdParam);
	DDX_Text(pDX, IDC_BAT_NAME_EDIT, m_sBatName);
	DDX_Radio(pDX, IDC_RADIO2, m_iPackTypeRadio);
	DDX_Control(pDX, IDC_FILENAME_EDIT, m_dFileNameEdit);
}

BEGIN_MESSAGE_MAP(CQuickTexturePackerDlg, CDialogEx)
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_ENTER_BTN, &CQuickTexturePackerDlg::OnBnClickedEnterBtn)
	ON_BN_CLICKED(IDC_CLOSE_BTN, &CQuickTexturePackerDlg::OnBnClickedCloseBtn)
	ON_BN_CLICKED(IDC_CMD_BUTTON, &CQuickTexturePackerDlg::OnBnClickedCmdButton)
	ON_BN_CLICKED(IDC_RADIO2, &CQuickTexturePackerDlg::OnBnClickedRadio2)
	ON_BN_CLICKED(IDC_RADIO3, &CQuickTexturePackerDlg::OnBnClickedRadio3)
END_MESSAGE_MAP()


// CQuickTexturePackerDlg ��Ϣ�������

BOOL CQuickTexturePackerDlg::OnInitDialog()
{
	CDialogEx::OnInitDialog();

	// ���ô˶Ի����ͼ�ꡣ��Ӧ�ó��������ڲ��ǶԻ���ʱ����ܽ��Զ�
	//  ִ�д˲���
	SetIcon(m_hIcon, TRUE);			// ���ô�ͼ��
	SetIcon(m_hIcon, FALSE);		// ����Сͼ��

	// TODO: �ڴ���Ӷ���ĳ�ʼ������
	//��ʼ��Format�����˵�
	m_dFormatBox.ResetContent();
	m_dFormatBox.AddString("RGBA8888");
	m_dFormatBox.AddString("BGRA8888");
	m_dFormatBox.AddString("RGBA4444");
	m_dFormatBox.AddString("RGB888");
	m_dFormatBox.AddString("RGB565");
	m_dFormatBox.AddString("RGBA5551");
	m_dFormatBox.AddString("RGBA5555");
	m_dFormatBox.AddString("PVRTC2");
	m_dFormatBox.AddString("PVRTC4");
	m_dFormatBox.AddString("PVRTC2_NOALPHA");
	m_dFormatBox.AddString("PVRTC4_NOALPHA");
	m_dFormatBox.AddString("ALPHA");
	m_dFormatBox.AddString("ALPHA_INTENSITY");
	m_dFormatBox.AddString("ETC1");
	m_dFormatBox.SetCurSel(0);
	
	//��ʼ��SizeConstraints�����˵�
	m_dSizeConstraintsBox.ResetContent();
	m_dSizeConstraintsBox.AddString("NPOT");
	m_dSizeConstraintsBox.AddString("AnySize");
	m_dSizeConstraintsBox.AddString("POT");
	m_dSizeConstraintsBox.SetCurSel(0);

	//��ʼ��TrimMode�����˵�
	m_dTrimModeBox.ResetContent();
	m_dTrimModeBox.AddString("Trim");
	m_dTrimModeBox.AddString("None");
	m_dTrimModeBox.AddString("Crop");
	m_dTrimModeBox.AddString("CropKeepPos");
	m_dTrimModeBox.SetCurSel(0);

	m_iPackTypeRadio = 1;
	m_dFileNameEdit.EnableWindow(FALSE);

	//��д��һ�μ�¼������
	ConfigDetail config = m_ConfigManager.LoadConfig("config");
	m_sSourcePath = config.GetSourcePath();
	m_sTargetPath = config.GetTargetPath();
	m_sTexturePackerPath = config.GetTexturePackerPath();

	int iTemp = config.GetTrimMode();
	m_dTrimModeBox.SetCurSel(iTemp);
	iTemp = config.GetSizeConstraints();
	m_dSizeConstraintsBox.SetCurSel(iTemp);
	iTemp = config.GetFormat();
	m_dFormatBox.SetCurSel(iTemp);
	
	UpdateData(false);

	return TRUE;  // ���ǽ��������õ��ؼ������򷵻� TRUE
}

// �����Ի��������С����ť������Ҫ����Ĵ���
//  �����Ƹ�ͼ�ꡣ����ʹ���ĵ�/��ͼģ�͵� MFC Ӧ�ó���
//  �⽫�ɿ���Զ���ɡ�

void CQuickTexturePackerDlg::OnPaint()
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
HCURSOR CQuickTexturePackerDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}



void CQuickTexturePackerDlg::OnBnClickedEnterBtn()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	UpdateData(true);
	ConfigDetail config = MakeConfigDetail();
	m_ConfigManager.SaveConfig(config, "config");
	if("" == m_sTexturePackerPath)
	{
		AfxMessageBox("������TexturePacker����Ŀ¼");
		return;
	}
	if("" == m_sSourcePath)
	{
		AfxMessageBox("������Ҫ�����ͼƬ����Ŀ¼");
		return;
	}
	if("" == m_sTargetPath)
	{
		AfxMessageBox("�����������ͼƬ����ŵ�Ŀ¼");
		return;
	}

	if('\\' != m_sTexturePackerPath[m_sTexturePackerPath.GetLength() - 1] )
	{
		m_sTexturePackerPath = m_sTexturePackerPath + "\\";
	}

	if( 1 == m_iPackTypeRadio)
	{
		PackSpritesInFloder(m_sSourcePath, m_sTargetPath);
	}else
	{
		PackSpirteIntoOneFile();
	}
}

void CQuickTexturePackerDlg::PackSpritesInFloder(const CString &sPath, const CString &tPath)
{
	if(sPath == "" || tPath == "" )
	{
		return ;
	}
	CString sourcePath;
	if('\\' != sPath[sPath.GetLength() - 1])
	{
		sourcePath = sPath + "\\";
	}else
	{
		sourcePath = sPath;
	}
	CString targetPath;
	if('\\' != tPath[tPath.GetLength() - 1])
	{
		targetPath = tPath + "\\";
	}else
	{
		targetPath = tPath;
	}
	CFileFind find;
	CString sSearchTarget = sourcePath + "*.*";

	BOOL isFind = find.FindFile(sSearchTarget);

	CFile file("test.bat", CFile::modeWrite|CFile::modeCreate);
	while(isFind)
	{
		isFind = find.FindNextFile();
		if(find.IsDots())
		{
			continue;
		}
		if(find.IsDirectory())
		{
			CString nextSourcePath = sourcePath + find.GetFileName();
			CString nextTargetParh = targetPath + find.GetFileName();

			PackSpritesInFloder(nextSourcePath, nextTargetParh);
		}else
		{
			CString fileName = find.GetFileName();
			CString extend = fileName.Right(fileName.GetLength() - fileName.ReverseFind('.') - 1);
			if(IsExtendMatch(extend))
			{
				//fileName.Replace("." + extend, "");
				PackSpirte(fileName, sourcePath , targetPath ,file);
			}
		}
	}
	file.Close();

	system("test.bat");
}

BOOL CQuickTexturePackerDlg::IsExtendMatch(const CString &ext)
{
	return ext == "png" || ext == "jpg" || ext == "w";
}

void CQuickTexturePackerDlg::PackSpirte(const CString &fileName, const CString &sourcePath, const CString &targetPath, CFile &file)
{
	//��ȡ�������
	CString format;
	m_dFormatBox.GetWindowText(format);
	CString sizeConstraints;
	m_dSizeConstraintsBox.GetWindowText(sizeConstraints);
	CString trimMode;
	m_dTrimModeBox.GetWindowText(trimMode);

	CString temp = fileName.Left(fileName.ReverseFind('.'));
	CString targetFileName = targetPath + temp + ".pvr.ccz";
	CString sourceFileName = sourcePath + fileName;
	CString cmdString;

	//��ȡͼƬ�Ĵ�С
	CImage image;
	image.Load(sourceFileName);
	int width = image.GetWidth();
	int height = image.GetHeight();

	cmdString.Format("\"%sTexturePacker\" --max-size 2048 --sheet %s --format cocos2d --max-width %d --max-height %d --shape-padding 0 --border-padding 0 --inner-padding 0 --disable-rotation --trim-mode %s --size-constraints %s --opt %s %s",
		m_sTexturePackerPath, targetFileName, width, height, trimMode, sizeConstraints,format, sourceFileName);
	file.Write(cmdString,cmdString.GetLength());
	file.Write("\r\n",2);

	//AfxMessageBox(cmdString);
	//cmdString = "ipconfig";
	//system(cmdString);
	//ShellExecute(NULL, "open", "E:\\tool\\TexturePacker\\bin\\TexturePacker", cmdString,NULL,SW_HIDE);
}

void CQuickTexturePackerDlg::OnBnClickedCloseBtn()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	this->DestroyWindow();
}


void CQuickTexturePackerDlg::OnOK()
{
	// TODO: �ڴ����ר�ô����/����û���

	//CDialogEx::OnOK();
}


void CQuickTexturePackerDlg::OnBnClickedCmdButton()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	AfxMessageBox("�����Шr(�s���t)�q");
}

ConfigDetail CQuickTexturePackerDlg::MakeConfigDetail()
{
	UpdateData(true);

	ConfigDetail config;

	config.SetSourcePath(m_sSourcePath);
	config.SetTargetPath(m_sTargetPath);
	config.SetTexturePackerPath(m_sTexturePackerPath);

	int temp;
	temp = m_dTrimModeBox.GetCurSel();
	config.SetTrimMode(temp);
	temp = m_dSizeConstraintsBox.GetCurSel();
	config.SetSizeConstraints(temp);
	temp = m_dFormatBox.GetCurSel();
	config.SetFormat(temp);

	return config;
}

void CQuickTexturePackerDlg::OnBnClickedRadio2()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	m_dFileNameEdit.EnableWindow(TRUE);
}


void CQuickTexturePackerDlg::OnBnClickedRadio3()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	m_dFileNameEdit.EnableWindow(FALSE);
}

void CQuickTexturePackerDlg::PackSpirteIntoOneFile()
{
	CString sourcePath;
	if('\\' != m_sSourcePath[m_sSourcePath.GetLength() - 1])
	{
		sourcePath = m_sSourcePath + "\\";
	}else
	{
		sourcePath = m_sSourcePath;
	}
	CString targetPath;
	if('\\' != m_sTargetPath[m_sTargetPath.GetLength() - 1])
	{
		targetPath = m_sTargetPath + "\\";
	}else
	{
		targetPath = m_sTargetPath;
	}

	if('\\' != m_sTexturePackerPath[m_sTexturePackerPath.GetLength() - 1] )
	{
		m_sTexturePackerPath = m_sTexturePackerPath + "\\";
	}

	//��ȡ�������
	CString format;
	m_dFormatBox.GetWindowText(format);
	CString sizeConstraints;
	m_dSizeConstraintsBox.GetWindowText(sizeConstraints);
	CString trimMode;
	m_dTrimModeBox.GetWindowText(trimMode);

	CString cmdString;
	CString fileName;
	m_dFileNameEdit.GetWindowTextA(fileName);
	CString targetFileName = targetPath + fileName + ".pvr.ccz";
	CString targetPlistName = targetPath + fileName + ".plist"; 

	CFile file("test.bat", CFile::modeWrite|CFile::modeCreate);

	cmdString.Format("\"%sTexturePacker\" --max-size 2048 --sheet %s --data %s --format cocos2d  --trim-mode %s --disable-rotation --size-constraints %s --opt %s %s",
		m_sTexturePackerPath, targetFileName, targetPlistName, trimMode, sizeConstraints,format, sourcePath);

	file.Write(cmdString,cmdString.GetLength());
	file.Write("\r\n",2);
	file.Close();

	system("test.bat");
}