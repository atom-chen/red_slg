#include "core/game_exception.h"

#include "module_def.h"
#include "map_scene.h"
#include "npc_tbl.h"

bool CMapScene::load()
{
	FUNC_BEGIN(SCENE_MOD);

	TMapNpcVec* npcs = getMapData()->getNpcs();
	for(uint32 num = 0; num < npcs->size(); ++num)
	{
		CNpcConfigTbl* npcRow = DNpcTblMgr.find(npcs->at(num));
		if(NULL == npcRow)
		{
			gxError("Can't find npc row!{0}", npcRow->toString());
			continue;
		}
	};

	return true;

	FUNC_END(false);
}