#ifndef _SCENE_UTIL_H_
#define _SCENE_UTIL_H_

#define TILE_BLOCK          0x01  // �赲��
#define TILE_ENTRY_BLOCK    0x02  // �������Npc�赲
#define TILE_OBJECT_BLOCK   0x04  // ��Ʒ�赲

/**
 * \brief �������ݽṹ
 */
typedef struct _SrvMapTile
{
  sint8  flags;     // ��������
  sint8  type;      // ��������
}TSrvMapTile;
typedef TSrvMapTile TTile;
typedef std::vector<TTile> TTiles;

enum EMapDataBlockFlag
{
	BLOCK_FLAG_WALK = 0x1,				// ����
	BLOCK_FLAG_TRANSPARENT = 0x2,		// ͸��
	BLOCK_FLAG_SKILL = 0x4,				// ����
	BLOCK_FLAG_BATTLE = 0x8,			// ս��
	BLOCK_FLAG_SAFE_ZONE = 0x10,		// ��ȫ��
};

#endif