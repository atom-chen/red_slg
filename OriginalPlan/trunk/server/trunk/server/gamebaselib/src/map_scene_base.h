#ifndef _MAP_SCENE_BASE_H_
#define _MAP_SCENE_BASE_H_

#include "core/time/interval_timer.h"
#include "core/base_util.h"

#include "block.h"
#include "area.h"
#include "map_data_base.h"
#include "game_struct.h"
#include "game_define.h"
#include "game_util.h"
#include "game_rand.h"
#include "scene_util.h"
#include "scene_object_manager.h"
#include "scene_role_manager.h"
#include "scan.h"
#include "role_base.h"
#include "map_player_handler_base.h"
#include "map_world_handler_base.h"

class CCharacterObject;
class CMapSceneBase
{
public:
	CMapSceneBase();
	virtual ~CMapSceneBase();

public:
	// 开始初始化
	virtual bool					proInit( TMapID_t mapID );
	// 更新
	virtual	bool					proUpdate( GXMISC::TDiffTime_t diff );
	// 玩家进入场景
	virtual	void					proRoleEnterScene( CRoleBase* pRole );
	// 玩家离开场景
	virtual void					proRoleLeaveScene( CRoleBase* pRole, bool exitFlag );
	// 怪物离开场景
	virtual void					proMonsterLeaveScene( uint32 monsterNum, TMonsterTypeID_t monsterTypeID, TObjUID_t objUID );
	// 踢掉玩家
	virtual void					kickAllRole();
	// 踢掉单个玩家
	virtual	void					kickSingleRole( CRoleBase* pRole );
	// 是否能进入
	virtual bool					canEnter();
	// 得到踢掉坐标
	virtual bool					getKickPos( TMapIDRangePos* kickPos, CRoleBase* pRole ) const;
	// 得到复活坐
	virtual EGameRetCode			getRelivePos( CRoleBase* pRole, EReliveType reliveType, TMapIDRangePos* relivePos ) const;	// 获取回城复活点
	// 是否强制更新所有块
	virtual bool					isForceUpdateAllBlock();

	// 基本接口
public:
	virtual bool init(CMapBase* data);
	virtual bool load();
	virtual void unload();
	virtual bool update(GXMISC::TDiffTime_t diff);
	virtual void cleanUp();

	// 场景的类型
public:
	bool isDynamicScene();
	bool isNormalScene();

public:
	// 事件
	bool onInit();
	void onUnload();
	void onRoleEnter(CRoleBase* obj);
	void onRoleLeave(CRoleBase* obj, bool exitFlag);

	///====================场景管理====================
public:
	// 进入场景
	bool enter(CGameObject* obj);
	// 离开场景
	void leave(CGameObject* obj,bool exitFlag);
	uint16 getMaxRoleNum();
	bool isMaxRoleNum();

	// 扫描
public:
	/**
	* 扫描指定范围内的对象
	* @param flag=true 表示从当前块搜索起, 否则以矩形搜索
	*/
	bool scan(CScanOperator* scanOperator, bool flag);
	bool scanRole(TAxisPos* pos, uint8 range, TScanRoleBaseList& roleList);
	bool scanRole(TBlockID_t blockID, uint8 range, TScanRoleBaseList& roleList);
	// = idBlockA - (idBlockA & idBlockB)
	bool scanRoleSub( TBlockID_t blockIDA, TBlockID_t blockIDB, uint8 range, TScanRoleBaseList& roleList);
	bool scanObject( TBlockID_t blockID, uint8 range, TScanObjList& objList );
	// = idBlockA - (idBlockA & idBlockB)
	bool scanObjSub( TBlockID_t blockIDA, TBlockID_t blockIDB, uint8 range, TScanObjList& objList);

public:
	// 地图数据
	CMapBase* getMapData();
	const bool posValidate(const TAxisPos *pos);

public:
	// 块功能
	void getRectInRange( TBlockRect* rect, sint8 range, TBlockID_t blockID );							// 得到矩形范围
	void getBlocksInRange( TBlockIDList* ids, TRange_t range, TBlockID_t blockID, bool rectOrCurFlag );	//rectOrCurFlag=true 表示从当前块搜索起, 否则以矩形搜索
	bool isInCurBlock(TBlockID_t blockID, TAxisPos* axisPos, uint8 range);								// 是否在当前块中
	uint8 axisRange2BlockRange(const TAxisPos* axisPos, uint8 range);									// 当前格子范围转换成块范围
	uint8 blockRangeInTwo(TBlockID_t blockID1, TBlockID_t blockID2);									// 求相交
	bool checkBlockID(TBlockID_t blockID);																// 检测块是否合法
	CBlock* getBlock(TBlockID_t blockID);																// 得到块
	TBlockID_t calcBlockID( const TAxisPos* pos );																// 计算块ID
	void signUpdateBlock(sint32 roleBlockNum);															// 标记块需要更新
	bool isBlockDirty(TBlockID_t blockID);																// 当前块是否已经脏
	// 块对像管理
	bool objBlockRegister( CGameObject *obj, TBlockID_t blockID );										// 块注册
	bool objBlockUnregister( CGameObject *obj, TBlockID_t blockID );									// 块移除
	bool objBlockChanged( CGameObject *obj, TBlockID_t blockIDNew, TBlockID_t blockIDOld );				// 块改变
	void leaveBlock(CGameObject* pObject);																// 离开场景

	// 场景动态阻挡点
public:
	// 查找一个范围空位置
	bool findEmptyPos( TAxisPos* pos, TRange_t range );
	bool findEmptyPos( TAxisPos* pos, TRange_t range, bool cycle );
	bool findEmptyPos( TAxisPos* top, TAxisPos* bottom, TAxisPos* pos );
	bool findRandEmptyPos( TAxisPos* pos, TRange_t range );
	bool findRandEmptyPos( TAxisPos* top, TAxisPos* bottom, TAxisPos* pos );
	bool findRandPos(TAxisPos* pos, TRange_t range);
	void randStepPos(TListPos* poss, TAxisPos* srcPos, TRange_t nRange, uint32 maxSteps = 0);
	void randPos( const TAxisPos* top, const TAxisPos* buttom, TAxisPos* randP );
	bool isLineEmpty(const TAxisPos* srcPos, const TAxisPos* destPos);
	bool getLineEmptyPos(const TAxisPos* srcPos, const TAxisPos* destPos, TAxisPos* targetPos);
	bool getLineEmptyPos(const TAxisPos* srcPos, const TAxisPos* destPos, TRange_t range, TAxisPos* targetPos);
	// 阻挡点
	const bool checkBlock(const TAxisPos* pos, const sint8 block);
	const bool checkBlock(TAxisPos_t x, TAxisPos_t y,const sint8 block);
	const bool checkBlock(TAxisPos_t x, TAxisPos_t y);
	const bool checkBlock(const TAxisPos *pos);
	void setBlock(const TAxisPos *pos,const sint8 block);
	void setBlock(const TAxisPos *pos);
	void setBlock(const TAxisPos *pos, TRange_t range, const sint8 block); 
	void clearBlock(const TAxisPos *pos,const sint8 block);
	void clearBlock(const TAxisPos *pos);
	const bool checkObjectBlock(const TAxisPos *pos);
	void setObjectBlock(const TAxisPos *pos);
	void clearObjectBlock(const TAxisPos *pos);
	const TTile* getTile(const TAxisPos *pos);

	// 对象管理
public:
	// 获取指定块的附近的广播玩家列表
	template<typename T>
	void getRoleList(CBlock* pBlock, T& roleList, TObjUID_t exceptObjUID = INVALID_OBJ_UID);
	// 获取所有玩家的SocketIndex
	void getAllRoleSocketIndex(GXMISC::TSockIndexAry* socks);
	// 判断是否人数达到饱和上限
	bool isCanEnter(){ return true; }
	// 判断是否人数完全饱和
	bool isFull(){ return false; }
	// 获取Object
	CGameObject* getObjByUID(TObjUID_t objUID);
	// 获取CharacterObject
	CCharacterObject* getCharacterByUID(TObjUID_t objUID);

	// 广播 @todo仔细调整接口
public:
	//向当前场景内发送广播消息，广播的中心点位置为pOwnCharacter所在位置
	//广播距离为len个单位，如果len为-1，则广播到整个场景里
	//如果bSendMe设置为真，则消息同时也发给pOwnCharacter所在玩家
	template<typename T>
	bool broadCastScene( T& packet ) ;

	template<typename T>
	bool broadCastSceneChat( T& packet ) ;

	//向pOwnCharacter所在的位置广播一个消息
	//消息的范围为当前的ZoneA和ZoneA周围的N圈Zone
	//N为配置好的信息
	template<typename T>
	bool broadCast(	T& packet, CCharacterObject* character, bool sendMe, sint32 range ) ;

	//向BlockID所在区域为中心广播一个消息
	//范围为BlockID所在区域以及周围N圈Block
	//N为配置好的信息
	template<typename T>
	bool broadCast(T& packet, TBlockID_t blockID,sint32 range);

	//广播聊天消息时使用
	//向BlockID所在区域为中心广播一个消息
	//范围为BlockID所在区域以及周围N圈Block
	//N为配置好的信息
	//BlockID为INVALID_BLOCK_ID时，全场景广播
	template<typename T>
	bool broadCastChat(T& packet, TBlockID_t blockID);

	// 发送消息
	template<typename T>
	bool sendPacket( T& packet, TScanRoleBaseList& roleList );

public:
	virtual CSceneRoleManager* getRoleMgr(){ return &_roleMgr; } // @TODO 将虚函数变成非虚函数
	virtual CSceneObjectManager* getObjectMgr(){ return &_objMgr; } // @TODO 将虚函数变成非虚函数

	// 内部成员管理
public:
	TMapID_t getMapID() const;
	void setSceneID(TSceneID_t sceneID){_sceneID = sceneID; genStrName(); }
	TSceneID_t getSceneID() const{ return _sceneID; }
	void setSceneType( ESceneType type ){_sceneType = type; genStrName(); }
	ESceneType getSceneType() const{ return _sceneType; }
	void setIsNeedClose( bool needClose )	{ _isNeedClose = needClose; }
	bool getIsNeedClose() const				{ return _isNeedClose; }
	void setOwnerObjUID(TObjUID_t objUID){ _ownerObjUID = objUID; }
	TObjUID_t getOwnerObjUID(){ return _ownerObjUID; }
	TSceneGroupID_t getEmptyGroupID();
	void putEmptyGourpID(TSceneGroupID_t groupID);
	void initRoleInfo(TSceneGroupID_t maxRole, sint32 maxGroupNum);
	sint32 getMaxNumInGroup() const;

public:
	void getSceneData(TSceneData* data);

private:
	bool							_isNeedClose;				// 是否需要关闭
	CSceneObjectManager				_objMgr;					// 对象管理
	CSceneRoleManager				_roleMgr;					// 角色管理
	CMapBase*						_mapData;					// 地图数据
	CAreaManager					_areaMgr;					// 事件区管理
	TBlockList						_blockList;					// 块列表
	TBlockInfo						_blockInfo;					// 块信息
	TSceneID_t						_sceneID;					// 场景ID
	ESceneType						_sceneType;					// 场景类型
	TMapID_t						_mapID;						// 地图ID
	uint32							_maxMonsterNum;				// 场景开启时的怪物总数
	GXMISC::TGameTime_t				_openTime;					// 场景开启时间
	GXMISC::CManualIntervalTimer	_closeTimer;				// 关闭计时器
	TTiles							_allTiles;					// 所有的地图格子
	GXMISC::CBitSet					_blockDirty;				// 有角色存在的块
	sint32							_blockRoleNum;				// 有角色存在的块的数目
	TObjUID_t						_ownerObjUID;				// 谁拥有此场景
	std::vector<sint32>				_emptyIndex;				// 空的索引标识
	TSceneGroupID_t					_maxRoleNum;				// 最大的角色数目
	sint32							_maxRoleNumInGroup;			// 一组内最大的角色数目
	TSceneGroupID_t					_curGroupID;				// 当前组标识ID

protected:
	DMultiIndexImpl1(TSceneID_t, _sceneID, INVALID_SCENE_ID);
	DFastObjToString2Alias(CMapSceneBase, TSceneID_t, SceneID, _sceneID, uint32, SceneType, _sceneType);
};

#include "map_scene_base.inl"

#endif	// _MAP_SCENE_BASE_H_