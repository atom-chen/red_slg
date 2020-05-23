/**
* Date: 2011-6-14 22:23:38
* Description: 管理类, 可通过几个键查找对象
*/
#ifndef HASH_MANAGER_H_
#define HASH_MANAGER_H_

#include "base_util.h"
#include "debug.h"
#include "string_common.h"
#include "hash_util.h"
#include "obj_mem_fix_pool.h"

namespace GXMISC
{
	template<typename T, bool flag = std::is_class<T>::value>
	struct HashMultiIndexTtraits;

	template<typename T>
	struct HashMultiIndexTtraits<T, true>
	{
		typedef typename T::HashKeyType KeyType;
		const static KeyType InvalidKey = T::InvalidKey;
	};

	template<typename T>
	struct HashMultiIndexTtraits<T, false>
	{
		typedef T KeyType;
	};

    // 声明定义key的宏 
    // keytype
    // setKey
    // getKey()
    // isKey()
    // keyToString()~key4ToString()
    // INVALID_KEY~INVALID_KEY4
    //
    // @todo 添加了keyToString(), setKey()

    // 定义宏
#define DMultiIndexImpl1(MultiIndexKeyIDType, MultiIndexKeyID, MultiIndexInvalidID)   \
public:     \
    typedef MultiIndexKeyIDType KeyType;    \
    const static GXMISC::HashMultiIndexTtraits<KeyType>::KeyType INVALID_KEY = MultiIndexInvalidID;     \
    void setKey(KeyType key)    \
    {   \
    MultiIndexKeyID = key;  \
    }   \
    KeyType getKey()    \
    {   \
    return MultiIndexKeyID; \
    }   \
    bool    isKey()     \
    {   \
    return getKey() != INVALID_KEY; \
    }   \
    const std::string keyToString() const   \
    {   \
    return GXMISC::gxToString(MultiIndexKeyID);   \
    }

#define DMultiIndexImplNotInvalid1(MultiIndexKeyIDType, MultiIndexKeyID)   \
public:     \
    typedef MultiIndexKeyIDType KeyType;    \
    const static GXMISC::HashMultiIndexTtraits<KeyType>::KeyType INVALID_KEY;       \
    void setKey(KeyType key)    \
    {   \
    MultiIndexKeyID = key;  \
    }   \
    KeyType getKey()    \
    {   \
    return MultiIndexKeyID; \
    }   \
    bool    isKey()     \
    {   \
    return getKey() != INVALID_KEY; \
    }   \
    const std::string keyToString() const   \
    {   \
    return GXMISC::gxToString(MultiIndexKeyID);   \
    }

#define DMultiIndexImpl2(MultiIndexKeyIDType, MultiIndexKeyID, MultiIndexInvalidID)   \
public: \
    typedef MultiIndexKeyIDType KeyType2;    \
    const static GXMISC::HashMultiIndexTtraits<KeyType2>::KeyType INVALID_KEY2 = MultiIndexInvalidID; \
    void setKey2(KeyType2 key)    \
    {   \
    MultiIndexKeyID = key;  \
    }   \
    KeyType2 getKey2()    \
    {   \
    return MultiIndexKeyID; \
    }   \
    bool    isKey2()\
    {   \
    return getKey2() != INVALID_KEY2; \
    }   \
    const    std::string key2ToString() const \
    {   \
    return GXMISC::gxToString(MultiIndexKeyID);    \
    }
#define DMultiIndexImplNotInvalid2(MultiIndexKeyIDType, MultiIndexKeyID)   \
public: \
    typedef MultiIndexKeyIDType KeyType2;    \
    const static GXMISC::HashMultiIndexTtraits<KeyType2>::KeyType INVALID_KEY2; \
    void setKey2(KeyType2 key)    \
    {   \
    MultiIndexKeyID = key;  \
    }   \
    KeyType2 getKey2()    \
    {   \
    return MultiIndexKeyID; \
    }   \
    bool    isKey2()\
    {   \
    return getKey2() != INVALID_KEY2; \
    }   \
    const    std::string key2ToString() const \
    {   \
    return GXMISC::gxToString(MultiIndexKeyID);    \
    }

#define DMultiIndexImpl3(MultiIndexKeyIDType, MultiIndexKeyID, MultiIndexInvalidID)   \
public: \
    typedef MultiIndexKeyIDType KeyType3;    \
    const static GXMISC::HashMultiIndexTtraits<KeyType3>::KeyType INVALID_KEY3 = MultiIndexInvalidID; \
    void setKey3(KeyType3 key)    \
    {   \
    MultiIndexKeyID = key;  \
    }   \
    KeyType3 getKey3()    \
    {   \
    return MultiIndexKeyID; \
    }   \
    bool    isKey3()\
    {   \
    return getKey3() != INVALID_KEY3; \
    }   \
    const    std::string key3ToString() const \
    {   \
    return GXMISC::gxToString(MultiIndexKeyID);    \
    }
#define DMultiIndexImplNotInvalid3(MultiIndexKeyIDType, MultiIndexKeyID)   \
public: \
    typedef MultiIndexKeyIDType KeyType3;    \
    const static GXMISC::HashMultiIndexTtraits<KeyType3>::KeyType INVALID_KEY3; \
    void setKey3(KeyType3 key)    \
    {   \
    MultiIndexKeyID = key;  \
    }   \
    KeyType3 getKey3()    \
    {   \
    return MultiIndexKeyID; \
    }   \
    bool    isKey3()\
    {   \
    return getKey3() != INVALID_KEY3; \
    }   \
    const    std::string key3ToString() const \
    {   \
    return GXMISC::gxToString(MultiIndexKeyID);    \
    }

#define DMultiIndexImpl4(MultiIndexKeyIDType, MultiIndexKeyID, MultiIndexInvalidID)   \
public: \
    typedef MultiIndexKeyIDType KeyType4;    \
    const static GXMISC::HashMultiIndexTtraits<KeyType4>::KeyType INVALID_KEY4 = MultiIndexInvalidID; \
    void setKey4(KeyType4 key)    \
    {   \
    MultiIndexKeyID = key;  \
    }   \
    KeyType4 getKey4()    \
    {   \
    return MultiIndexKeyID; \
    }   \
    bool    isKey4()\
    {   \
    return getKey4() != INVALID_KEY4; \
    }   \
    const    std::string key4ToString() const   \
    {   \
    return GXMISC::gxToString(MultiIndexKeyID);    \
    }
#define DMultiIndexImplNotInvalid4(MultiIndexKeyIDType, MultiIndexKeyID)   \
public: \
    typedef MultiIndexKeyIDType KeyType4;    \
    const static GXMISC::HashMultiIndexTtraits<KeyType4>::KeyType INVALID_KEY4; \
    void setKey4(KeyType4 key)    \
    {   \
    MultiIndexKeyID = key;  \
    }   \
    KeyType4 getKey4()    \
    {   \
    return MultiIndexKeyID; \
    }   \
    bool    isKey4()\
    {   \
    return getKey4() != INVALID_KEY4; \
    }   \
    const    std::string key4ToString() const   \
    {   \
    return GXMISC::gxToString(MultiIndexKeyID);    \
    }

/// 迭代函数
#define DMultiIndexIterFunc(T)	\
private:	\
	Iterator __iter;	\
public:	\
	T* getBegin(){	\
if (size() <= 0){	\
		return NULL;	\
}	\
__iter = begin(); \
return __iter->second;	\
	}	\
	T* getNext(){	\
		if (__iter == end()){	\
				return NULL;	\
		}	\
		++__iter;	\
		return __iter->second;	\
	}
    /**
    * @param isNeedFree 表示是否需要在析构的时候释放所存的指针对象
    */
	template<typename T, bool IsNeedFree = false,
		const typename HashMultiIndexTtraits<typename T::KeyType>::KeyType InvalidKey=T::INVALID_KEY>
    class CHashMultiIndex
    {
    protected:
        typedef T*  _ValueType;
        typedef typename T::KeyType _KeyType;
        typedef CHashMap<_KeyType, _ValueType> Containter;
        typedef typename Containter::iterator _Iterator;
		typedef T _ValueProType;		// 原类型

    public:
		typedef _ValueProType					ValueProType;
        typedef _ValueType						ValueType;
        typedef _KeyType						KeyType;
        typedef std::pair<KeyType, ValueType>	KeyValueType;
        typedef _Iterator						Iterator;
        typedef void (*TTraverseCallType)(ValueType&, void* arg);   // 遍历的函数指针          // @todo 采用对象绑定的方式做

    public:
        static const ValueType InvalidValue;

    public:
        CHashMultiIndex(const std::string& mgrName="") : _mgrName(mgrName){}
        ~CHashMultiIndex()
        {
            if(IsNeedFree)
            {
                traverse(&Free, NULL);
            }

            _manager.clear();
        }

        static void Free(ValueType& val, void* arg)
        {
            if(val != InvalidValue)
            {
                gxAssert(val->isKey());
                DSafeDelete(val);
            }
        }
    public:
        bool add(ValueType val)
        {
            // 键无效
            if(!val->isKey())
            {
				gxWarning("key invalid! Mgr={0}, Key={1}", toString(), val->keyToString().c_str());
                return false;
            }

            // 已经存在返回
            KeyType key = val->getKey();
            if(anyExist(key))
            {
                gxError("Key repeat! Mgr={0}, Key={1}", toString(), val->keyToString().c_str());
                return false;
            }

            _manager[key] = val;

            return true;
        }

        ValueType remove(const KeyType& key)
        {
            gxAssert(key != InvalidKey);
            gxAssert(_manager.size() > 0);

            if(key == InvalidKey)
            {
                gxWarning("Key is invalid! Mgr={0}, Key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }
            Iterator iter = _manager.find(key);
            if(iter == _manager.end())
            {
                gxWarning("Can't find value! Mgr={0}, Key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }
            ValueType val = iter->second;
            _manager.erase(key);

            if(IsNeedFree)
            {
                gxInfo("Remove from manager! Mgr={0}, Key={1}", toString(), gxToString(key).c_str());
                DSafeDelete(val);
                return InvalidValue;
            }

            return val;           
        }
        bool isExist(const KeyType& key)
        {
            //            gxAssert(key != InvalidKey);
            if(key == InvalidKey){ return false; }

            return _manager.find(key) != _manager.end();
        }
        bool anyExist(const KeyType& key1)
        {
            return isExist(key1);
        }

        ValueType find(const KeyType& key)
        {
            //            gxAssert(key != InvalidKey);
            if(isExist(key))
            {
                return _manager.find(key)->second;
            }

            return InvalidValue;
        }

        Iterator begin()
        {
            return _manager.begin();
        }
        Iterator end()
        {
            return _manager.end();
        }
        
        void traverse(TTraverseCallType call, void* arg)
        {
            for(Iterator iter = begin(); iter != end(); ++iter)
            {
                call(iter->second, arg);
            }
        }

        uint32 size()
        {
            return (uint32)_manager.size();
        }

    public:
        void genStrName()
        {
			_strName = gxToString("MgrName={0}",_mgrName.c_str());
        }
        const char* toString()
        {
            return _strName.c_str();
        }
    private:
        Containter _manager;
        std::string _mgrName;
        std::string _strName;
    };

	template<typename T, bool IsNeedFree = false,
		const typename HashMultiIndexTtraits<typename T::KeyType>::KeyType InvalidKey = T::INVALID_KEY>
	class CPlayerMgrPool : public GXMISC::CHashMultiIndex<T, IsNeedFree, InvalidKey>
	{
	public:
		typedef GXMISC::CHashMultiIndex<T, IsNeedFree, InvalidKey> TBaseType;
		typedef CPlayerMgrPool TMyType;

	public:
		CPlayerMgrPool(){}
		~CPlayerMgrPool(){}

	public:
		bool init(sint32 maxNum)
		{
			return _objPool.init(maxNum);
		}

		typename TBaseType::ValueType addNewPlayer(typename T::KeyType key1)
		{
			typename TBaseType::ValueType player = _objPool.newObj();
			if (NULL == player) {
				gxError( "Can't new player! Key={0}", key1);
				return TBaseType::InvalidValue;
			}

			player->setKey(key1);
			if(!this->add(player))
			{
				gxError("Can't add player!Key={0}", key1);
				return InvalidKey;
			}

			return player;
		}

		void freeNewPlayer(typename TBaseType::ValueType val);
		void delPlayer(typename T::KeyType key1);
		uint32 size();

	protected:
		GXMISC::CFixObjPool<T>   _objPool;           // 对象池
	};

	template<typename T, bool IsNeedFree,
		const typename HashMultiIndexTtraits<typename T::KeyType>::KeyType InvalidKey>
		uint32 GXMISC::CPlayerMgrPool<T, IsNeedFree, InvalidKey>::size()
	{
		return _objPool.size();
	}

	template<typename T, bool IsNeedFree,
		const typename HashMultiIndexTtraits<typename T::KeyType>::KeyType InvalidKey>
		void GXMISC::CPlayerMgrPool<T, IsNeedFree, InvalidKey>::delPlayer( typename T::KeyType key1 )
	{
		typename TBaseType::ValueType player = this->remove(key1);
		if(NULL != player)
		{
			_objPool.deleteObj(player);
		}
	}

	template<typename T, bool IsNeedFree,
		const typename HashMultiIndexTtraits<typename T::KeyType>::KeyType InvalidKey>
		void GXMISC::CPlayerMgrPool<T, IsNeedFree, InvalidKey>::freeNewPlayer( typename TBaseType::ValueType val )
	{
		_objPool.deleteObj(val);
	}

	template<typename T, bool isNeedFree, const typename HashMultiIndexTtraits<typename T::KeyType>::KeyType InvalidKey>
	const typename GXMISC::CHashMultiIndex<T, isNeedFree, InvalidKey>::ValueType 
		GXMISC::CHashMultiIndex<T, isNeedFree, InvalidKey>::InvalidValue = NULL;

    template<typename T, bool IsNeedFree = false, 
        const typename HashMultiIndexTtraits<typename T::KeyType>::KeyType InvalidKey=T::INVALID_KEY,
        const typename HashMultiIndexTtraits<typename T::KeyType2>::KeyType InvalidKey2
			=T::INVALID_KEY2>
    class CHashMultiIndex2
    {
        typedef T*          _ValueType;
        typedef typename T::KeyType _KeyType;
        typedef typename T::KeyType2 _KeyType2;
        typedef CHashMap<_KeyType, _ValueType>      Containter;
        typedef typename Containter::iterator _Iterator;
        typedef CHashMap<_KeyType2, _ValueType>     Containter2;
        typedef typename Containter2::iterator _Iterator2;
		typedef T _ValueProType;		// 原类型

    public:
		typedef _ValueProType					ValueProType;
        typedef T*								ValueType;
        typedef _KeyType						KeyType;
        typedef _KeyType2                       KeyType2;
        typedef std::pair<KeyType, ValueType>	KeyValueType;
        typedef _Iterator						Iterator;
        typedef std::pair<KeyType2, ValueType>	KeyValueType2;
        typedef _Iterator2                      Iterator2;
        typedef void (*TTraverseCallType)(ValueType&, void* arg);   // 遍历的函数类型

    public:
        static const ValueType InvalidValue;

    public:
        CHashMultiIndex2(const std::string& mgrName="") : _mgrName(mgrName) { genStrName(); }
        ~CHashMultiIndex2()
        {
            if(IsNeedFree)
            {
                traverse(&Free, NULL);
            }

            _manager1.clear();
            _manager2.clear();
        }

        static void Free(ValueType& val, void* arg)
        {
            if(val != InvalidValue)
            {
                gxAssert(val->isKey());
				gxAssert(val->isKey2());
                DSafeDelete(val);
            }
        }

    public:
        bool add(ValueType val)
        {
            gxAssert(_manager1.size() == _manager2.size());
            gxAssert(val->isKey());
			gxAssert(val->isKey2());
            if(!val->isKey())
            {
                return false;
            }

            KeyType key1 = val->getKey();
            KeyType2 key2 = val->getKey2();
            if(anyExist(key1, key2))
            {
				gxError("Key repeat! Mgr={0}, key={1}, key2={2}", _mgrName.c_str(), val->keyToString().c_str(), val->key2ToString().c_str());
                gxAssert(false);
                return false;
            }

            _manager1[key1] = val;
            _manager2[key2] = val;

            return true;
        }

        // 通过第一个键删除对象
        ValueType remove(const KeyType& key)
        {
            gxAssert(_manager1.size() == _manager2.size());
            gxAssert(key != InvalidKey);
            if(key == InvalidKey)
            {
                gxWarning("Key is invalid! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }
            Iterator iter = _manager1.find(key);
            if(iter == _manager1.end())
            {
                gxWarning("Mgr1 can't find value! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }
            ValueType val = iter->second;
            if(val == InvalidValue)
            {
                gxWarning("Val is invalid!Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }

            gxAssert(val->isKey());
            if(!val->isKey())
            {
                gxWarning("Key is invalid! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }
            if(!allExist(key, val->getKey2()))
            {
                gxWarning("key is repeat! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }

            _manager1.erase(key);
            _manager2.erase(val->getKey2());

            if(IsNeedFree)
            {
                DSafeDelete(val);
                gxInfo("Delete manager val! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                return InvalidValue;
            }

            return val;
        }
        // 通过第二个键删除对象
        ValueType remove2(const KeyType2& key)
        {
            gxAssert(_manager1.size() == _manager2.size());
            gxAssert(key != InvalidKey2);
            if(key == InvalidKey2)
            {
                gxWarning("Key is invalid! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
            }
            Iterator2 iter = _manager2.find(key);
            if(iter == _manager2.end())
            {
                gxWarning("Mgr2 can't find value! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }
            ValueType val = iter->second;
            if(val == InvalidValue)
            {
                gxWarning("Val is invalid! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }

            gxAssert(val->isKey());
            if(!val->isKey())
            {
                gxWarning("Key is invalid! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }
            if(!allExist(val->getKey(), key))
            {
                gxWarning("key is repeat! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }

            _manager1.erase(val->getKey());
            _manager2.erase(key);

            if(IsNeedFree)
            {
                gxInfo("Remove value from manager!Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                DSafeDelete(val);
                return InvalidValue;
            }

            return val;
        }

        uint32 size()
        {
            return (uint32)_manager1.size();
        }

        // 在某一个哈希表中存在则返回true
        bool isExist1(const KeyType& key)
        {
            gxAssert(_manager1.size() == _manager2.size());
            return _manager1.find(key) != _manager1.end();
        }
        bool isExist2(const KeyType2& key)
        {
            gxAssert(_manager1.size() == _manager2.size());
            return _manager2.find(key) != _manager2.end();
        }
        // 在所有哈希表中存在才返回true
        bool allExist(const KeyType& key1, const KeyType2& key2)
        {
            gxAssert(_manager1.find(key1) != _manager1.end() && _manager2.find(key2) != _manager2.end());
            gxAssert(_manager1.size() == _manager2.size());
            return _manager1.find(key1) != _manager1.end() && _manager2.find(key2) != _manager2.end();
        }
        bool anyExist(const KeyType& key1, const KeyType2& key2)
        {
            return isExist1(key1) || isExist2(key2);
        }

        // 查找某一个key是否存在
        ValueType find(const KeyType& key)
        {
            gxAssert(_manager1.size() == _manager2.size());
            if(isExist1(key))
            {
                return _manager1.find(key)->second;
            }

            return InvalidValue;
        }
        ValueType find2(const KeyType2& key)
        {
            gxAssert(_manager1.size() == _manager2.size());
            if(isExist2(key))
            {
                return _manager2.find(key)->second;
            }

            return InvalidValue;
        }

        Iterator begin()
        {
            gxAssert(_manager1.size() == _manager2.size());
            return _manager1.begin();
        }
        Iterator end()
        {
            gxAssert(_manager1.size() == _manager2.size());
            return _manager1.end();
        }
        Iterator2 begin2()
        {
            gxAssert(_manager1.size() == _manager2.size());
            return _manager2.begin();
        }
        Iterator2 end2()
        {
            gxAssert(_manager1.size() == _manager2.size());
            return _manager2.end();
        }

        void traverse(TTraverseCallType call, void* arg)
        {
            gxAssert(_manager1.size() == _manager2.size());
            for(Iterator iter = begin(); iter != end(); ++iter)
            {
                call(iter->second, arg);
            }
        }

    public:
        void genStrName()
        {
			_strName = gxToString("MgrName={0}",_mgrName.c_str());
        }
        const char* toString()
        {
            return _strName.c_str();
        }
    private:
        Containter  _manager1;
        Containter2 _manager2;
        
        std::string _mgrName;
        std::string _strName;
    };

    template<typename T, bool isNeedFree,
		const typename HashMultiIndexTtraits<typename T::KeyType>::KeyType InvalidKey,
		const typename HashMultiIndexTtraits<typename T::KeyType2>::KeyType InvalidKey2>
    const typename GXMISC::CHashMultiIndex2<T, isNeedFree, InvalidKey, InvalidKey2>::ValueType 
        GXMISC::CHashMultiIndex2<T, isNeedFree, InvalidKey, InvalidKey2>::InvalidValue = NULL;

	template<typename T, bool IsNeedFree = false, 
		const typename HashMultiIndexTtraits<typename T::KeyType>::KeyType InvalidKey=T::INVALID_KEY,
		const typename HashMultiIndexTtraits<typename T::KeyType2>::KeyType InvalidKey2
		=T::INVALID_KEY2>
	class CPlayerMgr2Pool : public GXMISC::CHashMultiIndex2<T, IsNeedFree, InvalidKey, InvalidKey2>
	{
	public:
		typedef GXMISC::CHashMultiIndex2<T, IsNeedFree, InvalidKey> TBaseType;
		typedef CPlayerMgr2Pool TMyType;

	public:
		CPlayerMgr2Pool(){}
		~CPlayerMgr2Pool(){}

	public:
		typename TBaseType::ValueType addNewPlayer(typename T::KeyType key1);
		void freeNewPlayer(typename TBaseType::ValueType val);
		void delPlayer(typename T::KeyType key1);
		uint32 size();

	protected:
		GXMISC::CFixObjPool<T>   _objPool;           // 对象池
	};

    template<typename T, bool IsNeedFree = false, 
		const typename HashMultiIndexTtraits<typename T::KeyType>::KeyType InvalidKey=T::INVALID_KEY,
		const typename HashMultiIndexTtraits<typename T::KeyType2>::KeyType InvalidKey2=T::INVALID_KEY2,
        const typename HashMultiIndexTtraits<typename T::KeyType3>::KeyType InvalidKey3=T::INVALID_KEY3>
    class CHashMultiIndex3
    {
        typedef T*          _ValueType;
        typedef typename T::KeyType  _KeyType;
        typedef typename T::KeyType2 _KeyType2;
        typedef typename T::KeyType3 _KeyType3;
        typedef CHashMap<_KeyType, _ValueType>      Containter;
        typedef typename Containter::iterator _Iterator;
        typedef CHashMap<_KeyType2, _ValueType>     Containter2;
        typedef typename Containter2::iterator _Iterator2;
        typedef CHashMap<_KeyType3, _ValueType>     Containter3;
        typedef typename Containter3::iterator _Iterator3;
		typedef T _ValueProType;		// 原类型

	public:
		typedef _ValueProType					ValueProType;
        typedef T*								ValueType;
        typedef _KeyType						KeyType;
        typedef _KeyType2                       KeyType2;
        typedef _KeyType3                       KeyType3;
        typedef std::pair<KeyType, ValueType>	KeyValueType;
        typedef _Iterator						Iterator;
        typedef std::pair<KeyType2, ValueType>	KeyValueType2;
        typedef _Iterator2                      Iterator2;
        typedef std::pair<KeyType3, ValueType>  KeyValueType3;
        typedef _Iterator3                      Iterator3;
        typedef void (*TTraverseCallType)(ValueType&, void* arg);   // 遍历的函数类型

    public:
        static const ValueType InvalidValue;

    public:
        CHashMultiIndex3(const std::string& mgrName="") : _mgrName(mgrName) { genStrName(); }
        ~CHashMultiIndex3()
        {
            if(IsNeedFree)
            {
                traverse(&Free, NULL);
            }

            _manager1.clear();
            _manager2.clear();
            _manager3.clear();
        }

        static void Free(ValueType& val, void* arg)
        {
            if(val != InvalidValue)
            {
                gxAssert(val->isKey());
                DSafeDelete(val);
            }
        }


    public:
        bool add(ValueType val)
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size());
            gxAssert(val->isKey());
			gxAssert(val->isKey2());
			gxAssert(val->isKey3());
            if(!val->isKey())
            {
				gxWarning("Key is invalid! Mgr={0}, Key={1}, Key2={2}, Key3={3}", toString(), val->keyToString().c_str(), val->key2ToString().c_str(), val->key3ToString().c_str());
                gxAssert(false);
                return false;
            }

            KeyType key1 = val->getKey();
            KeyType2 key2 = val->getKey2();
            KeyType3 key3 = val->getKey3();
            if(anyExist(key1, key2, key3))
            {
				gxError("Key repeat! Mgr={0}, Key={1}, Key2={2}, Key3={3}", toString(), val->keyToString().c_str(), val->key2ToString().c_str(), val->key3ToString().c_str());
                gxAssert(false);
                return false;
            }

            _manager1[key1] = val;
            _manager2[key2] = val;
            _manager3[key3] = val;

            return true;
        }

        // 通过第一个键删除对象
        ValueType remove(const KeyType& key)
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size());
            gxAssert(key != InvalidKey);

            Iterator iter = _manager1.find(key);
            if(iter == _manager1.end())
            {
                gxWarning("Can't find value from mgr! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }
            ValueType val = iter->second;
            if(val == InvalidValue)
            {
                gxWarning("Value is invalid! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }

            gxAssert(val->isKey());
            if(!val->isKey())
            {
                gxWarning("Key is invalid! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }
            if(!allExist(key, val->getKey2(), val->getKey3()))
            {
                gxWarning("Key is repeat! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }

            _manager1.erase(key);
            _manager2.erase(val->getKey2());
            _manager3.erase(val->getKey3());

            if(IsNeedFree)
            {
                gxWarning("Remove value from mgr! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                DSafeDelete(val);
                return InvalidValue;
            }

            return val;
        }
        // 通过第二个键删除对象
        ValueType remove2(const KeyType2& key)
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size());
            gxAssert(key != InvalidKey2);

            Iterator2 iter = _manager2.find(key);
            if(iter == _manager2.end())
            {
                gxWarning("Can't find value from mgr! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }
            ValueType val = iter->second;
            if(val == InvalidValue)
            {
                gxWarning("Value is invalid! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }

            gxAssert(val->isKey());
            if(!val->isKey())
            {
                gxWarning("Key is invalid! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }
            if(!allExist(val->getKey(), key, val->getKey3()))
            {
                gxWarning("Key is repeat! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }

            _manager1.erase(val->getKey());
            _manager2.erase(key);
            _manager3.erase(val->getKey3());

            if(IsNeedFree)
            {
                gxWarning("Remove value from mgr! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                DSafeDelete(val);
                return InvalidValue;
            }

            return val;
        }
        // 通过第三个键删除对象
        ValueType remove3(const KeyType3& key)
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size());
            gxAssert(key != InvalidKey3);

            Iterator3 iter = _manager3.find(key);
            if(iter == _manager3.end())
            {
                gxWarning("Can't find value from mgr! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }
            ValueType val = iter->second;
            if(val == InvalidValue)
            {
                gxWarning("Value is invalid! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }

            gxAssert(val->isKey());
            if(!val->isKey())
            {
                gxWarning("Key is invalid! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }
            if(!allExist(val->getKey(), val->getKey2(), key))
            {
                gxWarning("Key is repeat! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }

            _manager1.erase(val->getKey());
            _manager2.erase(val->getKey2());
            _manager3.erase(key);

            if(IsNeedFree)
            {
                gxWarning("Remove value from mgr! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                DSafeDelete(val);
                return InvalidValue;
            }

            return val;
        }

        uint32 size()
        {
            return (uint32)_manager1.size();
        }

        // 在某一个哈希表中存在则返回true
        bool isExist1(const KeyType& key)
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size());
            return _manager1.find(key) != _manager1.end();
        }
        bool isExist2(const KeyType2& key)
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size());
            return _manager2.find(key) != _manager2.end();
        }
        bool isExist3(const KeyType3& key)
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size());
            return _manager3.find(key) != _manager3.end();
        }
        // 在所有哈希表中存在才返回true
        bool allExist(const KeyType& key1, const KeyType2& key2, const KeyType3& key3)
        {
            gxAssert(_manager1.find(key1) != _manager1.end() && _manager2.find(key2) != _manager2.end() && _manager3.find(key3) != _manager3.end());
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size());
            return _manager1.find(key1) != _manager1.end() && _manager2.find(key2) != _manager2.end() && _manager3.find(key3) != _manager3.end();
        }

        bool anyExist(const KeyType& key1, const KeyType2& key2, const KeyType3& key3)
        {
            return isExist1(key1) || isExist2(key2) || isExist3(key3);
        }

        // 查找某一个key是否存在
        ValueType find(const KeyType& key)
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size());
            if(isExist1(key))
            {
                return _manager1.find(key)->second;
            }

            return InvalidValue;
        }
        ValueType find2(const KeyType2& key)
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size());
            if(isExist2(key))
            {
                return _manager2.find(key)->second;
            }

            return InvalidValue;
        }
        ValueType find3(const KeyType3& key)
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size());
            if(isExist3(key))
            {
                return _manager3.find(key)->second;
            }

            return InvalidValue;
        }

        Iterator begin()
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size());
            return _manager1.begin();
        }
        Iterator end()
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size());
            return _manager1.end();
        }
        Iterator2 begin2()
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size());
            return _manager2.begin();
        }
        Iterator2 end2()
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size());
            return _manager2.end();
        }
        Iterator3 begin3()
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size());
            return _manager3.begin();
        }
        Iterator3 end3()
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size());
            return _manager3.end();
        }

        void traverse(TTraverseCallType call, void* arg)
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size());
            for(Iterator iter = begin(); iter != end(); ++iter)
            {
                call(iter->second, arg);
            }
        }

    public:
        void genStrName()
        {
			_strName = gxToString("MgrName={0}",_mgrName.c_str());
        }
        const char* toString()
        {
            return _strName.c_str();
        }

    private:
        Containter  _manager1;
        Containter2 _manager2;
        Containter3 _manager3;

        std::string _mgrName;
        std::string _strName;
    };

    template<typename T, bool isNeedFree,
		const typename HashMultiIndexTtraits<typename T::KeyType>::KeyType InvalidKey,
		const typename HashMultiIndexTtraits<typename T::KeyType2>::KeyType InvalidKey2,
		const typename HashMultiIndexTtraits<typename T::KeyType3>::KeyType InvalidKey3>
    const typename GXMISC::CHashMultiIndex3<T, isNeedFree, InvalidKey, InvalidKey2, InvalidKey3>::ValueType 
        GXMISC::CHashMultiIndex3<T, isNeedFree, InvalidKey, InvalidKey2, InvalidKey3>::InvalidValue = NULL;

    template<typename T, bool IsNeedFree = false, 
		const typename HashMultiIndexTtraits<typename T::KeyType>::KeyType InvalidKey=T::INVALID_KEY,
		const typename HashMultiIndexTtraits<typename T::KeyType2>::KeyType InvalidKey2=T::INVALID_KEY2,
		const typename HashMultiIndexTtraits<typename T::KeyType3>::KeyType InvalidKey3=T::INVALID_KEY3,
        const typename HashMultiIndexTtraits<typename T::KeyType4>::KeyType InvalidKey4=T::INVALID_KEY4>
    class CHashMultiIndex4
    {
        typedef T*          _ValueType;
        typedef typename T::KeyType  _KeyType;
        typedef typename T::KeyType2 _KeyType2;
        typedef typename T::KeyType3 _KeyType3;
        typedef typename T::KeyType4 _KeyType4;
        typedef CHashMap<_KeyType, _ValueType>      Containter;
        typedef typename Containter::iterator _Iterator;
        typedef CHashMap<_KeyType2, _ValueType>     Containter2;
        typedef typename Containter2::iterator _Iterator2;
        typedef CHashMap<_KeyType3, _ValueType>     Containter3;
        typedef typename Containter3::iterator _Iterator3;
        typedef CHashMap<_KeyType4, _ValueType>     Containter4;
        typedef typename Containter4::iterator _Iterator4;
		typedef T _ValueProType;		// 原类型

	public:
		typedef _ValueProType					ValueProType;
        typedef T*								ValueType;
        typedef _KeyType						KeyType;
        typedef _KeyType2                       KeyType2;
        typedef _KeyType3                       KeyType3;
        typedef _KeyType4                       KeyType4;
        typedef std::pair<KeyType, ValueType>	KeyValueType;
        typedef _Iterator						Iterator;
        typedef std::pair<KeyType2, ValueType>	KeyValueType2;
        typedef _Iterator2                      Iterator2;
        typedef std::pair<KeyType3, ValueType>  KeyValueType3;
        typedef _Iterator3                      Iterator3;
        typedef std::pair<KeyType4, ValueType> KeyValueType4;
        typedef _Iterator4                      Iterator4;
        typedef void (*TTraverseCallType)(ValueType&, void* arg);   // 遍历的函数类型

    public:
        static const ValueType InvalidValue;

    public:
        CHashMultiIndex4(const std::string& mgrName="") : _mgrName(mgrName) { genStrName(); }
        ~CHashMultiIndex4()
        {
            if(IsNeedFree)
            {
                traverse(&Free, NULL);
            }

            _manager1.clear();
            _manager2.clear();
            _manager3.clear();
            _manager4.clear();
        }

        static void Free(ValueType& val, void* arg)
        {
            if(val != InvalidValue)
            {
                gxAssert(val->isKey());
                DSafeDelete(val);
            }
        }

    public:
        bool add(ValueType val)
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size() && _manager3.size() == _manager4.size());
            gxAssert(val->isKey());
			gxAssert(val->isKey2());
			gxAssert(val->isKey3());
			gxAssert(val->isKey4());
            if(!val->isKey())
            {
                gxWarning("Key is invalid! Mgr={0}, key={1}", toString(), gxToString(val->getKey()).c_str());
                gxAssert(false);
                return false;
            }

            KeyType  key1 = val->getKey();
            KeyType2 key2 = val->getKey2();
            KeyType3 key3 = val->getKey3();
            KeyType4 key4 = val->getKey4();
            if(anyExist(key1, key2, key3, key4))
            {
				gxError("Key repeat! key={0}, key2={1}, key3={2}, key4={3}", val->keyToString().c_str(), val->key2ToString().c_str(), val->key3ToString().c_str(), val->key4ToString().c_str());
                gxAssert(false);
                return false;
            }

            _manager1[key1] = val;
            _manager2[key2] = val;
            _manager3[key3] = val;
            _manager4[key4] = val;

            return true;
        }

        // 通过第一个键删除对象
        ValueType remove(const KeyType& key)
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size() && _manager3.size() == _manager4.size());
            gxAssert(key != InvalidKey);

            Iterator iter = _manager1.find(key);
            if(iter == _manager1.end())
            {
                gxWarning("Can't find value from mgr! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }
            ValueType val = iter->second;
            if(val == InvalidValue)
            {
                gxWarning("Value is invalid! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }

            gxAssert(val->isKey());
            if(!val->isKey())
            {
                gxWarning("Key is invalid! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }
            if(!allExist(key, val->getKey2(), val->getKey3(), val->getKey4()))
            {
                gxWarning("Key is repeat! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }

            _manager1.erase(key);
            _manager2.erase(val->getKey2());
            _manager3.erase(val->getKey3());
            _manager4.erase(val->getKey4());

            if(IsNeedFree)
            {
                gxWarning("Remove value from mgr! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                DSafeDelete(val);
                return InvalidValue;
            }

            return val;
        }
        // 通过第二个键删除对象
        ValueType remove2(const KeyType2& key)
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size() && _manager3.size() == _manager4.size());
            gxAssert(key != InvalidKey2);

            Iterator2 iter = _manager2.find(key);
            if(iter == _manager2.end())
            {
                gxWarning("Can't find value from mgr! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }
            ValueType val = iter->second;
            if(val == InvalidValue)
            {
                gxWarning("Value is invalid! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }

            gxAssert(val->isKey());
            if(!val->isKey())
            {
                gxWarning("Key is invalid! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }
            if(!allExist(val->getKey(), key, val->getKey3(), val->getKey4()))
            {
                gxWarning("Key is repeat! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }

            _manager1.erase(val->getKey());
            _manager2.erase(key);
            _manager3.erase(val->getKey3());
            _manager4.erase(val->getKey4());

            if(IsNeedFree)
            {
                gxWarning("Remove value from mgr! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                DSafeDelete(val);
                return InvalidValue;
            }

            return val;
        }
        // 通过第三个键删除对象
        ValueType remove3(const KeyType3& key)
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size() && _manager3.size() == _manager4.size());
            gxAssert(key != InvalidKey3);

            Iterator3 iter = _manager3.find(key);
            if(iter == _manager3.end())
            {
                gxWarning("Can't find value from mgr! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }
            ValueType val = iter->second;
            if(val == InvalidValue)
            {
                gxWarning("Value is invalid! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }

            gxAssert(val->isKey());
            if(!val->isKey())
            {
                gxWarning("Key is invalid! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }
            if(!allExist(val->getKey(), val->getKey2(), key, val->getKey4()))
            {
                gxWarning("Key is repeat! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }

            _manager1.erase(val->getKey());
            _manager2.erase(val->getKey2());
            _manager3.erase(key);
            _manager4.erase(val->getKey4());

            if(IsNeedFree)
            {
                gxWarning("Remove value from mgr! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                DSafeDelete(val);
                return InvalidValue;
            }

            return val;
        }
        // 通过第四个键删除对象
        ValueType remove4(const KeyType4& key)
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size() && _manager3.size() == _manager4.size());
            gxAssert(key != InvalidKey4);

            Iterator4 iter = _manager4.find(key);
            if(iter == _manager4.end())
            {
                gxWarning("Can't find value from mgr! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }
            ValueType val = iter->second;
            if(val == InvalidValue)
            {
                gxWarning("Value is invalid! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }

            gxAssert(val->isKey());
            if(!val->isKey())
            {
                gxWarning("Key is invalid! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }
            if(!allExist(val->getKey(), val->getKey2(), val->getKey3(), key))
            {
                gxWarning("Key is invalid! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                gxAssert(false);
                return InvalidValue;
            }
            _manager1.erase(val->getKey());
            _manager2.erase(val->getKey2());
            _manager3.erase(val->getKey4());
            _manager4.erase(key);

            if(IsNeedFree)
            {
                gxWarning("Remove value from mgr! Mgr={0}, key={1}", toString(), gxToString(key).c_str());
                DSafeDelete(val);
                return InvalidValue;
            }

            return val;
        }

        uint32 size()
        {
            return (uint32)_manager1.size();
        }

        // 在某一个哈希表中存在则返回true
        bool isExist1(const KeyType& key)
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size() && _manager3.size() == _manager4.size());
            return _manager1.find(key) != _manager1.end();
        }
        bool isExist2(const KeyType2& key)
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size() && _manager3.size() == _manager4.size());
            return _manager2.find(key) != _manager2.end();
        }
        bool isExist3(const KeyType3& key)
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size() && _manager3.size() == _manager4.size());
            return _manager3.find(key) != _manager3.end();
        }
        bool isExist4(const KeyType4& key)
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size() && _manager3.size() == _manager4.size());
            return _manager4.find(key) != _manager4.end();
        }
        // 在所有哈希表中存在才返回true
        bool allExist(const KeyType& key1, const KeyType2& key2, const KeyType3& key3, const KeyType4& key4)
        {
            gxAssert(_manager1.find(key1) != _manager1.end() && _manager2.find(key2) != _manager2.end() 
                && _manager3.find(key3) != _manager3.end() && _manager4.find(key4) != _manager4.end());
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size() && _manager3.size() == _manager4.size());
            return _manager1.find(key1) != _manager1.end() && _manager2.find(key2) != _manager2.end() 
                && _manager3.find(key3) != _manager3.end() && _manager4.find(key4) != _manager4.end();
        }
        bool anyExist(const KeyType& key1, const KeyType2& key2, const KeyType3& key3, const KeyType4& key4)
        {
            return isExist1(key1) || isExist2(key2) || isExist3(key3) || isExist4(key4);
        }

        // 查找某一个key是否存在
        ValueType find(const KeyType& key)
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size() && _manager3.size() == _manager4.size());
            if(isExist1(key))
            {
                return _manager1.find(key)->second;
            }

            return InvalidValue;
        }
        ValueType find2(const KeyType2& key)
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size() && _manager3.size() == _manager4.size());
            if(isExist2(key))
            {
                return _manager2.find(key)->second;
            }

            return InvalidValue;
        }
        ValueType find3(const KeyType3& key)
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size() && _manager3.size() == _manager4.size());
            if(isExist3(key))
            {
                return _manager3.find(key)->second;
            }

            return InvalidValue;
        }
        ValueType find4(const KeyType4& key)
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size() && _manager3.size() == _manager4.size());
            if(isExist4(key))
            {
                return _manager4.find(key)->second;
            }

            return InvalidValue;
        }

        Iterator begin()
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size() && _manager3.size() == _manager4.size());
            return _manager1.begin();
        }
        Iterator end()
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size() && _manager3.size() == _manager4.size());
            return _manager1.end();
        }
        Iterator2 begin2()
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size() && _manager3.size() == _manager4.size());
            return _manager2.begin();
        }
        Iterator2 end2()
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size() && _manager3.size() == _manager4.size());
            return _manager2.end();
        }
        Iterator3 begin3()
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size() && _manager3.size() == _manager4.size());
            return _manager3.begin();
        }
        Iterator3 end3()
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size() && _manager3.size() == _manager4.size());
            return _manager3.end();
        }
        Iterator4 begin4()
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size() && _manager3.size() == _manager4.size());
            return _manager4.begin();
        }
        Iterator4 end4()
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size() && _manager3.size() == _manager4.size());
            return _manager4.end();
        }

        void traverse(TTraverseCallType call, void* arg)
        {
            gxAssert(_manager1.size() == _manager2.size() && _manager2.size() == _manager3.size() && _manager3.size() == _manager4.size());
            for(Iterator iter = begin(); iter != end(); ++iter)
            {
                call(iter->second, arg);
            }
        }

    public:
        void genStrName()
        {
			_strName = gxToString("MgrName={0}",_mgrName.c_str());
        }
        const char* toString()
        {
            return _strName.c_str();
        }

    private:
        Containter  _manager1;
        Containter2 _manager2;
        Containter3 _manager3;
        Containter4 _manager4;

        std::string _mgrName;
        std::string _strName;
    };

    template<typename T, bool isNeedFree,
		const typename HashMultiIndexTtraits<typename T::KeyType>::KeyType InvalidKey,
		const typename HashMultiIndexTtraits<typename T::KeyType2>::KeyType InvalidKey2,
		const typename HashMultiIndexTtraits<typename T::KeyType3>::KeyType InvalidKey3,
		const typename HashMultiIndexTtraits<typename T::KeyType4>::KeyType InvalidKey4>
        const typename GXMISC::CHashMultiIndex4<T, isNeedFree, InvalidKey, InvalidKey2, InvalidKey3, InvalidKey4>::ValueType 
        GXMISC::CHashMultiIndex4<T, isNeedFree, InvalidKey, InvalidKey2, InvalidKey3, InvalidKey4>::InvalidValue = NULL;
}

#endif // HASH_MANAGER_H_