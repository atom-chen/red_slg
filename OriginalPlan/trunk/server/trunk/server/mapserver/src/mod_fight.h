#ifndef _MOD_FIGHT_H_
#define _MOD_FIGHT_H_

#include "game_module.h"
#include "fight_struct.h"

class CModFight : public CGameRoleModule
{
public:
	CModFight();
	~CModFight();

	//基本接口
public:
	virtual bool onLoad() override;
	virtual void onSendData() override;
	virtual void onSave(bool offLineFlag) override;

	// 事件触发
public:

public:
	TFightRecord* getFightRecrod();

private:
	// 战斗记录
	TFightRecord _fightRecord;	
};

#endif // _MOD_FIGHT_H_