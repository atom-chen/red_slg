#ifndef _ROLE_H_
#define _ROLE_H_

#include <map>

#include "core/game_exception.h"

#include "module_def.h"
#include "role_base.h"
#include "map_db_role_data.h"
#include "map_db_role_process.h"
#include "mod_bag.h"
#include "user_struct.h"
#include "mod_buffer.h"
#include "attr_backup_struct.h"
#include "object_struct.h"
#include "chat_pipe.h"
#include "mod_mission.h"
#include "script_engine.h"
#include "new_role_tbl.h"
#include "attributes.h"
#include "limit_manager.h"
#include "login_status.h"
#include "levelup_tbl.h"
#include "constant_tbl.h"
#include "record_define.h"
#include "mod_fight.h"
#include "transport_tbl.h"

class CMapScene;
class CMapPlayerHandler;
class CMapDbPlayerHandler;
struct _RoleFightData;
class CMapServerData;

class CRoleScriptObject : public GXMISC::IScriptObject
{
public:
};

class CRole : public CRoleBase	
{
	friend class COpenDynamicScene;

public:
	typedef CRoleBase TBaseType;
	typedef CRole TMyType;
	friend bool AutoBindClass(CScriptEngine::TScriptState* pState);

public:
	CRole();
	~CRole();

public:
	virtual bool update( GXMISC::TDiffTime_t diff );

public:
	// 得到外观属性
	virtual uint16 getShapeData(char* data, uint32 maxSize);
	TPackLen_t getShapeData(TPackRoleShape* shape);

	// 脚本模块
public:
	lua_tinker::s_object getScriptObject();
	lua_tinker::s_object getScriptObject1();

	// 背包模块
public:
	inline CModBag* getBagMod(){ return &_bagMod; }

	// Buffer模块
public:
	inline CModBuffer* getBufferMod() { return &_bufferMod; }

	// 聊天模块
public:
	inline CModChat* getChatMod(){ return &_chatMod; }

	// 任务模块
public:
	inline CModMission* getMissionMod() { return &_missionMod; }

	// 战斗模块
public:
//	inline CModFight* getFightMod(){ return &_fightMod; }

	// 模块数据
public:
	void sendAllData(); 
	void getRoleDetailData(TRoleDetail* detail);	
private:
	void _sendDetailData();
	void _sendBagItemList();
	void _sendMissionData();

public:
	CLevelUpTbl* getLevelRow() const; 
	CNewRoleTbl* getNewRoleRow() const; 
	CMapServerData* getMapServerData() const; 

	/*****************************************************
		角色属性
	*******************************************************/
public:
	// 性别
	TSex_t getSex() const { return _sex; }	
	void setSex(TSex_t val); 

	/// 角色名字
	virtual const TRoleName_t getRoleName() const { return getHumanBaseData()->roleName; } 
	virtual void setRoleName(const std::string& roleName) { TBaseType::setRoleName(roleName); getHumanBaseData()->roleName = roleName; } 
	virtual const std::string getRoleNameStr() const { return getRoleName().toString(); } 
	virtual void onRename(EGameRetCode retCode);

	/// 上次场景ID
	TSceneID_t getLastSceneID() const { return getHumanBaseData()->lastSceneID; } 
	void setLastSceneID(TSceneID_t val) { getHumanBaseData()->lastSceneID = val; } 

	/// 上次地图ID
	TMapID_t getLastMapID() const { return getHumanBaseData()->lastMapID; } 
	void setLastMapID(TMapID_t val) { getHumanBaseData()->lastMapID = val; } 

	/// 上次地图坐标
	TAxisPos* getLastMapPos() const { return &getHumanBaseData()->lastMapPos; } 
	void setLastMapPos(TAxisPos* val) { getHumanBaseData()->lastMapPos = *val; } 

	/// 登出时间
	GXMISC::TGameTime_t getLogoutTime() const { return getHumanBaseData()->logoutTime; }
	GXMISC::TGameTime_t getLogoutTime(){ return getHumanBaseData()->logoutTime; }
	void setLogoutTime(GXMISC::TGameTime_t val) { getHumanBaseData()->logoutTime = val; }	

	/// 创建时间
	GXMISC::TGameTime_t getCreateTime() const { return getHumanBaseData()->createTime; } 
	void setCreateTime(GXMISC::TGameTime_t val) { getHumanBaseData()->createTime = val; } 

	/// 一天之内登陆的次数
	sint32 getLoginCountOneDay() const { return getHumanBaseData()->loginCountOneDay; } 
	void setLoginCountOneDay(sint32 val) { getHumanBaseData()->loginCountOneDay = val; } 

	/// 元宝及绑定元宝
	TRmb_t getAllRmb() const;									///< 得到元宝总和 
	TRmb_t descAllRmb(TRmb_t val, bool logFlag = false);		///< 扣除元宝 
	TRmb_t addBindRmb(TRmb_t val, bool logFlag = false);		///< 增加绑定元宝 
	TRmb_t getBindRmb() const { return getHumanBaseData()->getBindRmb(); }	///< 获取绑定元宝
	TRmb_t getRmb() const { return getHumanBaseData()->getRmb(); }	///< 获取充值元宝

	/// 游戏币
	TGold_t getGameMoney() const { return getHumanBaseData()->gameMoney; } 
	void setGameMoney(TGold_t val) { getHumanBaseData()->gameMoney = val; } 
	TGold_t addGameMoney(TGold_t val, bool logFlag = false); 

	/// 经验
	virtual TExp_t getMaxExp(TLevel_t lvl = 0) const; 
	virtual TExp_t getExp() const { return getHumanBaseData()->exp; } 
	virtual void setExp(TExp_t val) { getHumanBaseData()->exp = val; CGameMisc::RefixValue(getHumanBaseData()->exp, 0, getMaxExp(getLevel())); } 

	/// 角色等级
	virtual TLevel_t getMaxLevel() const; 
	virtual TLevel_t getLevel() const { return getHumanBaseData()->level; } 
	virtual void setLevel(TLevel_t val) { getHumanBaseData()->level = val; CGameMisc::RefixValue(getHumanBaseData()->level, 0, getMaxLevel());} 

	/// 原型ID
	TRoleProtypeID_t getProtypeID() const { return getHumanBaseData()->protypeID; } 
	void setProtypeID(TRoleProtypeID_t val) { getHumanBaseData()->protypeID = val; } 

	/// vip等级
	virtual TVipLevel_t getVipLevel() const { return getHumanBaseData()->vipLevel; } 
	virtual void setVipLevel(TVipLevel_t val) { getHumanBaseData()->vipLevel = val; } 
	TVipLevel_t addVipLevel(TVipLevel_t val, bool logFlag = false ); 

	/// 体力值
	virtual TStrength_t getMaxStrength() const { return getNewRoleRow()->strength; } 
	virtual TStrength_t getStrength() const { return getHumanBaseData()->strength; } 
	virtual void setStrength(TStrength_t val) { getHumanBaseData()->strength = val;  } 
	bool isMaxStrength() { return getStrength() >= getMaxStrength(); }           

	/// vip经验值
	virtual TVipExp_t getVipExp() const { return getHumanBaseData()->vipExp; } 
	virtual void setVipExp( TVipExp_t val){ getHumanBaseData()->vipExp = val;} 
	TVipExp_t addVipExp( TVipExp_t  val, bool logFlag = false); 

	/// 渠道
	TSourceWayID_t getSource_way() const { return getHumanBaseData()->getSource_way(); }	
	void setSource_way(TSourceWayID_t val) { getHumanBaseData()->setSource_way(val.toString()); }

	/// 子渠道
	TSourceWayID_t getChisource_way() const { return getHumanBaseData()->getChisource_way(); }	
	void setChisource_way(TSourceWayID_t val) { getHumanBaseData()->setChisource_way(val.toString()); }	

	/// 背包格
	TItemContainerSize_t getbagOpenGridNum() const { return getHumanBaseData()->bagOpenGridNum; }
	void setbagOpenGridNum(TItemContainerSize_t val) { getHumanBaseData()->bagOpenGridNum = val; }

	/// 更新世界服务器用户信息
	void updateUserData(TW2MUserDataUpdate* pData);

public:
	/// 刷新快速属性
	virtual void refreshFast(bool sendFlag = true);	 
	/// 加载配置属性
	virtual void loadBaseAttr(TBaseAttrs* baseAttr);	
	/// 等级改变 sLvl原等级 dLvl改变后等级
	virtual void onLevelChanged(uint32 sLvl, uint32 dLvl);

	/// 重命名
	bool renameName(const std::string& roleName); 

	/// 随机名字
	const std::string randName(); 

	// 获取角色备份属性(用于属性同步)
	const TRoleAttrBackup* getRoleAttrBackup() const;

	/*****************************************************
							道具及货币
	*******************************************************/
public:
	/// 增加货币
	void handleAddMoneyPort(EAttributes attr, TAttrVal_t moneyvar, EMoneyRecordTouchType changeway = MONEYRECORDDEFINE);
	/// 扣减货币
	EGameRetCode handleDescMoneyPort(EAttributes attr, TAttrVal_t moneyvar, EMoneyRecordTouchType changeway = MONEYRECORDDEFINE);

	/// 统一处理人物属性
	void handleRoleAttr(EAttributes attr, TAttrVal_t attrvar);
	/// 获取角色属性
	TAttrVal_t handleGetRoleAttr(EAttributes attr) const;

	/// 统一处理道具和代币添加接口
	EGameRetCode handleAddTokenOrItem(const TItemReward * iteminfo, sint32 changeway = 0);
	/// 统一处理道具和代币删除接口
	EGameRetCode handleDeleteTokenOrItem(const TItemReward * iteminfo, sint32 changeway = 0);
	/// 统一处理道具和代币获取接口
	EGameRetCode handleGetTokenOrItem(TItemTypeID_t itemTypeID);

	/// 统一判断货币是否有足够的消费额度
	EGameRetCode isEnoughWaste(EAttributes attr, sint32 moneyvar);

	/// 元宝
	TRmb_t chargeRmb(TRmb_t val, bool logFlag = true);			///< 充值
protected:
	/// 充值事件
	void onChargeRmb(TRmb_t oldRmb, TRmb_t newRmb, TRmb_t addRmb);
public:
	/// 道具添加事件
	void onAddItem(EItemRecordType recordType, EPackType packType, TItemTypeID_t itemTypeID, TItemNum_t num, TItemQuality_t quality);
	/// 道具消耗事件
	void onDescItem(EItemRecordType recordType, EPackType packType, TItemTypeID_t itemTypeID, TItemNum_t num, TItemQuality_t quality);
	/// 道具删除事件
	void onDeleteItem(EItemRecordType recordType, EPackType packType, TItemTypeID_t itemTypeID, TItemNum_t num, TItemQuality_t quality);
private:
	/// 增加等级奖励
	void _addLevelAward(TLevel_t level);
	/*****************************************************
							战斗
	*******************************************************/
public:
	bool isFight() const;
	void onFightFinish(bool victory, sint32 killNum);

	/*****************************************************
							聊天
	*******************************************************/
public:
	void sendChat(const std::string& msg); 

	/*****************************************************
							脚本
	*******************************************************/
public:
	/// 设置创建Role脚本对象的函数名
	bool initScript(std::string functionName);

	/*****************************************************
					同步角色数据到数据库操作
	*******************************************************/
public:
	bool onLoad( TRoleManageInfo* info, CHumanDBBackup* hummanDB, TLoadRoleData* loadData, TChangeLineTempData* tempData, bool isAdult);	///< 加载角色数据	
	bool onSave(bool offLineFlag);											///< 保存	
	void setHummanDBBuffer(const char* buff, sint32 len);					///< 保存角色DB数据
	void sendTimerUpdateData(bool forceFlag, ESaveRoleType saveType);		///< 定时更新角色数据 
	bool isDbModBusy();														///< 数据库是否繁忙
	void loadDataOk(TLoadRoleData* pLoadData);								///< 数据加载成功

public:
	void setHummanDBData(CHumanDBData* dbData);					///< 数据库保存数据结构 
	CHumanDBData* getHumanDBData() const;						///< 获取角色所有DB数据 
	CHumanDB* getHumanDB() const;								///< 获取数据库存储对象 
	CHumanBaseData* getHumanBaseData() const;					///< 获取角色基本数据 
	TLoadWaitEnter* getLoadWaitData() const;					///< 得到玩家加载数据 
	CLimitManager* getLimitManager();							///< 得到限号信息 
	void updateLimitManger(GXMISC::TDiffTime_t diff);			///< 定时更新限号信息
	/// 设置加载等待信息
	void setLoadWaitInfo(ELoadRoleType loadType, TSceneID_t sceneID, const TAxisPos* pos, bool sendAllDataFlag);

	/*****************************************************
						时间管理
	*******************************************************/
public:
	void onOfflineOverrunDays(uint32 days);				///< 离线超过的天数, 只有过天的才会调用此函数(如:2012-02-01 23:50 下线,  
	///< 如果2012-02-02 00:10 上线, 则表示过天了, 如果2012-02-01 23:55上线则表示未过天)
	uint32 getOfflineOverrunDays(sint32 hour, sint32 min, sint32 seconds); 
	uint32 getOfflineOverrunDays(sint32 hour, sint32 min); 
	uint32 getOfflineOverrunDays(); 
	uint32 getOfflineHours();									///< 获取上次离线多少小时 
	uint32 getOfflineMins();									///< 获取上次离线超过分数 
	// @TODO
	virtual bool isOfflineDayTime(sint8 hour, sint8 mins = 0, sint8 seconds = 0);								///< 离线是否过了当天的小时 
	virtual bool isOfflineTime(GXMISC::TGameTime_t gameTime);													///< 离线是否过了某个时间	
	virtual bool isOfflineTime(sint16 year, sint8 month, sint8 day, sint8 hour, sint8 mins, sint8 seconds);		///< 离线是否过了某个时间	
	virtual void on0Timer();									///< 0点定时器 
	virtual void on12Timer();									///< 12点定时器 
	virtual void onHourTimer(sint8 hour);						///< 小时定时器
	sint32  getLoginsDay();										///< 得到一天登录次数 
	bool isFirstLoginInDay();									///< 是否为当天第一次登陆 
	GXMISC::TDiffTime_t getOnlineTime();						///< 获取当前在线游戏时间 
	GXMISC::TDiffTime_t getOnlineMins();						///< 获取当前在线游戏时间(分钟为单位) 
	void onFiveSecondTimer();									///< 五秒定时器 

public:
	void sendErrorCode(EGameRetCode retCode);

	/*****************************************************
						场景管理
	*******************************************************/
public:
	/// 得到场景记录
	TRoleSceneRecord* getSceneRecord();
	/// 离开场景
	/// exitFlag=true表示正常离开场景, 否则表示非正常离开场景(如断线,刷新)
	void leaveScene(bool exitFlag); 
	/// 进入场景
	bool enterScene(TMapID_t mapID);
	/// 进入场景
	bool enterScene(TSceneID_t sceneID);
	/// 移动
	virtual bool move( TPackMovePosList* posList ); 
	/// 移动
	bool roleMove(TPackMovePosList* posList, ERoleMoveType moveType);
	/// 能否看到当前对象
	virtual bool isCanViewMe( const CGameObject *pObj ); 
	/// 是否需要更新块
	virtual bool isNeedUpdateBlock(); 
	/// 设置角色位置
	virtual void setAxisPos(const TAxisPos* pos);
	/// 设置地图ID
	virtual void setMapID(TMapID_t mapID); 
	/// 设置场景ID
	virtual void setSceneID(TSceneID_t sceneID);
	/// 设置切换场景位置
	void setChangePos(TSceneID_t sceneID, const TAxisPos* pos);
	/// 发送进入场景事件
	void sendEnterScene(ESceneType type);
	/// 通知其他玩家进入场景
	void sendOtherChangeScene(TObjUID_t objUID, TSceneID_t sceneID, const TAxisPos* pos);
	/// 获取切换线数据
	TChangeLineWait* getChangeLineWait();
public:
	/// 进入场景回调事件
	virtual void onEnterScene(CMapSceneBase* pScene);
	/// 离开场景事件
	virtual void onLeaveScene(CMapSceneBase* pScene);
	/// 打开动态场景事件
	void onOpenDynamicMap(TSceneID_t sceneID, const TAxisPos* pos, TServerID_t mapServerID, EGameRetCode retCode);
	/// 切线返回事件
	void onChangeLineRet();
	/// 移动到指定点回调事件
	virtual void onMove(const TAxisPos* pos);
public:
	/// 传送点传送
	EGameRetCode transport(TTransportTypeID_t transportTypeID);
	/// 切换服务器
	EGameRetCode changeLine(TServerID_t serverID, TSceneID_t sceneID, const TAxisPos* pos, ETeleportType type);
	/// 开启动动态场景
	EGameRetCode openDynamicMap(TMapID_t mapID);
	/// 开启副本成功,把玩家传送进动态场景中
	EGameRetCode moveToDynamicMap(TSceneID_t sceneID, const TAxisPos* pos, TServerID_t mapServerID);
	/// 切换地图
	EGameRetCode changeMap(TMapID_t mapID, const TAxisPos* pos, ETeleportType type);
public:
	/// 是否为切线等待客户端登陆状态
	bool isChangeLineWait();
	/// 是否为切线状态,包含isChangeLineWait()
	bool isChangeLine();
	/// 是否为切场景
	bool isChangeMap();
private:
	/// 切换地图
//	EGameRetCode changeMap(TTransportTypeID_t id, ETeleportType type, bool isCheckPos = true, bool isCheckLevel = true);
// 	/// 切线
// 	EGameRetCode changeLine(TMapID_t mapID, const TAxisPos& pos, ETeleportType type);
// 	/// 切线
// 	EGameRetCode changeLine(TSceneID_t sceneID, TMapServerID_t mapServerID, const TAxisPos& pos, ETeleportType type);
	// 切换到目标场景
	void toDestScene(TSceneID_t sceneID, const TAxisPos* destPos, ETeleportType type);
	/// 将相关玩家移动到动态场景中
	void moveAllToDynamicMap(TSceneID_t sceneID, const TAxisPos* pos, TRoleUID_t roleUID, TServerID_t mapServerID);
private:
	/// 在远程打开一个动态场景
	EGameRetCode openRemoteDynamicMap(TMapID_t mapID);
	/// 打开本地动态场景
	EGameRetCode openLocalDynamicMap(TMapID_t mapID);
	/// 获取普通场景
	bool getNormalMapScene(TMapID_t mapID, TServerID_t& mapServerID, TSceneID_t& sceneID);
private:
	/// 检测是否可以传送
	EGameRetCode checkTelport(CTransportConfigTbl* tbl, bool isCheckPos, bool isCheckLevel, TMapIDRangePos* destPos, ETeleportType type);
	/// 检测是否可以切换地图
	EGameRetCode checkChangeMap(TMapID_t mapID, const TAxisPos* pos, ETeleportType type);
	/// 检测是否可以进入动态场景
	EGameRetCode checkEnterDynaMap(TMapID_t mapID);
private:
	/*****************************************************
						   任务操作
	*******************************************************/
public:
	/// 任务提交事件
	void onMissionSubmit(TMissionTypeID_t missionTypeID, EMissionType missionType, TOwnMission* mission);	 
	/// 任务接收事件
	void onMissionAccept(TMissionTypeID_t missionTypeID, EMissionType missionType, TOwnMission* mission);	 

	/*****************************************************
							退出管理
	*******************************************************/
public:
	// 踢掉角色 
	void kick(bool needSave, sint32 sockWaitTime = 1, const std::string reason = "");	
	virtual void directKick(bool needSave, bool delFromMgr, bool needRet, EKickType kickType = KICK_TYPE_ERR);		// 直接踢掉 
	virtual void quitGame();								// 主动退出游戏, 通知World服务器玩家下线, 等待World释放数据 
public:
	void onUnloadRole(EUnloadRoleType unloadType, bool needRet);        				// 世界服务器释放角色数据
	virtual void waitReconnect();														// 连接关闭
public:
	CLoginWaiterManager* getLoginManager() { return &_loginManager; }
	void setLoginManager(CLoginWaiterManager* val) { _loginManager = *val; }
public:
	void sendKickMsg(EKickType kickType);												// 发送掉线消息 
	void quit(bool forceQuit, const char* quitResult, sint32 sockWaitTime = 3);			// 退出 
	void cleanAll(sint32 sockWaitTime);													// 清理角色数据
	void heartToWorld(GXMISC::TDiffTime_t diff);                                        // 向世界服务器发送的心跳 
	void saveRet();                                                     				// 保存数据返回
	void offlineSave(bool saveNeedRet, ESaveRoleType saveType);							// 保存数据后再下线
	void onQuitHandle(ESaveRoleType roleType);											// 退出处理
	void toWorldKick();	// 通知世界服务器踢掉玩家 

private:
	void quitSuccess();	                												// 退出成功, 可以释放数据
	void onChangeLineUnload();															// 切线释放角色数据
	void onQuitUnload();																// 角色下线
	void onKickByOtherUnload();															// 被其他玩家T下线
	
	// 状态管理
public:
	// 是否需要等待下线(有数据需要从World通过MapServer转发到客户端)
	bool isWaitOffline();	 									 		
private:
	void closeSocketHandler(sint32 sockWaitTime);
	void closeDbHandler();

	void quitOnLoadData();
	void quitOnEnter();
	void quitOnEnterScene();
	void quitOnChangeMap();
	void quitOnSave();
	void quitOnQuit();
	void quitOnQuitReq();

	/// 玩家数据管理
public:
	void getRoleUserData(CWorldUserData* data); 
	std::string toRoleString(); 

	/*****************************************************
						禁言封号
	*******************************************************/
public:
	//添加禁言信息
	void addLimitChatInfo( TAccountID_t accountId, TRoleUID_t roleId, GXMISC::CGameTime	begintime, GXMISC::CGameTime endtime, TServerOperatorId_t uniqueId );
	//查看是否正处在禁言期间
	bool isForbbidChat( TAccountID_t accountId );  

	/*****************************************************
						登陆相关处理
	*******************************************************/
public:
	/// 初始化CCharacter父类中的成员
	void initCharacter();					
	/// 如果初始化过, 则不需要重新初始化
	bool isNeedInit();						
	/// 发送释放数据返回
	void sendUnloadRet(EGameRetCode ret); 
	/// 得到场景数据
	void getScenData(CArray1<TNPCTypeID_t>* npcs, CArray1<TTransportTypeID_t>* trans);
	/// 设置本进程登陆
	void setLocalServerLogin(bool flag);
public:
	/// 获取数据对像指针
	CMapDbPlayerHandler* getDbHandler(bool isLogErr = true); 
	CMapPlayerHandler* getPlayerHandler(bool logFlag = true); 
	CRoleScriptObject* getScriptHandler();
public:
	// 数据加载成功则进入游戏
	bool onScene(CMapScene* pScene);                                            									///< 进入场景 
	bool onEnter();				                                                									///< 进入游戏
	bool onBeforeChangeMap(TSceneID_t sceneID, const TAxisPos* pos, ELoadRoleType changeType, ETeleportType type);	///< 切换场景前
	bool onChangeMap(TSceneID_t sceneID, const TAxisPos* pos, ETeleportType type);									///< 切换场景
	bool onAfterChangeMap(TSceneID_t sceneID, const TAxisPos* pos, ELoadRoleType changeType, ETeleportType type);	///< 切换场景后
	bool onQuit();				                                                									///< 完全退出当前服务器
	bool onBeforeChangeLine(TChangeLineTempData* tempData, TMapID_t mapID,
		const TAxisPos* pos, TServerID_t mapServerID, ETeleportType type);											///< 源服务器切线前
	bool onAfterChangeLine(TChangeLineTempData* tempData, ETeleportType type);										///< 目标服务器切线后
	bool onLogin();				                                                									///< 登陆
	virtual bool onLogout();			                                                							///< 登出
	bool onNewLogin();			                                                									///< 新角色登陆
	bool onOldLogin();			                                                									///< 老角色登陆
	virtual void onIdle();																							///< 空闲
	bool reLogin();				                                                									///< 重新登陆
	void initClient();			                                                									///< 客户端初始化成功
	virtual void onLoginTimeout();																					///< 登陆超时事件
	virtual void onLogoutTimeout();																					///< 登出超时事件
	virtual bool onAddToReady();																					///< 添加到准备队列中
	virtual bool onAddToLogout();																					///< 添加到登出队列中
	virtual void onRemoveFromLogout();																				///< 从登出队列删除

	// 模块
private:
	CModBag							_bagMod;						///< 背包模块
	CModBuffer						_bufferMod;						///< Buffer模块
	CModChat						_chatMod;						///< 聊天模块
	CModMission						_missionMod;					///< 任务模块
	CModFight						_fightMod;						///< 战斗模块

	// 移动
private:
	bool _initFlag;													///< 是否初始化过
	GXMISC::TGameTime_t             _lastCheckMoveTime;             ///< 上一次检测移动的速度(MAX_MOVE_CHECK_TIME)
	uint32                          _totalMovePosNumInCheckTime;    ///< 检测间隔内的移动格子总数
	TAxisPos                        _lastCheckMovePos;              ///< 上一次检测移动的停留格子
	bool							_canMoveFlag;					///< 是否可以移动(在切线,切换场景, 传送后不能再接收移动消息, 必须等到client init success消息后才能移动)

	// 切线及切换地图
private:
	TChangeLineWait                 _changeLineWait;				///< 切线等待
	TLoadWaitEnter					_loadWaitData;					///< 加载时的数据
	TRoleSceneRecord				_sceneRecord;					///< 场景信息记录
	bool							_isLocalServerLogin;			///< 是否本进程登陆

	// 定时器
private:
	GXMISC::CManualIntervalTimer    _humanDBDataSaveTimer;			///< 保存角色数据的定时器
	GXMISC::CManualIntervalTimer	_update2WTime;					///< 更新数据到世界服务器
	GXMISC::CManualIntervalTimer    _heartToWorldTimer;				///< 与世界服务器的心跳定时器
	GXMISC::CManualIntervalTimer	_fiveSecTimer;					///< 五秒定时器

	// 数据库数据
private:
	CHumanDB						_humanDb;						///< 保存的对象
	TRoleAttrBackup					_attrBackup;					///< 同步给客户端的属性备份
	TSex_t							_sex;							///< 性别
	CLimitManager					_limitMgr;						///< 限号信息管理
	CLoginWaiterManager				_loginManager;					///< 登陆管理器(包括登入及登出)
	CRoleScriptObject				_scriptObject;					///< 脚本对象
};

#endif	// _ROLE_H_