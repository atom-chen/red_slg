// @BEGNODOC
#ifndef _GAME_UTIL_H_
#define _GAME_UTIL_H_

#include "game_base_util.h"

// @ENDDOC
typedef sint32 THp_t;														///< 血量
static const THp_t INVALID_HP = 0;
typedef sint32 TMp_t;														///< 魔量
static const TMp_t INVALID_MP = 0;
typedef sint32 TStrength_t;													///< 体力
static const TStrength_t INVALID_STRENGTH = 0;
typedef sint32 TDamage_t;													///< 额外伤害
static const TDamage_t INVALID_DAMAGE = 0;
typedef sint32 TPower_t;													///< 力量
static const TPower_t INVALID_POWER = 0;
typedef sint32 TAttackRange_t;												///< 攻击距离
static const TAttackRange_t INVALID_ATTACK_RANGE = 0;
typedef sint32 TAttackSpeed_t;												///< 攻击速度
static const TAttackSpeed_t INVALID_ATTACK_SPEED = 0;
typedef sint32 TExp_t;														///< 经验
static const TExp_t INVALID_EXP = 0;
typedef sint32 TFame_t;														///< 声望
static const TFame_t INVALID_FAME = 0;
typedef sint32 TGold_t;														///< 金钱
static const TGold_t INVALID_GOLD = 0;
typedef sint32 TRmb_t;														///< 元宝
static const TRmb_t INVALID_RMB = 0;
typedef sint16 TMoveSpeed_t;												///< 移动速度
static const TMoveSpeed_t INVALID_MOVE_SPEED = GXMISC::INVALID_SINT16_NUM;
typedef uint16 TSkillTypeID_t;												///< 技能类型ID
static const TSkillTypeID_t INVALID_SKILL_TYPE_ID = 0;
typedef sint8 TSkillLevel_t;												///< 技能等级
static const TSkillLevel_t INVALID_SKILL_LEVEL = 0;

typedef uint8 TAttackImpactType_t;											///< 攻击效果类型
static const TAttackImpactType_t INVALID_ATTACK_IMPACT = INVALID_ATTACK_IMPACT_TYPE;

typedef sint32 TCampID_t;													///< 阵营
static const TCampID_t INVALID_CAMP_ID = 0;

typedef uint16 TRange_t;                                                    ///< 范围
static const TRange_t INVALID_RANGE = 0;

// 属性
typedef sint32 TAttackPhysic_t;												///< 物理攻击
static const TAttackPhysic_t INVALID_ATTACK_PHYSIC = 0;
typedef sint32 TAttackMagic_t;												///< 魔法攻击
static const TAttackMagic_t INVALID_ATTACK_MAGIC = 0;
typedef sint32 TDodge_t;													///< 闪避
static const TDodge_t INVALID_DODGE = 0;
typedef sint32 TDefensePhysic_t;											///< 物理防御
static const TDefensePhysic_t INVALID_DEFENSE_PHYSIC = 0;
typedef sint32 TDefenseMagic_t;												///< 法术防御
static const TDefenseMagic_t INVALID_DEFENSE_MAGIC = 0;
typedef sint32 THit_t;														///< 命中
static const THit_t INVALID_HIT = 0;
typedef sint32 TCrit_t;														///< 暴击
static const TCrit_t INVALID_CRIT = 0;
typedef sint32 TCritHurt_t;													///< 暴击伤害值
static const TCritHurt_t INVALID_CRIT_HURT = 0;
typedef sint32 TSkillHurt_t;												///< 技能伤害
static const TSkillHurt_t INVALID_SKILL_HURT = 0;

typedef uint32 TSaveIndex_t;												///< 角色保存数据的索引标识
static const TSaveIndex_t INVALID_SAVE_INDEX = GXMISC::MAX_UINT32_NUM;

typedef uint16 TItemTypeID_t;												///< 道具类型ID
static const TItemTypeID_t INVALID_ITEM_TYPE_ID = 0;
typedef uint8 TItemType_t;													///< 道具类型
static const TItemType_t INVALID_ITEM_TYPE = 0;
typedef sint16 TItemNum_t;													///< 道具数目
static const TItemNum_t INVALID_ITEM_NUM = 0;
typedef uint32 TItemUID_t;													///< 道具唯一ID
static const TItemUID_t INVALID_ITEM_UID = 0;
// typedef uint8 TItemIndexID_t;												///< 道具索引
// static const TItemIndexID_t INVALID_ITEM_INDEX = 255;
typedef uint8 TItemQuality_t;												///< 道具品质
static const TItemQuality_t INVALID_ITEM_QUALITY = 1;
typedef uint8 TItemBind_t;													///< 道具绑定标识
static const TItemBind_t INVALID_ITEM_BIND = 0;
typedef uint8 TItemContainerSize_t;											///< 道具容器容量
static const TItemContainerSize_t INVALID_ITEM_CONTAINER_SIZE = 0;
typedef uint8 TContainerIndex_t;											///< 道具在容器中的索引
static const TContainerIndex_t INVALID_CONTAINER_INDEX = GXMISC::INVALID_UINT8_NUM;
typedef sint8 TItemStre_t;													///< 物品强化等级
static const TItemStre_t INVALID_ITEM_STRE = 0;


typedef uint16 TEquipItemMarkNum_t;											///< 装备编号ID
static const TEquipItemMarkNum_t INVALID_EQUIPITEM_MARK_ID = 0;
typedef uint8 TEquipItemPositionID_t;										///< 装备位置ID
static const TEquipItemPositionID_t INVALID_EQUIPPOSITION_ID = 0;
typedef uint8 TEquipItemQualityID_t;										///< 装备品阶
static const TEquipItemQualityID_t INVALID_EQUIPQUALITY_ID = 0;
typedef uint16 TEquipItemLvL;												///< 装备等级
static const TEquipItemLvL	INVALID_EQUIP_LVL = 0;

typedef uint16 TPetTypeID_t;												///< 宠物ID
static const TPetTypeID_t INVALID_PET_TYPE_ID = 0;

typedef uint16 TCommanderTypeID_t;											///< 武将编号
static const TCommanderTypeID_t INVALID_COMMANDER_TYPE_ID = 0;

typedef sint16 TOdd_t;														///< 机率类型
static const TOdd_t INVALID_ODD_TYPE_ID = 0;

typedef sint32 TChapterTypeID;											///< 关卡类型ID
static const TChapterTypeID INVALID_CHAPTER_TYPE_ID = 0;

typedef sint32 TRewardTypeID_t;                                             ///< 关卡奖励类型ID
static const TRewardTypeID_t INVALID_REWARD_TYPE_ID = 0;

typedef sint32 TCommanderFTypeID_t;                                         ///< 兵符编号
static const TCommanderFTypeID_t INVALID_COMMANDER_F_TYPE_ID = 0;

typedef uint16	TBuffOdd_t;													///< buffer概率
static const TBuffOdd_t INVALID_BUUUODD = 0;
typedef uint16 TItemFuncID_t;												///< 功能效果ID
static const TItemFuncID_t INVALID_ITEMFUNCID_ID = 0;
typedef uint16 TTouchKeyID_t;												///< 触发文本ID
static const TTouchKeyID_t INVALID_TOUCHKEY_ID = 0;
typedef uint16 TTouchEffectID_t;											///< 触发效果ID
static const TTouchEffectID_t INVALID_TOUCHEFFECT_ID = 0;
typedef uint32 TTouchEffectVar_t;											///< 触发效果值(内容)
static const TTouchEffectVar_t INVALID_TOUCHEFFECT_VAR = 0;

typedef uint8	TGmPower_t;													///< GM权限
static const TGmPower_t			INVALID_GM_POWER = 0;

typedef GXMISC::CFixString<MAX_GM_CMD_LENGTH>	TGmCmdStr_t;				///< GM字符串
static const TGmCmdStr_t	INVALID_GM_CMD_STR;

typedef uint32 TRandDropID_t;												///< 随机掉落ID
static const TRandDropID_t	INVALID_DROP_ID = 0;

typedef uint16 TSkillID_t;													///< 技能ID
static const TSkillID_t	INVALID_SKILL_ID = -1;
typedef uint8 TSkillHand_t;													///< 技能手势
static const TSkillHand_t INVALID_SKILLHAND_ID = -1;
typedef sint32 TSkillDander_t;												///< 怒气
static const TSkillDander_t INVALID_DANDER = 0;
typedef sint32 TEnergy_t;													///< 能量
static const TEnergy_t INVALID_ENERGY = 0;
typedef sint32 TWisdom_t;													///< 智力
static const TWisdom_t INVALID_WISDOM = 0;
typedef sint32 TAgility_t;													///< 敏捷
static const TAgility_t INVALID_AGILITY = 0;
typedef uint8 TSkillType_t;
static const TSkillType_t INVALID_SKILLTYPE = 0;							///< 技能类型
//typedef uint8 TSkillLevel_t;												///< 技能等级
//static const TSkillLevel_t DEFAULT_SKILLLVL = 0;
typedef uint16 TTuneupValue_16EX;											///< 属性调整系数
static const TTuneupValue_16EX INVALID_TUNEUPVALUE_16EX = 0;

typedef uint32 TTuneupValue_32EX;											///< 属性调整系数(扩展)
static const TTuneupValue_32EX INVALID_TUNEUPVALUE_32EX = 0;

typedef uint8 TSkillTarget_t;												///< 技能目标
static const TSkillTarget_t INVALID_SKILLTARGE_ID = 0;
typedef uint16 TSkillDistance_t;											///< 技能攻击距离
static const TSkillDistance_t INVALID_SKILLDISTANCE = 0;
typedef uint8 TSkillState_t;												///< 技能状态
static const TSkillState_t INVALID_SKILLSTATE_ID = 0;
typedef uint32 TMining_t;													///< 炸矿类型
static const TMining_t INVALID_MININGVALUE = 0;

typedef sint32 TSoldierScienceTypeID_t;                                     ///< 小兵科技id
static const TSoldierScienceTypeID_t INVALID_SOLDIER_SCIENCE_TYPE_ID = 0;

//武将属性
typedef sint32 TAttrAttack_t;                                               ///< 攻击
static const TAttrAttack_t INVALID_ATTR_ATTACK_TYPE = 0;
typedef sint32 TAttrHp_t;                                                   ///< 生命
static const TAttrHp_t INVALID_ATTR_HP_TYPE = 0;
typedef sint32 TAttrDefense_t;                                              ///< 防御
static const TAttrDefense_t INVALID_ATTR_DEFENSE_TYPE = 0;
typedef sint32 TAttrSpiritPower_t;                                          ///< 灵力  @TODO  可以去掉的
static const TAttrSpiritPower_t INVALID_ATTR_SPIRIT_POWER_TYPE = 0;
typedef sint32 TAttrPotential_t;                                            ///< 潜力
static const TAttrPotential_t INVALID_ATTR_POTENTIAL_TYPE = 0;
typedef sint32 TAttrLevel_t;                                                ///< 等级
static const TAttrLevel_t INVALID_ATTR_LEVEL_TYPE = 0;
typedef sint32 TAttrTrainPoint_t;                                           ///< 训练点
static const TAttrTrainPoint_t INVALID_ATTR_TRAINPOINT_TYPE = 0;
typedef sint32 TAttrSciencePoint_t;                                         ///< 科技点
static const TAttrSciencePoint_t INVALID_ATTR_SCIENCEPOINT_TYPE = 0;
typedef sint32 TAttrMedicine_t;                                             ///< 魔晶，洗魂点
static const TAttrMedicine_t INVALID_ATTR_MEDICINE_TYPE = 0;

typedef sint32 TSoldierTypeID_t;                                            ///< 小兵id
static const TSoldierTypeID_t INVALID_SOLDIER_TYPE_ID = 0;

typedef sint32	TEmployPoint_t;												///< 雇拥点
static const TEmployPoint_t	INVALID_EMPLOYPOINT = 0;

typedef sint32	TCalluppoint_t;												///< 征召令
static const TCalluppoint_t	INVALID_CALLUPPOINT = 0;

typedef uint16 TMissionTypeID_t;											///< 任务类型ID
static const TMissionTypeID_t INVALID_MISSION_TYPE_ID = 0;

typedef uint32 TStoreMarkNum_t;												///< 商品编号
static const TStoreMarkNum_t	INVALID_STOREITEMMARKNUM = 0;
typedef uint32 TStoreItemNum_t;												///< 商品数量
static const TStoreItemNum_t	INVALID_STOREITEMNUM = 0;
typedef uint32 TstoreCycle_t;												///< 商品活动周期
static const TstoreCycle_t		INVALID_STOREITECYCLE = 0;
typedef uint8 TstoreActType;												///< 商品活动形式
static const TstoreActType		INVALID_STOREITEACTTYPR = 0;

typedef sint32 TVipExp_t;                                                   ///< vip经验值
static const TVipExp_t         INVALID_VIP_EXP = 0;
typedef sint32 TGiftId_t;                                                   ///< 礼包
static  const TGiftId_t        INVALID_GIFT_ID = 0;

typedef sint32 TSoldierNewTypeID_t;											///< 兵种类型id
static const TSoldierNewTypeID_t INVALID_SOLDIER_NEW_TYPE_ID = 0;
typedef sint32 TAttrTypeID_t;												///< 属性类型id
static const TAttrTypeID_t INVALID_ATTR_TYPE_ID = 0;
typedef sint32 TSoldierNewLevelType_t;										///< 兵种等级
static const TSoldierNewLevelType_t INVALID_SOLDIER_NEW_LEVEL_TYPE = 0;

typedef sint32 TCost_t;														///< Cost值
static const TCost_t INVALID_COST = 0;										///< 无效的Cost值

typedef uint16	TRecordeLen_t;												///< 记录长度
static const TRecordeLen_t	INVALID_RECORDE_LEN = 0;

typedef uint8	TRecordeID_t;												///< 日志记录ID
static const TRecordeID_t	INVALID_RECORDE_ID = 0;

typedef GXMISC::CFixString<50> TSerialStr_t;								///< 序列号ID
static const TSerialStr_t INVALID_SERILA_STR = "";

typedef TCharArray2	TChatText_t;											///< 聊天内容		// @TODO丢弃

typedef GXMISC::CFixString<100> TPlatformName_t;							///< 平台名字
static const TPlatformName_t INVALID_PLAT_FORM_NAME;

typedef GXMISC::CFixString<50> TAppendCDKeyString;							///< 激活码后面添加的字符串	// @TODO 丢弃
static const TAppendCDKeyString INVALID_APPEN_KEY_STRING;

typedef GXMISC::CFixString<50> TServerName_t;								///< 服务器名字
static const TServerName_t INVALID_SERVER_NAME;

typedef sint32 TRestrain_t;													///< 小兵克制
static const TRestrain_t INVALID_RESTRAIN_TYPE = 0;

typedef sint16 TCourseGroupType_t;											///< 历程组编号
static const TCourseGroupType_t INVALID_COURSE_GROUP_TYPE = 0;

typedef sint16 TCourseNameType_t;											///< 子历程编号
static const TCourseNameType_t INVALID_COURSE_NAME_TYPE = 0;

typedef sint32 TFinishNumType_t;											///< 完成目标数目
static const TFinishNumType_t INVALID_FINISH_NUM_TYPE = 0;

typedef sint8 TChallengeNum_t;												///< 挑战次数
static const TChallengeNum_t INVALID_CHALLENGE_NUM = 0;

typedef sint16 TRankNum_t;													///< 排名
static const TRankNum_t INVALID_RANK_NUM = 0;

typedef sint32 TDiamodRank_t;                                               ///< 排名钻石碎片
static const TDiamodRank_t INVALId_DIAMOD_RANK = -1;

typedef sint32 TPowerMedicine_t;                                            ///< 体力药剂使用次数
static const TPowerMedicine_t INVALID_POWER_MEDICINE = -1;

typedef sint16 TActive_t;                                                   ///< 活动编号
static const TActive_t INVALID_ACTIVE = 0;

typedef sint16 TKeepDay_t;           ///< 连续签到
static const TKeepDay_t INVALID_KEEP_DAY = 0;

typedef sint32 TXingXiangId_t;       ///< 形象资源Id
static const TXingXiangId_t INVAlID_XING_XIANG_ID = 0;


typedef uint8 TElfId_t;														///< 战灵形象id
static const TElfId_t INVALID_ELF_ID = 0;

typedef sint8 TElfLv_t;														///< 战灵等级
static const TElfLv_t INVALID_ELF_Lv = 0;

typedef sint32 TElfPower_t;                                                 ///< 魂能
static const TElfPower_t INVALID_ELF_POWER = 0;

typedef sint32 TElfExp_t;                                                   ///< 需求经验（其实和魂能是同一个东西）
static const TElfExp_t INVALID_ELF_EXP = 0;

typedef sint16 TLoginDay_t;                                                 ///< 登陆天数
static const TLoginDay_t INVALID_LOGIN_DAY = 0;

typedef uint16 TAnnouncementID_t;											///< 公告ID
static const TAnnouncementID_t INVALID_ANNOUNCEMENT_ID = 0;

typedef uint16 TEmployFreeTime_t;											///< 雇佣免费刷新次数
static const TEmployFreeTime_t INVALID_EMPLOYFREETIME_ID = 0;

typedef uint16 TEndLessGuanQiaID_t;											///< 无尽长廊
static const TEndLessGuanQiaID_t INVALID_ENDLESS_GUANQIA_ID = 0;

typedef uint16 TEndLessAwardID_t;											///< 见识奖励ID
static const TEndLessAwardID_t INVALID_ENDLESS_AWARD_ID = 0;

typedef uint16 TFormationID_t;												///< 阵型ID
static const TFormationID_t INVALID_FORMATION_ID = 0;

typedef TCharArray2 TExchangeGiftID_t;                                      ///< 兑换码Id
static const TExchangeGiftID_t INVALID_EXCHANGE_GIFT_ID = "";

typedef uint32 TExchangeItemID_t;                                           ///< 兑换码对应的礼包id
static const TExchangeItemID_t INVALID_EXCHANGE_ITEM_ID = 0;

typedef sint16 TExchangeConfigId_t;                                         ///< 兑换码兑换id
static const TExchangeConfigId_t INVALID_EXCHANGE_CONFIG_ID = 0;

typedef sint32 TServerOperatorId_t;                                         ///< 系统构造的禁言或分号记录
static const TServerOperatorId_t INVALID_SERVER_OPERTOR_ID = 0;

typedef sint8 TWelfare_type;												///< 开服活动类型
static const TWelfare_type INVALID_WELFARE_TYPE = 0;

typedef uint64 TRewardIndex_t;												///< 奖励表索引id
static const TRewardIndex_t INVALID_REWARD_INDEX = GXMISC::INVALID_UINT64_NUM;

#endif	// @NODOC