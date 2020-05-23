#ifndef _GAME_CONFIG_H_
#define _GAME_CONFIG_H_

#include "core/types_def.h"
#include "core/string_parse.h"
#include "core/carray.h"

class CGameConfig
{
	// 世界服务器参数
public:
	uint32 loginPlayerNum;					// 一次性登陆的玩家个数
	uint32 loginPlayerInterval;				// 处理loginplayer的时间间隔
	uint32 maxWServerStatTime;				// 世界服务器统计时间
	uint32 maxWorldRoleHeartOutTime;		// 世界服务器角色心跳超时时间

	// 地图服务器参数
public:
	uint32 maxMapPlayerDataLenght;			// 地图连接数据最大缓存长度
	uint32 monsterDieLeaveSceneTime;		// 怪物死亡后离开场景时间
	uint32 blockSize;						// 块大小
	uint32 broadcastRange;					// 广播时搜索范围
	uint32 maxLoginReadyTimes;				// 角色登陆的最大等待时间
	uint32 maxLogoutTimes;					// 角色登出的最大等待时间
	uint32 maxSceneRoleNum;					// 场景最大的角色数目

	// 怪物参数
public:
	uint32 monDamageCheckTime;				// 怪物伤害检测间隔(增加仇恨)
	uint32 monRandMoveTime;					// 怪物随机移动时间
	uint32 maxMonRandMoveRange;				// 怪物随机移动范围
	uint32 useAssistSkillAddHate;			// 使用辅助技能会对怪物增加多少仇恨值
	uint32 maxMonApproachDis;				// 怪物超过多远不再追击

	// 战斗参数
public:
	uint32 skillAttackBackRange;			// 技能击退距离
	uint32 randKillRoleStateTime;			// 乱杀的持续时间

public:
	// 公用参数
	bool iniFileUncrypt;					// 配置文件是否加密
	uint32 packSendHandle;					// 包发送是否需要处理
	uint32 packReadHandle;					// 包接收是否需要处理
	uint32 maxSocketHandlerPackNumPerSec;	// 每秒钟客户端能发送的数据包
	GXMISC::CCharArray<1024> urlPath;		// 资源路径

	// 调试开关
public:
	std::vector<GXMISC::CStringParse<std::string> >	dbgOption;
	uint32 dbgEnterView;

	enum EDbgOption
	{
		DBG_OPTION_ENTER_VIEW,
	};

public:
	void setBlockSize(uint32 val);
	// 获取同屏
	uint8 getSameScreenRadius();
	void setBroadcastRange(uint32 val);
};

extern CGameConfig g_GameConfig;

#endif