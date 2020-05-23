#ifndef _ITEM_DEIFINE_H
#define _ITEM_DEIFINE_H

#include <string>

/// @brief 背包类型
enum EPackType
{
	PACK_TYPE_INVALID = 0,		///< 无效
	PACK_TYPE_BAG = 1,			///< 背包
	PACK_TYPE_EQUIP = 2,		///< 装备

// 	PACK_TYPE_STORAGE,			///< 仓库
// 	PACK_TYPE_TEMP,				///< 临时
// 	PACK_TYPE_MISSION,          ///< 任务
// 	PACK_TYPE_EXCHANGE,			///< 交易
// 	PACK_TYPE_GUILD,			///< 帮会仓库

	PACKET_TABLE_TYPE_NUMBER,	///< 背包类型数目
};
DToStringDef(EPackType);

/// 大类
enum EItemType
{
	ITEM_TYPE_INVALID = 0,		///< 无效类型
	ITEM_TYPE_EQUIP = 1,		///< 装备, 双击使用后会装备到角色身上
	ITEM_TYPE_DRUG = 2,			///< 药品, 双击后物品消失并增加药效
	ITEM_TYPE_CONSUME = 3,		///< 消耗, 不可双击使用
	ITEM_TYPE_SCROLL = 4,		///< 卷轴, 可双击使用, 并触发脚本
	ITEM_TYPE_SKILL_BOOK = 5,	///< 技能书, 可双击使用
	ITEM_TYPE_GEM = 6,			///< 宝石, 可双击使用
	ITEM_TYPE_BUFFER = 7,		///< Buffer, 可双击使用

	ITEM_TYPE_NUMBER,			///< 物品的类别数量
};
DToStringDef(EItemType);

/// 道具数据类型
// enum EItemDataType
// {
// 	IDT_INVALID,					// 无效
// 	IDT_ITEM,						// 物品
// 	IDT_PET,						// 宠物
// };

/// 装备操作类型
enum EOptEquipType
{
	OPT_EQUIP_INVALID = 0,
	OPT_EQUIP_CAN,					// 可以强化装备
	OPT_EQUIP_CAN_NOT,				// 不可以强化装备
};
DToStringDef(EOptEquipType);

/// 道具摧毁限制
enum EDestroyType
{
	DESTROY_TYPE_CAN = 1,			// 能摧毁
	DESTROY_TYPE_CANT = 2,			// 不能摧毁
};
DToStringDef(EDestroyType);

/// 道具出售限制
enum ESellLimit
{
	SELL_LIMIT_CAN = 1,				// 可出售
	SELL_LIMIT_CANT = 2,			// 不可出售
};
DToStringDef(ESellLimit);

/// 职业限制
enum EJobLimit
{
	JOB_LIMIT_NORMAL = 4,			// 无限制
};
DToStringDef(EJobLimit);

/// 性别限制
enum ESexLimit
{
	SEX_LIMIT_MALE = 1,				// 男
	SEX_LIMIT_FEMALE = 2,			// 女
	SEX_LIMIT_NORMAL = 3,			// 无限制
};
DToStringDef(ESexLimit);

/// 装备子类型
enum EEquipType
{
	EQUIP_TYPE_INVALID = 0,		///< 无效位置
	EQUIP_TYPE_START = 1,		///< 开始装备
	EQUIP_TYPE_ARM = 1,			///< 武器
	EQUIP_TYPE_ARMET = 2,		///< 头盔
	EQUIP_TYPE_SHOULDER,		///< 护肩
	EQUIP_TYPE_ARMOR,			///< 护甲
	EQUIP_TYPE_BELT,			///< 腰带
	EQUIP_TYPE_LEG,				///< 护腿
	EQUIP_TYPE_BOOTS,			///< 靴子
	EQUIP_TYPE_NECKLACE,		///< 项链
	EQUIP_TYPE_GALLUS,			///< 吊坠
	EQUIP_TYPE_RING,			///< 戒指
	EQUIP_TYPE_WRIST,			///< 护腕
	EQUIP_TYPE_GLOVE,			///< 手套
	EQUIP_TYPE_FASHION,			///< 时装
	EQUIP_TYPE_NUMBER,			///< 装备类型数目
	EQUIP_TYPE_POS_NUM = EQUIP_TYPE_NUMBER + 1,	///< 装备位置总数
};
DToStringDef(EEquipType);

/// 药品子类
enum EDrugSubClass
{
	DRUG_SUB_CLASS_HP = 1,			///< 人物红
	DRUG_SUB_CLASS_MP,				///< 人物蓝
	DRUG_SUB_CLASS_PET_HP,			///< 宠物红
};
DToStringDef(EDrugSubClass);

/// 消耗
enum EConsumeSubClass
{
	CONSUME_SUB_CLASS_TASK = 1,		///< 任务道具
	CONSUME_SUB_CLASS_RELIVE,		///< 复活令
	CONSUME_SUB_CLASS_HORN,			///< 小喇叭
	CONSUME_SUB_CLASS_FLY_SHOES,	///< 小飞鞋
	CONSUME_SUB_CLASS_TAN_HE_LING,	///< 弹劾令
	CONSUME_SUB_CLASS_TONG_YA_LING,	///< 通涯令
	CONSUME_SUB_CLASS_TRAVEL_CARD,	///< 环游卡
	CONSUME_SUB_CLASS_CROP,			///< 种子
	CONSUME_SUB_CLASS_SHOVEL,		///< 铲子
};
DToStringDef(EConsumeSubClass);

/// 技能书
enum ESkillBookSubClass
{
	SKILL_BOOK_SUB_CLASS_ROLE,			///< 人物技能书
	SKILL_BOOK_SUB_CLASS_PET,			///< 宠物技能书
};
DToStringDef(ESkillBookSubClass);

/// 宝石
enum EGemSubClass
{
	GEM_SUB_CLASS_INVALID = 0,			///< 无效类型
	GEM_SUB_CLASS_INLAY,				///< 镶嵌
	GEM_SUB_CLASS_WASH,					///< 洗练
	GEM_SUB_CLASS_RISE_STAR,			///< 升星石
	GEM_SUB_CLASS_ATTR,					///< 属性石
	GEM_SUB_CLASS_GROW_UP,				///< 成长石
	GEM_SUB_CLASS_LOCK_ATTR,			///< 属性锁
};
DToStringDef(EGemSubClass);


/// Buffer
enum EBufferSubClass
{
	BUFF_SUB_INVALID = 0,				///< 无效类型
	BUFF_SUB_ITEM,						///< buff丹
	BUFF_SUB_ROLE_HP,					///< 人物红球
	BUFF_SUB_ROLE_MP,					///< 人物蓝球
	BUFF_SUB_PET_HP,					///< 宠物红球
	BUFF_SUB_ROLE_EXP,					///< 人物加倍经验卡
	BUFF_SUB_ROLE_GOLD,					///< 人物加倍银子卡
};
DToStringDef(EBufferSubClass);

/// 卷轴
enum EScrollSubClass
{
	SCROLL_SUB_INVALID = 0,				///< 无效类型
// 	SCROLL_SUB_OPEN_CHARM = 1,			///< 开启符
// 	SCROLL_SUB_FORGE = 2,				///< 坐骑锻造丹
// 	SCROLL_SUB_FLY = 3,					///< 小飞鞋
// 	SCROLL_SUB_BAG_EXTEND = 4,			///< 背包扩展符
// 	SCROLL_SUB_STORAGE_EXTEND = 5,		///< 仓库扩展符
// 	SCROLL_SUB_VIP = 6,					///< VIP卡
// 	SCROLL_SUB_CREATE_GUILD = 7,		///< 建帮令
// 	SCROLL_SUB_GIFT = 8,				///< 礼包
// 	SCROLL_SUB_CLASS_DISMANTLE = 9,		///< 钳子
// 	SCROLL_SUB_PET_EGG = 10,			///< 宠物蛋
// 	SCROLL_SUB_FAR_STORAGE = 11,		///< 远程仓库
// 	SCROLL_SUB_FAR_SHOP = 12,			///< 远程商店
// 	SCROLL_SUB_HORSE_PROPERTY = 13,		///< 坐标道具
// 	SCROLL_SUB_RANDOM_PROPERTY = 14,	///< 随机道具
// 	SCROLL_SUB_NEW_YEAR = 15,			///< 年之部件
};
DToStringDef(EScrollSubClass);

/// 装备品质
enum EEquipQuality
{
	EQUIP_QUALITY_INVALID = 0,			///< 无效类型
	EQUIP_QUALITY_WRITE = 1,			///< 白色装备
	EQUIP_QUALITY_GREEN = 2,			///< 绿色装备
	EQUIP_QUALITY_BLUE = 3,				///< 蓝色装备
	EQUIP_QUALITY_PURPLE = 4,			///< 紫色装备

	EQUIP_QUALITY_NUMBER,
};
DToStringDef(EEquipQuality);

/// 宝石品质
enum EGemQuality
{
	GEM_QUALITY_ONE = 1,				///< 一级宝石
	GEM_QUALITY_TWO = 2,				///< 二级宝石
	GEM_QUALITY_THR = 3,				///< 三级宝石
	GEM_QUALITY_FOUR = 4,				///< 四级宝石
	GEM_QUALITY_FIVE = 5,				///< 五级宝石
	GEM_QUALITY_SIX = 6,				///< 六级宝石

	GEM_QUALITY_NUMBER,					///< 品质总数
};
DToStringDef(EGemQuality);

/// 物品扩展最大数
enum EItemExtremum
{
	ITEM_EXTREMUM_MAX_STRE_LEVEL = 12,		///< 
	ITEM_EXTREMUM_MAX_APPEND_NUM = 9,		///< 
};
DToStringDef(EItemExtremum);

/// 绑定类型
enum EBindType
{
	BIND_TYPE_INVALID = 0,							///< 无效的绑定
	BIND_TYPE_UNBIND = 1,							///< 非绑定
	BIND_TYPE_BIND,									///< 绑定
	BIND_TYPE_EQUIP,								///< 装备绑定
};
DToStringDef(EBindType);

/// 物品绑定类型, 不允许修改 ！！！
enum EItemAttrBindType
{
	ITEM_ATTR_TYPE_INVALID = 0,							///< 无效绑定类型
	ITEM_ATTR_TYPE_UNBIND = BIND_TYPE_UNBIND,           ///< 非绑定       
	ITEM_ATTR_TYPE_BIND = BIND_TYPE_BIND,               ///< 绑定
	ITEM_ATTR_TYPE_BIND_ALL,							///< 所有
};
DToStringDef(EItemAttrBindType);

/// 物品扩展属性
enum EItemExtAttrType
{
	ITEM_ATTR_EXT_TYPE_BIND = 1,					///< 绑定规则
	ITEM_ATTR_EXT_TYPE_STRE = 2,					///< 强化规则
};
DToStringDef(EItemExtAttrType);

/// 奖励类型
enum EAwardType
{
	AWARD_INVALID = 0,			///< 无效奖励类型
	AWARD_EXP,					///< 经验
	AWARD_MONEY,				///< 游戏币
	AWARD_RMB,					///< 元宝
	AWARD_BIND_RMB,				///< 绑定元宝
	AWARD_ITEM,					///< 物品
};
DToStringDef(EAwardType);

/// @brief 背包操作类型
enum EBagOperateType
{
	BAG_OPERATE_TYPE_INVALID = 0,		///< 无效操作类型
	BAG_OPERATE_TYPE_DROP = 1,			///< 丢弃
	BAG_OPERATE_TYPE_USE = 2,			///< 使用
	BAG_OPERATE_TYPE_SELL = 3,			///< 出售
	BAG_OPERATE_TYPE_PACK_UP = 4,		///< 整理
	BAG_OPERATE_TYPE_REQ_ALL = 5,		///< 请求背包所有道具
};

#endif //_ITEM_DEIFINE_H