
// PlistChangeDlg.h : ͷ�ļ�
//

#pragma once


// CPlistChangeDlg �Ի���
class CPlistChangeDlg : public CDialogEx
{
// ����
public:
	CPlistChangeDlg(CWnd* pParent = NULL);	// ��׼���캯��

// �Ի�������
	enum { IDD = IDD_PLISTCHANGE_DIALOG };

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
	CString pathName;
public:
	afx_msg void OnBnClickedBtnConfirm();
	afx_msg void OnBnClickedBtnClose();
private:
	void ScanDiskFile(const CString& strPat);
	void changePlist(const CString& fileName);
};
