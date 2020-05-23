#ifndef _MONSTER_MANAGER_H_
#define _MONSTER_MANAGER_H_

#include "game_util.h"
#include "multi_index.h"
#include "obj_mem_fix_pool.h"
#include "time_util.h"
#include "scene_object_manager.h"
#include "monster.h"

class CMonsterConfigTbl;

typedef struct _AddMonster
{
	TMonsterTypeID_t monsterTypeID;
	uint8 num;
	TAxisPos pos;
	TObjUID_t objUID;
}TAddMonster;
class CMapScene;
class CMonsterManager : public GXMISC::CHashMultiIndex<CMonster>
{
public:
	typedef GXMISC::CHashMultiIndex<CMonster> TBaseType;

public:
	CMonsterManager(){ _genObjUID = TEMP_MOSTER_INIT_UID; }
	~CMonsterManager(){}

public:
	bool init(uint32 num);
	void update(GXMISC::TDiffTime_t diff);

	void        setScene(CMapScene* pScene);
	CMapScene*  getScene();

public:
	CMonster*   addMonster(CMonsterDistributeConfigTbl* distribute, TBlockID_t blockID);
	CMonster*	addMonster(TMonsterTypeID_t monsterTypeID, TMapID_t mapID, const TAxisPos& pos, bool needRefresh);
	void        delMonster(TObjUID_t objUID);
	CMonster*   findMonster(TObjUID_t objUID);
	uint32      size();
	void        updateGuardMonster(GXMISC::TDiffTime_t diff);
	void		killAllMonster();
	void		pushMonster(TMonsterTypeID_t monsterTypeID, uint8 num, const TAxisPos& pos, TObjUID_t ownerUID);
private:
	void        freshMonster(CMonster* monster);

private:
	TObjUID_t   genObjUID();

private:
	TObjUID_t                       _genObjUID;
	GXMISC::CFixObjPool<CMonster>   _objPool;
	CMapScene*                      _scene;
	std::vector<TAddMonster>		_addMonsters;			// Ìí¼ÓµÄ¹ÖÎï
};

#endif