
// PlistChangeDlg.h : 头文件
//

#pragma once


// CPlistChangeDlg 对话框
class CPlistChangeDlg : public CDialogEx
{
// 构造
public:
	CPlistChangeDlg(CWnd* pParent = NULL);	// 标准构造函数

// 对话框数据
	enum { IDD = IDD_PLISTCHANGE_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV 支持


// 实现
protected:
	HICON m_hIcon;

	// 生成的消息映射函数
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
