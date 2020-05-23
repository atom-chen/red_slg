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

// ��������
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

	// �����ӿ�
public:
	virtual void	cleanUp();
	virtual bool	init( const TCharacterInit* inits );
	virtual bool	update( GXMISC::TDiffTime_t diff );
	virtual bool	updateOutBlock( GXMISC::TDiffTime_t diff );
protected:
private:

	// ��������
public:
	virtual void onMoveUpdate(TPackMovePosList* posList, TObjUID_t objUID, TObjType_t objType);	// �ƶ�����
	virtual void onRegisterToBlock();															// ע�ᵽ������
	virtual void onEnterScene(CMapSceneBase* pScene);											// ���볡��
	virtual void onLeaveScene(CMapSceneBase* pScene);											// �뿪����
public:
	void resetPos(const TAxisPos* pos, EResetPosType type, bool broadFlag, bool randFlag);		// ˲�� 
protected:
private:

	// �������
public:
	bool isDie();											// �Ƿ��Ѿ�����
	void setDie();											// �����Ƿ��Ѿ�����
	bool isTimeToLeaveScene(GXMISC::TGameTime_t curTime);	// �Ƿ��������뿪������ʱ��
public:
	// ��ȡ�����߶���(����С��[������Ϊ��Boss]�����[������Ϊ��ɫ])
	virtual CCharacterObject* getOwner();
	// ��ȡ�����ߵ�ObjectUID
	virtual TObjUID_t getOwnerUID();
	// ���������ߵ�ObjectUID
	virtual void setOwnerUID(TObjUID_t objUID);
	// ��ȡ��ɫ������
	CRoleBase* getRoleBaseOwner();
	// ������ת���ɽ�ɫ
	CRoleBase* toRoleBase();
protected:

public:
	GXMISC::TDiffTime_t getLogicTime();			// ��ȡ�߼�ʱ��

protected:
	TObjState_t _objState;						// ��ɫ״̬
	CActionBan _banAction;						// Ŀ����Ϊ

protected:
	GXMISC::TDiffTime_t _diff;					// ���ε���update��ʱ���
	GXMISC::TGameTime_t _lastUpdateTime;		// ��һ�θ��µ�ʱ��

private:
	CCharMsgHandle* _msgHandle;					// ��Ϣ����
};

#endif