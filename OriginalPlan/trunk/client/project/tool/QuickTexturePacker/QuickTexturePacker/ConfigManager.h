#ifndef CONFIG_MANAGER_H_INCLUDED
#define CONFIG_MANAGER_H_INCLUDED

#include"stdafx.h"
#include"ConfigDetail.h"

class ConfigManager{
public:
	ConfigManager(){}
	~ConfigManager(){}

	ConfigDetail LoadConfig(const CString configFileName);
	int SaveConfig(ConfigDetail,const CString configFileName);

private:
	CStdioFile m_cFile;
};

#endif