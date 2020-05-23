#include "object_manager.h"

void CObjectManager::update( GXMISC::TDiffTime_t diff )
{

}

bool CObjectManager::init(TObjManagerInit* initMgr)
{
	_genObjUID = initMgr->initObjUID;
	_maxObjUID = initMgr->maxObjUID;
	return true;
}

TObjUID_t CObjectManager::genObjUID()
{
	if(_genObjUID >= _maxObjUID)
	{
		return INVALID_OBJ_UID;
	}

	return _genObjUID++;
}