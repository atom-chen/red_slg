#ifndef _PACKET_CM_MISSION_H_
#define _PACKET_CM_MISSION_H_

#include "core/types_def.h"
#include "core/stream_impl.h"

#include "game_util.h"
#include "packet_id_def.h"
#include "base_packet_def.h"
#include "game_struct.h"
#include "mission_struct.h"

#pragma pack(push, 1)

/** @defgroup PackMissionModule 任务模块
* @{
*/

/** @defgroup PackUpdateMissionList 更新任务列表
* @{
*/
class MCUpdateMissionList : public CServerPacket, public GXMISC::IStreamableStaticAll<MCUpdateMissionList>
{
	// @member
public:
	CArray1<PackMission> missions;				///< 任务列表

public:
	DPACKET_BASE_DEF(MCUpdateMissionList, PACKET_MC_MISSION_UPDATE, CServerPacket);
	DPACKET_IMPL1(missions);
};
/** @}*/

/** @defgroup PackUpdateMissionParam 更新条件参数(当前杀怪数,当前物品数)
* @{
*/
class MCUpdateMissionParam : public CServerPacket, public GXMISC::IStreamableStaticAll<MCUpdateMissionParam>
{
	// @member
public:
	CArray1<PackMissionParams> params;			///< 任务列表参数

public:
	DPACKET_BASE_DEF(MCUpdateMissionParam, PACKET_MC_MISSION_UPDATE_PARAMS, CServerPacket);
	DPACKET_IMPL1(params);
};
/** @}*/

/** @defgroup PackDeleteMission 删除一个任务
* @{
*/
class MCDeleteMission : public CServerPacket
{
	// @member
public:
	TMissionTypeID_t missionID;			///< 任务ID

public:
	DSvrPacketImpl(MCDeleteMission, PACKET_MC_MISSIONRE_DEL);
};
/** @}*/

/** @defgroup PackMissionOperate (领取/提交)任务操作
* @{
*/
class CMMissionOperate : public CRequestPacket
{
	// @member
public:
	uint8 operateType;					///< 操作类型 参考见: @ref EMissionOperation
	TMissionTypeID_t missionID;			///< 任务ID

public:
	DReqPacketImpl(CMMissionOperate, PACKET_CM_MISSION_OPERATION);
};
class MCMissionOperateRet : public CResponsePacket
{
	// @member
public:
	uint8 operateType;					///< 操作类型 参考见: @ref EMissionOperation
	TMissionTypeID_t missionID;			///< 任务ID

public:
	DResPacketImpl(MCMissionOperateRet, PACKET_MC_MISSION_OPERATION_RET);
};
/** @}*/

/** @}*/


#pragma pack(pop)

#endif	// _PACKET_CM_MISSION_H_