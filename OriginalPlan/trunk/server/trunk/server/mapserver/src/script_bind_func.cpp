#include "core/debug.h"

#include "script_engine.h"
#include "role.h"
#include "mod_bag.h"
#include "role_manager.h"
#include "announcement_tbl.h"
#include "announcement.h"
#include "map_server.h"
#include "map_server_instance.h"
#include "map_server_data.h"
#include "script_bind_func.h"

// 得到所有玩家
typedef std::vector<CRole*> TRoleList;
static void GetRoleCallFunc(CRoleBase*& role, void* arg)
{
	TRoleList* roles = (TRoleList*)arg;
	roles->push_back((CRole*)role);
}
std::vector<CRole*> CMServerHelper::LuaGetAllRole()
{
	TRoleList roles;
	DRoleManager.traverseReady(GetRoleCallFunc, &roles);
	DRoleManager.traverseEnter(GetRoleCallFunc, &roles);
	DRoleManager.traverseLogout(GetRoleCallFunc, &roles);
	return roles;
}
// 得到玩家
CRole* CMServerHelper::LuaGetRole(TRoleUID_t roleUID)
{
	return DRoleManager.findByRoleUID(roleUID);
}

lua_tinker::s_object CMServerHelper::LuaGetSpRole(TRoleUID_t roleUID)
{
	CRole* pRole = DRoleManager.findByRoleUID(roleUID);
	if(NULL == pRole)
	{
		return lua_tinker::s_object();
	}

	return pRole->getScriptObject();
}

// 向玩家发送消息
void CMServerHelper::LuaChat(CRole* pRole, std::string msg)
{
	pRole->sendChat(msg);	
}

// 世界消息广播
void CMServerHelper::LuaWorldChatBroad(std::string name, std::string title, uint8 vipLv, std::string msg)
{
	MCWorldChatMsg msgRet;
	msgRet.setRetCode(EGameRetCode::RC_SUCCESS);
	msgRet.fromPlayer = name;
	msgRet.fromPlayerTitle = title;
	msgRet.fromPlayerVipLv = vipLv;
	msgRet.msg = msg;
	DRoleManager.broadcastToAllEnterQue(msgRet);
}

// 系统走马灯
void CMServerHelper::LuaSystemChatBroad(std::string name, uint8 type, sint32 count)
{
	MCScreenAnnounce msgRet;
	msgRet.setRetCode(EGameRetCode::RC_SUCCESS);
	msgRet.name = name;
	msgRet.type = type;
	msgRet.count = count;
	DRoleManager.broadcastToAllEnterQue(msgRet);
}

// 得到玩家管理器
CRoleManager* CMServerHelper::LuaGetRoleMgr()
{
	return CRoleManager::GetPtrInstance();
}
// 得到服务器数据
CMapServerData* CMServerHelper::LuaGetServerData()
{
	return CMapServerData::GetPtrInstance();
}
// 得到地图主服务
CMapServer* CMServerHelper::LuaGetMapServer()
{
	return DMapServer;
}

// 通过玩家名字得到玩家
CRole* CMServerHelper::LuaGetRoleByName(const std::string roleName)
{
	std::vector<CRole*> roles = LuaGetAllRole();
	for(sint32 i = 0; i < (sint32)roles.size(); ++i)
	{
		if(NULL != roles[i]){
			if(roles[i]->getRoleNameStr() == roleName){
				return roles[i];
			}
		}
	}

	return NULL;
}
// 踢掉玩家
void CMServerHelper::LuaKickRole(const std::string roleName)
{
	CRole* pRole = LuaGetRoleByName(roleName);
	if(NULL != pRole)
	{
		pRole->kick(true, 1, "GM kick role!");
	}
}
// 得到公告事件类型
sint32 CMServerHelper::LuaGetAnnouncementEventType(TAnnouncementID_t id)
{
	CAnnouncementTbl* pRow = DAnnouncementTblMgr.find(id);
	if(NULL != pRow)
	{
		return pRow->eventType;
	}

	return 0;
}
sint8 CMServerHelper::LuaGetAnnouncementSysType(TAnnouncementID_t id)
{
	CAnnouncementTbl* pRow = DAnnouncementTblMgr.find(id);
	if(NULL != pRow)
	{
		return pRow->systemType;
	}

	return 0;
}

// 发送公告
void CMServerHelper::LuaAllAnnouncement(std::string msg, sint32 lastTime, sint32 interval)
{
	MWAnnoucement announcement;
	announcement.msg = msg;
	announcement.lastTime = lastTime;
	announcement.interval = interval;
	BroadCastToWorld(announcement, SYSTEM_ROLE_UID, true);
}

uint64 CMServerHelper::LuaToNum64(std::string str)
{
	uint64 num = 0;
	GXMISC::gxFromString(str, num);
	return num;
}

uint32 CMServerHelper::LuaCrc32(std::string value)
{
	return GXMISC::StrCRC32(value.c_str());
}
string CMServerHelper::Md5String(std::string value)
{
	return ToMD5String(value);
}

bool BindFunc(CScriptEngineCommon::TScriptState* pState)
{
	return true;
}