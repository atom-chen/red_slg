#ifndef _LIB_CONFIG_H_
#define _LIB_CONFIG_H_

#include "types_def.h"
#include "fix_array.h"

namespace GXMISC
{
	// @TODO 需要重新设计
	enum ELibConfig
	{
		// 统计
		LIB_CONFIG_STAT_DB_FLAG,
		LIB_CONFIG_STAT_INTERVAL,

		// 调试开关
		LIB_CONFIG_DBG_SOCK_ERR,

		LIB_CONFIG_MAX,
	};

	enum ELibConfigFlag
	{
		LIB_CONFIG_FLAG_SOCK_ERR = 1,
	};
	
	class CLibConfig
	{
	public:
		uint32 getStatDb();
		uint32 getStatInterval();

	public:
		void setConfig(ELibConfig config, uint32 flag);
		uint32 getConfig(ELibConfig config);
		bool isConfig(ELibConfig config);

	public:
		void init();

	public:
		CFixArray<uint32, LIB_CONFIG_MAX> configs;
	};

	extern CLibConfig _g_LibConfig;
}

#endif // _LIB_CONFIG_H_