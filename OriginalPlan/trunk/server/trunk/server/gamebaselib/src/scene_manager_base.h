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
					��̬��������
	 *****************************************/
public:
	/**
	 * @brief ���������ֶ�̬���� @TODO ��δʵ��
	 * @return bool
	 */
	bool openSomeDynamicScene();
	/**
	 * @brief ������̬����
	 * @param TMapID_t mapID ��ͼID
	 * @param ESceneType sceneType ��ͼ����
	 * @param TObjUID_t objUID �����߶���UID
	 * @return CMapSceneBase* ��������
	 */
	CMapSceneBase* openDynamicScene(TMapID_t mapID, ESceneType sceneType, TObjUID_t objUID, bool needSendToWorld);
	/**
	 * @brief �رն�̬����
	 * @param TSceneID_t sceneID ����ID
	 * @param bool needSendToWorld �Ƿ���Ҫ���͸����������
	 * @return void
	 */
	void closeDynamicScene( TSceneID_t sceneID, bool needSendToWorld );
public:
	/**
	 * @brief ���Ϳ�����̬������Ϣ�����������
	 * @param CMapSceneBase pScene ��������
	 * @return void
	 */
	void sendOpenDynamicToWorld(CMapSceneBase* pScene);
	/**
	 * @brief ���͹رն�̬������Ϣ�����������
	 * @param TSceneID_t sceneID ����ID
	 * @return void
	 */
	void sendCloseDynamicToWorld(TSceneID_t sceneID);
	// ͳ��
public:
	void statDynamicSceneNum();
	sint32 getDynamicMapNum() const;

private:
	// �������黹����Ӧ�Ķ������
	void delDynamicScene( CMapSceneBase* pScene );

public:
	TSceneID_t genSceneID(TServerID_t serverID, uint8 mapType, TMapID_t mapID);

public:
	template<typename T>
	void broadcast(T& packet);
	template<typename T>
	void broadcastChat(T& packet);

private:
	TCopyID_t _genCopyID;							// ������������ID
	uint32 _dynamicSceneNum[SCENE_TYPE_NUMBER];		// ��ǰ������̬��������
};

extern CSceneManagerBase* g_SceneManagerBase;
#define SceneMgrBase g_SceneManagerBase

#include "scene_manager_base.inl"

#endif	// _SCENE_MANAGER_BASE_H_
