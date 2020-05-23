#ifndef _MAP_SERVER_TASK_H_
#define _MAP_SERVER_TASK_H_

#include "service_task.h"
#include "game_util.h"
#include "game_pos.h"

enum
{
	SERVER_TASK_TYPE_OPEN_SCENE,
	SERVER_TASK_TYPE_RESET_PET,
};
// 开启动态场景
class COpenDynamicScene : public GXMISC::CServiceTask
{
public:
	COpenDynamicScene();
	~COpenDynamicScene();

public:
	virtual void run() override;
	virtual void cleanUp() override;
	virtual sint32 getType() override;

public:
	void setParam(TObjUID_t objUID, TMapID_t mapID, const TAxisPos* pos, ESceneType sceneType);

private:
	TObjUID_t _objUID;			///< 对象UID
	TMapID_t _mapID;			///< 地图ID
	TAxisPos _pos;				///< 位置
	ESceneType _sceneType;		///< 场景类型
};

#endif	// _MAP_SERVER_TASK_H_