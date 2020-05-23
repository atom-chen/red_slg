#ifndef _OBJECT_STRUCT_H_
#define _OBJECT_STRUCT_H_

#include "core/stream_traits.h"
#include "core/carray.h"

#include "game_util.h"
#include "game_define.h"
#include "packet_struct.h"
#include "base_packet_def.h"
#include "attributes.h"
#include "streamable_util.h"

#pragma pack(push, 1)

/// 角色详细数据
typedef struct RoleDetail : public GXMISC::IStreamableAll
{
	// @member
public:
	// 基础
	TObjUID_t			objUID;							///< 对象UID
	TRoleUID_t         	roleUID;						///< 角色UID
	TRoleProtypeID_t	protypeID;						///< 原型ID
	TRoleName_t			name;							///< 姓名
	TLevel_t			level;							///< 等级
	TSex_t				sex;							///< 性别 @ref ESexType
	TExp_t				maxExp;							///< 经验最大值
	TExp_t	            exp;                			///< 经验
	TGold_t             gold;               			///< 金钱
	TRmb_t              rmb;                			///< 元宝
	TMapID_t			mapID;							///< 地图ID
	TAxisPos_t			xPos;							///< X位置
	TAxisPos_t			yPos;							///< Y位置
	TDir_t				dir;							///< 方向 @ref EDir2

	// 战斗
	TMoveSpeed_t		moveSpeed;						///< 移动速度
	THp_t				maxHp;							///< 最大血量
	THp_t				curHp;							///< 当前血量
	TEnergy_t			maxEnergy;						///< 最大能量
	TEnergy_t			curEnergy;						///< 当前体力值
	TPower_t			power;       					///< 力量
	TAgility_t			agility;      					///< 敏捷
	TWisdom_t           wisdom;               			///< 智力
	TStrength_t			physical;						///< 体力
	TAttackPhysic_t		attack;							///< 普通攻击
	TAttackPhysic_t		skillAttack;					///< 技能攻击
	TDamage_t			damage;							///< 额外伤害
	TCrit_t				crit;							///< 暴击
	TDefensePhysic_t	defense;						///< 防御
	TDamage_t			damageReduce;					///< 伤害减免
	TDodge_t			dodge;							///< 闪避

	//	TPetTypeID_t		petTypeID;						///< 宠物类型ID
	//	TLevel_t			vipLevel;						///< VIP等级
	//	TExp_t				vipExp;                         ///< vip经验值	

public:
	DSTREAMABLE_IMPL1(name);

}TRoleDetail;

#pragma pack(pop)

#endif	// _OBJECT_STRUCT_H_