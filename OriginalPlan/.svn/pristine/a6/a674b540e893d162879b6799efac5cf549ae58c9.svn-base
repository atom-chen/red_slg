#ifndef _CONSTANT_TBL_H_
#define _CONSTANT_TBL_H_

#include "core/string_common.h"
#include "base_packet_def.h"

#include "game_util.h"
#include "game_struct.h"
#include "tbl_config.h"
#include "tbl_loader.h"

class CConstantTbl : public CConfigTbl
{
public:
	sint32 id;						///< 常量编号
	TCharArray2 strId;				///< 字符编号
	std::string quantity;			///< 数值

public:
	DMultiIndexImpl1(uint32, id, 0);
	DMultiIndexImpl2(TCharArray2, strId, '0');

	DObjToString(CConstantTbl, uint32, id);
};

class  CConstantTblLoader : 
	public CConfigLoader2<CConstantTblLoader, CConstantTbl>
{
public:
	typedef CConfigLoader2<CConstantTblLoader, CConstantTbl> TBaseType;
public:
	virtual bool readRow(ConfigRow* row, sint32 count, TBaseType::ValueProType* destRow)
	{
		DReadConfigInt(id, id, destRow);
		DReadConfigTxt(strId, name, destRow);
		DReadConfigTxt(quantity,quantity,destRow);

		DAddToLoader(destRow);

		return true;
	}
};

#define DConstantTblMgr CConstantTblLoader::GetInstance()

template<typename T>
inline T GetConstantValue(sint32 id)
{
	const char* pStr = GetStringConstant(id);
	if(NULL == pStr){
		return (T)0;
	}
	CConstantTbl* constantRow = DConstantTblMgr.find2(pStr);
	if(NULL == constantRow)
	{
		return (T)0;
	}
	T val = (T)0;
	GXMISC::gxFromString(constantRow->quantity, val);
	return val;
}

template<>
inline uint32 GetConstantValue(sint32 id)
{
	const char* pStr = GetStringConstant(id);
	if (NULL == pStr){
		return 0;
	}
	CConstantTbl* constantRow = DConstantTblMgr.find2(pStr);
	if (NULL == constantRow)
	{
		return 0;
	}

	if (constantRow->quantity.find('-') != std::string::npos)
	{
		return 0;
	}

	uint32 val = 0;
	GXMISC::gxFromString(constantRow->quantity, val);
	return val;
}

template<>
inline std::string GetConstantValue<std::string>(sint32 id)
{
	const char* pStr = GetStringConstant(id);
	if(NULL == pStr){
		return "";
	}

	CConstantTbl* constantRow = DConstantTblMgr.find2(pStr);
	if(NULL == constantRow)
	{
		return "";
	}

	return constantRow->quantity;
}

#define GetConstant GetConstantValue
#define GetConstInt GetConstantValue<uint32>

#endif	// _CONSTANT_TBL_H_