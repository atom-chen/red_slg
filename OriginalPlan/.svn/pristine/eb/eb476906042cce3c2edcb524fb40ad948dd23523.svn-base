#ifndef _MAP_DB_PLAYER_HANDLER_H_
#define _MAP_DB_PLAYER_HANDLER_H_

#include "map_db_player_handler_base.h"
#include "map_db_role_process.h"

class CMapDbPlayerHandler : public CMapDbPlayerHandlerBase
{
public:
	typedef CMapDbPlayerHandlerBase TBaseType;

public:
	CMapDbPlayerHandler(GXMISC::CDatabaseConnWrap* dbWrap = NULL, GXMISC::TDbIndex_t index = GXMISC::INVALID_UNIQUE_INDEX);
	~CMapDbPlayerHandler(){}

public:
	// 加载角色数据
	bool sendLoadDataTask(TLoadRoleData* loadData, TChangeLineTempData* changeLineTempData, GXMISC::TSocketIndex_t worldPlayerSockIndex, GXMISC::TSocketIndex_t requestSocketIndex, bool isLocalServerLogin);
	// 保存角色数据
	bool sendSaveRoleData(CHumanDB* data, GXMISC::TSocketIndex_t worldPlayerSockIndex, bool needRet, ESaveRoleType saveType);
	// 更新角色数据
	void sendUpdateRoleData(CHumanDB* data, ESaveRoleType saveType);
};

#endif	// _MAP_DB_PLAYER_HANDLER_H_