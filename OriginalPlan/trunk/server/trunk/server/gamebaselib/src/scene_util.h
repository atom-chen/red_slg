#ifndef _SCENE_UTIL_H_
#define _SCENE_UTIL_H_

#define TILE_BLOCK          0x01  // 阻挡点
#define TILE_ENTRY_BLOCK    0x02  // 人物或者Npc阻挡
#define TILE_OBJECT_BLOCK   0x04  // 物品阻挡

/**
 * \brief 格字数据结构
 */
typedef struct _SrvMapTile
{
  sint8  flags;     // 格子属性
  sint8  type;      // 格子类型
}TSrvMapTile;
typedef TSrvMapTile TTile;
typedef std::vector<TTile> TTiles;

enum EMapDataBlockFlag
{
	BLOCK_FLAG_WALK = 0x1,				// 行走
	BLOCK_FLAG_TRANSPARENT = 0x2,		// 透明
	BLOCK_FLAG_SKILL = 0x4,				// 技能
	BLOCK_FLAG_BATTLE = 0x8,			// 战场
	BLOCK_FLAG_SAFE_ZONE = 0x10,		// 安全区
};

#endif