#ifndef _DB_STRUCT_BASE_H_
#define _DB_STRUCT_BASE_H_

#include "lib_misc.h"
#include "db_types_def.h"

namespace GXMISC{

#pragma pack(push, 1)
	struct TDBStructBase
	{
		TDBVersion_t	dbVersion;		// 数据库版本
		//	GXMISC::TGameTime_t saveTime;	// 保存时间 @TODO
		TDBStructBase() : dbVersion(INVALID_DB_VERSION){}
	};

	template<typename T>
	struct TDBStructParse
	{
		// 结构体如果进行了版本升级，则必须实现此接口
		bool parseVersion( T& data, TDBVersion_t realVersion , uint32 curIndex, uint32 totalIndex, const char* str )
		{
			return false;
		}
	};

#pragma pack(pop)
}

#endif