#ifndef _GAME_MISC_H_
#define _GAME_MISC_H_

#include "core/hash_util.h"

#include "game_pos.h"
#include "game_util.h"
#include "game_rand.h"

#define __PI			3.1415f
#define __HALF_PI		__PI / 2
#define __QUARTER_PI	__PI / 4

#define DRound(a) (sint32(a+0.5))

#define MAX_DIR_ADJUST_NUM 10
const static sint32 FourDirAdjustNum[MAX_DIR_ADJUST_NUM] = {2,4,6,8,10,12,14,16,18,20};
const static TAdjust FourDirAjdust[4][MAX_DIR_ADJUST_NUM][20] =
{
	{{{-1,-1},{0,-1}},
	{{-2,-2},{1,-2},{0,-2},{-1,-2}},
	{{-3,-3},{2,-3},{1,-3},{0,-3},{-1,-3},{-2,-3}},
	{{-4,-4},{3,-4},{2,-4},{1,-4},{0,-4},{-1,-4},{-2,-4},{-3,-4}},
	{{-5,-5},{4,-5},{3,-5},{2,-5},{1,-5},{0,-5},{-1,-5},{-2,-5},{-3,-5},{-4,-5}},
	{{-6,-6},{5,-6},{4,-6},{3,-6},{2,-6},{1,-6},{0,-6},{-1,-6},{-2,-6},{-3,-6},{-4,-6},{-5,-6}},
	{{-7,-7},{6,-7},{5,-7},{4,-7},{3,-7},{2,-7},{1,-7},{0,-7},{-1,-7},{-2,-7},{-3,-7},{-4,-7},{-5,-7},{-6,-7}},
	{{-8,-8},{7,-8},{6,-8},{5,-8},{4,-8},{3,-8},{2,-8},{1,-8},{0,-8},{-1,-8},{-2,-8},{-3,-8},{-4,-8},{-5,-8},{-6,-8},{-7,-8}},
	{{-9,-9},{8,-9},{7,-9},{6,-9},{5,-9},{4,-9},{3,-9},{2,-9},{1,-9},{0,-9},{-1,-9},{-2,-9},{-3,-9},{-4,-9},{-5,-9},{-6,-9},{-7,-9},{-8,-9}},
	{{-10,-10},{9,-10},{8,-10},{7,-10},{6,-10},{5,-10},{4,-10},{3,-10},{2,-10},{1,-10},{0,-10},{-1,-10},{-2,-10},{-3,-10},{-4,-10},{-5,-10},{-6,-10},{-7,-10},{-8,-10},{-9,-10}}},

	{{{1,0},{1,-1}},
	{{2,1},{2,0},{2,-1},{2,-2}},
	{{3,2},{3,1},{3,0},{3,-1},{3,-2},{3,-3}},
	{{4,3},{4,2},{4,1},{4,0},{4,-1},{4,-2},{4,-3},{4,-4}},
	{{5,4},{5,3},{5,2},{5,1},{5,0},{5,-1},{5,-2},{5,-3},{5,-4},{5,-5}},
	{{6,5},{6,4},{6,3},{6,2},{6,1},{6,0},{6,-1},{6,-2},{6,-3},{6,-4},{6,-5},{6,-6}},
	{{7,6},{7,5},{7,4},{7,3},{7,2},{7,1},{7,0},{7,-1},{7,-2},{7,-3},{7,-4},{7,-5},{7,-6},{7,-7}},
	{{8,7},{8,6},{8,5},{8,4},{8,3},{8,2},{8,1},{8,0},{8,-1},{8,-2},{8,-3},{8,-4},{8,-5},{8,-6},{8,-7},{8,-8}},
	{{9,8},{9,7},{9,6},{9,5},{9,4},{9,3},{9,2},{9,1},{9,0},{9,-1},{9,-2},{9,-3},{9,-4},{9,-5},{9,-6},{9,-7},{9,-8},{9,-9}},
	{{10,9},{10,8},{10,7},{10,6},{10,5},{10,4},{10,3},{10,2},{10,1},{10,0},{10,-1},{10,-2},{10,-3},{10,-4},{10,-5},{10,-6},{10,-7},{10,-8},{10,-9},{10,-10}}},

	{{{0,1},{1,1}},
	{{-1,2},{0,2},{1,2},{2,2}},
	{{-2,3},{-1,3},{0,3},{1,3},{2,3},{3,3}},
	{{-3,4},{-2,4},{-1,4},{0,4},{1,4},{2,4},{3,4},{4,4}},
	{{-4,5},{-3,5},{-2,5},{-1,5},{0,5},{1,5},{2,5},{3,5},{4,5},{5,5}},
	{{-5,6},{-4,6},{-3,6},{-2,6},{-1,6},{0,6},{1,6},{2,6},{3,6},{4,6},{5,6},{6,6}},
	{{-6,7},{-5,7},{-4,7},{-3,7},{-2,7},{-1,7},{0,7},{1,7},{2,7},{3,7},{4,7},{5,7},{6,7},{7,7}},
	{{-7,8},{-6,8},{-5,8},{-4,8},{-3,8},{-2,8},{-1,8},{0,8},{1,8},{2,8},{3,8},{4,8},{5,8},{6,8},{7,8},{8,8}},
	{{-8,9},{-7,9},{-6,9},{-5,9},{-4,9},{-3,9},{-2,9},{-1,9},{0,9},{1,9},{2,9},{3,9},{4,9},{5,9},{6,9},{7,9},{8,9},{9,9}},
	{{-9,10},{-8,10},{-7,10},{-6,10},{-5,10},{-4,10},{-3,10},{-2,10},{-1,10},{0,10},{1,10},{2,10},{3,10},{4,10},{5,10},{6,10},{7,10},{8,10},{9,10},{10,10}}},

	{{{-1,0},{-1,1}},
	{{-2,-1},{-2,0},{-2,1},{-2,2}},
	{{-3,-2},{-3,-1},{-3,0},{-3,1},{-3,2},{-3,3}},
	{{-4,-3},{-4,-2},{-4,-1},{-4,0},{-4,1},{-4,2},{-4,3},{-4,4}},
	{{-5,-4},{-5,-3},{-5,-2},{-5,-1},{-5,0},{-5,1},{-5,2},{-5,3},{-5,4},{-5,5}},
	{{-6,-5},{-6,-4},{-6,-3},{-6,-2},{-6,-1},{-6,0},{-6,1},{-6,2},{-6,3},{-6,4},{-6,5},{-6,6}},
	{{-7,-6},{-7,-5},{-7,-4},{-7,-3},{-7,-2},{-7,-1},{-7,0},{-7,1},{-7,2},{-7,3},{-7,4},{-7,5},{-7,6},{-7,7}},
	{{-8,-7},{-8,-6},{-8,-5},{-8,-4},{-8,-3},{-8,-2},{-8,-1},{-8,0},{-8,1},{-8,2},{-8,3},{-8,4},{-8,5},{-8,6},{-8,7},{-8,8}},
	{{-9,-8},{-9,-7},{-9,-6},{-9,-5},{-9,-4},{-9,-3},{-9,-2},{-9,-1},{-9,0},{-9,1},{-9,2},{-9,3},{-9,4},{-9,5},{-9,6},{-9,7},{-9,8},{-9,9}},
	{{-10,-9},{-10,-8},{-10,-7},{-10,-6},{-10,-5},{-10,-4},{-10,-3},{-10,-2},{-10,-1},{-10,0},{-10,1},{-10,2},{-10,3},{-10,4},{-10,5},{-10,6},{-10,7},{-10,8},{-10,9},{-10,10}}}
};

const static sint32 EightDirAdjustNum[8][MAX_DIR_ADJUST_NUM] =
{
	{1,1,3,3,5,5,5,7,7,9},
	{1,3,3,5,5,7,9,9,11,11},
	{1,1,3,3,5,5,5,7,7,9},
	{1,3,3,5,5,7,9,9,11,11},
	{1,1,3,3,5,5,5,7,7,9},
	{1,3,3,5,5,7,9,9,11,11},
	{1,1,3,3,5,5,5,7,7,9},
	{1,3,3,5,5,7,9,9,11,11}
};
const static TAdjust EightDirAdjust[8][MAX_DIR_ADJUST_NUM][20] =
{
	{{{0,-1},},
	{{0,-2},},
	{{1,-3},{0,-3},{-1,-3},},
	{{1,-4},{0,-4},{-1,-4},},
	{{2,-5},{1,-5},{0,-5},{-1,-5},{-2,-5},},
	{{2,-6},{1,-6},{0,-6},{-1,-6},{-2,-6},},
	{{2,-7},{1,-7},{0,-7},{-1,-7},{-2,-7},},
	{{3,-8},{2,-8},{1,-8},{0,-8},{-1,-8},{-2,-8},{-3,-8},},
	{{3,-9},{2,-9},{1,-9},{0,-9},{-1,-9},{-2,-9},{-3,-9},},
	{{4,-10},{3,-10},{2,-10},{1,-10},{0,-10},{-1,-10},{-2,-10},{-3,-10},{-4,-10},},
	},

	{{{1,-1},},
	{{2,-1},{2,-2},{1,-2},},
	{{3,-2},{3,-3},{2,-3},},
	{{4,-2},{4,-3},{4,-4},{3,-4},{2,-4},},
	{{5,-3},{5,-4},{5,-5},{4,-5},{3,-5},},
	{{6,-3},{6,-4},{6,-5},{6,-6},{5,-6},{4,-6},{3,-6},},
	{{7,-3},{7,-4},{7,-5},{7,-6},{7,-7},{6,-7},{5,-7},{4,-7},{3,-7},},
	{{8,-4},{8,-5},{8,-6},{8,-7},{8,-8},{7,-8},{6,-8},{5,-8},{4,-8},},
	{{9,-4},{9,-5},{9,-6},{9,-7},{9,-8},{9,-9},{8,-9},{7,-9},{6,-9},{5,-9},{4,-9},},
	{{10,-5},{10,-6},{10,-7},{10,-8},{10,-9},{10,-10},{9,-10},{8,-10},{7,-10},{6,-10},{5,-10},},
	},

	{{{1,0},},
	{{2,0},},
	{{3,1},{3,0},{3,-1},},
	{{4,1},{4,0},{4,-1},},
	{{5,2},{5,1},{5,0},{5,-1},{5,-2},},
	{{6,2},{6,1},{6,0},{6,-1},{6,-2},},
	{{7,2},{7,1},{7,0},{7,-1},{7,-2},},
	{{8,3},{8,2},{8,1},{8,0},{8,-1},{8,-2},{8,-3},},
	{{9,3},{9,2},{9,1},{9,0},{9,-1},{9,-2},{9,-3},},
	{{10,4},{10,3},{10,2},{10,1},{10,0},{10,-1},{10,-2},{10,-3},{10,-4},},
	},

	{{{1,1},},
	{{1,2},{2,2},{2,1},},
	{{2,3},{3,3},{3,2},},
	{{2,4},{3,4},{4,4},{4,3},{4,2},},
	{{3,5},{4,5},{5,5},{5,4},{5,3},},
	{{3,6},{4,6},{5,6},{6,6},{6,5},{6,4},{6,3},},
	{{3,7},{4,7},{5,7},{6,7},{7,7},{7,6},{7,5},{7,4},{7,3},},
	{{4,8},{5,8},{6,8},{7,8},{8,8},{8,7},{8,6},{8,5},{8,4},},
	{{4,9},{5,9},{6,9},{7,9},{8,9},{9,9},{9,8},{9,7},{9,6},{9,5},{9,4},},
	{{5,10},{6,10},{7,10},{8,10},{9,10},{10,10},{10,9},{10,8},{10,7},{10,6},{10,5},},
	},

	{{{0,1},},
	{{0,2},},
	{{-1,3},{0,3},{1,3},},
	{{-1,4},{0,4},{1,4},},
	{{-2,5},{-1,5},{0,5},{1,5},{2,5},},
	{{-2,6},{-1,6},{0,6},{1,6},{2,6},},
	{{-2,7},{-1,7},{0,7},{1,7},{2,7},},
	{{-3,8},{-2,8},{-1,8},{0,8},{1,8},{2,8},{3,8},},
	{{-3,9},{-2,9},{-1,9},{0,9},{1,9},{2,9},{3,9},},
	{{-4,10},{-3,10},{-2,10},{-1,10},{0,10},{1,10},{2,10},{3,10},{4,10},},
	},

	{{{-1,1},},
	{{-2,1},{-2,2},{-1,2},},
	{{-3,2},{-3,3},{-2,3},},
	{{-4,2},{-4,3},{-4,4},{-3,4},{-2,4},},
	{{-5,3},{-5,4},{-5,5},{-4,5},{-3,5},},
	{{-6,3},{-6,4},{-6,5},{-6,6},{-5,6},{-4,6},{-3,6},},
	{{-7,3},{-7,4},{-7,5},{-7,6},{-7,7},{-6,7},{-5,7},{-4,7},{-3,7},},
	{{-8,4},{-8,5},{-8,6},{-8,7},{-8,8},{-7,8},{-6,8},{-5,8},{-4,8},},
	{{-9,4},{-9,5},{-9,6},{-9,7},{-9,8},{-9,9},{-8,9},{-7,9},{-6,9},{-5,9},{-4,9},},
	{{-10,5},{-10,6},{-10,7},{-10,8},{-10,9},{-10,10},{-9,10},{-8,10},{-7,10},{-6,10},{-5,10},},
	},

	{{{-1,0},},
	{{-2,0},},
	{{-3,-1},{-3,0},{-3,1},},
	{{-4,-1},{-4,0},{-4,1},},
	{{-5,-2},{-5,-1},{-5,0},{-5,1},{-5,2},},
	{{-6,-2},{-6,-1},{-6,0},{-6,1},{-6,2},},
	{{-7,-2},{-7,-1},{-7,0},{-7,1},{-7,2},},
	{{-8,-3},{-8,-2},{-8,-1},{-8,0},{-8,1},{-8,2},{-8,3},},
	{{-9,-3},{-9,-2},{-9,-1},{-9,0},{-9,1},{-9,2},{-9,3},},
	{{-10,-4},{-10,-3},{-10,-2},{-10,-1},{-10,0},{-10,1},{-10,2},{-10,3},{-10,4},},
	},

	{{{-1,-1},},
	{{-1,-2},{-2,-2},{-2,-1},},
	{{-2,-3},{-3,-3},{-3,-2},},
	{{-2,-4},{-3,-4},{-4,-4},{-4,-3},{-4,-2},},
	{{-3,-5},{-4,-5},{-5,-5},{-5,-4},{-5,-3},},
	{{-3,-6},{-4,-6},{-5,-6},{-6,-6},{-6,-5},{-6,-4},{-6,-3},},
	{{-3,-7},{-4,-7},{-5,-7},{-6,-7},{-7,-7},{-7,-6},{-7,-5},{-7,-4},{-7,-3},},
	{{-4,-8},{-5,-8},{-6,-8},{-7,-8},{-8,-8},{-8,-7},{-8,-6},{-8,-5},{-8,-4},},
	{{-4,-9},{-5,-9},{-6,-9},{-7,-9},{-8,-9},{-9,-9},{-9,-8},{-9,-7},{-9,-6},{-9,-5},{-9,-4},},
	{{-10,-10},{-10,-9},{-10,-8},{-10,-7},{-10,-6},{-10,-5},{-5,-10},{-6,-10},{-7,-10},{-8,-10},{-9,-10},},
	},
};

class CGameMisc
{
private:
	static TDir_t _GetDir(const TAxisPos& pos1, const TAxisPos& pos2)
	{
		TAxisPos_t diffX = pos2.x-pos1.x;
		TAxisPos_t diffY = pos2.y-pos1.y;

		if(diffX > 0)
		{
			if(diffY > 0)
			{
				return (TDir_t)DIR_3;
			}
			else if(diffY == 0)
			{
				return (TDir_t)DIR_2;
			}
			else
			{
				return (TDir_t)DIR_1;
			}

		}
		else if(diffX == 0)
		{
			if(diffY > 0)
			{
				return (TDir_t)DIR_4;
			}
			else if(diffY == 0)
			{
				return (TDir_t)DIR_0;
			}
			else
			{
				return (TDir_t)DIR_0;
			}
		}
		else
		{
			if(diffY > 0)
			{
				return (TDir_t)DIR_5;
			}
			else if(diffY == 0)
			{
				return (TDir_t)DIR_6;
			}
			else
			{
				return (TDir_t)DIR_7;
			}
		}
	}

public:
	static TDir_t GetOpposeDir(TDir_t dir)
	{
		switch (dir)
		{
		case DIR_0:
			{
				return DIR_4;
			}
		case DIR_1:
			{
				return DIR_5;
			}
		case DIR_2:
			{
				return DIR_6;
			}
		case DIR_3:
			{
				return DIR_7;
			}
		case DIR_4:
			{
				return DIR_0;
			}
		case DIR_5:
			{
				return DIR_1;
			}
		case DIR_6:
			{
				return DIR_2;
			}
		case DIR_7:
			{
				return DIR_3;
			}
		}
		return DIR_0;
	}
	static TDir_t GetDir(const TAxisPos& pos1, const TAxisPos& pos2)
	{
		if((uint8)MySqrt(pos1, pos2) > 1)
		{
			return GetDirForAngle(pos1, pos2);
		}

		return _GetDir(pos1, pos2);
	}

	static TDir_t GetFourDir(const TAxisPos& pos1, const TAxisPos& pos2)
	{
		sint32 angle = (sint32)MyAngle(pos1, pos2);
		if(angle<-45 && angle>-135)
		{
			return DIR_0;
		}
		else if(angle<=45 && angle>=-45)
		{
			return DIR_1;
		}
		else if(angle>-135 && angle<-45) 
		{
			return DIR_2; 
		}
		else if(angle>=135 || angle>=-135) 
		{
			return DIR_3; 
		}
		else 
		{
			return DIR_0; 
		}
	}

	// 两点之间的方向
	static TDir_t GetDirForAngle(const TAxisPos& pos1, const TAxisPos& pos2)
	{ 
		sint32 angle = (sint32)MyAngle(pos1, pos2);
		if(angle<-67.5 && angle>-112.5)
		{
			return DIR_0;
		}
		else if(angle<=-22.5 && angle>=-67.5)
		{
			return DIR_1;
		}
		else if(angle>-22.5 && angle<22.5) 
		{
			return DIR_2; 
		}
		else if(angle>=22.5 && angle<=67.5) 
		{
			return DIR_3; 
		}
		else if(angle>67.5 && angle < 112.5) 
		{
			return DIR_4; 
		}
		else if(angle>=112.5 && angle <= 157.5) 
		{
			return DIR_5; 
		}
		else if(angle>157.5 || angle<-157.5) 
		{
			return DIR_6; 
		}
		else if(angle>=-157.5 && angle<=112.5) 
		{
			return DIR_7; 
		}
		else 
		{
			return DIR_0; 
		}
	}

	static TDir_t RandDir()
	{
		return DRandGen.randUInt()%(DIR_7+1);
	}

	template<typename T, typename U>
	static T RefixValue(T& t, const U minValue, const T maxValue = std::numeric_limits<T>::max())
	{
		if(t > (T)maxValue)
		{
			t = maxValue;
		}
		if(t < (T)minValue)
		{
			t = minValue;
		}

		return t;
	}

	inline static bool IsInValidRadius(TAxisPos_t x1, TAxisPos_t y1, TAxisPos_t x2, TAxisPos_t y2, uint8 range)
	{
		TAxisPos_t x, y;

		x = x1 - x2;
		y = y1 - y2;

		return ((range*range) >= (x*x + y*y));
	}

	static float MySqrt( const TAxisPos& pCur, const TAxisPos& pTar )
	{
		return (float)sqrt( ((double)pCur.x-(double)pTar.x)*((double)pCur.x-(double)pTar.x)+
			((double)pCur.y-(double)pTar.y)*((double)pCur.y-(double)pTar.y) ) ;
	}

	static double MyAngle(const TAxisPos& pCur, const TAxisPos& pTar)
	{
		double x,y,fHyp,cos,rad,deg;
		x = pTar.x - pCur.x;
		y = pTar.y - pCur.y;

		fHyp = sqrt(pow(x,2) + pow(y,2));

		cos = x / fHyp;
		rad = acos(cos);

		deg = 180/(__PI / rad);

		if(y < 0)
		{
			deg = -deg;
		}
		else if((y == 0) && (x < 0))
		{
			deg = 180;
		}

		return deg;
	}

	// 方向矩阵, 游戏方向对应的矩阵值, 参考(EDir)

	// 生成场景ID
	static TSceneID_t GenSceneID(TServerID_t serverID, uint8 mapType, TMapID_t mapID, TCopyID_t copyID)
	{
		TSceneID_t sceneID = serverID;
		sceneID <<= sizeof(uint8)*8;
		sceneID |= mapType&0xFF;
		sceneID <<= sizeof(TMapID_t)*8;
		sceneID |= (mapID&0xFFFF);
		sceneID <<= sizeof(TCopyID_t)*8;
		sceneID |= (copyID&0xFFFFFFFF);

		return sceneID;
	}

	// 获取场景类型
	static uint8 GetMapType(TSceneID_t sceneID)
	{
		return (sceneID >> ((sizeof(TCopyID_t)*8)+sizeof(TMapID_t)*8)) & 0xFF ;
	}
	// 通过场景ID获取地图ID
	static TMapID_t GetMapID(TSceneID_t sceneID)
	{
		return (sceneID >> (sizeof(TCopyID_t)*8)) & 0xFFFF ;
	}
	// 通过场景ID获取服务器ID
	static TServerID_t GetMapServerID(TSceneID_t sceneID)
	{
		return (sceneID >> (sizeof(TCopyID_t)*8+sizeof(TMapID_t)*8+sizeof(uint8)*8)) & 0xFF;
	}
	// 是否为动态场景
	static bool IsDynamicMap(ESceneType sceneType)
	{
		return !IsNormalMap(sceneType);
	}
	// 是否为动态场景
	static bool IsNormalMap(ESceneType sceneType)
	{
		return sceneType == SCENE_TYPE_NORMAL;
	}
	// 生成RoleUID
	static TRoleUID_t GenRoleUID(TRoleUID_t roleUID, TWorldServerID_t worldID)
	{
		TRoleUID_t tempRoleUID = worldID;
		tempRoleUID <<= 4*8;
		tempRoleUID += roleUID;
		return tempRoleUID;
	}
	// 通过RoleUID获取WorldID
	static TWorldServerID_t GetWorldIDByRoleUID(TRoleUID_t roleUID)
	{
		TRoleUID_t tempRoleUID = roleUID;
		tempRoleUID >>= 4*8;
		return (TWorldServerID_t)(tempRoleUID & 0xffff);
	}
	// 通过RoleUID获取RoleUIDSeed
	static TRoleUID_t GetRoleUIDSeedByRoleUID(TRoleUID_t roleUID)
	{
		TRoleUID_t tempRoleUID = roleUID;
		return (TRoleUID_t)(tempRoleUID & 0xffffffff);
	}
	// 上向取整
	template<class T>
	static T CeilFun(double var)
	{
		return static_cast<T>(ceil(var));
	}
	// 下向取整
	template<class T>
	static T FloorFun(double var)
	{
		return static_cast<T>(floor(var));
	}
	// 将时间转换成对应的秒数
	static GXMISC::TDiffTime_t ToSeconds(sint8 hour, sint8 mins, sint8 seconds)
	{
		return hour*GXMISC::SECOND_IN_HOUR+mins*GXMISC::SECOND_IN_MINUTE+seconds;
	}	
	// 比较两个时间是否在同一天
	static bool IsSameDay(GXMISC::TGameTime_t time1, GXMISC::TGameTime_t time2)
	{
		GXMISC::CDateTime curDateTime((GXMISC::TTime)time1);
		GXMISC::CDateTime dateTime((GXMISC::TTime)time2);

		if(curDateTime.year() == dateTime.year() && curDateTime.month() == dateTime.month() && curDateTime.day() == dateTime.day())
		{
			return true;
		}

		return false;
	}
	// 将字符串转换成对应的数字
	static sint32 ToNumber(std::string& str)
	{
		sint32 val;
		GXMISC::gxFromString(str, val);
		return val;
	}

	static sint32 ToLocalDay(GXMISC::TGameTime_t curTime)
	{
		return GXMISC::CTimeManager::ToLocalTime(curTime)/GXMISC::SECOND_IN_DAY;
	}

	static sint32 ToLocalDay(GXMISC::TGameTime_t curTime, sint32 baseHour, sint32 baseMin=0, sint32 baseSeconds=0)
	{
		GXMISC::TDiffTime_t secs = CGameMisc::ToSeconds(baseHour, baseMin, baseSeconds);
		GXMISC::TGameTime_t tempTimes = GXMISC::CTimeManager::ToLocalTime(curTime);
		sint32 offlineDay = (tempTimes-secs)/GXMISC::SECOND_IN_DAY;
		return offlineDay;
	}
};

namespace std
{
	template <>
	struct less<TRoleName_t>
	{
		bool operator()(const TRoleName_t& key1, const TRoleName_t& key2) const
		{
			return key1.toString() < key2.toString();
		}
	};

 	template <>
 	struct less<TCharArray2>
 	{
 		bool operator()(const TCharArray2& key1, const TCharArray2& key2) const
 		{
 			return key1.toString() < key2.toString();
 		}
 	};

	template <>
	struct less<TCharArray1>
	{
		bool operator()(const TCharArray1& key1, const TCharArray1& key2) const
		{
			return key1.toString() < key2.toString();
		}
	};

#ifdef COMP_GCC
	/*
	namespace tr1
	{
		template<>
		struct hash<TCharArray1>
			: public std::unary_function< TCharArray1, size_t>
		{
			size_t operator()(const TCharArray1& str) const
			{ 
				size_t _Val = 2166136261U;
				size_t _First = 0;
				size_t _Last = str.size();
				size_t _Stride = 1 + _Last / 10;

				if (_Stride < _Last)
					_Last -= _Stride;
				for(; _First < _Last; _First += _Stride)
					_Val = (size_t)16777619U * _Val ^ (size_t)str[(TCharArray1::size_type)_First];
				return (_Val);
			}

			size_t operator()(TCharArray1& str) const
			{ 
				size_t _Val = 2166136261U;
				size_t _First = 0;
				size_t _Last = str.size();
				size_t _Stride = 1 + _Last / 10;

				if (_Stride < _Last)
					_Last -= _Stride;
				for(; _First < _Last; _First += _Stride)
					_Val = (size_t)16777619U * _Val ^ (size_t)str[(TCharArray1::size_type)_First];
				return (_Val);
			}
		};

 		template<>
 		struct hash<TCharArray2>
 			: public std::unary_function< TCharArray2, size_t>
 		{
 			size_t operator()(const TCharArray2& str) const
 			{ 
 				size_t _Val = 2166136261U;
 				size_t _First = 0;
 				size_t _Last = str.size();
 				size_t _Stride = 1 + _Last / 10;
 
 				if (_Stride < _Last)
 					_Last -= _Stride;
 				for(; _First < _Last; _First += _Stride)
 					_Val = (size_t)16777619U * _Val ^ (size_t)str[(TCharArray2::size_type)_First];
 				return (_Val);
 			}
 
 			size_t operator()(TCharArray2& str) const
 			{ 
 				size_t _Val = 2166136261U;
 				size_t _First = 0;
 				size_t _Last = str.size();
 				size_t _Stride = 1 + _Last / 10;
 
 				if (_Stride < _Last)
 					_Last -= _Stride;
 				for(; _First < _Last; _First += _Stride)
 					_Val = (size_t)16777619U * _Val ^ (size_t)str[(TCharArray2::size_type)_First];
 				return (_Val);
 			}
 		};

		template<>
		struct hash<TRoleName_t>
			: public std::unary_function< TRoleName_t, size_t>
		{
			size_t operator()(const TRoleName_t& str) const
			{ 
				size_t _Val = 2166136261U;
				size_t _First = 0;
				size_t _Last = str.size();
				size_t _Stride = 1 + _Last / 10;

				if (_Stride < _Last)
					_Last -= _Stride;
				for(; _First < _Last; _First += _Stride)
					_Val = (size_t)16777619U * _Val ^ (size_t)str[(TRoleName_t::size_type)_First];
				return (_Val);
			}

			size_t operator()(TRoleName_t& str) const
			{ 
				size_t _Val = 2166136261U;
				size_t _First = 0;
				size_t _Last = str.size();
				size_t _Stride = 1 + _Last / 10;

				if (_Stride < _Last)
					_Last -= _Stride;
				for(; _First < _Last; _First += _Stride)
					_Val = (size_t)16777619U * _Val ^ (size_t)str[(TRoleName_t::size_type)_First];
				return (_Val);
			}
		};
	*/
#endif

	template<>
	struct hash<TCharArray1>
		: public std::unary_function< TCharArray1, size_t>
	{
		size_t operator()(const TCharArray1& str) const
		{ 
			size_t _Val = 2166136261U;
			size_t _First = 0;
			size_t _Last = str.size();
			size_t _Stride = 1 + _Last / 10;

			if (_Stride < _Last)
				_Last -= _Stride;
			for(; _First < _Last; _First += _Stride)
				_Val = (size_t)16777619U * _Val ^ (size_t)str[(TCharArray1::size_type)_First];
			return (_Val);
		}

		size_t operator()(TCharArray1& str) const
		{ 
			size_t _Val = 2166136261U;
			size_t _First = 0;
			size_t _Last = str.size();
			size_t _Stride = 1 + _Last / 10;

			if (_Stride < _Last)
				_Last -= _Stride;
			for(; _First < _Last; _First += _Stride)
				_Val = (size_t)16777619U * _Val ^ (size_t)str[(TCharArray1::size_type)_First];
			return (_Val);
		}
	};

 	template<>
 	struct hash<TCharArray2>
 		: public std::unary_function< TCharArray2, size_t>
 	{
 		size_t operator()(const TCharArray2& str) const
 		{ 
 			size_t _Val = 2166136261U;
 			size_t _First = 0;
 			size_t _Last = str.size();
 			size_t _Stride = 1 + _Last / 10;
 
 			if (_Stride < _Last)
 				_Last -= _Stride;
 			for(; _First < _Last; _First += _Stride)
 				_Val = (size_t)16777619U * _Val ^ (size_t)str[(TCharArray2::size_type)_First];
 			return (_Val);
 		}
 
 		size_t operator()(TCharArray2& str) const
 		{ 
 			size_t _Val = 2166136261U;
 			size_t _First = 0;
 			size_t _Last = str.size();
 			size_t _Stride = 1 + _Last / 10;
 
 			if (_Stride < _Last)
 				_Last -= _Stride;
 			for(; _First < _Last; _First += _Stride)
 				_Val = (size_t)16777619U * _Val ^ (size_t)str[(TCharArray2::size_type)_First];
 			return (_Val);
 		}
 	};

	template<>
	struct hash<TRoleName_t>
		: public std::unary_function< TRoleName_t, size_t>
	{
		size_t operator()(const TRoleName_t& str) const
		{ 
			size_t _Val = 2166136261U;
			size_t _First = 0;
			size_t _Last = str.size();
			size_t _Stride = 1 + _Last / 10;

			if (_Stride < _Last)
				_Last -= _Stride;
			for(; _First < _Last; _First += _Stride)
				_Val = (size_t)16777619U * _Val ^ (size_t)str[(TRoleName_t::size_type)_First];
			return (_Val);
		}

		size_t operator()(TRoleName_t& str) const
		{ 
			size_t _Val = 2166136261U;
			size_t _First = 0;
			size_t _Last = str.size();
			size_t _Stride = 1 + _Last / 10;

			if (_Stride < _Last)
				_Last -= _Stride;
			for(; _First < _Last; _First += _Stride)
				_Val = (size_t)16777619U * _Val ^ (size_t)str[(TRoleName_t::size_type)_First];
			return (_Val);
		}
	};
}

#ifdef OS_WINDOWS
#include <xhash>
_STDEXT_BEGIN

inline size_t hash_value(const TRoleName_t& _Keyval)
{
	return std::_Hash_seq((const unsigned char *)_Keyval.toString().c_str(), _Keyval.size());
}
inline size_t hash_value(const TCharArray1& _Keyval)
{
	return std::_Hash_seq((const unsigned char *)_Keyval.toString().c_str(), _Keyval.size());
}
inline size_t hash_value(const TCharArray2& _Keyval)
{
	return std::_Hash_seq((const unsigned char *)_Keyval.toString().c_str(), _Keyval.size());
}

template<>
class hash_compare<TRoleName_t, std::less<TRoleName_t> >
{
protected:
	typedef TRoleName_t _Kty;
	typedef std::less<TRoleName_t> _Pr;

public:
	enum
	{	// parameters for hash table
		bucket_size = 4,	// 0 < bucket_size
		min_buckets = 8};	// min_buckets = 2 ^^ N, 0 < N

		hash_compare()
			: comp()
		{	// construct with default comparator
		}

		hash_compare(_Pr _Pred)
			: comp(_Pred)
		{	// construct with _Pred comparator
		}

		size_t operator()(const _Kty& _Keyval) const
		{	// hash _Keyval to size_t value by pseudorandomizing transform
			long _Quot = (long)(hash_value(_Keyval) & LONG_MAX);
			ldiv_t _Qrem = ldiv(_Quot, 127773);

			_Qrem.rem = 16807 * _Qrem.rem - 2836 * _Qrem.quot;
			if (_Qrem.rem < 0)
				_Qrem.rem += LONG_MAX;
			return ((size_t)_Qrem.rem);
		}

		bool operator()(const _Kty& _Keyval1, const _Kty& _Keyval2) const
		{	// test if _Keyval1 ordered before _Keyval2
			return (comp(_Keyval1, _Keyval2));
		}

protected:
	_Pr comp;	// the comparator object
};

template<>
class hash_compare<TCharArray1, std::less<TCharArray1> >
{
protected:
	typedef TCharArray1 _Kty;
	typedef std::less<TCharArray1> _Pr;

public:
	enum
	{	// parameters for hash table
		bucket_size = 4,	// 0 < bucket_size
		min_buckets = 8};	// min_buckets = 2 ^^ N, 0 < N

		hash_compare()
			: comp()
		{	// construct with default comparator
		}

		hash_compare(_Pr _Pred)
			: comp(_Pred)
		{	// construct with _Pred comparator
		}

		size_t operator()(const _Kty& _Keyval) const
		{	// hash _Keyval to size_t value by pseudorandomizing transform
			long _Quot = (long)(hash_value(_Keyval) & LONG_MAX);
			ldiv_t _Qrem = ldiv(_Quot, 127773);

			_Qrem.rem = 16807 * _Qrem.rem - 2836 * _Qrem.quot;
			if (_Qrem.rem < 0)
				_Qrem.rem += LONG_MAX;
			return ((size_t)_Qrem.rem);
		}

		bool operator()(const _Kty& _Keyval1, const _Kty& _Keyval2) const
		{	// test if _Keyval1 ordered before _Keyval2
			return (comp(_Keyval1, _Keyval2));
		}

protected:
	_Pr comp;	// the comparator object
};

template<>
class hash_compare<TCharArray2, std::less<TCharArray2> >
{
protected:
	typedef TCharArray2 _Kty;
	typedef std::less<TCharArray2> _Pr;

public:
	enum
	{	// parameters for hash table
		bucket_size = 4,	// 0 < bucket_size
		min_buckets = 8};	// min_buckets = 2 ^^ N, 0 < N

		hash_compare()
			: comp()
		{	// construct with default comparator
		}

		hash_compare(_Pr _Pred)
			: comp(_Pred)
		{	// construct with _Pred comparator
		}

		size_t operator()(const _Kty& _Keyval) const
		{	// hash _Keyval to size_t value by pseudorandomizing transform
			long _Quot = (long)(hash_value(_Keyval) & LONG_MAX);
			ldiv_t _Qrem = ldiv(_Quot, 127773);

			_Qrem.rem = 16807 * _Qrem.rem - 2836 * _Qrem.quot;
			if (_Qrem.rem < 0)
				_Qrem.rem += LONG_MAX;
			return ((size_t)_Qrem.rem);
		}

		bool operator()(const _Kty& _Keyval1, const _Kty& _Keyval2) const
		{	// test if _Keyval1 ordered before _Keyval2
			return (comp(_Keyval1, _Keyval2));
		}

protected:
	_Pr comp;	// the comparator object
};

_STDEXT_END
#endif

#endif	// _GAME_MISC_H_
