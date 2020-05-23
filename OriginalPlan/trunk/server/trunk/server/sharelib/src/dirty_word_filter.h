#ifndef _DIRTY_WORD_FILTER_H_
#define _DIRTY_WORD_FILTER_H_

#include <vector>
#include <string>
#include <iostream>
#include <fstream>

#include "core/debug.h"
#include "core/singleton.h"
#include "core/string_common.h"

#include "game_errno.h"

#define  ROLE_NAME_MIN_CHAR_NUM 2           // 名字的最小长度
#define  ROLE_NAME_MAX_CHAR_NUM 7           // 名字的最大长度
#define  READ_FILE_BUFF 1024

class CCheckText : public GXMISC::CManualSingleton<CCheckText>
{
public:
	DSingletonImpl();

public:
	CCheckText()	{ _checkContainer.clear(); }
	~CCheckText()	{ _checkContainer.clear(); }

	EGameRetCode isTextPass( const std::string& checkText )
	{
		if(checkText.find(' ')!=std::string::npos)  
		{
			return RC_TEXT_INVALID;
		}
		for (std::vector<std::string>::iterator itr = _checkContainer.begin(); itr != _checkContainer.end(); itr++ )
		{
			size_t found = checkText.find(itr->c_str());
			if (found != std::string::npos)
			{
				return RC_TEXT_INVALID;
			}
		}
		return RC_SUCCESS;
	}

	std::vector<std::string>& getFilterContentVec(void)
	{
		return _checkContainer;
	}

	std::set<std::string>& getFilterContentSet(void)
	{
		return _filterContainer;
	}

	bool isFilterContent(const std::string& content )
	{
		if( _filterContainer.find(content) != _filterContainer.end() )
		{
			return false;
		}
		
		return true;
	}

	// 初始化容器
	bool init( const std::string& filePath )
	{
		std::ifstream openFile(filePath.c_str());
		if (!openFile.is_open())
		{
			gxError("{0} file cant open",filePath.c_str());
			return false;
		}
		char temp[READ_FILE_BUFF];
		memset(temp,0,READ_FILE_BUFF);
		while (!openFile.eof())
		{
			openFile.getline(temp,READ_FILE_BUFF-1);
			if ( 0 != GXMISC::gxStricmp(temp,""))
			{
				_checkContainer.push_back(temp);
				_filterContainer.insert(temp);
			}
			memset(temp,0,READ_FILE_BUFF);
		}
		openFile.close();
		return true;
	}

private:
	std::string _filePath;
	std::vector<std::string> _checkContainer;
	std::set<std::string> _filterContainer;               //脏字检查
};

#define DCheckText CCheckText::GetInstance()

#endif	// _DIRTY_WORD_FILTER_H_