#ifndef _DATABASE_UTIL_H_
#define _DATABASE_UTIL_H_

#include "stdcore.h"
#include "base_util.h"
#include "time_util.h"

namespace GXMISC
{
    class CDbTask;
    class CDbConnTask;
    class CDbWrapTask;
    class CDatabaseHandler;
    class CDatabaseConnWrap;
    class CDatabaseConnMgr;
    class CDatabaseConn;
	class CDbTaskActiveQueue;
	class CDbTaskQueueWrap;
	
	static const uint32 DB_DEL_USER_EXIST_TIME=600;
	typedef struct _DbDelUser
	{
		TUniqueIndex_t uid;
		TTime_t startTime;
	}TDbDelUser;
	typedef uint32 TDbErrorCode_t;
    typedef std::map<TUniqueIndex_t, CDatabaseHandler*> TDbConnUsers;
    typedef uint32 TDatabaseHostID_t;
    static const TDatabaseHostID_t INVALID_DATABASE_HOST_ID = std::numeric_limits<TDatabaseHostID_t>::max();
	typedef std::map<TUniqueIndex_t, TDbDelUser> TDbDelUserMap;
}

#endif