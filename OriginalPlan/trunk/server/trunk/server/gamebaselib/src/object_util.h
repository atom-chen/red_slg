#ifndef _OBJ_UTIL_H_
#define _OBJ_UTIL_H_

#include "game_util.h"
#include "game_pos.h"
#include "game_struct.h"

typedef struct _ObjInit
{
	TAxisPos axisPos;		// λ��
	TDir_t dir;				// ����
	EObjType type;			// ��������
	TObjUID_t objUID;		// ����UID
	TObjGUID_t objGUID;		// ����GUID
	TMapID_t mapID;			// ��ͼID

	_ObjInit( void )
	{
		cleanUp();
	}

	virtual void cleanUp( )
	{
		axisPos.cleanUp();
		dir = INVALID_DIR;
		type = INVALID_OBJ_TYPE;
		objGUID = INVALID_OBJ_GUID;
		objUID = INVALID_OBJ_UID;
	}
}TObjInit;

class CBufferManager;

typedef struct _CharacterInit : public TObjInit
{
	_CharacterInit()
	{
		job = INVALID_JOB;
		level = 1;
		mp = 0;
		hp = 0;
		exp = 0;
		moveSpeed = INVALID_MOVE_SPEED;
		die = false;
		commSkillID = INVALID_SKILL_TYPE_ID;
		commSkillLevel = INVALID_SKILL_LEVEL;
	}
	bool die;						// �Ƿ�����
	TJob_t job;						// ְҵ
	TLevel_t level;					// �ȼ�
	TMp_t mp;						// ħ��
	THp_t hp;						// Ѫ��
	TExp_t exp;						// ����
	TMoveSpeed_t moveSpeed;			// �ƶ��ٶ�
	TSkillTypeID_t commSkillID;		// ��ͨ����ID
	TSkillLevel_t commSkillLevel;   // ��ͨ���ܵȼ�
	CBufferManager* bufferManager;	// Buffer������
}TCharacterInit;

#endif	// _OBJ_UTIL_H_