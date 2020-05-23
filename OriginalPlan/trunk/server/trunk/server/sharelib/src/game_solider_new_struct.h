// @BEGNODOC
#ifndef _GAME_SOLDER_NEW_STRUCT_H_
#define _GAME_SOLDER_NEW_STRUCT_H_

#include "core/stream_traits.h"
#include "core/array.h"

#include "game_util.h"
#include "game_define.h"
#include "packet_struct.h"
#include "base_packet_def.h"
#include "attributes.h"
#include "streamable_util.h"


#pragma pack(push, 1)
// @ENDDOC

typedef struct _attrTypeDb
{
	// @member
public:
	TAttrTypeID_t                   attrType;            ///< 兵种属性类型(攻击，防御，血量，克制）
	sint32                          level;               ///< 等级	
}TAttrTypeDb;                                                ///< 小兵属性
typedef CArray1< struct _attrTypeDb > TAttrTypeDbAry;      ///< 小兵属性列表


typedef struct _soldierNewDb
{
	// @member
public:
	TSoldierNewTypeID_t             soldierType;         ///< 兵种类型（枪兵，步兵，弓兵） 
	TSoldierNewLevelType_t          soliderLevel;                    ///< 兵种等级
	TAttrTypeDbAry                  attrTypeAry;         ///< 属性列表

}TSoldierNewDb;                                              ///< 小兵
typedef CArray1<struct _soldierNewDb> TSoldierNewDbAry;    ///< 小兵列表


typedef struct _attrType
{
	// @member
public:
	TAttrTypeID_t                   attrType;            ///< 兵种属性类型(攻击，防御，血量，克制）
	sint32                          level;               ///< 等级	
}TAttrType;                                                  ///< 小兵属性
typedef std::vector< struct _attrType > TAttrTypeVec;        ///< 小兵属性列表


typedef struct _soldierNew
{
	// @member
public:
	TSoldierNewTypeID_t             soldierType;         ///< 兵种类型（枪兵，步兵，弓兵）   
	TSoldierNewLevelType_t          soliderLevel;                    ///< 兵种等级
	TAttrTypeVec                    attrTypeVec;         ///< 属性列表

}TSoldierNew;                                                ///< 小兵
typedef std::vector<struct _soldierNew> TSoldierNewVec;      ///< 小兵列表



typedef struct _attrTypePacket
{
	// @member
public:
	TAttrTypeID_t                   attrType;                ///< 兵种属性类型(攻击，防御，血量，克制）
	sint32                          level;                   ///< 等级	
}TAttrTypePacket;                                              ///< 小兵属性
typedef CArray1< struct _attrTypePacket > TAttrTypePacketAry;  ///< 小兵属性列表


typedef struct _soldierNewPacket
{
	// @member
public:
	TSoldierNewTypeID_t             soldierType;             ///< 兵种类型（枪兵，步兵，弓兵）   
	TSoldierNewLevelType_t          soliderLevel;            ///< 兵种等级
	TAttrTypePacketAry              attrTypeAry;             ///< 属性列表

}TSoldierNewPacket;                                              ///< 小兵
typedef CArray1<struct _soldierNewPacket> TSoldierNewPacketAry;  ///< 小兵列表




// @BEGNODOC
#pragma pack(pop)

#endif
// @ENDDOC