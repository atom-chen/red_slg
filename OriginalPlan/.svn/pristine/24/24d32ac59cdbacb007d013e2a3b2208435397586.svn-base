#ifndef _OBJECT_MANAGER_H_
#define _OBJECT_MANAGER_H_

#include "core/multi_index.h"

#include "game_util.h"
#include "object.h"

typedef struct _ObjManagerInit
{
	TObjUID_t initObjUID;
	TObjUID_t maxObjUID;
}TObjManagerInit;

class CObjectManager : public GXMISC::CHashMultiIndex<CGameObject>
{
public:
	typedef GXMISC::CHashMultiIndex<CGameObject> TBaseType;
	DMultiIndexIterFunc(CGameObject);
public:
	CObjectManager() {} 
	virtual ~CObjectManager() {}

public:
	virtual bool init(TObjManagerInit* initMgr);
	virtual void update( GXMISC::TDiffTime_t diff );

public:
	void delObj(TBaseType::KeyType key)
	{
		remove(key);
	}

	bool isObjExist(TBaseType::KeyType key)
	{
		return isExist(key);
	}

public:
	void addObj(TBaseType::ValueType val)
	{
		add(val);
	}

	CGameObject* findObj( TObjUID_t uid )
	{
		return find(uid);
	}

	TObjUID_t genObjUID();

protected:
	TObjUID_t _genObjUID;
	TObjUID_t _maxObjUID;
};

#endif	// _OBJECT_MANAGER_H_