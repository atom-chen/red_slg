/********************************************************************
	created:	2013/09/16
	created:	16:9:2013   15:57
	file base:	world_mall_mgr
	file ext:	cpp
	author:		Z_Y_R
	
	purpose:	商城管理类
	*********************************************************************/

#include "world_mall_mgr.h"
#include "packet_mw_base.h"
#include "world_user_mgr.h"
#include "world_map_player_mgr.h"
#include "mall_tbl.h"
#include "comtools/comtools.h"
#include "world_server.h"
#include "time_util.h"
#include "packet_cm_mall.h"
#include "world_db_server_handler.h"

CWorldMallMgr::CWorldMallMgr()
{
	_goodInfoVec.clear();
}

CWorldMallMgr::~CWorldMallMgr()
{

}

//还有数据库数据
void CWorldMallMgr::initMallGoodList()
{
	//先读表
	_initFromConfig();
}

void CWorldMallMgr::updateMallGoodList( bool bflag/* = true */)
{
	TGoodWTMapUpdateInfoArray	wtmarray;
	TsendGoodInfoArray			wtcarray;
	//更新逻辑
	GoodInfoVec::iterator iter = _goodInfoVec.begin();

	TWtmGoodInfo	wtminfo;
	TGoodMsInfo		wtcinfo;

	for(; iter != _goodInfoVec.end(); ++iter)
	{
		CMallTbl * pmalltbl = GMallTblMgr.find(iter->_dbGoodInfo.storeMarkNum);
		if(!pmalltbl)
		{
			return;
		}

		//之前商品是否处理活动状态
		bool btemp = _isLocateState(iter->_dbGoodInfo, static_cast<uint8>(STORE_LIMITTIME));

		//处理超时上架商品
		_handleOverTimeGood(iter->_dbGoodInfo, iter->_dbGoodInfo.storeBuyType);

		bool bupdate = _updateTargetGood(iter->_dbGoodInfo, pmalltbl->goodinfo.storeBuyType);
		if(bupdate)
		{
			//商品状态前后对比
			if(bupdate != btemp)
			{
				wtcinfo.clean();

				wtcinfo.storeMarkNum		= iter->_dbGoodInfo.storeMarkNum;
				wtcinfo.storeItemSurNum		= iter->_dbGoodInfo.storeItemSurNum;
				wtcinfo.storeValidTime		= iter->_dbGoodInfo.storeValidTime;
				wtcinfo.storeStateTypeList	= iter->_dbGoodInfo.storeStateTypeList;

				wtcarray.pushBack(wtcinfo);
			}

			wtminfo.clean();

			wtminfo.storeMarkNum		= iter->_dbGoodInfo.storeMarkNum;
			wtminfo.storeItemSurNum		= iter->_dbGoodInfo.storeItemSurNum;
			wtminfo.storeValidTime		= iter->_dbGoodInfo.storeValidTime;
			wtminfo.storeStateTypeList	= iter->_dbGoodInfo.storeStateTypeList;
			wtminfo.storeCycle			= iter->_dbGoodInfo.storeCycle;

			wtmarray.pushBack(wtminfo);
		}
	}

	if(bflag)
	{
		if(!wtmarray.empty())
		{
			//广播给其他map server(同步数据)
			sendUpdateGoodListToM(wtmarray);
		}

		if(!wtcarray.empty())
		{
			//广播所有在线客户端
			sendAllPlayerUpdateGoodInfo(wtcarray);
		}

	}
}

EGameRetCode CWorldMallMgr::deleteTargetGoodByMarkNum( TStoreMarkNum_t marknum )
{
	return RC_FAILED;
}

void CWorldMallMgr::handleAskBuyGood( TRoleUID_t roleid, const TRoleBuyInfo & info )
{
	//测试
	//dotest();

	CMallGoodBaseObj * pobj = _findTargetMallGood(info.storeMarkNum);
	if(!pobj)
	{
		return;
	}

	//先更新
	updateMallGoodList(false);

	CMallTbl * pmalltbl = GMallTblMgr.find(info.storeMarkNum);
	if(!pmalltbl)
	{
		return;
	}

	EGameRetCode retcode = RC_SUCCESS;

	if(pmalltbl->goodinfo.storeIsLimit == static_cast<uint8>(LIMESNUM)/* &&
		pmalltbl->goodinfo.storeIsLimitBuyNum == static_cast<uint8>(NOPERSONLIMESNUM)*/)
	{
		// 修改为购买次数
		//if(info.storeItemNum > pobj->_dbGoodInfo.storeItemSurNum)
		if(pobj->_dbGoodInfo.storeItemSurNum <= 0)
		{
			//提示:该商品已售完
			retcode = RC_GOOD_HAVENOTNUM;
		}
		else
		{
			//pobj->_dbGoodInfo.storeItemSurNum	-=	info.storeItemNum;
			pobj->_dbGoodInfo.storeItemSurNum --;
			retcode = RC_SUCCESS;

			//更新购买后结果
			updateTargetGood(pobj->_dbGoodInfo);
		}
	}

	//下发给玩家
	sendRecvBuyResultToM(roleid, info, retcode);
}

void CWorldMallMgr::sendMallGoodListToM()
{
	WMSendMallGoodList retpacket;

	GoodInfoVec::iterator iter = _goodInfoVec.begin();
	for(; iter != _goodInfoVec.end(); ++iter)
	{
		TWtmGoodInfo info;
		info.storeMarkNum		= iter->_dbGoodInfo.storeMarkNum;
		info.storeItemSurNum	= iter->_dbGoodInfo.storeItemSurNum;
		info.storeValidTime		= iter->_dbGoodInfo.storeValidTime;
		info.storeCycle			= iter->_dbGoodInfo.storeCycle;
		info.storeStateTypeList = iter->_dbGoodInfo.storeStateTypeList;
		retpacket.sendgoodinfoarray.pushBack(info);
	}

	DWorldMapPlayerMgr.broadCast(retpacket);
}

void CWorldMallMgr::sendUpdateGoodListToM( const TGoodWTMapUpdateInfoArray & array )
{
	WMSendUpdateMallGoodList retpacket;

	retpacket.sendupdategoodinfoarray = array;

	DWorldMapPlayerMgr.broadCast(retpacket);
}

void CWorldMallMgr::sendRecvBuyResultToM( TRoleUID_t roleid, const TRoleBuyInfo & info, EGameRetCode retcode )
{
	WMRecMallGood retpacket;

	CWorldUser* onlineUser = DWorldUserMgr.findUserByRoleUID(roleid);
	if(!onlineUser)
	{
		gxError(" world user is out with roleid is ", roleid);
		return;
	}

	retpacket.roleid		= roleid;
	retpacket.rolebuyinfo	= info;
	retpacket.retCode		= retcode; //处理是否购买成功
	onlineUser->sendPacket(retpacket);
}

void CWorldMallMgr::sendAllPlayerUpdateGoodInfo( const TsendGoodInfoArray & array )
{
	MCUpdateMallGoodInfoList packet;
	packet.sendupdategoodinfoarray = array;
	BroadCastToMapServer(packet);
}

void CWorldMallMgr::_initFromConfig()
{
	CMallTblLoader::Iterator iter = GMallTblMgr.begin();
	for(; iter != GMallTblMgr.end(); ++iter)
	{
		CMallTbl * pmalltbl = iter->second;
		if(!pmalltbl)
			continue;

		//判断是否可以出售
		if(pmalltbl->goodinfo.storeIsSell == static_cast<uint8>(SELL_STATE))
		{

			CMallGoodBaseObj goodobj;
			goodobj._dbGoodInfo.storeMarkNum		= pmalltbl->goodinfo.storeMarkNum;
			goodobj._dbGoodInfo.storeItemSurNum		= pmalltbl->goodinfo.storeLimitNum;
			goodobj._dbGoodInfo.storeValidTime		= pmalltbl->goodinfo.storeValidTime;
			goodobj._dbGoodInfo.storeCycle			= 0;
			goodobj._dbGoodInfo.storeOperatorTime	= 0;
			goodobj._dbGoodInfo.storeBuyType		= pmalltbl->goodinfo.storeBuyType;
			//赋值配置表的状态
			_handleGoodState(goodobj._dbGoodInfo, goodobj._dbGoodInfo.storeBuyType);

			_goodInfoVec.push_back(goodobj);
		}
	}
}

bool CWorldMallMgr::_updateTargetGood( TWgoodInfo & data, TstoreActType type )
{
	CMallTbl * pmalltbl = GMallTblMgr.find(data.storeMarkNum);
	if(!pmalltbl)
	{
		return false;
	}

	//判断商品活动类型
	GXMISC::CGameTime tetqwt = DTimeManager.nowSysTime();
	if(type == static_cast<uint8>(GAMESTRAT_TYPE))
	{
		GXMISC::TGameTime_t tempt = DTimeManager.nowSysTime() - DCWorldServer->getOpenTime();
		data.storeValidTime = (data.storeValidTime < tempt) ? 0 : (data.storeValidTime - tempt);
		data.storeOperatorTime	= DTimeManager.nowSysTime();

		//处理状态
		DZeroPtr(&data.storeStateTypeList);
		if(data.storeValidTime == 0)
		{
			data.storeBuyType		= static_cast<TstoreActType>(INVAL_TYPE);
			_handleGoodState(data, data.storeBuyType);
			return false;
		}

		_handleGoodState(data, data.storeBuyType);
		return true;
	}
	else if(type == static_cast<uint8>(PERIOD_TYPE))
	{
		GXMISC::TGameTime_t touchtime = _computusTouchDay(pmalltbl);

		//判断当前时间达到商品触发时间
		if(DTimeManager.nowSysTime() < touchtime)
		{
			_setTargetData(data);
			return false;
		}

		GXMISC::TGameTime_t tempValidtime = touchtime + pmalltbl->goodinfo.storeValidTime;
		GXMISC::TGameTime_t tempoptime = data.storeOperatorTime;
		
		if(_goodIsSpecial(touchtime, tempValidtime) == static_cast<uint8>(GOOG_SPECIAL))
		{
			//上架期间
			data.storeValidTime		= tempValidtime - DTimeManager.nowSysTime();
			//data.storeOperatorTime	= DTimeManager.nowSysTime();

			_handleGoodState(data, data.storeBuyType);

			//gxInfo("mall loginfo! storeMarkNum{0}, storeItemSurNum{1}, storeValidTime{2}, storeOperatorTime{3}, storeStateTypeList{4}, storeBuyType{5}, storeState{6}", 
			//	data.storeMarkNum,
			//	data.storeItemSurNum,
			//	data.storeValidTime,
			//	data.storeCycle,
			//	data.storeOperatorTime.getGameTime(),
			//	(uint16)data.storeBuyType,
			//	(uint16)data.storeState);

			//gxInfo("mall loginfo statlist! storeStateTypeList1{0}, storeStateTypeList2{1}, storeStateTypeList3{2}, storeStateTypeList4{3}, storeStateTypeList5{4}", 
			//	data.storeStateTypeList[0],
			//	data.storeStateTypeList[1],
			//	data.storeStateTypeList[2],
			//	data.storeStateTypeList[3]);

			return true;
		}
		else if(_goodIsSpecial(touchtime, tempValidtime) == static_cast<uint8>(GOOG_NORMAL))
		{
			//超时(下架)
			_setTargetData(data);

			//data.storeOperatorTime	= DTimeManager.nowSysTime();
			//data.storeValidTime		= 0;
			//data.storeItemSurNum	= 0;
			//data.storeBuyType		= static_cast<TstoreActType>(INVAL_TYPE);
			//data.storeState			= static_cast<uint8>(GOOG_NORMAL);
			////处理状态(注意下架后，变回普通商品)
			//data.storeStateTypeList.clear();
			//_handleGoodState(data, data.storeBuyType);

			return true;
		}
	}
	else if(type == static_cast<uint8>(INVAL_TYPE))
	{
		_handleGoodState(data, data.storeBuyType);
		//不需要更新
		return false;
	}
	return false;
}

CMallGoodBaseObj * CWorldMallMgr::_findTargetMallGood( TStoreMarkNum_t marknum )
{
	GoodInfoVec::iterator iter = _goodInfoVec.begin();
	for(; iter != _goodInfoVec.end(); ++iter)
	{
		if(marknum == iter->_dbGoodInfo.storeMarkNum)
		{
			return &(*iter);
		}
	}
	return NULL;
}

void CWorldMallMgr::_handleGoodState( TWgoodInfo & data, TstoreActType type )
{
	CMallTbl * pmalltbl = GMallTblMgr.find(data.storeMarkNum);
	if(!pmalltbl)
	{
		return;
	}

	if(type == static_cast<uint8>(GAMESTRAT_TYPE) ||
		type == static_cast<uint8>(PERIOD_TYPE))
	{
		if(pmalltbl->goodinfo.storeIsTimeLimit == static_cast<uint8>(LIMESTIME))
		{
			if (!data.storeStateTypeList.find(STORE_LIMITTIME))
			{
				data.storeStateTypeList.pushBack(static_cast<uint8>(STORE_LIMITTIME));
			}
		}
		if(pmalltbl->goodinfo.storeIsLimit == static_cast<uint8>(LIMESNUM))
		{
			if(!data.storeStateTypeList.find(STORE_LIMITNUM))
			{
				data.storeStateTypeList.pushBack(static_cast<uint8>(STORE_LIMITNUM));
			}
		}
		if(pmalltbl->goodinfo.storeIsDiscount == static_cast<uint8>(DISCOUNT))
		{
			if(!data.storeStateTypeList.find(STORE_DISCOUNT))
			{
				data.storeStateTypeList.pushBack(static_cast<uint8>(STORE_DISCOUNT));
			}
		}
		if(pmalltbl->goodinfo.storeIsSellFast == static_cast<uint8>(SELLFAST))
		{
			if(!data.storeStateTypeList.find(STORE_SELLFAST))
			{
				data.storeStateTypeList.pushBack(static_cast<uint8>(STORE_SELLFAST));
			}
		}
		////增加了个人限购买
		//if(pmalltbl->goodinfo.storeIsLimitBuyNum == static_cast<uint8>(PERSONLIMESNUM))
		//{
		//	if(!data.storeStateTypeList.find(STORE_LIMITNUM_PSONL))
		//	{
		//		data.storeStateTypeList.pushBack(static_cast<uint8>(STORE_LIMITNUM_PSONL));
		//	}
		//}
	}
	else if(type == static_cast<uint8>(INVAL_TYPE))
	{
		//热买判断
		if(pmalltbl->goodinfo.storeIsSellFast == static_cast<uint8>(SELLFAST))
		{
			if(!data.storeStateTypeList.find(STORE_SELLFAST))
			{
				data.storeStateTypeList.pushBack(static_cast<uint8>(STORE_SELLFAST));
			}
		}
	}
}

void CWorldMallMgr::fillDataFromDB( TGoodDBInfoArray & array )
{
	GoodInfoVec::iterator iter = _goodInfoVec.begin();
	for(; iter != _goodInfoVec.end(); ++iter)
	{
		CMallTbl * pmalltbl = GMallTblMgr.find(iter->_dbGoodInfo.storeMarkNum);
		if(!pmalltbl)
		{
			return;
		}

		TGoodDBInfoArray::iterator itor = array.findByKey(iter->_dbGoodInfo.storeMarkNum);
		if(itor != array.end())
		{
			iter->_dbGoodInfo.storeCycle				= itor->storeCycle;
			iter->_dbGoodInfo.storeOperatorTime			= itor->storeOperatorTime;
			iter->_dbGoodInfo.storeValidTime			= itor->storeValidTime;
			iter->_dbGoodInfo.storeItemSurNum			= itor->storeItemSurNum;
			iter->_dbGoodInfo.storeMarkNum				= itor->storeMarkNum;
		}

		//处理超时上架商品
		_handleOverTimeGood(iter->_dbGoodInfo, iter->_dbGoodInfo.storeBuyType);

		_updateTargetGood(iter->_dbGoodInfo, iter->_dbGoodInfo.storeBuyType);
	}
	//清除数据库内存
	array.clear();
}

void CWorldMallMgr::saveDataToDB( TGoodDBInfoArray & array )
{
	GoodInfoVec::iterator iter = _goodInfoVec.begin();
	TWgoodInfo info;
	for(; iter != _goodInfoVec.end(); ++iter)
	{
		//if(iter->_dbGoodInfo.storeIsRecode != static_cast<uint8>(IS_RECODE))
		//	continue;

		info.clean();
		info.storeMarkNum		= iter->_dbGoodInfo.storeMarkNum;
		info.storeItemSurNum	= iter->_dbGoodInfo.storeItemSurNum;
		info.storeValidTime		= iter->_dbGoodInfo.storeValidTime;
		info.storeCycle			= iter->_dbGoodInfo.storeCycle;
		info.storeOperatorTime	= iter->_dbGoodInfo.storeOperatorTime;
		info.storeStateTypeList	= iter->_dbGoodInfo.storeStateTypeList;
		array.pushBack(info);

		//设置不需记录
		//iter->_dbGoodInfo.storeIsRecode = static_cast<uint8>(NOT_RECODE);
	}
}

GXMISC::TGameTime_t CWorldMallMgr::_computusTouchDay( const CMallTbl * pmalltbl )
{
	if(!pmalltbl)
	{
		return 0;
	}

	sint32 y = DTimeManager.getYear();
	sint32 m = DTimeManager.getMonth();
	sint32 d = DTimeManager.getDay();
	sint32 h = DTimeManager.getHour();
	sint32 s = DTimeManager.getMinute();

	GXMISC::TGameTime_t o = DCWorldServer->getOpenTime();
	GXMISC::TGameTime_t n = DTimeManager.nowSysTime();

	GXMISC::TGameTime_t opentime = _setTime(o, 0, 0, 0);

	GXMISC::TGameTime_t periodtime	= (DTimeManager.nowSysTime() - opentime) / pmalltbl->goodinfo.storePeriod.getGameTime();
	GXMISC::TGameTime_t temptime	= opentime + (pmalltbl->goodinfo.storePeriod.getGameTime() * periodtime);

	GXMISC::TGameTime_t touchtime = _setTime(temptime, 
		pmalltbl->goodinfo.storeStartTime.hour, 
		pmalltbl->goodinfo.storeStartTime.min, 
		pmalltbl->goodinfo.storeStartTime.sec);

	return touchtime;
}

uint8 CWorldMallMgr::_goodIsSpecial( GXMISC::TGameTime_t frontime, GXMISC::TGameTime_t lasttime )
{
	if(frontime <= DTimeManager.nowSysTime() &&
		DTimeManager.nowSysTime() < lasttime)
	{
		return static_cast<uint8>(GOOG_SPECIAL);
	}
	else
	{
		return static_cast<uint8>(GOOG_NORMAL);
	}
}

void CWorldMallMgr::_handleOverTimeGood( TWgoodInfo & data, TstoreActType type )
{
	CMallTbl * pmalltbl = GMallTblMgr.find(data.storeMarkNum);
	if(!pmalltbl)
	{
		return;
	}

	if(pmalltbl->goodinfo.storeBuyType != static_cast<uint8>(PERIOD_TYPE))
		return;

	GXMISC::TGameTime_t touchtime = _computusTouchDay(pmalltbl);

	//判断当前时间达到商品触发时间
	if(DTimeManager.nowSysTime() < touchtime)
		return;

	GXMISC::TGameTime_t tempValidtime = touchtime + pmalltbl->goodinfo.storeValidTime;
	GXMISC::TGameTime_t tempoptime = data.storeOperatorTime;

	if(_goodIsSpecial(touchtime, tempValidtime) == static_cast<uint8>(GOOG_SPECIAL) &&
		tempoptime < touchtime)
	{
		//超时(上架)
		data.storeCycle	+= 1;
		data.storeOperatorTime	= DTimeManager.nowSysTime();
		data.storeValidTime		= tempValidtime - DTimeManager.nowSysTime();//pmalltbl->goodinfo.storeValidTime;
		data.storeItemSurNum	= pmalltbl->goodinfo.storeLimitNum;
		data.storeBuyType		= pmalltbl->goodinfo.storeBuyType;
		data.storeState			= static_cast<uint8>(GOOG_SPECIAL);
		//处理状态
		data.storeStateTypeList.clear();
		//_handleGoodState(data, type);
	}
}

GXMISC::TGameTime_t CWorldMallMgr::_setTime( GXMISC::TGameTime_t temptime, sint32 h, sint32 m, sint32 s )
{
	struct tm info;
	convertTargetTime(temptime, info);
	info.tm_hour		= h;
	info.tm_min			= m;
	info.tm_sec			= s;
	GXMISC::TGameTime_t touchtime	= static_cast<GXMISC::TGameTime_t>(mktime(&info));

	return (GXMISC::TGameTime_t)touchtime;
}

void CWorldMallMgr::_setTargetData( TWgoodInfo & data )
{
	uint8 state = data.storeState;
	data.storeOperatorTime	= DTimeManager.nowSysTime();
	data.storeValidTime		= 0;
	data.storeItemSurNum	= 0;
	data.storeBuyType		= static_cast<TstoreActType>(INVAL_TYPE);
	data.storeState			= static_cast<uint8>(GOOG_NORMAL);
	//处理状态(注意下架后，变回普通商品)
	data.storeStateTypeList.clear();
	_handleGoodState(data, data.storeBuyType);
}

bool CWorldMallMgr::_isLocateState( TWgoodInfo & data, uint8 state )
{
	TGoodStateLise::iterator iter = data.storeStateTypeList.begin();
	for(; iter != data.storeStateTypeList.end(); ++iter)
	{
		if(*iter == state)
		{
			return true;
		}
	}
	
	return false;
}

void CWorldMallMgr::updateTargetGood( TWgoodInfo & data )
{
	TGoodWTMapUpdateInfoArray	wtmarray;
	TsendGoodInfoArray			wtcarray;
	TWtmGoodInfo	wtminfo;
	TGoodMsInfo		wtcinfo;

	wtcinfo.storeMarkNum		= wtminfo.storeMarkNum			= data.storeMarkNum;
	wtcinfo.storeItemSurNum		= wtminfo.storeItemSurNum		= data.storeItemSurNum;
	wtcinfo.storeValidTime		= wtminfo.storeValidTime		= data.storeValidTime;
	wtcinfo.storeStateTypeList	= wtminfo.storeStateTypeList	= data.storeStateTypeList;
	wtminfo.storeCycle			= data.storeCycle;

	wtmarray.pushBack(wtminfo);

	wtcarray.pushBack(wtcinfo);

	//广播给其他map server(同步数据)
	sendUpdateGoodListToM(wtmarray);

	//广播所有在线客户端
	sendAllPlayerUpdateGoodInfo(wtcarray);
}

void CWorldMallMgr::dotest()
{
	//// 测试
	//DCWRecordeManager.handleCreateBeforeRecorde(NULL);
}

void CWorldMallMgr::update( GXMISC::TDiffTime_t diff )
{
	//GXMISC::CManualIntervalTimer	_worldmallTimer;										///< 商城定时器（一分钟	
}
