// #ifndef _CONSTANT_DEFINE_H_
// #define _CONSTANT_DEFINE_H_

#if ( !defined(_CONSTANT_DEFINE_H_) || defined(GENERATE_ENUM_STRINGS) )

#if (!defined(GENERATE_ENUM_STRINGS))
#define _CONSTANT_DEFINE_H_
#endif

#include "enum_to_string.h"

_BEGIN_ENUM(Constant)
{
	_E(INVALID_CONSTANTVAR, ""),							///< 无效常量

	//道具
	_E(TREASUREHUNT_ITEM_COMCD, ""),						///< 道具公共CD
	_E(ROLE_MOVE_SPEED, "cj_move"),							///< 角色移动速度

	// 背包
	_E(BUY_GRID_PRICE, "bb_cost"),							///< 单个格子价格
	_E(BAG_INIT_GRIDNUM, "bb_intsum"),						///< 初始格子数量
	_E(BAG_MAX_GRIDNUM, "bb_maxsum"),						///< 背包最大容量

	// 其他
	_E(OT_SCENE_ROLE_NUM, "qpxianshi"),						///< 全屏显示人数

	_E(MAX_CONSTANTVAR, ""),								///< 最大常量值
}
_END_ENUM(Constant)

#endif //_CONSTANT_DEFINE_H_