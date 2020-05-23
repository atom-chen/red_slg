#ifndef _TBL_DEFINE_H_
#define _TBL_DEFINE_H_

#include "core/time/date_time.h"

#define DTblRootPath()	\
	g_GameConfig.urlPath.toString()+_config.getConfigTblPath()+"/"

#define DFileName(fullPath)	\
	fullPath

#define ConfigRow TiXmlElement

// ��ȡ����
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

// ���������ļ�
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

extern const char* TblNewRoleName;						// �½�ɫ����
extern const char* TblCommanderName;					// �佫����
extern const char* TblMapName;							// ��ͼ����
extern const char* TblPetName;							// �������
extern const char* TblFormationName;					// �󷨱�
extern const char* TblSoliderName;						// С�����
extern const char* TblEmployName;						// ��ļ���ʱ�
extern const char* TblEmployMrName;						// ��ļĬ�ϱ�
extern const char* TblTreasurehuntName;					// Ѱ������
extern const char* TblGuanQiaName;                      // �ؿ�����
extern const char* TblStarName;                         // �Ǽ����Ǳ���
extern const char* TblItemName;						// �������߱���
extern const char* TblRandRoleNameName;					// ������ֱ�
extern const char* TblTokenName;                        // ������
extern const char* TblFormationLvName;                  // �����ȼ���
extern const char* TblRandDropName;						// �������
extern const char* TblRewardName;                       // ������Ʒ��
extern const char* TblConstantName;						// ������
extern const char* TblTransportName;					// ���͵��
extern const char* TblNpcName;							// NPC��
extern const char* TblScienceName;                      // С���Ƽ��� 
extern const char* TblPartnerSkillName;					// �佫����
extern const char* TblRoleSkillName;					// ��ɫ����
extern const char* TblBufferName;						// Buffer����
extern const char* TblMiningName;						// ը���淨
extern const char* TblLevelUpName;						// ��������
extern const char* TblPetStyleName;                     // �������ͱ�
extern const char* TblMallName;							// �̳Ǳ�
extern const char* TblMissionName;						// �������
extern const char* TblVipName;                          // vip��
extern const char* TblSoldieradvName;                   // �±��ֿƼ����ױ�
extern const char* TblTechnologyName;                   // �±��ֿƼ���
extern const char* TblCourseName;                       // ���̱�
extern const char* TblNewBieRewardName;					// ���ֽ�����
extern const char* TblEquipMentName;					// װ����
extern const char* TblEquipStrengName;					// װ��ǿ����
extern const char* TblHeroRankListLevelAwardName;		// Ӣ�۰�ȼ�����
extern const char* TblHeroRankListDayAwardName;			// Ӣ�۰�ÿ�ս���
extern const char* TblActivityName;                     // ���
extern const char* TblRegistName;                       // ǩ����
extern const char* TblElfName;                          // ս�������
extern const char* TblElflvName;                        // ս��ȼ���
extern const char* TblAnnouncementName;					// �����
extern const char* TblWindowName;                       // ���ڰ�ť��
extern const char* TblEndlessGuanQiaName;				// �޾����ȱ�
extern const char* TblEndlessAwardName;					// �޾����Ƚ�����
extern const char* TblEndlessRankName;					// �޾����Ƚ�����
extern const char* TblZhangjieName;                     // �½ڱ�
extern const char* TblUpgradeName;                      // ͻ����
extern const char* TblFormationNewName;					// ���ͱ�
extern const char* TblDhmName;                          // �һ����
extern const char* TblWelfareName;                      // ������

#endif	// _TBL_DEFINE_H_