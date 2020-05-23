#ifndef _WORLD_PLAYER_H_
#define _WORLD_PLAYER_H_

#include "packet_struct.h"
#include "game_util.h"
#include "base_util.h"
#include "socket_handler.h"
#include "world_server_util.h"
#include "string_common.h"
#include "server_define.h"
#include "game_player_mgr.h"
#include "world_player_handler.h"
#include "world_map_player_mgr.h"
#include "world_login_role_list.h"
#include "user_struct.h"
#include "login_status.h"

#include "core/multi_index.h"

class CWorldPlayerHandler;
class CWorldDbHandler;
class CWorldUser;

/**
* 1. 如果角色正处于请求状态, 则不能退出登陆, 必须等待请求完成才能退出登陆, 否则状态会被覆盖
* 2. 不能发送重复的请求, 否则会导致请求和退出处理不一致
* 3. 处于请求状态, 任何请求都会等待或者返回错误
* 4. 玩家已经无效则请求失败
*/

// 角色账号在世界服务器的类
class CWorldPlayer
{
public:
    CWorldPlayer();
    ~CWorldPlayer();

public:
    void update(GXMISC::TDiffTime_t diff);

    // 内部成员管理
public:
    CWorldPlayerHandler* getSocketHandler(bool logFlag = true);
    CWorldDbHandler* getDbHandler(bool logFlag = true);
	CWorldUser* getCurrentUser();
    TAccountID_t getAccountID();
    void setAccountID(TAccountID_t accountID);
    void setSocketIndex(GXMISC::TSocketIndex_t socketIndex);
    GXMISC::TSocketIndex_t getSocketIndex();
    void setDbIndex(GXMISC::TUniqueIndex_t index);
    GXMISC::TDbIndex_t getDbIndex();
    TServerID_t getMapServerID();
    void setMapServerID(TServerID_t mapServerID);
    TChangeLineWait* getChangeLineWait();
	void setLoginKey(TLoginKey_t loginKey);
	TLoginKey_t getLoginKey();
	void setSourceWay(TSourceWayID_t sourceWay, TSourceWayID_t chisourceWay);
	TSourceWayID_t getSourceWay() const { return _sourceWay; }
	void setSourceWay(TSourceWayID_t val) { _sourceWay = val; }
	TSourceWayID_t getChisourceWay() const { return _chisourceWay; }
	void setChisourceWay(TSourceWayID_t val) { _chisourceWay = val; }
	GXMISC::CGameTime getLoginTime() const { return _logintime; }
	void setLoginTime(GXMISC::CGameTime val) {_logintime = val; }
	CLoginWaiterManager* getLoginManager() { return &_loginManager; }
	void setLoginManager(CLoginWaiterManager* val) { _loginManager = *val; }
	TGmPower_t getGmPower() const { return _gmPower; }
	void setGmPower(TGmPower_t val) { _gmPower = val; }

    // 角色管理
public:
    void addRole(TLoginRole* role);		// 添加角色
    bool hasRole(TRoleUID_t roleUID);	// 当前账号是否含有此角色
    bool isMaxRoleNum();				// 是否已经达到角色数上限
    void cleanRole();					// 清除角色
    TRoleUID_t getCurrentRoleUID();		// 当前RoleUID
    TObjUID_t getCurrentObjUID();		// 当前ObjUID
	sint32 getRoleNum();				// 获取到角色数目
	TRoleUID_t getFirstRoleUID();		// 得到第一个角色的UID

private:
    void getRoleList(TPackLoginRoleArray& roleList);
    bool selectRole(TRoleUID_t roleUID);

    // 队列管理
public:
	bool onAddToEnter();
	bool onAddToReady();
	bool onAddToLogout();
	void onRemoveFromEnter();
	void onRemoveFromReady();
	void onRemoveFromLogout();
	EManagerQueType getQueType();
	void onUpdateEnterQue(GXMISC::TDiffTime_t diff)     {}
	void onUpdateReadyQue(GXMISC::TDiffTime_t diff)     {}
	void onUpdateLogoutQue(GXMISC::TDiffTime_t diff)    {}

    // 事件处理
public:
    // 进入游戏前处理
    void onBeforeLogin(TServerID_t mapID);
    void onAfterLogin(TServerID_t mapServerID);
    /// 处理请求前事件(如果当前玩家已经失效则返回失败)
    EGameRetCode onBeforeRequst(EWPlayerActionType requstType);
    // 处理响应前事件
    EGameRetCode onBeforeResponse(EWPlayerActionType requstType);
	void onBerforeLoadRoleData( TObjUID_t objUID, TSceneID_t sceneID, TMapID_t mapID );

    // 退出管理
public:
    // 退出游戏的唯一接口
    // @notice 调用此方法之后再也不用使用此player对象
    void quit(bool isForce, const char* quitReason = "");
    // 通知MapServer当前对象需要下线, 返回true表示需要等待, 否则直接清除数据
    bool kickByOtherPlayer();
    // Socket断开连接
    void quitBySocketClose();
    // 数据库断开连接, 清除其他服务器上的玩家数据, 退出游戏
    void quitByDbClose();
    // MapServer断开连接
    void quitByMapServerClose();
private:
    // 除此对象的内部数据, 调用此方法之后再也不能使用此player对象
    void clean();
    void cleanSocketHandler();
    void cleanDbHandler();
    // !!! 当前对象已经被删除, 不能使用当前对象中的任何成员变量
    void onQuit(TAccountID_t accountID);
    // !!! 清除所有数据, 包括User
    void cleanAll();
    // 将当前对象设置成无效
    void setInvalid(EUnloadRoleType unloadType);			// @TODO 将设置无效的函数改掉，有逻辑错误, 释放数据返回需要判断对象是否有效
    bool isValid();

    // 数据检查及排错 @todo
public:
    // 玩家数据加载后, 通知其他服务器将数据释放
    // 同步玩家信息
    // 定时检测

    // 玩家操作
public:
    // 账号验证成功, 角色列表已经加载
    void loginSuccess();
    // 创建角色
    void createRoleReq(TRoleName_t& name, TRoleProtypeID_t typeID);
    EGameRetCode createRoleSuccess(TRetCode_t retCode, TLoginRole* role);
    void createRoleFailed(TLoginRole* role);
    // 删除角色
    //void deleteRoleReq(TRoleUID_t roleUID);
    // C->W登陆游戏
    void loginGameReq(TRoleUID_t roleUID, bool enterDynamicMapFlag);
    // M->W登陆游戏响应
    EGameRetCode loginGameRes(CWorldUserData* data, TServerID_t mapServerID);
    // M->W加载角色数据
    EGameRetCode loadRoleDataSuccess(CWorldUserData* data, TServerID_t mapServerID, TMapID_t mapID);
    bool loadRoleDataFailed(const TLoadRoleData* loadData, EGameRetCode retCode);
    // 客户端通知退出登陆, 此时表示已经连接到MapServer, WorldServer改变玩家状态
    void loginQuitReq();
    // M->W退出游戏请求
    void quitGameReq(TRoleUID_t roleUID);
    // W->M退出游戏响应
    void quitGameRes();
    // W->M释放角色数据请求
    bool unloadRoleDataReq(EUnloadRoleType unloadType, bool flag = true);
    // W->M 通知所有服务器释放角色数据,不需要返回
    bool unloadRoleDataAll();
    // 释放角色数据
    EGameRetCode unloadRoleDataSuccess(TRoleUID_t roleUID);
    void unloadRoleDataFailed(TRoleUID_t roleUID);
    // 切线请求(M->W)
    EGameRetCode changeLineReq(TSceneID_t sceneID, TAxisPos& pos, TServerID_t mapServerID, 
        TSceneID_t lastSceneID, TAxisPos& lastPos, TServerID_t lastMapServerID, TChangeLineTempData* tempData);		// 切线请求
    EGameRetCode changeLineUnloadRes();													                                // 释放源服务器角色数据响应
    EGameRetCode changeLineLoadRes(CWorldUserData* data, TServerID_t mapServerID, TMapID_t mapID);	                // 加载目标服务器角色数据响应
    // 切线返回(W->M)
    EGameRetCode changeLineUnloadReq();													                                // 释放源服务器角色数据请求
    EGameRetCode changeLineLoadReq();													                                // 加载目标服务器角色数据请求
    EGameRetCode changeLineRes(TServerID_t mapServerID, TMapID_t mapID);                                             // 切线响应

    // 进入副本请求
    //EGameRetCode openDynamicMapReq(TMapID_t mapID, ESceneType sceneType);                                             // 打开新副本请求
    void setChangeLine(TServerID_t mapServerID, TSceneID_t sceneID, const TAxisPos& pos);                            // 设置切线信息

    // 角色登陆
    void onUserLogin();
    void onRoleHeart();
    bool heartOutTime();

private:
    // 加载角色数据请求
    void loadRoleDataReq(CWorldMapPlayer* mapPlayer, ELoadRoleType loadType, TSceneID_t sceneID, TAxisPos& pos, bool needOpenMap, TMapID_t mapID);

    // 状态判断
public:
    // 是否通过账号验证
    bool isVerifyPass();
    // 是否为游戏状态
    bool isPlaying();
    // 是否为登陆游戏服务器成功状态
    bool isLoginGame();
    // 是否为空闲
    bool isIdle();
    // 是否正在加载数据
    bool isLoadRoleDataReq();

    // 是否为请求状态
    bool isRequstStatus();
    // 是否处于登陆状态, 如果处于这种状态下, Scoket断开连接会清除数据
    bool isAccountVerifyStatus();
    // 数据是否需要释放状态(需要通知Map服务器释放数据)
    bool isDataNeedFreeStatus();
    // 数据是否已经释放
    bool isDataHasFreedStatus();
    // 是否为加载角色数据状态
    bool isLoadRoleDataStatus();
    // 切线状态
    bool isChangeLineStatus();
	// 是否为进入游戏状态
	bool isEnterGame();

    // 状态检测
public:
    bool checkRequest();

public:
    // 账号验证成功需要处理的事情
    void doLoginVerify();

	// 转发限制信息
public:
	void transLimitInfo(void);

public:
	bool isRechargeStatus();
	void startRecharge();
	void closeRecharge();

public:
	void setPlayerStatus(EPlayerStatus status);
	EPlayerStatus getPlayerStatus();

public:
    const char* toString() const;

public:
	CWorldLoginRoleList* getCWorldLoginRoleList() {return &_roleList;}
private:
    void genStrName();
    std::string changeLineString();

private:
    TAccountID_t _accountID;				    // 账号ID
    CWorldLoginRoleList _roleList;			    // 角色列表
    GXMISC::TSocketIndex_t _socketIndex;	    // Socket索引
    GXMISC::TDbIndex_t _dbIndex;				// 数据库索引
    EPlayerStatus _playerStatus;			    // 玩家状态
    TServerID_t _mapServerID;					// 服务器ID
    GXMISC::TGameTime_t _lastHeartTime;         // 上一次心跳时间
	TLoginKey_t _loginKey;						// 登陆Key
	TSourceWayID_t _sourceWay;					// 渠道
	TSourceWayID_t _chisourceWay;				// 子渠道
	TGmPower_t _gmPower;						///< GM权限
	bool _valid;							    // 是否有效
    EManagerQueType _queType;				    // 队列类型
    EUnloadRoleType _unloadType;			    // 退出通知Map服务器释放数据原因

    // 换线数据
    TChangeLineTempData _changeLineTempData;	// 切线的临时数据
    TChangeLineWait _changeLineWait;            // 切线等待信息
	// 登录时间
	GXMISC::CGameTime	_logintime;				// 登录时间
	CLoginWaiterManager	_loginManager;			///< 登陆管理器(包括登入及登出) @TODO 实现此功能

private:
    std::string _strName;

private:
	bool _rechargeFlag;							// 充值标记

public:
    DMultiIndexImpl1(TAccountID_t, _accountID, INVALID_ACCOUNT_ID);
    DMultiIndexImpl2(GXMISC::TSocketIndex_t, _socketIndex, GXMISC::INVALID_SOCKET_INDEX);

public:
    template<typename T>
	void sendPacket(T& packet) {
		CWorldPlayerHandler* socketHandler = getSocketHandler();
		if (NULL != socketHandler) {
			socketHandler->sendPacket(packet);
		} else {
			gxWarning("Can't find socket handler! SocketIndex = {0}, PacketID = {1}", _socketIndex, packet.getPacketID());
		}
	}

    template<typename T>
    void sendToMapServer(T& packet)
    {
        CWorldMapPlayer* player = DWorldMapPlayerMgr.findMapPlayer(getMapServerID());
        if(NULL != player)
        {
            player->sendPacket(packet);
        }
    }
};

#endif
