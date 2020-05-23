#ifndef _SCRIPT_BIND_FUNC_H_
#define _SCRIPT_BIND_FUNC_H_

class CMServerHelper
{
public:
	static std::vector<CRole*> LuaGetAllRole();
	static CRole* LuaGetRole(TRoleUID_t roleUID);
	static CRole* LuaGetRoleByName(const std::string roleName);
	static lua_tinker::s_object LuaGetSpRole(TRoleUID_t roleUID);
	static void LuaChat(CRole* pRole, std::string msg);
	static void LuaWorldChatBroad(std::string name, std::string title, uint8 vipLv, std::string msg);
	static void LuaSystemChatBroad(std::string name, uint8 type, sint32 count);
	static CRoleManager* LuaGetRoleMgr();
	static CMapServerData* LuaGetServerData();
	static CMapServer* LuaGetMapServer();
	static void LuaKickRole(const std::string roleName);
	static sint32 LuaGetAnnouncementEventType(TAnnouncementID_t id);
	static sint8 LuaGetAnnouncementSysType(TAnnouncementID_t id);
	static void LuaAllAnnouncement(std::string msg, sint32 lastTime, sint32 interval);
	static uint64 LuaToNum64(std::string str);
	static uint32 LuaCrc32(std::string value);
	static string Md5String(std::string value);
};

#endif // _SCRIPT_BIND_FUNC_H_