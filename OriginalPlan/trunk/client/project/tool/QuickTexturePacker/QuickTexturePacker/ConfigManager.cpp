#include"stdafx.h"
#include"ConfigManager.h"
#include"ConfigDetail.h"

int ConfigManager::SaveConfig(ConfigDetail configDetail,const CString configFileName)
{
	CStdioFile file;
	BOOL bOpenSuccess = file.Open(configFileName, CFile::modeCreate | CFile::modeWrite);
	if(FALSE == bOpenSuccess)
	{
		return 1;
	}

	CString sTemp;
	sTemp = configDetail.GetSourcePath() + "\n";
	file.WriteString(sTemp);
	sTemp = configDetail.GetTargetPath() + "\n";
	file.WriteString(sTemp);
	sTemp = configDetail.GetTexturePackerPath() + "\n";
	file.WriteString(sTemp);
	int iTemp;
	iTemp = configDetail.GetTrimMode();
	sTemp.Format("%d\n", iTemp);
	file.WriteString(sTemp);
	iTemp = configDetail.GetSizeConstraints();
	sTemp.Format("%d\n", iTemp);
	file.WriteString(sTemp);
	iTemp = configDetail.GetFormat();
	sTemp.Format("%d\n", iTemp);
	file.WriteString(sTemp);

	file.Flush();
	file.Close();

	return 0;
}

ConfigDetail ConfigManager::LoadConfig(const CString configFileName)
{
	ConfigDetail config;
	CStdioFile file;
	BOOL bOpenSuccess = file.Open(configFileName, CFile::modeRead);
	if(FALSE == bOpenSuccess)
	{
		return config;
	}

	CString sTemp;
	file.ReadString(sTemp);
	config.SetSourcePath(sTemp);
	file.ReadString(sTemp);
	config.SetTargetPath(sTemp);
	file.ReadString(sTemp);
	config.SetTexturePackerPath(sTemp);
	int iTemp;
	file.ReadString(sTemp);
	sscanf_s(sTemp, "%d", &iTemp);
	config.SetTrimMode(iTemp);
	file.ReadString(sTemp);
	sscanf_s(sTemp, "%d", &iTemp);
	config.SetSizeConstraints(iTemp);
	file.ReadString(sTemp);
	sscanf_s(sTemp, "%d", &iTemp);
	config.SetFormat(iTemp);

	return config;
}