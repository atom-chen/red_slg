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
// ������̬����
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
	TObjUID_t _objUID;			///< ����UID
	TMapID_t _mapID;			///< ��ͼID
	TAxisPos _pos;				///< λ��
	ESceneType _sceneType;		///< ��������
};

#endif	// _MAP_SERVER_TASK_H_