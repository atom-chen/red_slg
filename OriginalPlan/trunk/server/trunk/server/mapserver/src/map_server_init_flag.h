#ifndef _MAP_SERVER_INIT_FLAG_H_
#define _MAP_SERVER_INIT_FLAG_H_

#include "core/bit_set.h"

// 服务器初始化标记
enum EMapServerInitFlag
{
	MAP_SVR_INIT_FLAG_DB_INIT,					// 数据库初始化成功
	MAP_SVR_INIT_FLAG_WORLD_REGISTE,			// 世界服务器初始化成功
	MAP_SVR_INIT_FLAG_SERVICE_START,			// 服务器开启成功
};

class CMapServerInitFlag
{
public:
	CMapServerInitFlag()
	{
		_successFlags.clearAll();
		_faildFlag.clearAll();
	}

public:
	void setDbInit(bool flag)
	{
		if(flag)
		{
			_successFlags.set(MAP_SVR_INIT_FLAG_DB_INIT);
		}
		else
		{
			_faildFlag.set(MAP_SVR_INIT_FLAG_DB_INIT);
		}
	}

	void setWorldRegiste(bool flag)
	{
		if(flag)
		{
			_successFlags.set(MAP_SVR_INIT_FLAG_WORLD_REGISTE);
		}
		else
		{
			_faildFlag.set(MAP_SVR_INIT_FLAG_WORLD_REGISTE);
		}
	}

	void setServiceStart(bool flag)
	{
		if(flag)
		{
			_successFlags.set(MAP_SVR_INIT_FLAG_SERVICE_START);
		}
		else
		{
			_faildFlag.set(MAP_SVR_INIT_FLAG_SERVICE_START);
		}
	}

	bool isInitSuccess()
	{
		return _successFlags.get(MAP_SVR_INIT_FLAG_DB_INIT)
			&& _successFlags.get(MAP_SVR_INIT_FLAG_WORLD_REGISTE);
	}

	void clearInitSuccess()
	{
		_successFlags.clear(MAP_SVR_INIT_FLAG_DB_INIT);
		_successFlags.clear(MAP_SVR_INIT_FLAG_WORLD_REGISTE);
	}

	bool isServiceStart()
	{
		return _successFlags.get(MAP_SVR_INIT_FLAG_SERVICE_START);
	}

	bool isInitFaild()
	{
		return _faildFlag.get(MAP_SVR_INIT_FLAG_DB_INIT)
			|| _faildFlag.get(MAP_SVR_INIT_FLAG_WORLD_REGISTE);
	}

	void clean()
	{
		_successFlags.clearAll();
		_faildFlag.clearAll();
	}

private:
	GXMISC::TBit16_t _successFlags;
	GXMISC::TBit16_t _faildFlag;
};

#endif	// _MAP_SERVER_INIT_FLAG_H_