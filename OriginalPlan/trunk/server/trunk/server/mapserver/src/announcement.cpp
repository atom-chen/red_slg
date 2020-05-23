#include "announcement.h"
#include "announcement_tbl.h"

#include "bagitem_tbl.h"
#include "game_define.h"

#include "packet_cm_base.h"
#include "map_world_handler_base.h"
#include "role.h"

void CAnnouncement::BroadSystem(TAnnouncementID_t id, const std::string msg)
{
	MCAnnouncement packet;
	packet.id = id;
	packet.key = "";
	packet.msg = msg;
	BroadCastToWorld(packet, INVALID_ROLE_UID, true);
}

void CAnnouncement::BroadToAll( TAnnouncementID_t id )
{
	CAnnouncementTbl* pRow = DAnnouncementTblMgr.find(id);
	if(NULL != pRow)
	{
		MCAnnouncement packet;
		packet.id = id;
		packet.key = pRow->keyStr;
		BroadCastToWorld(packet, INVALID_ROLE_UID, true);
	}
}

void CAnnouncement::BroadToAll( TAnnouncementID_t id, const std::string p1 )
{
	CAnnouncementTbl* pRow = DAnnouncementTblMgr.find(id);
	if(NULL != pRow)
	{
		MCAnnouncement packet;
		packet.id = id;
		packet.key = pRow->keyStr;
		packet.msg = p1;
		BroadCastToWorld(packet, INVALID_ROLE_UID, true);
	}
}

void CAnnouncement::BroadToAll( TAnnouncementID_t id, const std::string p1, const std::string p2 )
{
	CAnnouncementTbl* pRow = DAnnouncementTblMgr.find(id);
	if(NULL != pRow)
	{
		MCAnnouncement packet;
		packet.id = id;
		packet.key = pRow->keyStr;
		packet.msg = p1+","+p2;
		BroadCastToWorld(packet, INVALID_ROLE_UID, true);
	}
}

void CAnnouncement::BroadToAll( TAnnouncementID_t id, const std::string p1, const std::string p2, const std::string p3 )
{
	CAnnouncementTbl* pRow = DAnnouncementTblMgr.find(id);
	if(NULL != pRow)
	{
		MCAnnouncement packet;
		packet.id = id;
		packet.key = pRow->keyStr;
		packet.msg = p1+","+p2+","+p3;
		BroadCastToWorld(packet, INVALID_ROLE_UID, true);
	}
}

void CAnnouncement::BroadToAll( TAnnouncementID_t id, const std::string p1, const std::string p2, const std::string p3, const std::string p4 )
{
	CAnnouncementTbl* pRow = DAnnouncementTblMgr.find(id);
	if(NULL != pRow)
	{
		MCAnnouncement packet;
		packet.id = id;
		packet.key = pRow->keyStr;
		packet.msg = p1+","+p2+","+p3+","+p4;
		BroadCastToWorld(packet, INVALID_ROLE_UID, true);
	}
}

void CAnnouncement::BroadToAll( TAnnouncementID_t id, const std::string p1, const std::string p2, const std::string p3, const std::string p4, const std::string p5 )
{
	CAnnouncementTbl* pRow = DAnnouncementTblMgr.find(id);
	if(NULL != pRow)
	{
		MCAnnouncement packet;
		packet.id = id;
		packet.key = pRow->keyStr;
		packet.msg = p1+","+p2+","+p3+","+p4+","+p5;
		BroadCastToWorld(packet, INVALID_ROLE_UID, true);
	}
}

void CAnnouncement::BroadToAll( sint32 type, sint32 cond, sint8 sysType, const std::string p1 )
{
	TAnnouncementID_t id = DAnnouncementTblMgr.getPassCondID(type, cond, sysType);
	BroadToAll(id, p1);
}

void CAnnouncement::BroadToAll( sint32 type, sint32 cond, sint8 sysType, const std::string p1, const std::string p2 )
{
	TAnnouncementID_t id = DAnnouncementTblMgr.getPassCondID(type, cond, sysType);
	BroadToAll(id, p1, p2);
}

void CAnnouncement::BroadToAll( sint32 type, sint32 cond, sint8 sysType, const std::string p1, const std::string p2, const std::string p3 )
{
	TAnnouncementID_t id = DAnnouncementTblMgr.getPassCondID(type, cond, sysType);
	BroadToAll(id, p1, p2, p3);
}

void CAnnouncement::BroadToAll( sint32 type, sint32 cond, sint8 sysType, const std::string p1, const std::string p2, const std::string p3, const std::string p4 )
{
	TAnnouncementID_t id = DAnnouncementTblMgr.getPassCondID(type, cond, sysType);
	BroadToAll(id, p1, p2, p3, p4);
}

void CAnnouncement::BroadToAll( sint32 type, sint32 cond, sint8 sysType, const std::string p1, const std::string p2, const std::string p3, const std::string p4, const std::string p5 )
{
	TAnnouncementID_t id = DAnnouncementTblMgr.getPassCondID(type, cond, sysType);
	BroadToAll(id, p1, p2, p3, p4, p5);
}

std::string CAnnouncement::GetRoleName( CRole* pRole )
{
	return GXMISC::gxToString("%d|%s", ANNOUNCEMENT_ROLE, pRole->getRoleNameStr().c_str());
}

std::string CAnnouncement::GetItemName( TItemTypeID_t itemID )
{
	CItemConfigTbl* pRow = DItemTblMgr.find(itemID);
	if(NULL != pRow)
	{
		return GXMISC::gxToString("%d|%d|%s", ANNOUNCEMENT_ITEM, itemID, pRow->itemName.c_str());
	}

	return "";
}

std::string CAnnouncement::GetNumber( sint32 val )
{
	return GXMISC::gxToString("%d|%d", ANNOUNCEMENT_NUMBER, val);
}

