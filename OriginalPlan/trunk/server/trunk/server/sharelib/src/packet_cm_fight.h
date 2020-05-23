// @BEGNODOC
#ifndef _PACKET_CM_FIGHT_H_
#define _PACKET_CM_FIGHT_H_
#include "core/types_def.h"
#include "core/stream_impl.h"

#include "game_util.h"
#include "packet_id_def.h"
#include "base_packet_def.h"
#include "game_struct.h"
#include "game_socket_packet_handler.h"
#include "streamable_util.h"
#include "game_pos.h"
#include "bag_struct.h"
#include "object_struct.h"

#pragma pack(push, 1)
// @ENDDOC

/** @defgroup PackFightModule 基础模块
* @{
*/

/** @defgroup PackAttackBroad 攻击广播
* @{
*/
class MCAttackBroad : public CServerPacket
{
public:
	TObjUID_t srcObjUID;							// 攻击者UID
	TObjUID_t destObjUID;							// 攻击目标UID
	TSkillTypeID_t skillID;							// 技能ID
	TAxisPos_t x;									// 攻击位置X
	TAxisPos_t y;									// 攻击位置Y
	CArray1<TObjUID_t, MAX_ATTACKOR_NUM> objs;		// 受击者列表

// 	MCAttackBroad() : CServerPacket(PACKET_MC_ATTACK_BROAD)
// 	{
// 		DCleanPacketStruct(CServerPacket);
// 	}

	DPACKET_BASE_DEF(MCAttackBroad, PACKET_MC_ATTACK_BROAD, CServerPacket);

	TPackLen_t getPackLen()
	{
		totalLen = sizeof(CServerPacket)
			+sizeof(srcObjUID)
			+sizeof(destObjUID)
			+sizeof(skillID)
			+sizeof(x)
			+sizeof(y)
			+objs.sizeInBytes();

		return totalLen;
	}

	DPacketToString5Alias(MCAttackBroad,
		TObjUID_t, SrcObjUID, srcObjUID,
		TObjUID_t, DestObjUID, destObjUID,
		TSkillTypeID_t, SkillID, skillID,
		TAxisPos_t, X, x,
		TAxisPos_t, Y, y);
};
/** @}*/

/** @defgroup PackAttackImpact 攻击效果
* @{
*/
class MCAttackImpact : public CServerPacket
{
public:
	TSkillTypeID_t skillID;
	TPackAttackorList attackors;

	DSvrPacketImpl(MCAttackImpact, PACKET_MC_ATTACK_IMPACT);
	DPacketToString2Alias(MCAttackImpact,
		TSkillTypeID_t, SkillID, skillID,
		TPackAttackorList::size_type, AttackorNum, attackors.size());
};
/** @}*/

class MCObjActionBan : public CServerPacket
{
public:
	TObjUID_t objUID;
	TObjActionBan_t state;

	DSvrPacketImpl(MCObjActionBan, PACKET_MC_OBJ_ACTION_BAN);
};


/** @defgroup PackBuffer Buffer效果
* @{
*/
class MCAddBuffer : public CServerPacket
{
public:
	TPackBufferAry ary;
// 	MCAddBuffer() : CServerPacket(PACKET_MC_ADD_BUFFER)
// 	{
// 		DCleanPacketStruct(CServerPacket);
// 	}

public:
	DPACKET_BASE_DEF(MCAddBuffer, PACKET_MC_ADD_BUFFER, CServerPacket);

	TPackLen_t getPackLen()
	{
		totalLen = sizeof(CServerPacket)
			+ary.sizeInBytes();

		return totalLen;
	}
};
/** @}*/

class MCDelBuffer : public CServerPacket
{
public:
	TObjUID_t objUID;
	CArray2<TBufferTypeID_t, MAX_SEND_BUFFER_NUM> ary;

// 	MCDelBuffer() : CServerPacket(PACKET_MC_DEL_BUFFER)
// 	{
// 		DCleanPacketStruct(CServerPacket);
// 	}

public:
	DPACKET_BASE_DEF(MCDelBuffer, PACKET_MC_DEL_BUFFER, CServerPacket);

	TPackLen_t getPackLen()
	{
		totalLen = sizeof(CServerPacket)
			+sizeof(objUID)
			+ary.sizeInBytes();

		return totalLen;
	}
};

class CMBuffArray : public CRequestPacket
{
public:
	TObjUID_t objUID;

	DReqPacketImpl(CMBuffArray, PACKET_CM_BUFF_ARRAY);
};

class MCBuffArrayRet : public CResponsePacket
{
public:
	TObjUID_t objUID;

	DResPacketImpl(MCBuffArrayRet, PACKET_MC_BUFF_ARRAY_RET);
};

class CMViewBuff : public CRequestPacket
{
public:
	TObjUID_t objUID;
	TBufferTypeID_t buffTypeID;

	DReqPacketImpl(CMViewBuff, PACKET_CM_VIEW_BUFF);
};

class MCViewBuffRet : public CResponsePacket
{
public:
	TPackBuffer buff;

	DResPacketImpl(MCViewBuffRet, PACKET_MC_VIEW_BUFF_RET);
};

// } @buffer 

class CMFightOpenChapter : public CRequestPacket
{
	// @member
public:
	TChapterTypeID chapterTypeID;	///< 关卡ID

	DReqPacketImpl(CMFightOpenChapter, PACKET_CM_FIGHT_OPEN_CHAPTER);
};
class MCFightOpenChapterRet : public CResponsePacket
{
	// @member
public:
	TChapterTypeID chapterTypeID;	///< 关卡ID

	DResPacketImpl(MCFightOpenChapterRet, PACKET_MC_FIGHT_OPEN_CHAPTER_RET);
};

class CMFightFinish : public CRequestPacket
{
	// @member
public:
	sint8 victoryFlag;	///< 胜利标记(-1放弃, 0失败, 1胜利)

	DReqPacketImpl(CMFightFinish, PACKET_CM_FIGHT_FINISH);
};
class MCFightFinishRet : public CResponsePacket
{
public:
	DResPacketImpl(MCFightFinishRet, PACKET_MC_FIGHT_FINISH_RET);
};

/** @}*/
// @BEGNODOC
#pragma pack(pop)

#endif //_PACKET_CM_FIGHT_H_

// @ENDDOC