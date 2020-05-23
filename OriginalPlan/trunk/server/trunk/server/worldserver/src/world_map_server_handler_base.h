#ifndef _WORLD_MAP_SERVER_HANDLER_BASE_H_
#define _WORLD_MAP_SERVER_HANDLER_BASE_H_

#include "game_socket_handler.h"
#include "base_packet_def.h"
#include "packet_mw_base.h"

typedef GXMISC::EHandleRet (GXMISC::CSocketHandler::*TTransPacketHandler)(CBasePacket* packet, TObjUID_t objUID);
typedef CHashMap<TPacketID_t, TTransPacketHandler> TTransPacketHandlerHash;

class CWorldMapPlayer;
class CWorldMapServerHandlerBase : public CGameSocketHandler<CWorldMapServerHandlerBase>
{
public:
	typedef CGameSocketHandler<CWorldMapServerHandlerBase> TBaseType;

public:
	friend class CWorldMapPlayer;

public:
	CWorldMapServerHandlerBase() : CGameSocketHandler<CWorldMapServerHandlerBase>() {
		_serverID = INVALID_SERVER_ID;
	}

	~CWorldMapServerHandlerBase() {}

protected:
	// 启动
	virtual bool start();
	// 关闭
	virtual void close();
	// 帧事件
	virtual void breath(GXMISC::TDiffTime_t diff);

public:
	// 退出
	void quit();

public:
	/// 设置世界服务器ID
	void setServerID(TServerID_t serverID);
	/// 获取世界服务器ID
	TServerID_t getServerID();
	/// 生成日志字符串
	void genStrName();
	/// 获取字符对象 
	const char* toString();
	/// 获取世界服务器地图处理对象
	CWorldMapPlayer* getWorldMapPlayer();

protected:
	// 地图服务器注册
	GXMISC::EHandleRet handleMapServreRegiste(MWRegiste* packet);
	// 加载角色数据
	GXMISC::EHandleRet handleLoadRoleData(MWLoadRoleDataRet* packet);
	// 释放MapServer服务器上角色数据(保存User和Player数据)
	GXMISC::EHandleRet handleUnloadRoleData(MWUnloadRoleDataRet* packet);
	// 角色请求退出
	GXMISC::EHandleRet handleRoleQuit(MWRoleQuit* packet);
	// 用户登陆
	GXMISC::EHandleRet handleUserLogin(MWUserLogin* packet);
	// 角色踢掉
	GXMISC::EHandleRet handleRoleKick(MWRoleKick* packet);
	// 角色心跳
	GXMISC::EHandleRet handleRoleHeart(MWRoleHeart* packet);
	// 处理广播
	GXMISC::EHandleRet handleBroadCast(MWBroadPacket* packet);
	// 转处理转发
	GXMISC::EHandleRet handleTrans(MWTransPacket* packet);
	// 转发到世界服务器
	GXMISC::EHandleRet handleTrans2World(MWTrans2WorldPacket* packet);
	// 随机角色名字
	GXMISC::EHandleRet handleRandRoleName(MWRandRoleName* packet);
	// 重命名角色名
	GXMISC::EHandleRet handleRenameRoleName(MWRenameRoleName* packet);
	// 获取随机名字列表
	GXMISC::EHandleRet handleGetRandNameList(MWGetRandNameList* packet);
	// 充值返回
	GXMISC::EHandleRet handleRechargeRet(MWRechargeRet* packet);

protected:
	// 地图服务器注册事件
	virtual void onMapServerRegiste(TServerID_t mapServer) {}

	// 注册转发事件
protected:
	static void RegisterTransHandler(TPacketID_t id, TTransPacketHandler handler);

	// 处理转发
private:
	GXMISC::EHandleRet doTransToWorld(char* msg, uint32 len, TObjUID_t objUID);

private:
	TServerID_t _serverID;			///< 服务器ID
	std::string _strName;			///< 日志字符串

private:
	static TTransPacketHandlerHash TransPacketHash;		///< 转发处理表
};

#endif	// _WORLD_MAP_SERVER_HANDLER_BASE_H_