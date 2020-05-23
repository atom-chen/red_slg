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
	TAttrTypeID_t                   attrType;            ///< ������������(������������Ѫ�������ƣ�
	sint32                          level;               ///< �ȼ�	
}TAttrTypeDb;                                                ///< С������
typedef CArray1< struct _attrTypeDb > TAttrTypeDbAry;      ///< С�������б�


typedef struct _soldierNewDb
{
	// @member
public:
	TSoldierNewTypeID_t             soldierType;         ///< �������ͣ�ǹ���������������� 
	TSoldierNewLevelType_t          soliderLevel;                    ///< ���ֵȼ�
	TAttrTypeDbAry                  attrTypeAry;         ///< �����б�

}TSoldierNewDb;                                              ///< С��
typedef CArray1<struct _soldierNewDb> TSoldierNewDbAry;    ///< С���б�


typedef struct _attrType
{
	// @member
public:
	TAttrTypeID_t                   attrType;            ///< ������������(������������Ѫ�������ƣ�
	sint32                          level;               ///< �ȼ�	
}TAttrType;                                                  ///< С������
typedef std::vector< struct _attrType > TAttrTypeVec;        ///< С�������б�


typedef struct _soldierNew
{
	// @member
public:
	TSoldierNewTypeID_t             soldierType;         ///< �������ͣ�ǹ����������������   
	TSoldierNewLevelType_t          soliderLevel;                    ///< ���ֵȼ�
	TAttrTypeVec                    attrTypeVec;         ///< �����б�

}TSoldierNew;                                                ///< С��
typedef std::vector<struct _soldierNew> TSoldierNewVec;      ///< С���б�



typedef struct _attrTypePacket
{
	// @member
public:
	TAttrTypeID_t                   attrType;                ///< ������������(������������Ѫ�������ƣ�
	sint32                          level;                   ///< �ȼ�	
}TAttrTypePacket;                                              ///< С������
typedef CArray1< struct _attrTypePacket > TAttrTypePacketAry;  ///< С�������б�


typedef struct _soldierNewPacket
{
	// @member
public:
	TSoldierNewTypeID_t             soldierType;             ///< �������ͣ�ǹ����������������   
	TSoldierNewLevelType_t          soliderLevel;            ///< ���ֵȼ�
	TAttrTypePacketAry              attrTypeAry;             ///< �����б�

}TSoldierNewPacket;                                              ///< С��
typedef CArray1<struct _soldierNewPacket> TSoldierNewPacketAry;  ///< С���б�




// @BEGNODOC
#pragma pack(pop)

#endif
// @ENDDOC