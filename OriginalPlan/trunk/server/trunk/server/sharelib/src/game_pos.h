#ifndef _GAME_POS_H_
#define _GAME_POS_H_

#include "game_util.h"
#include "packet_def.h"
#include "base_packet_def.h"

#pragma pack(push, 1)

typedef struct TAdjust
{
	sint32 x;
	sint32 y;
}TAdjust;

/**
* \brief 场景坐标
*/
typedef struct AxisPos
{
	// @member
public:
	TAxisPos_t x;    ///< 横坐标
	TAxisPos_t y;    ///< 纵坐标

public:
	DPacketToString2Alias(_AxisPos, TAxisPos_t, XPos, x, TAxisPos_t, YPos, y);

public:
	TAxisPos_t getX() const { return x; }
	void setX(TAxisPos_t val) { x = val; }
	TAxisPos_t getY() const { return y; }
	void setY(TAxisPos_t val) { y = val; }

	void cleanUp( )
	{
		x = INVALID_AXIS_POS;
		y = INVALID_AXIS_POS;
	}

	bool isValid() const
	{
//         gxAssert(x == INVALID_AXIS_POS || (x >= 0 && x < 1000));
//         gxAssert(y == INVALID_AXIS_POS || (y >= 0 && y < 1000));
		return x != INVALID_AXIS_POS && y != INVALID_AXIS_POS;
	}

	/**
	* \brief 构造函数
	*
	*/
	AxisPos()
	{
		cleanUp();
	}

	/**
	* \brief 构造函数
	*
	*/
	AxisPos(const TAxisPos_t x, const TAxisPos_t y)
	{
		this->x = x;
		this->y = y;
	}

	/**
	* \brief 拷贝构造函数
	*
	*/
	AxisPos(const AxisPos &pos)
	{
		x = pos.x;
		y = pos.y;
	}

	/**
	* \brief 赋值操作符号
	*
	*/
	AxisPos & operator = (const AxisPos &pos)
	{
		x = pos.x;
		y = pos.y;
		return *this;
	}

	AxisPos& operator -= (uint16 range)
	{
		x -= range;
		y -= range;
		return *this;
	}

	AxisPos& operator += (uint16 range)
	{
		x += range;
		y += range;

		return *this;
	}

	uint64 toSinglePos()
	{
		uint64 pos;
		pos = x;
		pos <<= sizeof(TAxisPos_t)*8;
		pos |= y;
		return pos;
	}

// 	/**
// 	* \brief 重载+运算符号
// 	*
// 	*/
// 	const _AxisPos & operator+= (const _AxisPos &pos)
// 	{
// 		x += pos.x;
// 		y += pos.y;
// 		return *this;
// 	}
// 
// 	const _AxisPos & operator+= (const TAdjust &adjust)
// 	{
// 		x += adjust.x;
// 		y += adjust.y;
// 		return *this;
// 	}

	/**
	* \brief 重载+=运算符号
	*
	*/
	const AxisPos & operator+= (const AxisPos &pos)
	{
		x += pos.x;
		y += pos.y;
		return *this;
	}

	const AxisPos & operator+= (const TAdjust &adjust)
	{
		x += adjust.x;
		y += adjust.y;
		return *this;
	}

// 	/**
// 	* \brief 重载-运算符号
// 	*
// 	*/
// 	const _AxisPos & operator- (const _AxisPos &pos)
// 	{
// 		x -= pos.x;
// 		y -= pos.y;
// 		return *this;
// 	}
// 	
// 	const _AxisPos & operator- (const TAdjust &adjust)
// 	{
// 		x -= adjust.x;
// 		y -= adjust.y;
// 		return *this;
// 	}
	/**
	* \brief 重载-=运算符号
	*
	*/
	const AxisPos & operator-= (const AxisPos &pos)
	{
		x -= pos.x;
		y -= pos.y;
		return *this;
	}

	const AxisPos & operator-= (const TAdjust &adjust)
	{
		x -= adjust.x;
		y -= adjust.y;
		return *this;
	}

	/**
	* \brief 重载==逻辑运算符号
	*
	*/
	const bool operator== (const AxisPos &pos) const
	{
		return (x == pos.x && y == pos.y);
	}
    /**
	* \brief 重载==逻辑运算符号
	*
	*/
	const bool operator != (const AxisPos &pos) const
	{
		return !(x == pos.x && y == pos.y);
	}

	/**
	* \brief 重载>逻辑运算符号
	*
	*/
	const bool operator> (const AxisPos &pos) const
	{
		return (x > pos.x && y > pos.y);
	}

	/**
	* \brief 重载>=逻辑运算符号
	*
	*/
	const bool operator>= (const AxisPos &pos) const
	{
		return (x >= pos.x && y >= pos.y);
	}

	/**
	* \brief 重载<逻辑运算符号
	*
	*/
	const bool operator< (const AxisPos &pos) const
	{
		return (x < pos.x && y < pos.y);
	}

	/**
	* \brief 重载<=逻辑运算符号
	*
	*/
	const bool operator<= (const AxisPos &pos) const
	{
		return (x <= pos.x && y <= pos.y);
	}

	/**
	* \brief 以自身为中心点，获取到另外一个坐标的方向
	* \param pos 另外一个坐标点
	* \return 方向
	*/
	const int getDirect(const AxisPos *pos) const
	{
		TAxisPos_t diffX = this->x-pos->x;
		TAxisPos_t diffY = this->y-pos->y;

		if(diffX > 0)
		{
			if(diffY > 0)
			{
				return (TDir_t)DIR_6;
			}
			else if(diffY == 0)
			{
				return (TDir_t)DIR_5;
			}
			else
			{
				return (TDir_t)DIR_4;
			}

		}
		else if(diffX == 0)
		{
			if(diffY > 0)
			{
				return (TDir_t)DIR_7;
			}
			else if(diffY == 0)
			{
				return (TDir_t)DIR_0;
			}
			else
			{
				return (TDir_t)DIR_3;
			}
		}
		else
		{
			if(diffY > 0)
			{
				return (TDir_t)DIR_0;
			}
			else if(diffY == 0)
			{
				return (TDir_t)DIR_1;
			}
			else
			{
				return (TDir_t)DIR_2;
			}
		}
	}
}TAxisPos;
static const TAxisPos INVALID_AXIS_POS_T;

typedef std::list<TAxisPos> TAxisPosList;
typedef std::vector<TAxisPos> TAxisPosVec;
typedef CArray1<TAxisPos> TPackMovePosList;
typedef std::list<TAxisPos> TLogicMovePosList;

typedef struct AreaRect
{
	TAxisPos_t		left;
	TAxisPos_t		top;
	TAxisPos_t		right;
	TAxisPos_t		bottom;

	AreaRect()
	{
		cleanUp( ) ;
	}

	AreaRect(TAxisPos& leftTop, TAxisPos& rightBottom)
	{
		set(leftTop, rightBottom);
	}

	void cleanUp( )
	{
		left = 0 ;
		top =0 ;
		right =0 ;
		bottom=0 ;
	}

	bool isValid()
	{
		return left != 0 || top != 0 || right != 0 || bottom != 0;
	}

	void set(const TAxisPos& leftTop, const TAxisPos& rightBottom)
	{
		left = leftTop.x;
		top = leftTop.y;
		right = rightBottom.x;
		bottom = rightBottom.y;
	}

	TAxisPos getLeftTop()
	{
		TAxisPos temp;
		temp.x = left;
		temp.y = top;
		return temp;
	}

	TAxisPos getRightBottom()
	{
		TAxisPos temp;
		temp.x = right;
		temp.y = bottom;
		return temp;
	}

	bool isContain( TAxisPos_t x, TAxisPos_t y ) const
	{
		return ((x >= left) && (x <= right) && (y >= top) && (y <= bottom) );
	}
}TAreaRect;

// 地图位置
typedef struct MapPos
{
public:
	TMapID_t mapID;
	TAxisPos aixPos;

	operator TUMapID_t()
	{
		TUMapID_t umapID = mapID;
		return( umapID<<32) + (aixPos.x<<16) + (aixPos.y);
	}

	operator TUMapID_t() const
	{
		TUMapID_t umapID = mapID;
		return( umapID<<32) + (aixPos.x<<16) + (aixPos.y);
	}

}TMapPos;

inline bool luaval_to_axispos(lua_State* L, int lo, const char* type, AxisPos* ret, const char* funcName = "")
{
	if (nullptr == L || nullptr == ret || lua_gettop(L) < lo)
		return false;

	tolua_Error tolua_err;
	bool ok = true;
	if (!tolua_istable(L, lo, 0, &tolua_err))
	{
		luaval_to_native_err(L, "#ferror:", &tolua_err, funcName);
		ok = false;
	}

	if (ok)
	{
		lua_pushlstring(L, "x", 1);
		if (0 != lua_next(L, lo))
		{
			if (!luaval_to_sint16(L, lo, &ret->x, funcName))
			{
				ok = false;
			}

			lua_pop(L, 2);
		}
		else
		{
			ok = false;
		}
	}

	if (ok)
	{
		lua_pushlstring(L, "y", 1);
		if (0 != lua_next(L, lo))
		{
			if (!luaval_to_sint16(L, lo, &ret->y, funcName))
			{
				ok = false;
			}

			lua_pop(L, 2);
		}
		else
		{
			ok = false;
		}
	}

	return ok;
}

inline void axispos_to_luaval(lua_State* L, const char* type, const AxisPos& v)
{
	lua_newtable(L);

	if (nullptr == L)
	{
		return;
	}

	lua_tinker::push(L, "x");
	lua_tinker::push(L, v.x);
	lua_rawset(L, -3);

	lua_tinker::push(L, "y");
	lua_tinker::push(L, v.y);
	lua_rawset(L, -3);
}

#pragma pack(pop)

#endif	// _GAME_POS_H_