#ifndef _MAP_PLAYER_HANDLER_BASE_H_
#define _MAP_PLAYER_HANDLER_BASE_H_

#include "game_extend_socket_handler.h"
#include "game_player_mgr.h"
#include "packet_cm_login.h"

class CRoleBase;
// 客户端与服务器的连接处理句柄
class CMapPlayerHandlerBase : public CGameExtendSocketHandler<CMapPlayerHandlerBase>
{
	friend class CMapWorldServerHandlerBase;

public:
	typedef CGameExtendSocketHandler<CMapPlayerHandlerBase> TBaseType;

public:
	CMapPlayerHandlerBase();
	virtual ~CMapPlayerHandlerBase(){}

public:
	virtual bool start();
	virtual void close();
	virtual void breath(GXMISC::TDiffTime_t diff);

public:
	void quit(sint32 sockWaitTime);
	void clean();
	void initData();

public:
	virtual bool onBeforeHandlePacket(CBasePacket* packet);

public:
	GXMISC::EHandleRet handlePlayerHeart(MCPlayerHeart* packet);

public:
	CRoleBase* getRole(EManagerQueType type = MGR_QUE_TYPE_ENTER);

public:
	TRoleUID_t      getRoleUID(){ return _roleUID; }
	TAccountID_t    getAccountID(){ return _accountID; }
	TObjUID_t       getObjUID(){return _objUID; }
	GXMISC::TSocketIndex_t getWorldPlayerSockIndex();

public:
	void	setRoleInfo(TAccountID_t accountID, TRoleUID_t roleUID, TObjUID_t objUID);
	void	setWorldPlayerSockIndex(GXMISC::TSocketIndex_t index);
	void    setRoleUID(TRoleUID_t roleUID){ _roleUID = roleUID; genStrName(); }
	void    setAccountID(TAccountID_t accountID){ _accountID = accountID; genStrName(); }
	void    setObjUID(TObjUID_t objUID){ _objUID = objUID; genStrName(); }
	bool    isNeedFreeWorldRole();
	GXMISC::TGameTime_t getLastHeartTime() const { return _lastHeartTime; }
	void setLastHeartTime(GXMISC::TGameTime_t val) { _lastHeartTime = val; }
	GXMISC::TGameTime_t getLastSendHeartTime() const { return _lastSendHeartTime; }
	void setLastSendHeartTime(GXMISC::TGameTime_t val) { _lastSendHeartTime = val; }
	GXMISC::TDiffTime_t getHeartDiffTime() const { return _heartDiffTime; }
	void setHeartDiffTime(GXMISC::TDiffTime_t val) { _heartDiffTime = val; }
	GXMISC::TDiffTime_t getHeartOutDiffTime() const { return _heartOutDiffTime; }
	void setHeartOutDiffTime(GXMISC::TDiffTime_t val) { _heartOutDiffTime = val; }

public:
	void doCloseWaitReconnect();
	bool isHeartOutTime();
	bool isNeedSendHeart();
	void doPlayerHeart();
	void checkPlayerHeart();

protected:
	TRoleUID_t		_roleUID;							///< 玩家UID
	TAccountID_t	_accountID;							///< 账号
	TObjUID_t		_objUID;							///< 对象UID
	GXMISC::TSocketIndex_t _worldPlayerSockIndex;       ///< 世界服务器Player对象的唯一标识
	GXMISC::TGameTime_t	_lastHeartTime;					///< 上次心跳时间
	GXMISC::TGameTime_t	_lastSendHeartTime;				///< 上次发送心跳的时间
	GXMISC::TDiffTime_t _heartDiffTime;					///< 心跳发送间隔时间
	GXMISC::TDiffTime_t _heartOutDiffTime;				///< 心跳超时时间
	

	DFastObjToString3Alias(CMapPlayerHandlerBase, TRoleUID_t, RoleUID, _roleUID, TAccountID_t, AccountID, _accountID, TObjUID_t, ObjUID, _objUID);

private:
	static std::set<TPacketID_t> FilterPackets;

protected:
	bool isFilterPacket(TPacketID_t id);
	static void insertFilterPacket(TPacketID_t id );
private:
	// !!!内部禁止使用此函数, 只允许CMapWorldServerHandler使用
	void send(const void* msg, uint32 len);
};

#endif	// _MAP_PLAYER_HANDLER_BASE_H_