#ifndef _SCENE_H_
#define _SCENE_H_

#include "game_util.h"
#include "game_struct.h"

#include "core/string_common.h"
#include "core/multi_index.h"

class CScene
{
public:
    CScene();
    ~CScene();

public:
    void			init(TSceneData* sceneData);
    TSceneID_t		getSceneID();
    TServerID_t	getMapServerID();
//     bool isMaxRoleNum();
//     uint32 getRoleNum();
//     uint32 addRoleNum(sint32 num = 1);
//     uint32 descRoleNum(sint32 num = 1);
	ESceneType		getSceneType() const;
    bool			isRiskScene() const;
    bool			isNormalScene() const;
	bool			canEnter( GXMISC::TGameTime_t logoutTime ) const;

	void			changeOwner( TObjUID_t objUID );
	TObjUID_t		getOwner() const;

private:
	bool isLargerOffTime( GXMISC::TGameTime_t logoutTime ) const;	// 超过允许的掉线时间则为true（战场、副本）

private:
    TSceneData _sceneData;
    sint32 _roleNum;

    DMultiIndexImpl1(TSceneID_t, _sceneData.sceneID, INVALID_SCENE_ID);
    DFastObjToStringAlias(CScene, TSceneID_t, SceneID, _sceneData.sceneID);
};

#endif