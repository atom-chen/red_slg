
// QuickTexturePackerDlg.h : ͷ�ļ�
//

#pragma once
#include "afxwin.h"


// CQuickTexturePackerDlg �Ի���
class CQuickTexturePackerDlg : public CDialogEx
{
// ����
public:
	CQuickTexturePackerDlg(CWnd* pParent = NULL);	// ��׼���캯��

// �Ի�������
	enum { IDD = IDD_QUICKTEXTUREPACKER_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV ֧��


// ʵ��
protected:
	HICON m_hIcon;

	// ���ɵ���Ϣӳ�亯��
	virtual BOOL OnInitDialog();
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()
private:
	CString m_sSourcePath;
	CString m_sTargetPath;
public:
	afx_msg void OnBnClickedEnterBtn();
private:
	void PackSpritesInFloder(const CString &sourcePath, const CString &targetPath);
	BOOL IsExtendMatch(const CString &ext);
	void PackSpirte(const CString &fileName, const CString &sourcePath, const CString &targetPath, CFile &file);
	CString m_sTexturePackerPath;
public:
	afx_msg void OnBnClickedCloseBtn();
	virtual void OnOK();
private:
	CComboBox m_dFormatBox;
	CComboBox m_dSizeConstraintsBox;
	CComboBox m_dTrimModeBox;
	CString m_sCmdParam;
public:
	afx_msg void OnBnClickedCmdButton();
private:
	ConfigDetail MakeConfigDetail();
	ConfigManager m_ConfigManager;
	CString m_sBatName;
	int m_iPackTypeRadio;
public:
	afx_msg void OnBnClickedRadio2();
	afx_msg void OnBnClickedRadio3();
private:
	CEdit m_dFileNameEdit;
	void PackSpirteIntoOneFile();
};
