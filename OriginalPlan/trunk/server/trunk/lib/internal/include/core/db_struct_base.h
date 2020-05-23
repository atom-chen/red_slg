#ifndef _DB_STRUCT_BASE_H_
#define _DB_STRUCT_BASE_H_

#include "lib_misc.h"
#include "db_types_def.h"

namespace GXMISC{

#pragma pack(push, 1)
	struct TDBStructBase
	{
		TDBVersion_t	dbVersion;		// ���ݿ�汾
		//	GXMISC::TGameTime_t saveTime;	// ����ʱ�� @TODO
		TDBStructBase() : dbVersion(INVALID_DB_VERSION){}
	};

	template<typename T>
	struct TDBStructParse
	{
		// �ṹ����������˰汾�����������ʵ�ִ˽ӿ�
		bool parseVersion( T& data, TDBVersion_t realVersion , uint32 curIndex, uint32 totalIndex, const char* str )
		{
			return false;
		}
	};

#pragma pack(pop)
}

#endif