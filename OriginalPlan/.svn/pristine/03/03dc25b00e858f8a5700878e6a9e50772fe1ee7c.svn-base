#ifndef _GAME_MODULE_H_
#define _GAME_MODULE_H_

#include "time_util.h"
#include "game_struct.h"
#include "msg_base.h"

class CRole;
//class CMonster;
class CCharacterObject;

class CGameMoudle
{
public:
	CGameMoudle(){}
	virtual ~CGameMoudle(){}

public:
	CRole* getRole();
//	CMonster* getMonster();

public:
	virtual bool init(CCharacterObject* chart);	
	virtual bool onLoad(){ return true; }
	virtual void onSave(bool offLineFlag){}
	virtual void update(GXMISC::TDiffTime_t diff){}

protected:
	CCharacterObject* _owner;
};

class CGameRoleModule
{
public:
	CGameRoleModule(){}
	virtual ~CGameRoleModule(){}

public:
	inline CRole* getRole(){return _role;}

public:
	virtual bool init(CRole* role);
	virtual bool onLoad(){ return true; }
	virtual void onSave(bool offLineFlag){}
	virtual void update(GXMISC::TDiffTime_t diff){}
	virtual void onSendData(){}

protected:
	CRole* _role;
};

// class CGameMonsterModule
// {
// public:
// 	CGameMonsterModule(){}
// 	~CGameMonsterModule(){}
// 
// public:
// 	inline CMonster* getMonster(){return _monster;}
// 
// public:
// 	virtual bool init(CMonster* monster);
// 	virtual bool onLoad(){ return true; }
// 	virtual void onSave(bool offLineFlag){}
// 	virtual void update(GXMISC::TDiffTime_t diff){}
// 
// protected:
// 	CMonster* _monster;
// };

#endif		// _GAME_MODULE_H_