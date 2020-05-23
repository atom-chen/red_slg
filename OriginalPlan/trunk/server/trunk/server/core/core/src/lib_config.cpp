#include "lib_config.h"

namespace GXMISC
{
	CLibConfig _g_LibConfig;

	uint32 CLibConfig::getStatDb()
	{
		return configs[LIB_CONFIG_STAT_DB_FLAG];
	}

	void CLibConfig::init()
	{
		configs[LIB_CONFIG_STAT_INTERVAL] = 10;
		configs[LIB_CONFIG_DBG_SOCK_ERR] = 1;
	}

	void CLibConfig::setConfig( ELibConfig config, uint32 flag )
	{
		configs[config] = flag;
	}

	uint32 CLibConfig::getStatInterval()
	{
		return configs[LIB_CONFIG_STAT_INTERVAL];
	}

	uint32 CLibConfig::getConfig( ELibConfig config )
	{
		return configs[config];
	}

	bool CLibConfig::isConfig( ELibConfig config )
	{
		return configs[config] > 0;
	}
}