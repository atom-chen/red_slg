#ifndef _MAP_DB_ROLE_DATA_H_
#define _MAP_DB_ROLE_DATA_H_

#include "core/db_filed_parse.h"
#include "core/game_time.h"

#include "db_struct_base.h"
#include "game_struct.h"
#include "map_db_item.h"
#include "user_struct.h"

#include "map_db_mission.h"


#pragma pack(push, 1)

/// 玩家基础数据结构
struct CHumanBaseData : public GXMISC::TDBStructBase
{
public:
	CHumanBaseData();
	~CHumanBaseData();

public:
	TSceneID_t getSceneID() const { return sceneID; } 
	void setSceneID(TSceneID_t val) { sceneID = val; } 
	TSceneID_t getLastSceneID() const { return lastSceneID; } 
	void setLastSceneID(TSceneID_t val) { lastSceneID = val; } 
	TMapID_t getLastMapID() const { return lastMapID; } 
	void setLastMapID(TMapID_t val) { lastMapID = val; } 
	const TAxisPos* getLastMapPos() const { return &lastMapPos; } 
	void setLastMapPos(const TAxisPos* val) { lastMapPos = *val; } 
	TMapID_t getMapID() const { return mapID; } 
	void setMapID(TMapID_t val) { mapID = val; } 
	const TAxisPos* getMapPos() const { return &mapPos; } 
	void setMapPos(const TAxisPos* val) { mapPos = *val; } 
	std::string getRoleName() const { return roleName.toString(); } 
	void setRoleName(std::string val) { roleName = val; } 
	TRoleUID_t getRoleUID() const { return roleUID; } 
	void setRoleUID(TRoleUID_t val) { roleUID = val; } 
	TLevel_t getLevel() const { return level; } 
	void setLevel(TLevel_t val) { level = val; } 
	TObjUID_t getObjUID() const { return objUID; } 
	void setObjUID(TObjUID_t val) { objUID = val; } 
	GXMISC::TGameTime_t getLogoutTime() const { return GXMISC::TGameTime_t(logoutTime); } 
	void setLogoutTime(GXMISC::TGameTime_t val) { logoutTime = val; } 
	sint32 getLoginCountOneDay() const { return loginCountOneDay; } 
	void setLoginCountOneDay(sint32 val) { loginCountOneDay = val; } 
	TAccountID_t getAccountID() const { return accountID; } 
	void setAccountID(TAccountID_t val) { accountID = val; } 
	TRmb_t getRmb() const { return rmb; } 
	void setRmb(TRmb_t val) { rmb = val; } 
	TRmb_t getBindRmb() const { return bindRmb; } 
	void setBindRmb(TRmb_t val) { bindRmb = val; } 
	TGold_t getGameMoney() const { return gameMoney; } 
	void setGameMoney(TGold_t val) { gameMoney = val; } 
	TExp_t getExp() const { return exp; } 
	void setExp(TExp_t val) { exp = val; } 
	TRoleProtypeID_t getProtypeID() const { return protypeID; } 
	void setProtypeID(TRoleProtypeID_t val) { protypeID = val; } 
	TVipLevel_t getVipLevel() const { return vipLevel; } 
	void setVipLevel(TVipLevel_t val){ vipLevel = val; } 
	TVipExp_t getVipExp() const { return vipExp; } 
	void setVipLevel(TVipExp_t val){ vipExp = val; } 
	TItemContainerSize_t getbagOpenGridNum() const { return bagOpenGridNum;} 
	void setbagOpenGridNum(TItemContainerSize_t val) { bagOpenGridNum = val; }
	TRmb_t addChargeRmb(TRmb_t val); 
	TRmb_t getTotalChargeRmb() const { return totalChargeRmb; } 
	void setTotalChargeRmb(TRmb_t val) { totalChargeRmb = val; } 
	TStrength_t getStrength() const { return strength; } 
	void setStrength(TStrength_t val) { strength = val; } 
	std::string getSource_way() const { return source_way.toString(); }	
	void setSource_way(std::string val) { source_way = val; }
	std::string getChisource_way() const { return chisource_way.toString(); }
	void setChisource_way(std::string val) { chisource_way = val; }
	GXMISC::CGameTime getCreateTime() const { return createTime; }
	void setCreateTime(GXMISC::CGameTime val) { createTime = val; }	

public:
	sint32 getOfflineOverunDays(sint8 hour, sint8 mins, sint8 seconds) const; 
	bool isNewRole() const; 

public:
	TRoleUID_t roleUID;						///< 角色UID
	TAccountID_t accountID;					///< 账号ID
	TObjUID_t objUID;						///< 角色对象UID
	TRoleName_t roleName;					///< 角色名字
	TLevel_t level;							///< 角色等级
	TSex_t			sex;					///< 角色性别
	TSceneID_t sceneID;						///< 当前场景ID
	TSceneID_t lastSceneID;					///< 上次场景ID
	TMapID_t lastMapID;						///< 上次地图ID
	TAxisPos lastMapPos;					///< 上次地图坐标
	TMapID_t mapID;							///< 当前地图ID
	TAxisPos mapPos;						///< 当前地图坐标
	GXMISC::CGameTime logoutTime;			///< 登出时间
	GXMISC::CGameTime createTime;			///< 创建时间
	sint32 loginCountOneDay;				///< 一天之内登陆的次数
	TRmb_t rmb;								///< 元宝
	TRmb_t bindRmb;							///< 绑定元宝
	TRmb_t totalChargeRmb;					///< 总共充值的元宝
	TGold_t gameMoney;						///< 游戏币
	TExp_t exp;								///< 经验
	TRoleProtypeID_t protypeID;				///< 原型ID
	TVipLevel_t     vipLevel;               ///< vip等级
	TVipExp_t       vipExp;                 ///< vip经验值
	TStrength_t		strength;				///< 体力值
	TItemContainerSize_t bagOpenGridNum;	///< 背包开放格子数量
	TSourceWayID_t	source_way;				///< 渠道
	TSourceWayID_t	chisource_way;			///< 子渠道
};

#pragma pack(pop)

#endif	// _MAP_DB_ROLE_DATA_H_