#ifndef _OBJ_CHARACTER_H_
#define _OBJ_CHARACTER_H_

#include "core/time/interval_timer.h"

#include "obj_dynamic.h"
#include "object_util.h"
#include "char_attribute_core.h"
#include "char_move_core.h"
#include "char_msg_handle.h"
#include "char_skill_core.h"
#include "char_fight_core.h"
#include "char_relation_core.h"
#include "char_ai_core.h"

class CAICharacter;
class CRoleBase;

// 对象属性
class CCharacterObject : public CDynamicObject, public CCharAttributeCoreExt, 
	public CCharMoveCore, public CCharSkillCore, public CCharFightCore, public CCharRelationCore, public CCharAICore
{
public:
	typedef CDynamicObject TBaseType;
	typedef CCharAttributeCoreExt TBaseTypeAttrCore;
	typedef CCharMoveCore TBaseTypeMoveCore;

protected:
	CCharacterObject();
public:
	virtual ~CCharacterObject();

	// 基础接口
public:
	virtual void	cleanUp();
	virtual bool	init( const TCharacterInit* inits );
	virtual bool	update( GXMISC::TDiffTime_t diff );
	virtual bool	updateOutBlock( GXMISC::TDiffTime_t diff );
protected:
private:

	// 场景管理
public:
	virtual void onMoveUpdate(TPackMovePosList* posList, TObjUID_t objUID, TObjType_t objType);	// 移动更新
	virtual void onRegisterToBlock();															// 注册到场景块
	virtual void onEnterScene(CMapSceneBase* pScene);											// 进入场景
	virtual void onLeaveScene(CMapSceneBase* pScene);											// 离开场景
public:
	void resetPos(const TAxisPos* pos, EResetPosType type, bool broadFlag, bool randFlag);		// 瞬移 
protected:
private:

	// 对象管理
public:
	bool isDie();											// 是否已经死亡
	void setDie();											// 设置是否已经死亡
	bool isTimeToLeaveScene(GXMISC::TGameTime_t curTime);	// 是否到了死亡离开场景的时间
public:
	// 获取所有者对象(对于小怪[所有者为大Boss]或宠物[所有者为角色])
	virtual CCharacterObject* getOwner();
	// 获取所有者的ObjectUID
	virtual TObjUID_t getOwnerUID();
	// 设置所有者的ObjectUID
	virtual void setOwnerUID(TObjUID_t objUID);
	// 获取角色所有者
	CRoleBase* getRoleBaseOwner();
	// 将对象转换成角色
	CRoleBase* toRoleBase();
protected:

public:
	GXMISC::TDiffTime_t getLogicTime();			// 获取逻辑时间

protected:
	TObjState_t _objState;						// 角色状态
	CActionBan _banAction;						// 目标行为

protected:
	GXMISC::TDiffTime_t _diff;					// 两次调用update的时间差
	GXMISC::TGameTime_t _lastUpdateTime;		// 上一次更新的时间

private:
	CCharMsgHandle* _msgHandle;					// 消息处理
};

#endif