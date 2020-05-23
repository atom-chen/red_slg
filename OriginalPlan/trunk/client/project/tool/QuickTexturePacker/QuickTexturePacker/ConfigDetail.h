#ifndef CONFIG_DETAIL_H_INCLUDED
#define CONFIG_DETAIL_H_INCLUDED

#include"stdafx.h"


class ConfigDetail{
public:
	ConfigDetail():
		m_iFormat(0),m_iTrimMode(0),m_iSizeConstraints(0)
	{
	}
	~ConfigDetail(){}

public:
	//--------setter------------------------------
	void SetSourcePath(const CString &sourcePath)
	{
		m_sSourcePath = sourcePath;
	}

	void SetTargetPath(const CString &targetPath)
	{
		m_sTargetPath = targetPath;
	}
	void SetTexturePackerPath(const CString &texturePackerPath)
	{
		m_sTexturePackerPath = texturePackerPath;
	}
	void SetTrimMode(int trimMode)
	{
		m_iTrimMode = trimMode;
	}
	void SetSizeConstraints(int sizeConstraints)
	{
		m_iSizeConstraints = sizeConstraints;
	}
	void SetFormat(int format)
	{
		m_iFormat = format;
	}

	//---------getter------------------------------
	CString GetSourcePath()
	{
		return m_sSourcePath;
	}
	CString GetTargetPath()
	{
		return m_sTargetPath;
	}
	CString GetTexturePackerPath()
	{
		return m_sTexturePackerPath;
	}
	int GetTrimMode()
	{
		return m_iTrimMode;
	}
	int GetSizeConstraints()
	{
		return m_iSizeConstraints;
	}
	int GetFormat()
	{
		return m_iFormat;
	}
private:
	CString m_sSourcePath;
	CString m_sTargetPath;
	CString m_sTexturePackerPath;

	int m_iTrimMode;
	int m_iSizeConstraints;
	int m_iFormat;
};

#endif