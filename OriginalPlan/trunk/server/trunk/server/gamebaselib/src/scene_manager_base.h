#ifndef _SCENE_MANAGER_BASE_H_
#define _SCENE_MANAGER_BASE_H_

#include "core/multi_index.h"
#include "core/obj_mem_fix_pool.h"

#include "map_scene_base.h"

typedef std::vector<TSceneID_t> TSceneIDVec;

class CSceneManagerBase :
	public GXMISC::CHashMultiIndex<CMapSceneBase>
{
public:
	typedef GXMISC::CHashMultiIndex<CMapSceneBase> TBaseType;
	DMultiIndexIterFunc(CMapSceneBase);

public:
	CSceneManagerBase();
	~CSceneManagerBase(){}

public:
	virtual bool initAllMap();
	virtual void update(GXMISC::TDiffTime_t diff);

public:
	CMapSceneBase* findScene( TSceneID_t sceneID );
	bool isSceneExist(TSceneID_t key);
	void getScenes(TSceneAry& scenes);

public:
	CMapSceneBase* getLeastScene(TMapID_t mapID);
	virtual CMapSceneBase* addNewScene(TSceneID_t sceneID, uint8 mapType, bool addFlag){ return NULL; }
	virtual void delScene(TSceneID_t sceneID) {}

	/*****************************************
					动态场景管理
	 *****************************************/
public:
	/**
	 * @brief 开启动部分动态场景 @TODO 尚未实现
	 * @return bool
	 */
	bool openSomeDynamicScene();
	/**
	 * @brief 开启动态场景
	 * @param TMapID_t mapID 地图ID
	 * @param ESceneType sceneType 地图类型
	 * @param TObjUID_t objUID 所有者对象UID
	 * @return CMapSceneBase* 场景对象
	 */
	CMapSceneBase* openDynamicScene(TMapID_t mapID, ESceneType sceneType, TObjUID_t objUID, bool needSendToWorld);
	/**
	 * @brief 关闭动态场景
	 * @param TSceneID_t sceneID 场景ID
	 * @param bool needSendToWorld 是否需要发送给世界服务器
	 * @return void
	 */
	void closeDynamicScene( TSceneID_t sceneID, bool needSendToWorld );
public:
	/**
	 * @brief 发送开启动态场景消息给世界服务器
	 * @param CMapSceneBase pScene 场景对象
	 * @return void
	 */
	void sendOpenDynamicToWorld(CMapSceneBase* pScene);
	/**
	 * @brief 发送关闭动态场景消息给世界服务器
	 * @param TSceneID_t sceneID 场景ID
	 * @return void
	 */
	void sendCloseDynamicToWorld(TSceneID_t sceneID);
	// 统计
public:
	void statDynamicSceneNum();
	sint32 getDynamicMapNum() const;

private:
	// 将场景归还到对应的对象池中
	void delDynamicScene( CMapSceneBase* pScene );

public:
	TSceneID_t genSceneID(TServerID_t serverID, uint8 mapType, TMapID_t mapID);

public:
	template<typename T>
	void broadcast(T& packet);
	template<typename T>
	void broadcastChat(T& packet);

private:
	TCopyID_t _genCopyID;							// 场景序列增长ID
	uint32 _dynamicSceneNum[SCENE_TYPE_NUMBER];		// 当前各个动态场景数量
};

extern CSceneManagerBase* g_SceneManagerBase;
#define SceneMgrBase g_SceneManagerBase

#include "scene_manager_base.inl"

#endif	// _SCENE_MANAGER_BASE_H_
