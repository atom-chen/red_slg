/********************************************************************
	created:	2013/08/19
	created:	19:8:2013   14:19
	file base:	randdropItemMgr
	file ext:	h
	author:		Z_Y_R
	
	purpose:	随机掉落管理
*********************************************************************/
#ifndef _RANDDROPITEMMGR_H
#define _RANDDROPITEMMGR_H

#include "core/singleton.h"
#include "randdrop_tbl.h"
#include "game_rand.h"
#include "game_define.h"

class CranddropItemMgr : public GXMISC::CManualSingleton<CranddropItemMgr>
{
	DSingletonImpl();

public:
	CranddropItemMgr(){}
	~CranddropItemMgr(){}

public:
	void randItemByDropId(TRandDropID_t dropid, TItemRewardVec * iteminfovec)
	{
		CRandDropTbl* pranddrop = DRandDropTblMgr.find(dropid);
		if(!pranddrop)
		{
			gxError("rand item is failed with index is {0}", dropid);
			return;
		}

		if(pranddrop->randdropconfiginfo.oddandweitype == static_cast<TValueType_t>(DROPWEIGHT_TYPE))
		{
			//权重处理
			uint32 weigth = pranddrop->randdropconfiginfo.allWeigth;
			if(weigth == 0)
			{
				gxError("weigth is 0 whit dropindex is {0}", dropid);
				return;
			}

			int tempodds = DRandGen.getRand<uint32>(1, weigth);
			TRandDropComInfoVecEx & tempvec = pranddrop->randdropconfiginfo.dropcominfovec;
			TRandDropComInfoVecEx::iterator iter = tempvec.begin();
			for(; iter != tempvec.end(); ++iter)
			{
				if(iter->oddsmin <= tempodds &&
					iter->oddsmax > tempodds)
				{
					TItemReward iteminfo;
					iteminfo.itemTypeID = iter->itemTypeID;
					iteminfo.itemNum	 = DRandGen.getRand(iter->minNum, iter->maxNum);

					iteminfovec->push_back(iteminfo);
					break;
				}
			}
		}
		else
		{
			//先处理必奖励的
			TRewardComInfoVecEx & tempreex = pranddrop->randdropconfiginfo.rewardcominfovec;
			TRewardComInfoVecEx::iterator reiter = tempreex.begin();
			for(; reiter != tempreex.end(); ++reiter)
			{
				TItemReward iteminfo;
				iteminfo.itemTypeID		= reiter->itemTypeID;
				iteminfo.itemNum		= DRandGen.getRand(reiter->minNum, reiter->maxNum);
				iteminfovec->push_back(iteminfo);
			}

			//再处理随机的
			//机率处理 100%
			uint16 tempodds = DRandGen.getRand<uint16>(1, 100) * 100;
			TRandDropComInfoVecEx & temprandex = pranddrop->randdropconfiginfo.dropcominfovec;
			TRandDropComInfoVecEx::iterator randiter = temprandex.begin();
			for(; randiter != temprandex.end(); ++randiter)
			{
				if(randiter->oddsmin <= tempodds &&
					randiter->oddsmax > tempodds)
				{
					TItemReward iteminfo;
					iteminfo.itemTypeID = randiter->itemTypeID;
					iteminfo.itemNum		= DRandGen.getRand(randiter->minNum, randiter->maxNum);
					if(iteminfo.itemNum == 0)
					{
						continue;
					}
					iteminfovec->push_back(iteminfo);
				}
			}
		}

	}

};

#define GranddropItemMgr CranddropItemMgr::GetInstance()

#endif //_RANDDROPITEMMGR_H
