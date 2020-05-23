#ifndef _MAP_DB_COMMON_H_
#define _MAP_DB_COMMON_H_

#include "mysqlpp/mysql++.h"
#include "core/mutex.h"
#include "game_util.h"

class CHumanDB;
class CDBLoadBase
{
protected:
	CDBLoadBase()  { GXMISC::CFastLock::unlock(_isLock); }
public:
	virtual ~CDBLoadBase() {}

public:
	void cleanUp();
	bool init(TRoleUID_t roleUID, CHumanDB* human){ _roleUID = roleUID; _humanDB = human; return true; } 

public:
	inline bool setLock( bool isLock );
	inline bool getLock();
	TRoleUID_t getRoleUID(){ return _roleUID; }

public:
	bool loadFromDb(mysqlpp::Connection * conn);
	bool saveToDb(mysqlpp::Connection * conn, bool offlineFlag);

protected:
	virtual bool load(mysqlpp::Connection * conn) = 0;  // 加载数据
	virtual bool save(mysqlpp::Connection * conn, bool offlineFlag) = 0;  // 保存数据

protected:
	GXMISC::CFastLock::Lock_t	_isLock;			    // 加锁模块
	TRoleUID_t _roleUID;					            // 对象UID
	CHumanDB* _humanDB;                                 // 玩家对象
};

bool CDBLoadBase::setLock( bool isLock )
{
	if ( isLock )
	{
		return GXMISC::CFastLock::tryLock(_isLock);
	}

	GXMISC::CFastLock::unlock(_isLock);
	return true;
}

bool CDBLoadBase::getLock()
{
	return GXMISC::CFastLock::isLocked(_isLock);
}


#endif //_MAP_DB_COMMON_H_