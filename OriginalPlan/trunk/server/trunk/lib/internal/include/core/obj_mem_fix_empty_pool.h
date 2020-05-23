#ifndef _OBJ_MEM_FIX_EMPTY_POOL_H_
#define _OBJ_MEM_FIX_EMPTY_POOL_H_

#include <limits>

#include "types_def.h"
#include "debug.h"
#include "hash_util.h"

namespace GXMISC
{
#pragma pack(push, 1)

	// 固定大小的对象池
	template<class T, class KeyT, sint32 needProtectNum = 0>
	class CFixEmptyObjPool
	{
		typedef uint32 ObjPoolID_t;
		typedef std::set<ObjPoolID_t> TEmpytList;
		typedef CHashMap<KeyT, ObjPoolID_t> TContainerHash;

	public:
		typedef struct _PoolNode
		{
			KeyT	key;
			bool	usedFlag;
			T		obj;
		}TPoolNode;

	public:
		CFixEmptyObjPool( void )
		{
			_maxCount		= -1;
		}

		~CFixEmptyObjPool( void )
		{
			if(NULL != _objPool)
			{
				_objPool -= needProtectNum/2;
				DSafeDeleteArray(_objPool);
			}
		}

		bool init( sint32 nMaxCount )
		{
			gxAssert( nMaxCount > 0 );
			if ( nMaxCount <= 0 )
			{
				return false;
			}

			_maxCount = nMaxCount;
			// 加上needProtectNum防止数据溢出,使得实际使用的数据被覆盖
			_objPool = new TPoolNode[_maxCount+needProtectNum];

			for(ObjPoolID_t index = 0; index < (uint32)_maxCount; ++index)
			{
				_objPool[index].usedFlag = false;
				_emptyList.insert(index);
			}

			_objPool += (needProtectNum/2);

			return _objPool != NULL;
		}

		T* newObj( KeyT key )
		{
			gxAssert(_maxCount > 0);
			if(_emptyList.empty())
			{
				return NULL;
			}
			ObjPoolID_t index = *(_emptyList.begin());
			_objPool[index].usedFlag = true;
			_objPool[index].key = key;
			_emptyList.erase(_emptyList.begin());
			_usedHash.insert(typename TContainerHash::value_type(key, index));
			if(!std::is_pod<T>::value)
			{
				gxContReset(_objPool[index].obj);
			}
			else
			{
				DZeroPtr(&(_objPool[index].obj));
			}
			return &(_objPool[index].obj);
		}

		void deleteObj( KeyT key )
		{
			typename TContainerHash::iterator iter = _usedHash.find(key);
			if(iter == _usedHash.end())
			{
				return;
			}

			ObjPoolID_t index = iter->second;
			if(!std::is_pod<T>::value)
			{
				gxContReset(_objPool[index].obj);
			}
			else
			{
				DZeroPtr(&(_objPool[index].obj));
			}
			_objPool[index].usedFlag = false;
			_objPool[index].key = 0;
			_usedHash.erase(key);
			_emptyList.insert(index);
		}

		bool dumpToFile(const char* fileName)
		{
			FILE* fp;
			fp = fopen(fileName,"wb");
			if(NULL == fp)
			{
				return false;
			}

			if(!std::is_pod<T>::value)
			{
				sint32 num = _usedHash.size();
				fwrite(&num, sizeof(num), 1, fp);
				for(typename TContainerHash::iterator iter= _usedHash.begin(); iter != _usedHash.end(); ++iter)
				{
					ObjPoolID_t index = iter->second;
					_objPool[index].obj.dumpToFile(fp);
				}
			}
			else
			{
				fwrite(&_maxCount, sizeof(_maxCount), 1, fp);
				fwrite(_objPool, sizeof(TPoolNode), _maxCount, fp);
			}

			fclose(fp);
			return true;
		}

		bool dumpFromFile(const char* fileName)
		{
			FILE* fp;
			fp = fopen(fileName,"rb");
			if(NULL == fp)
			{
				return false;
			}

			sint32 num = 0;
			fread(&num, sizeof(num), 1, fp);
			if(0 == num)
			{
				return true;
			}

			if(!init(num))
			{
				return false;
			}

			if(std::is_pod<T>::value)
			{
				fread(_objPool, sizeof(TPoolNode), num, fp);
			}
			else
			{
				for(ObjPoolID_t index = 0; index < num; ++index)
				{
					_objPool[index].obj.dumpFromFile(fp);
					_objPool[index].usedFlag = true;
				}
			}

			for(ObjPoolID_t index = 0; index < num; ++index)
			{
				_emptyList.erase(index);
				_usedHash.insert(typename TContainerHash::value_type(_objPool[index].key, index));
			}

			fclose(fp);

			return true;
		}

		sint32 getCount( void ) const
		{
			return _usedHash.size();
		}

		TPoolNode* getObjPool()
		{
			return getObjPool(0);
		}

		TPoolNode* getObjPool(ObjPoolID_t index)
		{
			return &(_objPool[index]);
		}

		bool empty()
		{
			return _emptyList.empty();
		}

	private:
		TEmpytList		_emptyList;
		TContainerHash	_usedHash;
		TPoolNode*		_objPool;
		sint32          _maxCount;
	};

#pragma pack(pop)
}

#endif // _OBJ_MEM_FIX_EMPTY_POOL_H_