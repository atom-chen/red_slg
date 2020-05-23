#include "game_misc.h"
#include "scene.h"

CScene::CScene()
{
	_sceneData.sceneID = INVALID_SCENE_ID;
	_sceneData.mapServerID = INVALID_SERVER_ID;
	_roleNum = 0;
}

CScene::~CScene()
{
}

TSceneID_t CScene::getSceneID()
{
	return _sceneData.sceneID;
}

// uint32 CScene::getRoleNum()
// {
// 	return _roleNum;
// }
// 
// uint32 CScene::addRoleNum( sint32 num /*= 1*/ )
// {
// 	gxAssert(_roleNum+num <= _sceneData.maxRoleNum);
// 	_roleNum += num;
// 	return _roleNum;
// }
// 
// uint32 CScene::descRoleNum( sint32 num /*= 1*/ )
// {
// 	gxAssert(_roleNum-num >= 0);
// 	_roleNum -= num;
// 	return _roleNum;
// }

void CScene::init( TSceneData* sceneData )
{
	_sceneData = *sceneData;
	genStrName();
}

TServerID_t CScene::getMapServerID()
{
	return _sceneData.mapServerID;
}

// bool CScene::isMaxRoleNum()
// {
// 	return _sceneData.maxRoleNum == _roleNum;
// }

ESceneType CScene::getSceneType() const
{
	return _sceneData.sceneType;
}

bool CScene::isRiskScene() const
{
    return (_sceneData.sceneType == SCENE_TYPE_RISK);
}

bool CScene::isNormalScene() const
{
    return _sceneData.sceneType == SCENE_TYPE_NORMAL;
}


bool CScene::canEnter( GXMISC::TGameTime_t logoutTime ) const
{
    if( isNormalScene() )
    {
        return true;
    }

    if( isRiskScene() )
    {
        return _sceneData.lastTime > MAX_RISK_SCENE_LAST_ENTER_TIME;
    }

    return true;
}

bool CScene::isLargerOffTime( GXMISC::TGameTime_t logoutTime ) const
{
	TMapID_t mapID = CGameMisc::GetMapID(_sceneData.sceneID);
	uint8 sceneType = CGameMisc::GetMapType(_sceneData.sceneID);
	return false;
}

void CScene::changeOwner( TObjUID_t objUID )
{
	_sceneData.objUID = objUID;
}

TObjUID_t CScene::getOwner() const
{
	return _sceneData.objUID;
}