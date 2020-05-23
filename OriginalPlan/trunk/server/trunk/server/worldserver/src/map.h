#ifndef _MAP_H_
#define _MAP_H_

#include "scene.h"
#include "game_util.h"

typedef std::map<TSceneID_t, CScene*> TSceneMap;

// 地图对象
class CMap
{
public:
	bool addScene(CScene* pScene);
	void delScene(TSceneID_t sceneID);
	CScene* getLeastScene();
	CScene* getLeastScene(TServerID_t mapServerID);          // 获取人数最小的服务器
	CScene* getEmptyScene();
	CScene* getEmptyScene(TServerID_t mapServerID);          // 获取空的服务器
	void setMapID(TMapID_t mapID);
	TMapID_t getMapID();

private:
	TSceneMap _scenes;
	TMapID_t _mapID;

	DMultiIndexImpl1(TMapID_t, _mapID, INVALID_MAP_ID);
	DFastObjToStringAlias(CMap, TMapID_t, MapID, _mapID);
};

#endif