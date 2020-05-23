/********************************************************************
	created:	2013/09/16
	created:	16:9:2013   15:15
	file base:	world_mall_mgr
	file ext:	h
	author:		Z_Y_R
	
	purpose:	商城管理类
*********************************************************************/
#ifndef _WORLD_MALL_MGR_H_
#define _WORLD_MALL_MGR_H_

#include "core/singleton.h"

#include "game_util.h"
#include "world_db_mall.h"

class CMallTbl;

typedef std::vector<CMallGoodBaseObj>	GoodInfoVec;
typedef GoodInfoVec::iterator GoodIter;

class CWorldMallMgr : public GXMISC::CManualSingleton<CWorldMallMgr> 
{
public:
	CWorldMallMgr();
	~CWorldMallMgr();

public:
	void update(GXMISC::TDiffTime_t diff);

public:
	//下发给所有map的动态商品数据(同步)
	void sendMallGoodListToM();
	//更新商品
	void sendUpdateGoodListToM(const TGoodWTMapUpdateInfoArray & array);
	//返回购买结果
	void sendRecvBuyResultToM(TRoleUID_t roleid, const TRoleBuyInfo & info, EGameRetCode retcode);
	//广播的所有客户端，更新商城商品
	void sendAllPlayerUpdateGoodInfo(const TsendGoodInfoArray & array);

	//填充数据从DB
	void fillDataFromDB(TGoodDBInfoArray & array);
	//发送数据到DB
	void saveDataToDB(TGoodDBInfoArray & array);

	//初始化（动态商品数据）
	void initMallGoodList();
	//更新(参数1是判断是否需要下发到各个map服务器,进行更新)
	void updateMallGoodList(bool bflag = true);
	//更新目标商品数据
	void updateTargetGood(TWgoodInfo & data);
	//删除
	EGameRetCode deleteTargetGoodByMarkNum(TStoreMarkNum_t marknum);
	//处理购买商品逻辑(MTW)
	void handleAskBuyGood(TRoleUID_t roleid, const TRoleBuyInfo & info);
private:
	//根据配置表初始化
	void _initFromConfig();
	//更新商品处理
	bool _updateTargetGood(TWgoodInfo & data, TstoreActType type);
	//查找找商品
	CMallGoodBaseObj * _findTargetMallGood(TStoreMarkNum_t marknum);
	//处理商品状态
	void _handleGoodState(TWgoodInfo & data, TstoreActType type);
	//计算周期触发天数
	GXMISC::TGameTime_t _computusTouchDay(const CMallTbl * pmalltbl);
	//商品是否在上架状态
	uint8 _goodIsSpecial(GXMISC::TGameTime_t frontime, GXMISC::TGameTime_t lasttime);
	//初始化处理超出上架商品(只处理周期商品)
	void _handleOverTimeGood(TWgoodInfo & data, TstoreActType type);
	// 时间设置
	GXMISC::TGameTime_t _setTime(GXMISC::TGameTime_t temptime, sint32 h, sint32 m, sint32 s);
	// 设置商品为下架状态数据
	void _setTargetData(TWgoodInfo & data);
	// 判断商品状态是否处于某状态
	bool _isLocateState(TWgoodInfo & data, uint8 state);
	//测试
	void dotest();
private:
	//GoodInfoMap		_goodInfoMap;
	GoodInfoVec			_goodInfoVec;
};

#define GetWorldMallMgr CWorldMallMgr::GetInstance()

#endif //_WORLD_MALL_MGR_H_
