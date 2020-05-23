#ifndef LIMIT_HANDLE_H
#define LIMIT_HANDLE_H

#include "game_util.h"
#include "game_struct.h"

class CLimitHandle : public GXMISC::CSingleton<CLimitHandle>
{
public:
	CLimitHandle();
	virtual ~CLimitHandle();

	//同步处理(目前地图服不做封号同步)
public:
	// 初始化禁言列表
	void intitLimitChatList(const TLimitChatDBAry * dataary);

	// 添加禁言信息(同步Login)
	EGameRetCode addLimitChat(const TLimitChat * datainfo);

	// 删除禁言信息(同步Login)
	EGameRetCode deleteLimitChat(TAccountID_t accountid, TRoleUID_t roleid);

	// 更新禁言信息(同步Login)
	EGameRetCode updateLimitChat(const TLimitChat * datainfo);
};

#define DCMLimitHandle CLimitHandle::GetInstance();

#endif //LIMIT_HANDLE_H