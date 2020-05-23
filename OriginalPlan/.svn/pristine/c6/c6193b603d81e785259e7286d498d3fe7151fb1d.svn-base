#ifndef _GAME_PLAYER_MGR_H_
#define _GAME_PLAYER_MGR_H_

#include "core/multi_index.h"
#include "core/obj_mem_fix_pool.h"
#include "core/string_common.h"
#include "core/debug.h"

enum EManagerQueType 
{
    MGR_QUE_TYPE_INVALID,
    MGR_QUE_TYPE_READY,
    MGR_QUE_TYPE_ENTER,
    MGR_QUE_TYPE_LOGOUT,
};

class IPlayer{
public:
	virtual bool onAddToEnter()     { return true; }
	virtual bool onAddToReady()     {return true;}
	virtual bool onAddToLogout()     {return true;}
	virtual void onRemoveFromEnter()     {}
	virtual void onRemoveFromReady()     {}
	virtual void onRemoveFromLogout()     {}
	virtual void onUpdateEnterQue(GXMISC::TDiffTime_t diff)     {}
	virtual void onUpdateReadyQue(GXMISC::TDiffTime_t diff)     {}
	virtual void onUpdateLogoutQue(GXMISC::TDiffTime_t diff)    {}
};
#define _DGameMgrRenameFuncX(DValueType, DPlayerID, DKeyType, X)   \
    DValueType findBy##DPlayerID(DKeyType::KeyType##X _key, bool logFlag = true) \
    {   \
    DValueType val = (DKeyType*)find##X(_key); \
    if(GXMISC::CHashMultiIndex<DKeyType>::InvalidValue == val && logFlag)  \
    {   \
	gxDebug("Can't find "#DPlayerID"! "#DPlayerID"={0};", _key); \
    return GXMISC::CHashMultiIndex<DKeyType>::InvalidValue; \
    }   \
    return val;  \
    }   \
    DValueType findInReadyBy##DPlayerID(DKeyType::KeyType##X _key, bool logFlag = true)  \
    {   \
    DValueType val = (DKeyType*)findInReady##X(_key); \
    if(GXMISC::CHashMultiIndex<DKeyType>::InvalidValue == val  && logFlag)  \
    {   \
	gxDebug("Can't find "#DPlayerID" in read queue! "#DPlayerID"={0};", _key); \
    return GXMISC::CHashMultiIndex<DKeyType>::InvalidValue; \
    }   \
    return val;  \
    }   \
    DValueType findInEnterBy##DPlayerID(DKeyType::KeyType##X _key, bool logFlag = true)  \
    {   \
    DValueType val = (DKeyType*)findInEnter##X(_key); \
    if(GXMISC::CHashMultiIndex<DKeyType>::InvalidValue == val  && logFlag)  \
    {   \
    gxDebug("Can't find "#DPlayerID" in enter queue! "#DPlayerID"={0};", _key); \
    return GXMISC::CHashMultiIndex<DKeyType>::InvalidValue; \
    }   \
    return val;  \
    }   \
    DValueType findInLogoutBy##DPlayerID(DKeyType::KeyType##X _key, bool logFlag = true) \
    {   \
    DValueType val = (DKeyType*)findInLogout##X(_key); \
    if(GXMISC::CHashMultiIndex<DKeyType>::InvalidValue == val  && logFlag)  \
    {   \
    gxDebug("Can't find "#DPlayerID" in logout queue! "#DPlayerID"={0};", _key); \
    return GXMISC::CHashMultiIndex<DKeyType>::InvalidValue; \
    }   \
    return val;  \
    }   \
    DValueType findInQueTypeBy##DPlayerID(EManagerQueType tp, DKeyType::KeyType##X _key, bool logFlag = true)    \
    {   \
    switch(tp)  \
    {   \
    case MGR_QUE_TYPE_READY:    \
    {   \
    return findInReadyBy##DPlayerID(_key);   \
    }break; \
        case MGR_QUE_TYPE_ENTER:    \
    {   \
    return findInEnterBy##DPlayerID(_key);   \
    }break; \
        case MGR_QUE_TYPE_LOGOUT:   \
    {   \
    return findInLogoutBy##DPlayerID(_key); \
    }break; \
        default :   \
    {\
    }   \
    }   \
    if(logFlag){    \
    gxDebug("Can't find "#DPlayerID"in any queue!"#DPlayerID"={0};", _key);    \
    }   \
    return GXMISC::CHashMultiIndex<DKeyType>::InvalidValue;    \
    }

/**
* @brief 重命名之后成了以下形式
*        find##DPlayerID
*        findInReadyBy##DPlayerID
*        findInEnterBy##DPlayerID
*        findInLogoutBy##DPlayerID
*        findInQueTypeBy##DPlayerID
*/
#define DGameMgrRenameFunc1(DValueType, DPlayerID, DKeyType)   \
    DValueType findBy##DPlayerID(DKeyType::KeyType _key, bool logFlag = true) \
    {   \
        DValueType val = (DKeyType*)find(_key); \
        if(GXMISC::CHashMultiIndex<DKeyType>::InvalidValue == val && logFlag)  \
        {   \
            gxDebug("Can't find "#DPlayerID"! "#DPlayerID"={0};", _key); \
            return GXMISC::CHashMultiIndex<DKeyType>::InvalidValue; \
        }   \
        return val;  \
    }   \
    DValueType findInReadyBy##DPlayerID(DKeyType::KeyType _key, bool logFlag = true)  \
    {   \
        DValueType val = (DKeyType*)findInReady(_key); \
        if(GXMISC::CHashMultiIndex<DKeyType>::InvalidValue == val  && logFlag)  \
        {   \
            gxDebug("Can't find "#DPlayerID" in read queue! "#DPlayerID"={0};", _key); \
            return GXMISC::CHashMultiIndex<DKeyType>::InvalidValue; \
        }   \
        return val;  \
    }   \
    DValueType findInEnterBy##DPlayerID(DKeyType::KeyType _key, bool logFlag = true)  \
    {   \
        DValueType val = (DKeyType*)findInEnter(_key); \
        if(GXMISC::CHashMultiIndex<DKeyType>::InvalidValue == val  && logFlag)  \
        {   \
            gxDebug("Can't find "#DPlayerID" in enter queue! "#DPlayerID"={0};", _key); \
            return GXMISC::CHashMultiIndex<DKeyType>::InvalidValue; \
        }   \
        return val;  \
    }   \
    DValueType findInLogoutBy##DPlayerID(DKeyType::KeyType _key, bool logFlag = true) \
    {   \
        DValueType val = (DKeyType*)findInLogout(_key); \
        if(GXMISC::CHashMultiIndex<DKeyType>::InvalidValue == val  && logFlag)  \
        {   \
            gxDebug("Can't find "#DPlayerID" in logout queue! "#DPlayerID"={0};", _key); \
            return GXMISC::CHashMultiIndex<DKeyType>::InvalidValue; \
        }   \
        return val;  \
    }   \
    DValueType findInQueTypeBy##DPlayerID(EManagerQueType tp, DKeyType::KeyType _key, bool logFlag = true)    \
    {   \
        switch(tp)  \
        {   \
        case MGR_QUE_TYPE_READY:    \
        {   \
        return findInReadyBy##DPlayerID(_key);   \
        }break; \
        case MGR_QUE_TYPE_ENTER:    \
        {   \
        return findInEnterBy##DPlayerID(_key);   \
        }break; \
        case MGR_QUE_TYPE_LOGOUT:   \
        {   \
        return findInLogoutBy##DPlayerID(_key); \
        }break; \
        default :   \
        {\
        }   \
        }   \
        if(logFlag){    \
            gxDebug("Can't find "#DPlayerID"in any queue!"#DPlayerID"={0};", _key);    \
        }   \
        return GXMISC::CHashMultiIndex<DKeyType>::InvalidValue;    \
    }

#define DGameMgrRenameFunc2(DValueType, DPlayerID, DKeyType)    \
    _DGameMgrRenameFuncX(DValueType, DPlayerID, DKeyType, 2)
#define DGameMgrRenameFunc3(DValueType, DPlayerID, DKeyType)    \
    _DGameMgrRenameFuncX(DValueType, DPlayerID, DKeyType, 3)
#define DGameMgrRenameFunc4(DValueType, DPlayerID, DKeyType)    \
    _DGameMgrRenameFuncX(DValueType, DPlayerID, DKeyType, 4)

// 检查代码
#define DCheckPlayer(PlayerID)    \
    if(findInReady(PlayerID) != NULL)   \
    {   \
        gxAssert(NULL == findInEnter(PlayerID));    \
        gxAssert(NULL == findInLogout(PlayerID))    \
    }   \
    if(findInEnter(PlayerID) != NULL)   \
    {   \
        gxAssert(NULL == findInReady(PlayerID));    \
        gxAssert(NULL == findInLogout(PlayerID));   \
    }   \
    if(findInLogout(PlayerID) != NULL)  \
    {   \
        gxAssert(NULL == findInReady(PlayerID));    \
        gxAssert(NULL == findInEnter(PlayerID));   \
    }


// 检查代码
#define _DCheckPlayerX(Key2, X)    \
    if(findInReady##X(Key2) != NULL)   \
    {   \
        gxAssert(NULL == findInEnter##X(Key2));    \
        gxAssert(NULL == findInLogout##X(Key2))    \
    }   \
    if(findInEnter##X(Key2) != NULL)   \
    {   \
        gxAssert(NULL == findInReady##X(Key2));    \
        gxAssert(NULL == findInLogout##X(Key2));   \
    }   \
    if(findInLogout##X(Key2) != NULL)  \
    {   \
        gxAssert(NULL == findInReady##X(Key2));    \
        gxAssert(NULL == findInEnter##X(Key2));   \
    }

#define DCheckPlayer2(Key2) \
    _DCheckPlayerX(Key2, 2)
#define DCheckPlayer3(Key3) \
    _DCheckPlayerX(Key3, 3)
#define DCheckPlayer4(Key4) \
    _DCheckPlayerX(Key4, 4)

#define DCheckPlayerAll2(Player) \
    DCheckPlayer(Player->getKey()); \
    DCheckPlayer2(Player->getKey2());
#define DCheckPlayerAll3(Player) \
    DCheckPlayer(Player->getKey()); \
    DCheckPlayer2(Player->getKey2());   \
    DCheckPlayer3(Player->getKey3());
#define DCheckPlayerAll4(Player) \
    DCheckPlayer(Player->getKey()); \
    DCheckPlayer2(Player->getKey2());   \
    DCheckPlayer3(Player->getKey3());   \
    DCheckPlayer4(Player->getKey4());

template<typename T>
class CGamePlayerMgr
{
public:
    typedef GXMISC::CHashMultiIndex<T> TBaseType;						// 基本类型
    typedef typename TBaseType::TTraverseCallType TTraverseCallType;	// 遍历的函数类型
    typedef typename TBaseType::ValueType ValueType;					// 值类型

public:
    CGamePlayerMgr(){}
    ~CGamePlayerMgr(){}

public:
	uint32 size();
	bool isExist(typename T::KeyType key);

    // 不允许在遍历函数中删除对象, 不允许调用remove*类型的函数
    void traverseReady(TTraverseCallType call, void* arg);
    void traverseEnter(TTraverseCallType call, void* arg);
    void traverseLogout(TTraverseCallType call, void* arg);

public:
    bool addToReady(ValueType player);
    ValueType removeFromReady(typename T::KeyType key);
    uint32 readySize();
    bool addToEnter(ValueType player);
    ValueType removeFromEnter(typename T::KeyType key);
    uint32 enterSize();
    bool addToLogout(ValueType player);
    ValueType removeFromLogout(typename T::KeyType key);
    uint32 logoutSize();
	ValueType remove(typename T::KeyType key);

protected:
    ValueType find(typename T::KeyType key);
    ValueType findInReady(typename T::KeyType key);
    ValueType findInEnter(typename T::KeyType key);
    ValueType findInLogout(typename T::KeyType key);

protected:
    GXMISC::CHashMultiIndex<T> _readyQue;       // 登陆队列
    GXMISC::CHashMultiIndex<T> _enterQue;       // 游戏队列
    GXMISC::CHashMultiIndex<T> _logoutQue;      // 登出队列
};

template<typename T>
class CGamePlayerMgrPool : public CGamePlayerMgr<T>
{
public:
	typedef CGamePlayerMgr<T> TBaseType;
	typedef typename TBaseType::ValueType ValueType;

public:
	bool init(sint32 maxPlayerNum);
//	sint32 size();

public:
	ValueType addNewPlayer(typename T::KeyType key, bool isAddToReady = false);
	void freeNewPlayer(ValueType val);
	void delPlayer(typename T::KeyType key);

protected:
	GXMISC::CFixObjPool<T>   _objPool;    // 对象池
};

// template<typename T>
// sint32 CGamePlayerMgrPool<T>::size()
// {
// 	return _objPool.getCount();
// }

template<typename T>
typename CGamePlayerMgrPool<T>::ValueType CGamePlayerMgrPool<T>::addNewPlayer( typename T::KeyType key, bool isAddToReady /* = false */ )
{
	T* player = _objPool.newObj();
	gxAssert(player != NULL);
	if(player == NULL)
	{
		gxError("Can't get new player object! PlayerID = {0}", key);
		return NULL;
	}

	player->setKey(key);
	if(isAddToReady)
	{
		if(false == addToReady(player))
		{
			gxError("Can't add player to hash mgr! PlayerID = {0}", key);
			_objPool.deleteObj(player);
			return NULL;
		}
	}

	return player;
}

template<typename T>
void CGamePlayerMgrPool<T>::delPlayer( typename T::KeyType key )
{
	gxDebug("Delete player from player mgr! PlayerID = {0}", key);

	DCheckPlayer(key);

	T* player = this->_readyQue.find(key);
	if(NULL != player)
	{
		this->_readyQue.remove(key);
	}

	if(NULL == player)
	{
		player = this->_enterQue.find(key);
		if(NULL != player)
		{
			this->_enterQue.remove(key);
		}
	}

	if(NULL == player)
	{
		player = this->_logoutQue.find(key);
		if(NULL != player)
		{
			this->_logoutQue.remove(key);
		}
	}

	if(player == NULL)
	{
		gxDebug("Can't delete player! PlayerID = {0}", key);
		return;
	}

	if(player)
	{
		_objPool.deleteObj(player);
	}
}

template<typename T>
bool CGamePlayerMgrPool<T>::init( sint32 maxPlayerNum )
{
	return _objPool.init(maxPlayerNum);
}

template<typename T>
void CGamePlayerMgrPool<T>::freeNewPlayer( ValueType val )
{
	_objPool.deleteObj(val);
}

template<typename T>
typename CGamePlayerMgr<T>::ValueType CGamePlayerMgr<T>::remove( typename T::KeyType key )
{
	DCheckPlayer(key);

    ValueType val = NULL;
    if(_enterQue.isExist(key))
    {
        val = _enterQue.remove(key);
        if(NULL != val)
        {
            return val;
        }
    }

    if(_readyQue.isExist(key))
    {
        val = _readyQue.remove(key);
        if(NULL != val)
        {
            return val;
        }
    }

    if(_logoutQue.isExist(key))
    {
        val = _logoutQue.remove(key);
    }

	return val;
}

template<typename T>
bool CGamePlayerMgr<T>::isExist(typename T::KeyType key)
{
    return find(key) != NULL;
}

template<typename T>
uint32 CGamePlayerMgr<T>::logoutSize()
{
    return _logoutQue.size();
}
template<typename T>
uint32 CGamePlayerMgr<T>::enterSize()
{
    return _enterQue.size();
}
template<typename T>
uint32 CGamePlayerMgr<T>::readySize()
{
    return _readyQue.size();
}

template<typename T>
void CGamePlayerMgr<T>::traverseLogout( TTraverseCallType call, void* arg )
{
    _logoutQue.traverse(call, arg);
}
template<typename T>
void CGamePlayerMgr<T>::traverseEnter( TTraverseCallType call, void* arg )
{
    _enterQue.traverse(call, arg);
}
template<typename T>
void CGamePlayerMgr<T>::traverseReady( TTraverseCallType call, void* arg )
{
    _readyQue.traverse(call, arg);
}

template<typename T>
typename CGamePlayerMgr<T>::ValueType CGamePlayerMgr<T>::removeFromLogout( typename T::KeyType key )
{
    DCheckPlayer(key);
    ValueType val = _logoutQue.remove(key);
    if(TBaseType::InvalidValue == val)
    {
        return TBaseType::InvalidValue;
    }

    val->onRemoveFromLogout();
    return val;
}
template<typename T>
bool CGamePlayerMgr<T>::addToLogout( ValueType player )
{
    DCheckPlayer(player->getKey());
    if(!player->onAddToLogout())
    {
        return false;
    }

    return _logoutQue.add(player);
}
template<typename T>
typename CGamePlayerMgr<T>::ValueType CGamePlayerMgr<T>::findInLogout( typename T::KeyType key )
{
    return _logoutQue.find(key);
}
template<typename T>
typename CGamePlayerMgr<T>::ValueType CGamePlayerMgr<T>::removeFromEnter( typename T::KeyType key )
{
    DCheckPlayer(key);
    ValueType val = _enterQue.remove(key);
    if(TBaseType::InvalidValue == val)
    {
        return TBaseType::InvalidValue;
    }
    
    val->onRemoveFromEnter();
    return val;
}
template<typename T>
bool CGamePlayerMgr<T>::addToEnter( ValueType player )
{
    DCheckPlayer(player->getKey());
    if(false == player->onAddToEnter())
    {
        return false;
    }

    return _enterQue.add(player);
}
template<typename T>
typename CGamePlayerMgr<T>::ValueType CGamePlayerMgr<T>::findInEnter( typename T::KeyType key )
{
    return _enterQue.find(key);
}
template<typename T>
typename CGamePlayerMgr<T>::ValueType CGamePlayerMgr<T>::removeFromReady( typename T::KeyType key )
{
    DCheckPlayer(key);
    ValueType val = _readyQue.remove(key);
    if(TBaseType::InvalidValue == val)
    {
        return TBaseType::InvalidValue;
    }
    
    val->onRemoveFromReady();
    return val;
}
template<typename T>
bool CGamePlayerMgr<T>::addToReady( ValueType player )
{
    DCheckPlayer(player->getKey());
    if(false == player->onAddToReady())
    {
        return false;
    }

    return _readyQue.add(player);
}
template<typename T>
typename CGamePlayerMgr<T>::ValueType CGamePlayerMgr<T>::findInReady( typename T::KeyType key )
{
    return _readyQue.find(key);
}

template<typename T>
uint32 CGamePlayerMgr<T>::size()
{
	return _readyQue.size()+_enterQue.size()+_logoutQue.size();
}

template<typename T>
typename CGamePlayerMgr<T>::ValueType CGamePlayerMgr<T>::find( typename T::KeyType key )
{
    T* player = _enterQue.find(key);
    if(NULL == player)
    {
        player = _logoutQue.find(key);
    }
    if(NULL == player)
    {
        player = _readyQue.find(key);
    }

    if(player == NULL)
    {
        gxDebug("Can't find player! PlayerID = {0}", key);
        return NULL;
    }

    return player;
}

template<typename T>
class CGamePlayerMgr2
{
public:
    typedef GXMISC::CHashMultiIndex2<T> TBaseType;
    typedef typename TBaseType::TTraverseCallType TTraverseCallType;     // 遍历的函数类型
    typedef typename TBaseType::ValueType ValueType;                     // 值类型

public:
    CGamePlayerMgr2(){}
    ~CGamePlayerMgr2(){}

public:
    uint32 size();
    bool isExist(typename T::KeyType key1);

    // 不允许在遍历函数中删除对象, 不允许调用addTo*, remove*类型的函数
    void traverseReady(TTraverseCallType call, void* arg);
    void traverseEnter(TTraverseCallType call, void* arg);
    void traverseLogout(TTraverseCallType call, void* arg);

public:
    bool addToReady(ValueType player);
    ValueType removeFromReady(typename T::KeyType key1);
    uint32 readySize();
    bool addToEnter(ValueType player);
    ValueType removeFromEnter(typename T::KeyType key1);
    uint32 enterSize();
    bool addToLogout(ValueType player);
    ValueType removeFromLogout(typename T::KeyType key1);
    uint32 logoutSize();
	ValueType remove(typename T::KeyType key1);

protected:
    ValueType find(typename T::KeyType key1);
    ValueType find2(typename T::KeyType2 key2);
    ValueType findInReady(typename T::KeyType key1);
    ValueType findInReady2(typename T::KeyType2 key2);
    ValueType findInEnter(typename T::KeyType key1);
    ValueType findInEnter2(typename T::KeyType2 key2);
    ValueType findInLogout(typename T::KeyType key1);
    ValueType findInLogout2(typename T::KeyType2 key2);

protected:
//    GXMISC::CFixObjPool<T>   _objPool;           // 对象池
    GXMISC::CHashMultiIndex2<T> _readyQue;       // 登陆队列
    GXMISC::CHashMultiIndex2<T> _enterQue;       // 游戏队列
    GXMISC::CHashMultiIndex2<T> _logoutQue;      // 登出队列
};

template<typename T>
class CGamePlayerMgr2Pool : public CGamePlayerMgr2<T>
{
public:
	typedef CGamePlayerMgr2<T> TBaseType;
	typedef typename TBaseType::ValueType ValueType;
public:
	CGamePlayerMgr2Pool(){}
	~CGamePlayerMgr2Pool(){}

public:
	bool init(sint32 maxPlayerNum);

public:
	ValueType addNewPlayer(typename T::KeyType key1, typename T::KeyType2 key2, bool isAddToReady = false);
	void freeNewPlayer(ValueType val);
	void delPlayer(typename T::KeyType key1);
//	uint32 size();

protected:
	GXMISC::CFixObjPool<T>   _objPool;           // 对象池
};

template<typename T>
typename CGamePlayerMgr2Pool<T>::ValueType CGamePlayerMgr2Pool<T>::addNewPlayer( typename T::KeyType key1, typename T::KeyType2 key2, bool isAddToReady /* = false */ )
{
	ValueType player = _objPool.newObj();
	gxAssert(player != NULL);
	if(player == NULL)
	{
		gxError("Can't get new player object! Key1={0},Key2={0}", key1, key2);
		return NULL;
	}

	player->setKey(key1);
	player->setKey2(key2);
	if(isAddToReady)
	{
		if(false == addToReady(player))
		{
			gxError("Can't add new player object to manager! Key1={0},Key2={0}", key1, key2);
			_objPool.deleteObj(player);
			return NULL;
		}

		gxInfo("Add player to ReadyQueue! Key1={0},Key2={0}", key1, key2);
	}

	return player;
}

template<typename T>
void CGamePlayerMgr2Pool<T>::freeNewPlayer(ValueType val)
{
	_objPool.deleteObj(val);
}

template<typename T>
void CGamePlayerMgr2Pool<T>::delPlayer( typename T::KeyType key1 )
{
	gxDebug("Delete player from player mgr! Key1 = {0}", key1);

	DCheckPlayer(key1);

	ValueType player = this->_readyQue.find(key1);
	if(NULL != player)
	{
		gxDebug("Delete player from readque!Key = {0}", key1);
		if(NULL == this->_readyQue.remove(key1))
		{
			gxAssert(false);
		}
	}

	if(NULL == player)
	{
		player = this->_enterQue.find(key1);
		if(NULL != player)
		{
			gxDebug("Delete player from enterque!Key = {0}", key1);
			if(NULL == this->_enterQue.remove(key1))
			{
				gxAssert(false);
			}
		}
	}

	if(NULL == player)
	{
		player = this->_logoutQue.find(key1);
		if(NULL != player)
		{
			gxDebug("Delete player from logout!Key = {0}", key1);
			if(NULL == this->_logoutQue.remove(key1))
			{
				gxAssert(false);
			}
		}
	}

	if(player == NULL)
	{
		gxDebug("Can't delete player! Key1 = {0}", key1);
		return;
	}

	if(player)
	{
		_objPool.deleteObj(player);
		// @todo 添加删除回调接口
		// player->onDelete();
	}
}

template<typename T>
bool CGamePlayerMgr2Pool<T>::init( sint32 maxPlayerNum )
{
	return _objPool.init(maxPlayerNum);
}

// template<typename T>
// uint32 CGamePlayerMgr2Pool<T>::size()
// {
// 	return _objPool.getCount();
// }

template<typename T>
uint32 CGamePlayerMgr2<T>::size()
{
	return _readyQue.size()+_enterQue.size()+_logoutQue.size();
}

template<typename T>
typename CGamePlayerMgr2<T>::ValueType CGamePlayerMgr2<T>::remove( typename T::KeyType key1 )
{
#ifdef LIB_DEBUG
	DCheckPlayer(key1);
#endif
	
    ValueType val = NULL;
    if(_enterQue.isExist1(key1))
    {
        val = _enterQue.remove(key1);
        if(NULL != val)
        {
            return val;
        }
    }

    if(_readyQue.isExist1(key1))
    {
        val = _readyQue.remove(key1);
        if(NULL != val)
        {
            return val;
        }
    }

    if(_logoutQue.isExist1(key1))
    {
        val = _logoutQue.remove(key1);
    }

	return val;
}

template<typename T>
bool CGamePlayerMgr2<T>::isExist( typename T::KeyType key1 )
{
    return find(key1) != NULL;
}

template<typename T>
uint32 CGamePlayerMgr2<T>::logoutSize()
{
    return _logoutQue.size();
}
template<typename T>
uint32 CGamePlayerMgr2<T>::enterSize()
{
    return _enterQue.size();
}
template<typename T>
uint32 CGamePlayerMgr2<T>::readySize()
{
    return _readyQue.size();
}
template<typename T>
void CGamePlayerMgr2<T>::traverseLogout( TTraverseCallType call, void* arg )
{
    _logoutQue.traverse(call, arg);
}
template<typename T>
void CGamePlayerMgr2<T>::traverseEnter( TTraverseCallType call, void* arg )
{
    _enterQue.traverse(call, arg);
}
template<typename T>
void CGamePlayerMgr2<T>::traverseReady( TTraverseCallType call, void* arg )
{
    _readyQue.traverse(call, arg);
}

template<typename T>
typename CGamePlayerMgr2<T>::ValueType CGamePlayerMgr2<T>::removeFromLogout( typename T::KeyType key1 )
{
    DCheckPlayer(key1);
    ValueType val = _logoutQue.remove(key1);
    if(TBaseType::InvalidValue == val)
    {
        return TBaseType::InvalidValue;
    }

    val->onRemoveFromLogout();
    return val;
}
template<typename T>
bool CGamePlayerMgr2<T>::addToLogout( ValueType player )
{
    DCheckPlayerAll2(player);
    if(!player->onAddToLogout())
    {
        return false;
    }

    return _logoutQue.add(player);
}
template<typename T>
typename CGamePlayerMgr2<T>::ValueType CGamePlayerMgr2<T>::findInLogout( typename T::KeyType key1 )
{
    return _logoutQue.find(key1);
}
template<typename T>
typename CGamePlayerMgr2<T>::ValueType CGamePlayerMgr2<T>::findInLogout2( typename T::KeyType2 key2 )
{
    return _logoutQue.find2(key2);
}
template<typename T>
typename CGamePlayerMgr2<T>::ValueType CGamePlayerMgr2<T>::removeFromEnter( typename T::KeyType key1 )
{
    DCheckPlayer(key1);
    ValueType val = _enterQue.remove(key1);
    if(TBaseType::InvalidValue == val)
    {
        return TBaseType::InvalidValue;
    }

    val->onRemoveFromEnter();
    return val;
}
template<typename T>
bool CGamePlayerMgr2<T>::addToEnter( ValueType player )
{
    DCheckPlayerAll2(player);
    if(false == player->onAddToEnter())
    {
        return false;
    }

    return _enterQue.add(player);
}
template<typename T>
typename CGamePlayerMgr2<T>::ValueType CGamePlayerMgr2<T>::findInEnter( typename T::KeyType key1 )
{
    return _enterQue.find(key1);
}
template<typename T>
typename CGamePlayerMgr2<T>::ValueType CGamePlayerMgr2<T>::findInEnter2( typename T::KeyType2 key2 )
{
    return _enterQue.find2(key2);
}
template<typename T>
typename CGamePlayerMgr2<T>::ValueType CGamePlayerMgr2<T>::removeFromReady( typename T::KeyType key1 )
{
    DCheckPlayer(key1);
    ValueType val = _readyQue.remove(key1);
    if(TBaseType::InvalidValue == val)
    {
        return TBaseType::InvalidValue;
    }

    val->onRemoveFromReady();
    return val;
}
template<typename T>
bool CGamePlayerMgr2<T>::addToReady( ValueType player )
{
    DCheckPlayerAll2(player);
    if(false == player->onAddToReady())
    {
        return false;
    }

    return _readyQue.add(player);
}
template<typename T>
typename CGamePlayerMgr2<T>::ValueType CGamePlayerMgr2<T>::findInReady( typename T::KeyType key1 )
{
    return _readyQue.find(key1);
}

template<typename T>
typename CGamePlayerMgr2<T>::ValueType CGamePlayerMgr2<T>::findInReady2( typename T::KeyType2 key2 )
{
    return _readyQue.find2(key2);
}

template<typename T>
typename CGamePlayerMgr2<T>::ValueType CGamePlayerMgr2<T>::find( typename T::KeyType key1 )
{
    DCheckPlayer(key1);
    ValueType player = _enterQue.find(key1);
    if(NULL == player)
    {
        player = _logoutQue.find(key1);
    }
    if(NULL == player)
    {
        player = _readyQue.find(key1);
    }

    if(NULL == player)
    {
        gxDebug("Can't find player! Key1 = {0}", key1);
        return NULL;
    }

    return player;
}

template<typename T>
typename CGamePlayerMgr2<T>::ValueType CGamePlayerMgr2<T>::find2( typename T::KeyType2 key2 )
{
    DCheckPlayer2(key2);
    ValueType player = _readyQue.find2(key2);
    if(NULL == player)
    {
        player = _enterQue.find2(key2);
    }
    if(NULL == player)
    {
        player = _logoutQue.find2(key2);
    }

    if(NULL == player)
    {
        gxDebug("Can't find player! Key2 = {0}", key2);
        return NULL;
    }

    return player;
}


template<typename T>
class CGamePlayerMgr3
{
public:
    typedef GXMISC::CHashMultiIndex3<T> TBaseType;
    typedef typename TBaseType::TTraverseCallType TTraverseCallType;             // 遍历的函数类型
    typedef typename TBaseType::ValueType ValueType;
    typedef typename TBaseType::Iterator Iterator;

public:
    CGamePlayerMgr3(){}
    ~CGamePlayerMgr3(){}

public:
    uint32 size();
    bool isExist(typename T::KeyType key);
    bool isExist2(typename T::KeyType2 key);
    bool isExist3(typename T::KeyType3 key);

    // 不允许在遍历函数中删除对象, 不允许调用addTo*, remove*类型的函数
    void traverseReady(TTraverseCallType call, void* arg);
    void traverseEnter(TTraverseCallType call, void* arg);
    void traverseLogout(TTraverseCallType call, void* arg);

public:
    bool addToReady(ValueType player);
    ValueType removeFromReady(typename T::KeyType key1);
    uint32 readySize();
    bool addToEnter(ValueType player);
    ValueType removeFromEnter(typename T::KeyType key1);
    uint32 enterSize();
    bool addToLogout(ValueType player);
    ValueType removeFromLogout(typename T::KeyType key1);
    uint32 logoutSize();
	ValueType remove(typename T::KeyType key1);

protected:
    ValueType find(typename T::KeyType key1);
    ValueType find2(typename T::KeyType2 key2);
    ValueType find3(typename T::KeyType3 key3);
    ValueType findInReady(typename T::KeyType key1);
    ValueType findInReady2(typename T::KeyType2 key2);
    ValueType findInReady3(typename T::KeyType3 key3);
    ValueType findInEnter(typename T::KeyType key1);
    ValueType findInEnter2(typename T::KeyType2 key2);
    ValueType findInEnter3(typename T::KeyType3 key3);
    ValueType findInLogout(typename T::KeyType key1);
    ValueType findInLogout2(typename T::KeyType2 key2);
    ValueType findInLogout3(typename T::KeyType3 key3);

protected:
//    GXMISC::CFixObjPool<T>      _objPool;        // 对象池
    GXMISC::CHashMultiIndex3<T> _readyQue;       // 登陆队列
    GXMISC::CHashMultiIndex3<T> _enterQue;       // 游戏队列
    GXMISC::CHashMultiIndex3<T> _logoutQue;      // 登出队列
};

template<typename T>
class CGamePlayerMgr3Pool : public CGamePlayerMgr3<T>
{
public:
	typedef CGamePlayerMgr3<T> TBaseType;
	typedef typename TBaseType::ValueType ValueType;
public:
	CGamePlayerMgr3Pool(){}
	~CGamePlayerMgr3Pool(){}

public:
	bool init(sint32 maxPlayerNum);
//	uint32 size();

public:
	ValueType addNewPlayer(typename T::KeyType key1, typename T::KeyType2 key2, typename T::KeyType3 key3, bool isAddToReady = false);
	void freeNewPlayer(ValueType val);
	void delPlayer(typename T::KeyType key1);

protected:
	GXMISC::CFixObjPool<T>   _objPool;           // 对象池
};

template<typename T>
typename CGamePlayerMgr3Pool<T>::ValueType CGamePlayerMgr3Pool<T>::addNewPlayer( typename T::KeyType key1, typename T::KeyType2 key2, typename T::KeyType3 key3, bool isAddToReady /* = false */ )
{
	ValueType player = _objPool.newObj();
	gxAssert(player != NULL);
	if(player == NULL)
	{
		gxError("Can't get new player object! Key1={0},Key2={1},Key3={2}", key1, key2, key3);
		return NULL;
	}

	player->setKey(key1);
	player->setKey2(key2);
	player->setKey3(key3);
	if(isAddToReady)
	{
		if(false == addToReady(player))
		{
			gxError("Can't get new player object! Key1={0},Key2={1},Key3={2}", key1, key2, key3);
			_objPool.deleteObj(player);
			return NULL;
		}

		gxDebug("Add player to ReadyQueue!");
	}

	return player;
}

template<typename T>
void CGamePlayerMgr3Pool<T>::freeNewPlayer(ValueType val)
{
	_objPool.deleteObj(val);
}

template<typename T>
void CGamePlayerMgr3Pool<T>::delPlayer( typename T::KeyType key1 )
{
	gxDebug("Delete player from player mgr! Key1 = {0}", key1);

	DCheckPlayer(key1);

	ValueType player = this->_readyQue.find(key1);
	if(NULL != player)
	{
		gxDebug("Delete player from readque!Key1 = {0}", key1);
		if(NULL == this->_readyQue.remove(key1))
		{
			gxAssert(false);
		}
	}

	if(NULL == player)
	{
		player = this->_enterQue.find(key1);
		if(NULL != player)
		{
			gxDebug("Delete player from enterque!Key1 = {0}", key1);
			if(NULL == this->_enterQue.remove(key1))
			{
				gxAssert(false);
			}
		}
	}

	if(NULL == player)
	{
		player = this->_logoutQue.find(key1);
		if(NULL != player)
		{
			gxDebug("Delete player from logout!Key1 = {0}", key1);
			if(NULL == this->_logoutQue.remove(key1))
			{
				gxAssert(false);
			}
		}
	}

	if(player == NULL)
	{
		gxDebug("Can't delete player! Key1 = {0}", key1);
		return;
	}

	if(player)
	{
		_objPool.deleteObj(player);
	}
}

template<typename T>
bool CGamePlayerMgr3Pool<T>::init( sint32 maxPlayerNum )
{
	return _objPool.init(maxPlayerNum);
}

// template<typename T>
// uint32 CGamePlayerMgr3Pool<T>::size()
// {
// 	return _objPool.getCount();
// }

template<typename T>
uint32 CGamePlayerMgr3<T>::size()
{
	return _readyQue.size()+_enterQue.size()+_logoutQue.size();
}

template<typename T>
typename CGamePlayerMgr3<T>::ValueType CGamePlayerMgr3<T>::remove( typename T::KeyType key1 )
{
	DCheckPlayer(key1);

    ValueType val = NULL;
    if(_enterQue.isExist1(key1))
    {
        val = _enterQue.remove(key1);
        if(NULL != val)
        {
            return val;
        }
    }

    if(_readyQue.isExist1(key1))
    {
        val = _readyQue.remove(key1);
        if(NULL != val)
        {
            return val;
        }
    }

    if(_logoutQue.isExist1(key1))
    {
        val = _logoutQue.remove(key1);
    }

    return val;
}

template<typename T>
bool CGamePlayerMgr3<T>::isExist( typename T::KeyType key )
{
    return find(key) != NULL;
}

template<typename T>
bool CGamePlayerMgr3<T>::isExist2( typename T::KeyType2 key )
{
    return find2(key) != NULL;
}

template<typename T>
bool CGamePlayerMgr3<T>::isExist3( typename T::KeyType3 key )
{
    return find3(key) != NULL;
}

template<typename T>
uint32 CGamePlayerMgr3<T>::logoutSize()
{
    return _logoutQue.size();
}
template<typename T>
uint32 CGamePlayerMgr3<T>::enterSize()
{
    return _enterQue.size();
}
template<typename T>
uint32 CGamePlayerMgr3<T>::readySize()
{
    return _readyQue.size();
}
template<typename T>
void CGamePlayerMgr3<T>::traverseLogout( TTraverseCallType call, void* arg )
{
    _logoutQue.traverse(call, arg);
}
template<typename T>
void CGamePlayerMgr3<T>::traverseEnter( TTraverseCallType call, void* arg )
{
    _enterQue.traverse(call, arg);
}
template<typename T>
void CGamePlayerMgr3<T>::traverseReady( TTraverseCallType call, void* arg )
{
    _readyQue.traverse(call, arg);
}

template<typename T>
typename CGamePlayerMgr3<T>::ValueType CGamePlayerMgr3<T>::removeFromLogout( typename T::KeyType key1 )
{
    DCheckPlayer(key1);
    ValueType val = _logoutQue.remove(key1);
    if(TBaseType::InvalidValue == val)
    {
        return TBaseType::InvalidValue;
    }

    val->onRemoveFromLogout();
    return val;
}
template<typename T>
bool CGamePlayerMgr3<T>::addToLogout( ValueType player )
{
    DCheckPlayerAll3(player);
    if(!player->onAddToLogout())
    {
        return false;
    }

    return _logoutQue.add(player);
}
template<typename T>
typename CGamePlayerMgr3<T>::ValueType CGamePlayerMgr3<T>::findInLogout( typename T::KeyType key1 )
{
    return _logoutQue.find(key1);
}
template<typename T>
typename CGamePlayerMgr3<T>::ValueType CGamePlayerMgr3<T>::findInLogout2( typename T::KeyType2 key2 )
{
    return _logoutQue.find2(key2);
}
template<typename T>
typename CGamePlayerMgr3<T>::ValueType CGamePlayerMgr3<T>::findInLogout3( typename T::KeyType3 key3 )
{
    return _logoutQue.find3(key3);
}
template<typename T>
typename CGamePlayerMgr3<T>::ValueType CGamePlayerMgr3<T>::removeFromEnter( typename T::KeyType key1 )
{
    DCheckPlayer(key1);
    ValueType val = _enterQue.remove(key1);
    if(TBaseType::InvalidValue == val)
    {
        return TBaseType::InvalidValue;
    }

    val->onRemoveFromEnter();
    return val;
}
template<typename T>
bool CGamePlayerMgr3<T>::addToEnter( ValueType player )
{
    DCheckPlayerAll3(player);
    if(false == player->onAddToEnter())
    {
        return false;
    }

    return _enterQue.add(player);
}
template<typename T>
typename CGamePlayerMgr3<T>::ValueType CGamePlayerMgr3<T>::findInEnter( typename T::KeyType key1 )
{
    return _enterQue.find(key1);
}
template<typename T>
typename CGamePlayerMgr3<T>::ValueType CGamePlayerMgr3<T>::findInEnter2( typename T::KeyType2 key2 )
{
    return _enterQue.find2(key2);
}
template<typename T>
typename CGamePlayerMgr3<T>::ValueType CGamePlayerMgr3<T>::findInEnter3( typename T::KeyType3 key3 )
{
    return _enterQue.find3(key3);
}
template<typename T>
typename CGamePlayerMgr3<T>::ValueType CGamePlayerMgr3<T>::removeFromReady( typename T::KeyType key1 )
{
    DCheckPlayer(key1);
    ValueType val = _readyQue.remove(key1);
    if(TBaseType::InvalidValue == val)
    {
        return TBaseType::InvalidValue;
    }

    val->onRemoveFromReady();
    return val;
}
template<typename T>
bool CGamePlayerMgr3<T>::addToReady( ValueType player )
{
    DCheckPlayerAll3(player);
    if(false == player->onAddToReady())
    {
        return false;
    }

    return _readyQue.add(player);
}
template<typename T>
typename CGamePlayerMgr3<T>::ValueType CGamePlayerMgr3<T>::findInReady( typename T::KeyType key1 )
{
    return _readyQue.find(key1);
}
template<typename T>
typename CGamePlayerMgr3<T>::ValueType CGamePlayerMgr3<T>::findInReady2( typename T::KeyType2 key2 )
{
    return _readyQue.find2(key2);
}
template<typename T>
typename CGamePlayerMgr3<T>::ValueType CGamePlayerMgr3<T>::findInReady3( typename T::KeyType3 key3 )
{
    return _readyQue.find3(key3);
}

template<typename T>
typename CGamePlayerMgr3<T>::ValueType CGamePlayerMgr3<T>::find( typename T::KeyType key1 )
{
    DCheckPlayer(key1);
	ValueType player = _enterQue.find(key1);
	if(NULL == player)
	{
		player = _logoutQue.find(key1);
    }
    if(NULL == player)
    {
        player = _readyQue.find(key1);
    }

    if(NULL == player)
    {
        gxDebug("Can't find player! Key1 = {0}", key1);
        return NULL;
    }

    return player;
}

template<typename T>
typename CGamePlayerMgr3<T>::ValueType CGamePlayerMgr3<T>::find2( typename T::KeyType2 key2 )
{
    DCheckPlayer2(key2);
    ValueType player = _enterQue.find2(key2);
    if(NULL == player)
    {
        player = _logoutQue.find2(key2);
    }
    if(NULL == player)
    {
        player = _readyQue.find2(key2);
    }

    if(NULL == player)
    {
        gxDebug("Can't find player! Key2 = {0}", key2);
        return NULL;
    }

    return player;
}

template<typename T>
typename CGamePlayerMgr3<T>::ValueType CGamePlayerMgr3<T>::find3( typename T::KeyType3 key3 )
{
    DCheckPlayer3(key3);
    ValueType player = _enterQue.find3(key3);
    if(NULL == player)
    {
        player = _logoutQue.find3(key3);
    }
    if(NULL == player)
    {
        player = _readyQue.find3(key3);
    }

    if(NULL == player)
    {
        gxDebug("Can't find player! Key3 = {0}", key3);
        return NULL;
    }

    return player;
}

template<typename T>
class CGamePlayerMgr4
{
public:
    typedef GXMISC::CHashMultiIndex4<T> TBaseType;
    typedef typename TBaseType::TTraverseCallType TTraverseCallType;   // 遍历的函数类型
    typedef typename TBaseType::ValueType ValueType;

public:
    CGamePlayerMgr4(){}
    ~CGamePlayerMgr4(){}

public:
    uint32 size();
    bool isExist(typename T::KeyType key1);

    // 不允许在遍历函数中删除对象, 不允许调用addTo*, remove*类型的函数
    void traverseReady(TTraverseCallType call, void* arg);
    void traverseEnter(TTraverseCallType call, void* arg);
    void traverseLogout(TTraverseCallType call, void* arg);

public:
    bool addToReady(ValueType player);
    ValueType removeFromReady(typename T::KeyType key1);
    uint32 readySize();
    bool addToEnter(ValueType player);
    ValueType removeFromEnter(typename T::KeyType key1);
    uint32 enterSize();
    bool addToLogout(ValueType player);
    ValueType removeFromLogout(typename T::KeyType key1);
    uint32 logoutSize();
	ValueType remove(typename T::KeyType key1);

protected:
	ValueType find(typename T::KeyType key1);
	ValueType find2(typename T::KeyType2 key2);
	ValueType find3(typename T::KeyType3 key3);
	ValueType find4(typename T::KeyType4 key4);
	ValueType findInReady(typename T::KeyType key1);
	ValueType findInReady2(typename T::KeyType2 key2);
	ValueType findInReady3(typename T::KeyType3 key3);
	ValueType findInReady4(typename T::KeyType4 key4);
	ValueType findInEnter(typename T::KeyType key1);
	ValueType findInEnter2(typename T::KeyType2 key2);
	ValueType findInEnter3(typename T::KeyType3 key3);
	ValueType findInEnter4(typename T::KeyType4 key4);
	ValueType findInLogout(typename T::KeyType key1);
	ValueType findInLogout2(typename T::KeyType2 key2);
	ValueType findInLogout3(typename T::KeyType3 key3);
	ValueType findInLogout4(typename T::KeyType4 key4);

protected:
//    GXMISC::CFixObjPool<T>      _objPool;           // 对象池
    GXMISC::CHashMultiIndex4<T> _readyQue;          // 登陆队列
    GXMISC::CHashMultiIndex4<T> _enterQue;          // 游戏队列
    GXMISC::CHashMultiIndex4<T> _logoutQue;         // 登出队列
};

template<typename T>
class CGamePlayerMgr4Pool : public CGamePlayerMgr4<T>
{
public:
	typedef CGamePlayerMgr4<T> TBaseType;
	typedef typename TBaseType::ValueType ValueType;
public:
	CGamePlayerMgr4Pool(){}
	~CGamePlayerMgr4Pool(){}

public:
	bool init(sint32 maxPlayerNum);

public:
	ValueType addNewPlayer(typename T::KeyType key1, typename T::KeyType2 key2, typename T::KeyType3 key3, typename T::KeyType4 key4, bool isAddToReady = false);
	void freeNewPlayer(ValueType val);
	void delPlayer(typename T::KeyType key1);
//	uint32 size();

protected:
	GXMISC::CFixObjPool<T>   _objPool;           // 对象池
};

template<typename T>
typename CGamePlayerMgr4Pool<T>::ValueType CGamePlayerMgr4Pool<T>::addNewPlayer( 
	typename T::KeyType key1, typename T::KeyType2 key2, typename T::KeyType3 key3, typename T::KeyType4 key4, bool isAddToReady /* = false */ )
{
	ValueType player = _objPool.newObj();
	gxAssert(player != NULL);
	if(player == NULL)
	{
		gxError("Can't get new player object! Key1={0},Key2={1},Key3={2},Key4={3}", key1, key2, key3, key4);
		return NULL;
	}

	player->setKey(key1);
	player->setKey2(key2);
	player->setKey3(key3);
	player->setKey4(key4);
	if(isAddToReady)
	{
		if(false == addToReady(player))
		{
			gxError("Can't get new player object! Key1={0},Key2={1},Key3={2},Key4={3}", key1, key2, key3, key4);
			_objPool.deleteObj(player);
			return NULL;
		}

		gxDebug("Add player to ReadyQueue! Key1={0},Key2={1},Key3={2},Key4={3}", key1, key2, key3, key4);
	}

	return player;
}

template<typename T>
void CGamePlayerMgr4Pool<T>::freeNewPlayer(ValueType val)
{
	_objPool.deleteObj(val);
}

template<typename T>
void CGamePlayerMgr4Pool<T>::delPlayer( typename T::KeyType key1 )
{
	gxDebug("Delete player from player mgr! Key1 = {0}", key1);

	DCheckPlayer(key1);

	ValueType player = this->_readyQue.find(key1);
	if(NULL != player)
	{
		gxDebug("Delete player from readque!Key1= {0}", key1);
		if(NULL == this->_readyQue.remove(key1))
		{
			gxAssert(false);
		}
	}

	if(NULL == player)
	{
		player = this->_enterQue.find(key1);
		if(NULL != player)
		{
			gxDebug("Delete player from enterque!Key1 = {0}", key1);
			if(NULL == this->_enterQue.remove(key1))
			{
				gxAssert(false);
			}
		}
	}

	if(NULL == player)
	{
		player = this->_logoutQue.find(key1);
		if(NULL != player)
		{
			gxDebug("Delete player from logout!Key1 = {0}", key1);
			if(NULL == this->_logoutQue.remove(key1))
			{
				gxAssert(false);
			}
		}
	}

	if(player == NULL)
	{
		gxDebug("Can't delete player! Key1 = {0}", key1);
		return;
	}

	if(player)
	{
		_objPool.deleteObj(player);
	}
}

template<typename T>
bool CGamePlayerMgr4Pool<T>::init( sint32 maxPlayerNum )
{
	return _objPool.init(maxPlayerNum);
}

// template<typename T>
// uint32 CGamePlayerMgr4Pool<T>::size()
// {
// 	return _objPool.getCount();
// }

template<typename T>
uint32 CGamePlayerMgr4<T>::size()
{
	return _readyQue.size()+_enterQue.size()+_logoutQue.size();
}

template<typename T>
typename CGamePlayerMgr4<T>::ValueType CGamePlayerMgr4<T>::remove( typename T::KeyType key1 )
{
	DCheckPlayer(key1);
    ValueType val = NULL;

    if(_enterQue.find(key1) != NULL)
    {
        val = _enterQue.remove(key1);
        if(NULL != val)
        {
            return val;
        }
    }

    if(_readyQue.isExist1(key1))
    {
        val = _readyQue.remove(key1);
        if(NULL != val)
        {
            return val;
        }
    }

    if(_logoutQue.isExist1(key1))
    {
	    val = _logoutQue.remove(key1);
    }

	return val;
}

template<typename T>
bool CGamePlayerMgr4<T>::isExist( typename T::KeyType key1 )
{
    DCheckPlayer(key1);
    return find(key1) != NULL;
}

template<typename T>
uint32 CGamePlayerMgr4<T>::logoutSize()
{
    return _logoutQue.size();
}
template<typename T>
uint32 CGamePlayerMgr4<T>::enterSize()
{
    return _enterQue.size();
}
template<typename T>
uint32 CGamePlayerMgr4<T>::readySize()
{
    return _readyQue.size();
}
template<typename T>
void CGamePlayerMgr4<T>::traverseLogout( TTraverseCallType call, void* arg )
{
    _logoutQue.traverse(call, arg);
}
template<typename T>
void CGamePlayerMgr4<T>::traverseEnter( TTraverseCallType call, void* arg )
{
    _enterQue.traverse(call, arg);
}
template<typename T>
void CGamePlayerMgr4<T>::traverseReady( TTraverseCallType call, void* arg )
{
    _readyQue.traverse(call, arg);
}

template<typename T>
typename CGamePlayerMgr4<T>::ValueType CGamePlayerMgr4<T>::removeFromLogout( typename T::KeyType key1 )
{
    DCheckPlayer(key1);
    ValueType val = _logoutQue.remove(key1);
    if(TBaseType::InvalidValue == val)
    {
        return TBaseType::InvalidValue;
    }
    
    val->onRemoveFromLogout();
    return val;
}
template<typename T>
bool CGamePlayerMgr4<T>::addToLogout( ValueType player )
{
    DCheckPlayerAll4(player);
    if(false == player->onAddToLogout())
    {
        return false;
    }

    return _logoutQue.add(player);
}
template<typename T>
typename CGamePlayerMgr4<T>::ValueType CGamePlayerMgr4<T>::findInLogout( typename T::KeyType key1 )
{
    return _logoutQue.find(key1);
}
template<typename T>
typename CGamePlayerMgr4<T>::ValueType CGamePlayerMgr4<T>::findInLogout2( typename T::KeyType2 key2 )
{
    return _logoutQue.find2(key2);
}
template<typename T>
typename CGamePlayerMgr4<T>::ValueType CGamePlayerMgr4<T>::findInLogout3( typename T::KeyType3 key3 )
{
    return _logoutQue.find3(key3);
}
template<typename T>
typename CGamePlayerMgr4<T>::ValueType CGamePlayerMgr4<T>::findInLogout4( typename T::KeyType4 key4 )
{
    return _logoutQue.find4(key4);
}
template<typename T>
typename CGamePlayerMgr4<T>::ValueType CGamePlayerMgr4<T>::removeFromEnter( typename T::KeyType key1 )
{
    DCheckPlayer(key1);
    ValueType val = _enterQue.remove(key1);
    if(TBaseType::InvalidValue == val)
    {
        return TBaseType::InvalidValue;
    }

    val->onRemoveFromEnter();
    return val;
}
template<typename T>
bool CGamePlayerMgr4<T>::addToEnter( ValueType player )
{
    DCheckPlayerAll4(player);
    if(false == player->onAddToEnter())
    {
        return false;
    }

    return _enterQue.add(player);
}
template<typename T>
typename CGamePlayerMgr4<T>::ValueType CGamePlayerMgr4<T>::findInEnter( typename T::KeyType key1 )
{
    return _enterQue.find(key1);
}
template<typename T>
typename CGamePlayerMgr4<T>::ValueType CGamePlayerMgr4<T>::findInEnter2( typename T::KeyType2 key2 )
{
    return _enterQue.find2(key2);
}
template<typename T>
typename CGamePlayerMgr4<T>::ValueType CGamePlayerMgr4<T>::findInEnter3( typename T::KeyType3 key3 )
{
    return _enterQue.find3(key3);
}
template<typename T>
typename CGamePlayerMgr4<T>::ValueType CGamePlayerMgr4<T>::findInEnter4( typename T::KeyType4 key4 )
{
    return _enterQue.find4(key4);
}
template<typename T>
typename CGamePlayerMgr4<T>::ValueType CGamePlayerMgr4<T>::removeFromReady( typename T::KeyType key1 )
{
    DCheckPlayer(key1);
    ValueType val = _readyQue.remove(key1);
    if(TBaseType::InvalidValue == val)
    {
        return TBaseType::InvalidValue;
    }

    val->onRemoveFromReady();
    return val;
}
template<typename T>
bool CGamePlayerMgr4<T>::addToReady( ValueType player )
{
    DCheckPlayerAll4(player);
    if(false == player->onAddToReady())
    {
        return false;
    }

    return _readyQue.add(player);
}
template<typename T>
typename CGamePlayerMgr4<T>::ValueType CGamePlayerMgr4<T>::findInReady( typename T::KeyType key1 )
{
    return _readyQue.find(key1);
}
template<typename T>
typename CGamePlayerMgr4<T>::ValueType CGamePlayerMgr4<T>::findInReady2( typename T::KeyType2 key2 )
{
    return _readyQue.find2(key2);
}
template<typename T>
typename CGamePlayerMgr4<T>::ValueType CGamePlayerMgr4<T>::findInReady3( typename T::KeyType3 key3 )
{
    return _readyQue.find3(key3);
}
template<typename T>
typename CGamePlayerMgr4<T>::ValueType CGamePlayerMgr4<T>::findInReady4( typename T::KeyType4 key4 )
{
    return _readyQue.find4(key4);
}

template<typename T>
typename CGamePlayerMgr4<T>::ValueType CGamePlayerMgr4<T>::find( typename T::KeyType key1 )
{
    DCheckPlayer(key1);
    ValueType player = _enterQue.find(key1);
    if(NULL == player)
    {
        player = _logoutQue.find(key1);
    }
    if(NULL == player)
    {
        player = _readyQue.find(key1);
    }

    if(NULL == player)
    {
        gxDebug("Can't find player! Key1 = {0}", key1);
        return NULL;
    }

    return player;
}

template<typename T>
typename CGamePlayerMgr4<T>::ValueType CGamePlayerMgr4<T>::find2( typename T::KeyType2 key2 )
{
    DCheckPlayer2(key2);
    ValueType player = _enterQue.find2(key2);
    if(NULL == player)
    {
        player = _logoutQue.find2(key2);
    }
    if(NULL == player)
    {
        player = _readyQue.find2(key2);
    }

    if(NULL == player)
    {
        gxDebug("Can't find player! Key2 = {0}", key2);
        return NULL;
    }

    return player;
}

template<typename T>
typename CGamePlayerMgr4<T>::ValueType CGamePlayerMgr4<T>::find3( typename T::KeyType3 key3 )
{
    DCheckPlayer3(key3);
    ValueType player = _enterQue.find3(key3);
    if(NULL == player)
    {
        player = _logoutQue.find3(key3);
    }
    if(NULL == player)
    {
        player = _readyQue.find3(key3);
    }

    if(NULL == player)
    {
        gxDebug("Can't find player! Key3 = {0}", key3);
        return NULL;
    }

    return player;
}

template<typename T>
typename CGamePlayerMgr4<T>::ValueType CGamePlayerMgr4<T>::find4( typename T::KeyType4 key4 )
{
    DCheckPlayer4(key4);
    ValueType player = _enterQue.find4(key4);
    if(NULL == player)
    {
        player = _logoutQue.find4(key4);
    }
    if(NULL == player)
    {
        player = _readyQue.find4(key4);
    }
    if(NULL == player)
    {
        gxDebug("Can't find player! Key4 = {0}", key4);
        return NULL;
    }

    return player;
}

#endif