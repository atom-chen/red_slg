#ifndef _TBL_DEFINE_H_
#define _TBL_DEFINE_H_

#include "core/time/date_time.h"

#define DTblRootPath()	\
	g_GameConfig.urlPath.toString()+_config.getConfigTblPath()+"/"

#define DFileName(fullPath)	\
	fullPath

#define ConfigRow TiXmlElement

// 读取配置
#define DReadConfigInt(attr, rowName, tabRow)	\
	{	\
	sint32 val = 0;	\
	if(NULL == row->Attribute(#rowName))    \
		{   \
		gxError("Can't parse "#rowName"!Line={0},{1}", count, tabRow->toString());	\
		return false;   \
		}   \
		if(NULL == row->Attribute(#rowName, (int*)&val))	\
		{	\
		gxError("Can't parse "#rowName"!Line={0},{1}", count, tabRow->toString());	\
		return false;	\
		}	\
		tabRow->attr = decltype(tabRow->attr)(val);	\
	}
#define DReadConfigTxt(attr, rowName, tabRow)	\
	{	\
	if(NULL == row->Attribute(#rowName))    \
		{   \
		gxError("Can't parse "#rowName"!Line={0},{1}", count, tabRow->toString());	\
		return false;   \
		}   \
		tabRow->attr = row->Attribute(#rowName);	\
	}
#define DReadConfigIntX(attr, rowName, tabRow)	\
	{	\
	if(NULL == row->Attribute(#rowName))    \
		{   \
		gxError("Can't parse "#rowName"!Line={0},{1}", count, tabRow->toString());	\
		return false;   \
		}   \
		if(!attr.parse(row->Attribute(#rowName), "|"))	\
		{	\
		gxError("Can't parse "#rowName"!Line={0},{1}", count, tabRow->toString());	\
		return false;	\
		}	\
	}
#define DReadConfigIntXNoErr(attr, rowName, tabRow)	\
	{	\
	if(NULL == row->Attribute(#rowName))    \
		{   \
		gxError("Can't parse "#rowName"!Line={0},{1}", count, tabRow->toString());	\
		return false;   \
		}   \
		if(strlen(row->Attribute(#rowName)) != 0){	\
		if(!attr.parse(row->Attribute(#rowName), "|"))	\
			{	\
			gxError("Can't parse "#rowName"!Line={0},{1}", count, tabRow->toString());	\
			return false;	\
			}	\
		}	\
	}

#define DReadDateTime(attr, rowName, tabRow)	\
	{GXMISC::IntX intX;	\
	DReadConfigIntXNoErr(intX, rowName, tabRow);	\
	if(intX.size() > 6){ return false; }	\
	GXMISC::CDateTime dateTime;	\
	sint32 year=0,month=0,day=0,hour=0,mins=0,sec=0; \
	if(intX.size() >= 3){year=intX[0];month=intX[1];day=intX[2];} \
	if(intX.size() >= 4){hour=intX[3];} \
	if(intX.size() >= 5){mins=intX[4];} \
	if(intX.size() >= 6){sec=intX[5];} \
	dateTime.assign(year,month,day,hour,mins,sec);	\
	tabRow->attr=(GXMISC::TGameTime_t)dateTime.utcTime();	\
	}
#define DReadConfigIntXArray2NoErr(attr, rowName, tabRow)	\
	{	\
	if(NULL == row->Attribute(#rowName))    \
		{   \
		gxError("Can't parse "#rowName"!Line={0},{1}", count, tabRow->toString());	\
		return false;   \
		}   \
		if( strlen(row->Attribute(#rowName))!=0 )\
		{\
		if(!attr.parse(row->Attribute(#rowName), ";", "|"))	\
			{	\
			gxError("Can't parse "#rowName"!Line={0},{1}", count, tabRow->toString());	\
			return false;	\
			}	\
		}\
	}
#define DReadConfigIntXArray2(attr, rowName, tabRow)	\
	{	\
	if(NULL == row->Attribute(#rowName))    \
		{   \
		gxError("Can't parse "#rowName"!Line={0},{1}", count, tabRow->toString());	\
		return false;   \
		}   \
		if(!attr.parse(row->Attribute(#rowName), ";", "|"))	\
		{	\
		gxError("Can't parse "#rowName"!Line={0},{1}", count, tabRow->toString());	\
		return false;	\
		}	\
	}
#define DAddToLoader(tempRow)	\
	if(!add(tempRow))	\
	{	\
	gxError("Can't add loader!Line={0},{1}", count, tempRow->toString());	\
	return false;	\
	}
#define DLoaderGet()	\
	const KeyType getRow()	\
	{	\
	return get(1);	\
	}

// 加载配置文件
#define DLoaderConfig(TblName){	\
	std::string tbl##TblName##Name = DTblRootPath()+Tbl##TblName##Name;	\
	static C##TblName##TblLoader loader;	\
	if(false == loader.load(tbl##TblName##Name, configLoaderParam))	\
	{	\
	return false;	\
	}\
	_tblLoaders.push_back((CConfigLoaderBase*)&loader);	\
}

#define DConfigFind()	\
	ValueType findByKey(const TBaseType::KeyType& key){ return find(key); }

extern const char* TblNewRoleName;						// 新角色表名
extern const char* TblCommanderName;					// 武将表名
extern const char* TblMapName;							// 地图名字
extern const char* TblPetName;							// 宠物表名
extern const char* TblFormationName;					// 阵法表
extern const char* TblSoliderName;						// 小兵表格
extern const char* TblEmployName;						// 招募概率表
extern const char* TblEmployMrName;						// 招募默认表
extern const char* TblTreasurehuntName;					// 寻宝表名
extern const char* TblGuanQiaName;                      // 关卡表名
extern const char* TblStarName;                         // 星级评星表名
extern const char* TblItemName;						// 背包道具表名
extern const char* TblRandRoleNameName;					// 随机名字表
extern const char* TblTokenName;                        // 兵符表
extern const char* TblFormationLvName;                  // 兵符等级表
extern const char* TblRandDropName;						// 随机掉落
extern const char* TblRewardName;                       // 奖励物品表
extern const char* TblConstantName;						// 常量表
extern const char* TblTransportName;					// 传送点表
extern const char* TblNpcName;							// NPC表
extern const char* TblScienceName;                      // 小兵科技表 
extern const char* TblPartnerSkillName;					// 武将技能
extern const char* TblRoleSkillName;					// 角色技能
extern const char* TblBufferName;						// Buffer表名
extern const char* TblMiningName;						// 炸矿玩法
extern const char* TblLevelUpName;						// 升级表名
extern const char* TblPetStyleName;                     // 宠物类型表
extern const char* TblMallName;							// 商城表
extern const char* TblMissionName;						// 任务表名
extern const char* TblVipName;                          // vip表
extern const char* TblSoldieradvName;                   // 新兵种科技进阶表
extern const char* TblTechnologyName;                   // 新兵种科技表
extern const char* TblCourseName;                       // 历程表
extern const char* TblNewBieRewardName;					// 新手奖励表
extern const char* TblEquipMentName;					// 装备表
extern const char* TblEquipStrengName;					// 装备强化表
extern const char* TblHeroRankListLevelAwardName;		// 英雄榜等级奖励
extern const char* TblHeroRankListDayAwardName;			// 英雄榜每日奖励
extern const char* TblActivityName;                     // 活动表
extern const char* TblRegistName;                       // 签到表
extern const char* TblElfName;                          // 战灵形象表
extern const char* TblElflvName;                        // 战灵等级表
extern const char* TblAnnouncementName;					// 公告表
extern const char* TblWindowName;                       // 窗口按钮表
extern const char* TblEndlessGuanQiaName;				// 无尽长廊表
extern const char* TblEndlessAwardName;					// 无尽长廊奖励表
extern const char* TblEndlessRankName;					// 无尽长廊奖励表
extern const char* TblZhangjieName;                     // 章节表
extern const char* TblUpgradeName;                      // 突进表
extern const char* TblFormationNewName;					// 阵型表
extern const char* TblDhmName;                          // 兑换码表
extern const char* TblWelfareName;                      // 福利表

#endif	// _TBL_DEFINE_H_