#ifndef _ANNOUNCEMENT_H_
#define _ANNOUNCEMENT_H_

#include <string>

#include "game_util.h"

class CRole;
/**
 * 公告类
 */
class CAnnouncement 
{
public:
	// 广播给所有玩家
	static void BroadToAll(TAnnouncementID_t id);
	static void BroadToAll(TAnnouncementID_t id, const std::string p1);
	static void BroadToAll(TAnnouncementID_t id, const std::string p1, const std::string p2);
	static void BroadToAll(TAnnouncementID_t id, const std::string p1, const std::string p2, const std::string p3);
	static void BroadToAll(TAnnouncementID_t id, const std::string p1, const std::string p2, const std::string p3, const std::string p4);
	static void BroadToAll(TAnnouncementID_t id, const std::string p1, const std::string p2, const std::string p3, const std::string p4, const std::string p5);

public:
	static void BroadToAll(sint32 type, sint32 cond, sint8 sysType, const std::string p1);
	static void BroadToAll(sint32 type, sint32 cond, sint8 sysType, const std::string p1, const std::string p2);
	static void BroadToAll(sint32 type, sint32 cond, sint8 sysType, const std::string p1, const std::string p2, const std::string p3);
	static void BroadToAll(sint32 type, sint32 cond, sint8 sysType, const std::string p1, const std::string p2, const std::string p3, const std::string p4);
	static void BroadToAll(sint32 type, sint32 cond, sint8 sysType, const std::string p1, const std::string p2, const std::string p3, const std::string p4, const std::string p5);

public:
	static void BroadSystem(TAnnouncementID_t id, const std::string msg);

public:
	// 得到玩家名字
	static std::string GetRoleName(CRole* pRole);
	// 得到物品名字
	static std::string GetItemName(TItemTypeID_t itemID);
	// 得到数值
	static std::string GetNumber(sint32 val);
};

#endif	// _ANNOUNCEMENT_H_