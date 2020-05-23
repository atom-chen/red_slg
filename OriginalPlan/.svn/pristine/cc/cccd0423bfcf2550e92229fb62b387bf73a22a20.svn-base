#ifndef _RAND_NAME_H_
#define _RAND_NAME_H_

#include "singleton.h"

#include "rand_name_tbl.h"
#include "game_util.h"
#include "game_rand.h"
#include "world_all_user.h"
#include "dirty_word_filter.h"

enum  ERandRolePrj  //四种方案
{
    PROJIECT_ONE,   // id: 2
    PROJIECT_TWO,   // id: 3
    PROJIECT_THREE, // id: 2 , 3
    PROJIECT_FOUR,  // id: 3 , 2
};

enum ERandKey
{
    KEY_ONE = 1,
    KEY_TWO,
    KEY_THREE,
};

#define   RAND_ROLE_TIME  3             //最多随机次数
class     CRandRoleName : public GXMISC::CManualSingleton<CRandRoleName>
{
	DSingletonImpl();

public:
    CRandRoleName(){}
    ~CRandRoleName(){}
public:
    std::string   randRoleName(TSex_t sex)
    {
         std::string tempRand;
         //ERandRolePrj temp = (ERandRolePrj)DRandGen.getRand((uint32)PROJIECT_THREE,(uint32)PROJIECT_FOUR);
		 ERandRolePrj temp = PROJIECT_THREE;
         return _randPrj(sex,temp,tempRand);
    }
private:
    std::string   _randPrj(TSex_t sex, ERandRolePrj prj, std::string& tempRand)
    {
        for (uint8 i = 0; i < RAND_ROLE_TIME;++i)
        {
			tempRand = _randRoleName(sex,prj).c_str();
			TRoleName_t roleName = tempRand;
			CWorldUserSimpleData* tempRole = DWorldAllUserMgr.findUser(roleName);
            if (tempRole == NULL)
            {
                if ( !IsSuccess(DCheckText.isTextPass(tempRand.c_str())) )
                {
                    continue;
                }
                return tempRand;
            }
        }
        return tempRand;
    }
	std::string   _randRoleName(TSex_t sex,ERandRolePrj prj)
	{
		switch(prj)
		{
		case PROJIECT_ONE:
			{
				return _randNamePrj1(sex);
			}break;
		case PROJIECT_TWO:
			{
				return _randNamePrj2(sex);
			}break;
		case PROJIECT_THREE:
			{
				return _randNamePrj3(sex);
			}break;
		case PROJIECT_FOUR:
			{
				return _randNamePrj4(sex);
			}break;
		default:
			{
				gxError("err");
			}break;
		}
		return "";
	}
    std::string     _randNamePrj1(TSex_t sex)  //方案1
    {
        std::string temp = _getRandValues(KEY_ONE,sex);
        temp.append(_getRandValues(KEY_TWO,sex));
        return temp;
    }
    std::string     _randNamePrj2(TSex_t sex) //方案2
    {
        std::string temp = _getRandValues(KEY_ONE,sex);
        temp.append(_getRandValues(KEY_THREE,sex));
        return temp;
    }
    std::string     _randNamePrj3(TSex_t sex)   //方案3
    {
		std::string temp = _getRandValues(KEY_ONE,sex);
		temp.append(_getRandValues(KEY_TWO,sex));
		temp.append(_getRandValues(KEY_THREE,sex));
        return temp;
    }
    std::string     _randNamePrj4(TSex_t sex)    //方案4
    {
        std::string temp = _getRandValues(KEY_ONE,sex);
        temp.append(_getRandValues(KEY_THREE,sex));
        temp.append(_getRandValues(KEY_TWO,sex));
        return temp;
    }
    std::string _getRandValues(ERandKey key,TSex_t sex)
    {
        CRoleNameRandTbl* randName = DRandRoleNameLoader.find(key);
        if (randName == NULL)
        {
            gxAssert(false);
			return "";
        }
        if (sex == SEX_TYPE_MALE)
        {
            uint32 tempIndex = DRandGen.getRand<uint32>(0,randName->getLength(SEX_TYPE_MALE)-1);
            return randName->getString(SEX_TYPE_MALE,tempIndex);
        }
        uint32 tempIndex = DRandGen.getRand<uint32>(0,randName->getLength(SEX_TYPE_FEMALE)-1);
        return randName->getString(SEX_TYPE_FEMALE,tempIndex);
    }
};

#define      DRandRoleMgr    CRandRoleName::GetInstance()

#endif