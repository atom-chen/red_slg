#ifndef _RANDDROP_TBL_H_
#define _RANDDROP_TBL_H_

#include "game_util.h"
#include "rand_drop_struct.h"
#include "tbl_config.h"
#include "tbl_loader.h"

class CRandDropTbl : public CConfigTbl
{
public:
	//TRandDropConfigInfo		randdropconfiginfo;
	TRandDropConfigInfoEx		randdropconfiginfo;

public:
	virtual bool onAfterLoad(void * arg /* = NULL */)
	{
		return true;
	}

public:
	DMultiIndexImpl1(uint32, randdropconfiginfo.dropid, 0);
	DObjToString(CRandDropTbl, uint32, randdropconfiginfo.dropid);
};

class CRandDropTblLoader : 
	public CConfigLoader<CRandDropTblLoader, CRandDropTbl> 
{
public:
	DLoaderGet();
	DSingletonImpl();
	DConfigFind();

	//特殊处理
	bool  HandleConvert(const std::string & strtemp, int & var, const CRandDropTbl * destRow, const ConfigRow* row)
	{
		if(NULL == row->Attribute(strtemp.c_str()))  
		{   
			//gxError("Can't parse {0}!Line={1},{2}", strtemp.c_str(), count, destRow->toString());	
			return false;   
		}   
		if(NULL == row->Attribute(strtemp.c_str(), &var))	
		{	
			//gxError("Can't parse {0}!Line={1},{2}", strtemp.c_str(), count, destRow->toString());	
			return false;	
		}

		return true;
	}

	virtual bool readRow(ConfigRow* row, sint32 count, CRandDropTbl* destRow)
	{
		DReadConfigInt(randdropconfiginfo.dropid, id, destRow);
		DReadConfigInt(randdropconfiginfo.oddandweitype, type, destRow);
		
		std::string fmt1 = "item%u";
		std::string fmt2 = "num_min%u";
		std::string fmt3 = "num_max%u";
		std::string fmt4 = "binding%u";

		for(size_t index = 1; index < 6; index++)
		{
			TRandDropComInfoEx dropcominfo;
			dropcominfo.clean();

			fmt1 = GXMISC::gxToString(fmt1.c_str(), index);
			fmt2 = GXMISC::gxToString(fmt2.c_str(), index);
			fmt3 = GXMISC::gxToString(fmt3.c_str(), index);
			fmt4 = GXMISC::gxToString(fmt4.c_str(), index);

			int tempvar = 0;
			if(HandleConvert(fmt1, tempvar, destRow, row))
			{
				if(tempvar == 0)
				{
					continue;
				}
				dropcominfo.itemTypeID = tempvar;
			}
			if(HandleConvert(fmt2, tempvar, destRow, row))
			{
				dropcominfo.minNum = tempvar;
			}
			if(HandleConvert(fmt3, tempvar, destRow, row))
			{
				dropcominfo.maxNum = tempvar;
			}

			if(destRow->randdropconfiginfo.oddandweitype == static_cast<TValueType_t>(DROPWEIGHT_TYPE))
			{
				//　以下是权重处理
				if(HandleConvert(fmt4, tempvar, destRow, row))
				{
					dropcominfo.oddsmin = destRow->randdropconfiginfo.allWeigth;
					dropcominfo.oddsmax = tempvar + destRow->randdropconfiginfo.allWeigth;
					destRow->randdropconfiginfo.allWeigth += tempvar;
				}

				destRow->randdropconfiginfo.dropcominfovec.push_back(dropcominfo);
			}
			else
			{
				TOdd_t	allOdd = 0;	///< 对应总机率
				//以下是概率处理
				if(HandleConvert(fmt4, tempvar, destRow, row))
				{
					if(tempvar == -1)
					{
						//必奖励
						destRow->randdropconfiginfo.rewardcominfovec.push_back(dropcominfo);
					}
					else
					{
						if(HandleConvert(fmt4, tempvar, destRow, row))
						{
							dropcominfo.oddsmin = allOdd;
							dropcominfo.oddsmax = tempvar + allOdd;
							allOdd += tempvar;
						}

						//随机奖励
						destRow->randdropconfiginfo.dropcominfovec.push_back(dropcominfo);
					}
				}
			}

			fmt1 = "item%u";
			fmt2 = "num_min%u";
			fmt3 = "num_max%u";
			fmt4 = "binding%u";
		}

		DAddToLoader(destRow);

		return true;
	}

};

#define DRandDropTblMgr CRandDropTblLoader::GetInstance()

#endif //_RANDDROP_TBL_H_