#ifndef _OBJ_ATTR_FUNC_H_
#define _OBJ_ATTR_FUNC_H_

#include "types_def.h"

template <typename T>
class CObjAddAttrFunc
{
public:
	typedef uint32 (T::*Func)(uint32);
};

template <typename T>
class CObjGetAttrFunc
{
public:
	typedef uint32 (T::*Func)()const;
};

template <typename T>
class CObjAttrFunc
{
public:
	CObjAttrFunc()
	{
		memset(&_attrFunc, 0, sizeof(_attrFunc));
	}

	~CObjAttrFunc()
	{
		memset(&_attrFunc, 0, sizeof(_attrFunc));
	}

public:
	void					registerFunc( uint8 index, const typename T::Func pFunc )
	{
		if ( checkIndexValid(index) )
		{
			_attrFunc[index] = pFunc;
		}
	}

	const typename T::Func	getFunc( uint8 index ) const
	{
		if ( checkIndexValid(index) )
		{
			return _attrFunc[index];
		}
		return NULL;
	}

	bool checkIndexValid( uint8 index ) const
	{
		if ( index <= ATTR_FIGHT_INVALID || index >= ATTR_CHAR_CURR_MAX )
		{
			return false;
		}

		return true;
	}

private:
	typename T::Func _attrFunc[ATTR_CHAR_CURR_MAX];
};

#endif