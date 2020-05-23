#ifndef _ROLE_BASE_H_
#define _ROLE_BASE_H_

#include "core/base_util.h"

#include "game_util.h"
#include "game_player_mgr.h"
#include "obj_character.h"
#include "game_define.h"
#include "map_player_handler_base.h"
#include "map_world_handler_base.h"
#include "server_struct.h"

class CMapDbPlayerHandlerBase;

class CRoleBase : public CCharacterObject	
{
public:
	typedef CCharacterObject TBaseType;

protected:
	CRoleBase();
public:
	virtual ~CRoleBase();

public:
	virtual void	cleanUp();
	virtual bool	init( const TCharacterInit* inits );
	virtual bool	update( GXMISC::TDiffTime_t diff );
	virtual bool	updateOutBlock( GXMISC::TDiffTime_t diff );

	// 定时器
public:
	virtual void on0Timer();					
	virtual void on12Timer();					
	virtual void onHourTimer(sint8 hour);		
	virtual void onIdle();

public:
	TRoleHeart getHeartInfo();
	// 场景
public:
	virtual bool isCanViewMe( const CGameObject *pObj );
	virtual void onEnterScene(CMapSceneBase* pScene);
	virtual void onLeaveScene(CMapSceneBase* pScene);

	// 虚函数
public:
	virtual void waitReconnect();															// 连接断开 
	virtual void quitGame(){}																// 退出游戏	
	virtual void directKick(bool needSave, bool delFromMgr, bool needRet, EKickType kickType = KICK_TYPE_ERR){}					// 直接踢掉	
	virtual void quit(bool forceQuit, const char* quitResult, sint32 sockWaitTime = 1){}	// 退出	

	/*****************************************************
					队列管理器事件处理
    *******************************************************/
public:
	// 登陆队列超时
	virtual void onLoginTimeout();			
	// 登出队列超时
	virtual void onLogoutTimeout();			
	// 添加到登出队列
	virtual bool onLogout();				
	// 添加到进入队列
	virtual bool onEnter();					
public:
	// 是否在登出队列超时
	bool isTimeOutForLogout();				
	// 是否在准备队列超时
	bool isTimeOutForReady();				
	// 是否在准备队列
	bool isReady();							
	// 是否在游戏队列
	bool isEnter();							
	// 是否在登出队列
	bool isLogout();						
public:
	virtual bool onAddToEnter();			
	virtual bool onAddToReady();			
	virtual bool onAddToLogout();			
	virtual void onRemoveFromEnter();		
	virtual void onRemoveFromReady();		
	virtual void onRemoveFromLogout();		
	virtual void onUpdateEnterQue(GXMISC::TDiffTime_t diff) {}	
	virtual void onUpdateReadyQue(GXMISC::TDiffTime_t diff) {}	
	virtual void onUpdateLogoutQue(GXMISC::TDiffTime_t diff) {}	

public:
	// 重置登出等待时间
    void resetLogoutTime(uint32 seconds);	
	// 添加到登出队列
	void addRoleToLogout(uint32 secs = 3);	
	// 添加到登陆队列
	void addRoleToReady();					
public:
	ERoleStatus getStatus() const { return _status; }	
	void setStatus(ERoleStatus val) { _status = val; }	
	TRoleUID_t getRoleUID() const { return _roleUID; }	
	void setRoleUID(TRoleUID_t val) { _roleUID = val; }	
	std::string getRoleUIDString() const { return GXMISC::gxToString(getRoleUID()); }	
	TAccountID_t getAccountID() const { return _accountID; }	
	void setAccountID(TAccountID_t val) { _accountID = val; }	
	bool getIsAdult() const { return _isAdult; }	
	void setIsAdult(bool val) { _isAdult = val; }	
	GXMISC::TGameTime_t getLastAgainstIndulgeNoticeTime() const { return _lastAgainstIndulgeNoticeTime; }	
	void setLastAgainstIndulgeNoticeTime(GXMISC::TGameTime_t val) { _lastAgainstIndulgeNoticeTime = val; }	
	GXMISC::TDiffTime_t getLastAgainstIndulgeTime() const { return _lastAgainstIndulgeTime; }	
	void setLastAgainstIndulgeTime(GXMISC::TDiffTime_t val) { _lastAgainstIndulgeTime = val; }	
	TGmPower_t getGmPower() const { return _gmPower; }	
	void setGmPower(TGmPower_t val) { _gmPower = val; }	
	bool getIsOffOverDay() const { return _isOffOverDay; }	
	void setIsOffOverDay(bool val) { _isOffOverDay = val; }	
	TObjListNode* getRoleNode(){ return &_roleNode; }	
	TSceneGroupID_t getGroupID() const; 

public:
	GXMISC::TGameTime_t getLoginTime() const { return _loginTime; }	
	void setLoginTime(GXMISC::TGameTime_t val) { _loginTime = val; }	
	GXMISC::TDiffTime_t getLoginLastTime() const { return _loginLastTime; }	
	void setLoginLastTime(GXMISC::TDiffTime_t val) { _loginLastTime = val; }	
	GXMISC::TGameTime_t getLogoutTime() const { return _logoutTime; }	
	void setLogoutTime(GXMISC::TGameTime_t val) { _logoutTime = val; }	
	GXMISC::TDiffTime_t getLogoutLastTime() const { return _logoutLastTime; }	
	void setLogoutLastTime(GXMISC::TDiffTime_t val) { _logoutLastTime = val; }	
	GXMISC::TGameTime_t getEnterGameTime() const { return _enterGameTime; }	
	void setEnterGameTime(GXMISC::TGameTime_t val) { _enterGameTime = val; }	
	TSceneGroupID_t getSceneGroupID() const { return _sceneGroupID; } 
	void setSceneGroupID(TSceneGroupID_t val) { _sceneGroupID = val; } 

	virtual void setRoleName(const std::string& roleName){}	
	virtual const TRoleName_t getRoleName() const { return ""; } 
	virtual const std::string getRoleNameStr() const { return ""; } 
	virtual void onRename(EGameRetCode retCode){} 

	void setSocketIndex(GXMISC::TSocketIndex_t sockIndex);	
	GXMISC::TSocketIndex_t getSocketIndex() const;	
	void setDbIndex(GXMISC::TDbIndex_t dbIndex);	
	GXMISC::TDbIndex_t getDbIndex() const;	
	void setManagerQueType(EManagerQueType type);	
	EManagerQueType getManagerQueType() const;	
	void setQuitRet(bool retFlag);	
	bool getQuitRet() const;	
	void setLoginPlayerSocketIndex(GXMISC::TSocketIndex_t index);
	GXMISC::TSocketIndex_t getLoginPlayerSocketIndex() const;
	void setDbSaveIndex(TSaveIndex_t index);	
	TSaveIndex_t getDbSaveIndex() const;	
	void setLastSaveTime(GXMISC::TGameTime_t times);	
	GXMISC::TGameTime_t getLastSaveTime() const;	
	void setUpdateSaveDirty(bool dirty);	
	bool getUpdateSaveDirty() const;	
	void setIPAddress(std::string straddress);
	std::string getIPAddress() const;

	// 数据库保存
public:
	GXMISC::TDbHandlerTag getDbHandlerTag();	

public:
	CMapPlayerHandlerBase* getPlayerHandlerBase(bool logFlag = true);	
	CMapDbPlayerHandlerBase* getDbHandlerBase(bool logFlag = true);	

public:
	template<typename T>
	void sendPacket(T& packet);

	template<typename T>
	void sendToWorld(T& packet, bool my = false);

public:
	DMultiIndexImpl1(TRoleUID_t, _roleUID, INVALID_ROLE_UID);
	DMultiIndexImpl2(TObjUID_t, _objUID, INVALID_OBJ_UID);
	DMultiIndexImpl3(TAccountID_t, _accountID, INVALID_ACCOUNT_ID);

	// 玩家队列管理及状态
private:
	ERoleStatus						_status;						// 角色状态
	TRoleUID_t						_roleUID;						// 角色UID	
	TAccountID_t					_accountID;						// 账号UID	
	bool							_isAdult;						// 是否成年人
	GXMISC::TGameTime_t				_lastAgainstIndulgeNoticeTime;	// 上次防沉迷提示时间
	GXMISC::TDiffTime_t				_lastAgainstIndulgeTime;		// 上次防沉迷时间
	bool							_isOffOverDay;					// 是否离线过天
	TGmPower_t						_gmPower;						// GM权限
	TObjListNode					_roleNode;						// 在Block中的结点
	TSceneGroupID_t					_sceneGroupID;					// 在场景里的ID

	// 通讯及数据库交互信息
private:
	GXMISC::TGameTime_t				_loginTime;						// 登陆时间
	GXMISC::TDiffTime_t				_loginLastTime;					// 登陆持续时间
	GXMISC::TGameTime_t				_logoutTime;					// 登出时间
	GXMISC::TGameTime_t             _readyTime;                     // 放入登陆队列的时间
	GXMISC::TDiffTime_t				_logoutLastTime;				// 登出持续时间
	GXMISC::TGameTime_t				_enterGameTime;					// 进入游戏的时间
	GXMISC::TSocketIndex_t			_socketIndex;					// Socket索引
	GXMISC::TDbIndex_t				_dbIndex;						// Db索引
	EManagerQueType					_queType;						// 队列类型
	bool							_needQuitRet;					// 退出是否需要返回
	GXMISC::TSocketIndex_t          _loginPlayerSockIndex;          // 世界服务器Player对象的唯一标识
	TSaveIndex_t                    _dbUpdateSaveIndex;             // 定时保存数据标识
	GXMISC::TGameTime_t             _lastSaveTime;					// 上一次更新时间
	bool							_updateSaveDirty;				// 更新脏标记
	std::string						_macAddress;					// mac地址
};

template<typename T>
void CRoleBase::sendToWorld( T& packet, bool my )
{
	if(my){
		packet.roleUID = getRoleUID();
	}

	CMapWorldServerHandlerBase::SendPacket(packet);
}

template<typename T>
void CRoleBase::sendPacket(T& packet)
{
	CMapPlayerHandlerBase* handler = getPlayerHandlerBase(false);
	if(NULL != handler)
	{
		handler->sendPacket(packet);
	}
}

#endif	// _ROLE_BASE_H_