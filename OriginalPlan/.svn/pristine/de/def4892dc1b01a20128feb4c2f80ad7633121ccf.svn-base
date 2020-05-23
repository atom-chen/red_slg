#ifndef _TBL_RAND_NAME_
#define _TBL_RAND_NAME_
#include <vector>

#include "core/string_parse.h"
#include "core/singleton.h"

#include "tbl_config.h"
#include "tbl_loader.h"
#include "game_util.h"
#include "game_define.h"

typedef  std::vector<std::string> TRoleNameArray;

class  CRoleNameRandTbl : public CConfigTbl
{
public:
	CRoleNameRandTbl(){}
	~CRoleNameRandTbl(){}
public:
	std::string  getString(TSex_t sex,uint32 index)
	{
		if (sex == SEX_TYPE_MALE)
		{
			return randManRoleAry[index];
		}
		return randWomanRoleAry[index];
	}
	uint32   getLength(TSex_t sex)
	{
		if (sex == SEX_TYPE_MALE)
		{
			return randManRoleAry.size();
		}
		return randWomanRoleAry.size();
	}
public:
	uint8     id;
	TRoleNameArray  randManRoleAry;
	TRoleNameArray  randWomanRoleAry;

public:
	DMultiIndexImpl1(uint32,id,0);
	DObjToStringAlias(CRoleNameRandTbl, uint32, ID, id);
};

class  CRoleNameLoader : public CConfigLoader<CRoleNameLoader, CRoleNameRandTbl>
{
public:
	virtual bool readRow(ConfigRow* row, sint32 count, CRoleNameRandTbl* randNameRow)
	{
		DReadConfigInt(id,id,randNameRow);

		GXMISC::CStringParse<std::string> tempMan;
		tempMan.setParseFlag(",");
		std::string temp = row->Attribute("manCode");
		tempMan.parse(temp);
		randNameRow->randManRoleAry = tempMan.getValueList();

		GXMISC::CStringParse<std::string> tempWoman;
		tempWoman.setParseFlag(",");
		std::string tempW = row->Attribute("womanCode");
		tempWoman.parse(tempW);
		randNameRow->randWomanRoleAry = tempWoman.getValueList();

		DAddToLoader(randNameRow);

		return true;
	}
};

#define   DRandRoleNameTbl   CRoleNameLoader::GetInstance()

#endif	// _TBL_RAND_NAME_