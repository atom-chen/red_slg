#ifndef _SKILL_IMPACT_MANAGER_H_
#define _SKILL_IMPACT_MANAGER_H_

#include "singleton.h"
#include "time_util.h"
#include "hash_util.h"
#include "game_util.h"
#include "packet_cm_fight.h"

typedef struct _AttackImpactDelay
{
	uint32 SN;						// 攻击效果唯一序号
	TObjUID_t objUID;				// 攻击者UID
	MCAttackImpact impacts;			// 攻击效果列表
	GXMISC::TDiffTime_t diff;		// 攻击效果延时时间
	bool attackBackFlag;			// 击退效果
}TAttackImpactDelay;

typedef CHashMap<uint32, TAttackImpactDelay> TAttackImpactPacketList;

class CMapSceneBase;

// 技能效果延时列表
class CAttackImpactPacketManager
{
public:
	void initMe(CMapSceneBase* pScene);
	void addImpact(TAttackImpactDelay& delay);
	void update(GXMISC::TDiffTime_t diff);
	void doImpact(uint32 SN, TObjUID_t objUID);
	uint32 genSN();

private:
	TAttackImpactPacketList _attackImpactPacketList;
	uint32 _randSN;
	CMapSceneBase* _scene;
};

#endif