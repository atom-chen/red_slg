#include "core/lib_misc.h"

#include "limit_manager.h"
#include "game_misc.h"

CLimitManager::CLimitManager()
{
	cleanUp();
	//_timer.init(DEFAULT_CHECK_ROLE_LIMIT_TIME * GXMISC::MILL_SECOND_IN_MINUTE);
}

CLimitManager::~CLimitManager()
{
	cleanUp();
}

void CLimitManager::update( uint32 diff )
{
	//_timer.update(diff);
	//if ( !_timer.isPassed() )
	//{
	//	return ;
	//}
	//_timer.reset();
	//std::vector<uint32>	delVec;
	//GXMISC::TGameTime_t curTime = DTimeManager.nowSysTime();
	//LimitInfoItr itr = _limitAccountInfo.begin();
	//for ( ; itr!=_limitAccountInfo.end(); ++itr )
	//{
	//	TLimitAccountInfo& limitInfo = itr->second; 
	//	if ( limitInfo.limitLogin > 0 && limitInfo.limitLoginTime > curTime )
	//	{
	//		continue;
	//	}
	//	if ( limitInfo.limitChat == 0 || limitInfo.limitChatTime < curTime )
	//	{
	//		delVec.push_back(itr->first);
	//	}
	//	else if ( limitInfo.limitLogin != 0 )
	//	{
	//		limitInfo.limitLogin = 0;
	//	}
	//}

	//std::vector<uint32>::iterator delItr = delVec.begin();
	//for ( ; delItr!=delVec.end(); ++delItr )
	//{
	//	itr = _limitAccountInfo.find(*delItr);
	//	if ( itr != _limitAccountInfo.end() )
	//	{
	//		_limitAccountInfo.erase(itr);
	//	}
	//}
}

bool CLimitManager::loadLimitInfoFromDB( const std::vector<TLimitAccountInfo>* data )
{
	std::vector<TLimitAccountInfo>::const_iterator itr = data->begin();
	for (; itr != data->end(); ++itr)
	{
		TLimitAccountInfo limitInfo = *itr;
		//uint32 limitKey = GXMISC::StrCRC32(limitInfo.limitKey.data());
		//_limitAccountInfo[limitKey] = limitInfo;
	}
	return true;
}

bool CLimitManager::checkLimitLogin( TAccountID_t accountID ) const
{
	/*
	TLimitKeyStr_t keyStr = GXMISC::gxToString(accountID);
	uint32 limitKey = GXMISC::StrCRC32(keyStr.data());
	LimitInfoCItr itr = _limitAccountInfo.find(limitKey);
	if ( itr == _limitAccountInfo.end() )
	{
		return false;
	}
	*/
	return true; //itr->second.limitLogin > 0;
}

bool CLimitManager::checkLimitLogin( const std::string ip ) const
{
// 	uint32 limitKey = GXMISC::StrCRC32(ip.c_str());
// 	LimitInfoCItr itr = _limitAccountInfo.find(limitKey);
// 	if ( itr == _limitAccountInfo.end() )
// 	{
// 		return false;
// 	}
	return true ; //itr->second.limitLogin > 0;
}

bool CLimitManager::checkLimitChat( TAccountID_t accountID ) const
{
	//TLimitKeyStr_t keyStr = GXMISC::gxToString(accountID);
	//uint32 limitKey = GXMISC::StrCRC32(keyStr.data());
	//LimitInfoCItr itr = _limitAccountInfo.find(limitKey);
	//if ( itr == _limitAccountInfo.end() )
	//{
	//	return false;
	//}
	//return itr->second.limitChat > 0;
	return true;
}


void CLimitManager::updateLimitRole( ERoleLimitType limitType, TAccountID_t accountID, uint8 limitVal, GXMISC::TGameTime_t limitTime )
{
	std::string limitKey;
	limitKey = GXMISC::gxToString(accountID);
	updateLimitRole(limitType, limitKey, limitVal, limitTime);
}

void CLimitManager::updateLimitRole( ERoleLimitType limitType, const std::string& limitKey, uint8 limitVal, GXMISC::TGameTime_t limitTime )
{
	//uint32 limitKeyVal = GXMISC::StrCRC32(limitKey.c_str());
	//LimitInfoItr itr = _limitAccountInfo.find(limitKeyVal);
	//ERoleOptLimitType optLimitType = (limitType == ROLE_LIMIT_LOGIN || limitType == ROLE_LIMIT_DEL_LOGIN) ? ROLE_LIMIT_OPT_UPDATE_LOGIN : ROLE_LIMIT_OPT_UPDATE_CHAT;
	//if ( limitType == ROLE_LIMIT_LOGIN || limitType == ROLE_LIMIT_CHAT )
	//{
	//	limitVal = 1;
	//	if ( itr == _limitAccountInfo.end() )
	//	{
	//		TLimitAccountInfo limitInfo;
	//		limitInfo.limitKey = limitKey;
	//		limitType == ROLE_LIMIT_LOGIN ? limitInfo.limitLogin = limitVal : limitInfo.limitChat = limitVal;
	//		limitType == ROLE_LIMIT_LOGIN ? limitInfo.limitLoginTime = limitTime : limitInfo.limitChatTime = limitTime;
	//		_limitAccountInfo[limitKeyVal] = limitInfo;
	//	}
	//	else
	//	{
	//		TLimitAccountInfo& limitInfo = itr->second;
	//		limitType == ROLE_LIMIT_LOGIN ? limitInfo.limitLogin = limitVal : limitInfo.limitChat = limitVal;
	//		limitType == ROLE_LIMIT_LOGIN ? limitInfo.limitLoginTime = limitTime : limitInfo.limitChatTime = limitTime;
	//	}
	//}
	//else if ( limitType == ROLE_LIMIT_DEL_LOGIN || limitType == ROLE_LIMIT_DEL_CHAT )
	//{
	//	limitVal = 0;
	//	if ( itr == _limitAccountInfo.end() )
	//	{
	//		return ;
	//	}
	//	TLimitAccountInfo& limitInfo = itr->second;
	//	limitType == ROLE_LIMIT_DEL_CHAT ? limitInfo.limitChat = 0 : limitInfo.limitLogin = 0;
	//	if ( limitInfo.limitChat == 0 && limitInfo.limitLogin == 0 )
	//	{
	//		optLimitType = ROLE_LIMIT_OPT_DEL;
	//	}
	//}
}

void CLimitManager::cleanUp()
{
	_limitAccountInfo.clear();
	_maxMakeId = 0;
}

void CLimitManager::initLimitAccountIDList( const TLimitAccountDBAry * dataary )
{
	_limitAccountInfo.clear();
	for (TLimitAccountDBAry::const_iterator it = dataary->begin(); it != dataary->end(); it++)
	{
		TLimitAccountInfo tmp;		
		tmp.limitAccountID   = it->limitAccountID;
		tmp.limitRoleID      = it->limitRoleID;
		tmp.islimitAll       = it->islimitAll;
		tmp.worldserverAry   = it->worldserverAry;
		tmp.begintime        = it->begintime;
		tmp.endtime          = it->endtime;
		tmp.uniqueId         = it->uniqueId;
				
		if( ! isExistLimitAccountInfo( &tmp ) )
		{
			_limitAccountInfo.push_back( tmp );
		}

		if( it->uniqueId > _maxMakeId )
		{
			_maxMakeId = it->uniqueId;
		}
		
	}
}

void CLimitManager::initLimitChatList( const TLimitChatDBAry * dataary )
{
	_limitChatVec.clear();
	for (TLimitChatDBAry::const_iterator it = dataary->begin(); it != dataary->end(); it++)
	{
		TLimitChatInfo tmp;
		tmp.limitAccountID   = it->limitAccountID;
		tmp.limitRoleID      = it->limitRoleID;
		tmp.islimitAll       = it->islimitAll;
		tmp.worldserverAry   = it->worldserverAry;
		tmp.begintime        = it->begintime;
		tmp.endtime          = it->endtime;
		tmp.uniqueId         = it->uniqueId;
		
		_limitChatVec.push_back( tmp );
		if( ! isExistLimitChatInfo(&tmp) )
		{
			_limitChatVec.push_back( tmp );
		}

		if( it->uniqueId > _maxMakeId )
		{
			_maxMakeId = it->uniqueId;
		}
	}
}

EGameRetCode CLimitManager::addLimitAccount( const TLimitAccountInfo * data )
{
	TLimitAccountInfo tmp = *data;
	tmp.uniqueId          = getUniqueId();
	_limitAccountInfo.push_back( tmp );
	return RC_FAILED;
}

EGameRetCode CLimitManager::addLimitChat( const TLimitChatInfo * data )
{
	TLimitChatInfo tmp = *data;
	tmp.uniqueId       = getUniqueId();
	_limitChatVec.push_back( tmp );
	return RC_FAILED;
}


EGameRetCode	CLimitManager::addLimitAccountMap(const TLimitAccountInfo * data)
{
	//暂时没这样需求
	return RC_FAILED;
}

EGameRetCode	CLimitManager::addLimitChatMap(const TLimitChatInfo * data)
{
	LimitChatInfoVec::size_type pos = findLimitChatPos(data->uniqueId);
	if( pos!=_limitChatVec.size() )
	{
		_limitChatVec[pos]=*data;
	}
	else
	{
		_limitChatVec.push_back(*data);
	}
	
	return RC_FAILED;
}

//查找封号信息位置
LimitAccountInfoContainer::size_type CLimitManager::findLimitAccountPos( const TServerOperatorId_t uniqueId  )
{
	LimitAccountInfoContainer::size_type i=0;
	for( ; i!=_limitAccountInfo.size(); i++ )
	{
		if( _limitAccountInfo[i].uniqueId == uniqueId )
		{
			break;
		}
	}
	
	return i;
}

//查找禁言信息位置
LimitChatInfoVec::size_type CLimitManager::findLimitChatPos( const TServerOperatorId_t uniqueId  )
{
	LimitChatInfoVec::size_type i=0;
	for( ; i!=_limitChatVec.size(); i++ )
	{
		if( _limitChatVec[i].uniqueId == uniqueId )
		{
			break;
		}
	}

	return i;
}

EGameRetCode CLimitManager::deleteLimitAccount( const TServerOperatorId_t uniqueId   )
{
	LimitAccountInfoContainer::size_type pos = findLimitAccountPos( uniqueId );
	if( pos!= _limitAccountInfo.size() )
	{
		_limitAccountInfo.erase( _limitAccountInfo.begin()+pos );
	}
	return RC_FAILED;
}

EGameRetCode CLimitManager::deleteLinitChat( const TServerOperatorId_t uniqueId  )
{
	LimitChatInfoVec::size_type pos = findLimitChatPos( uniqueId );
	if( pos!=_limitChatVec.size() )
	{
		_limitChatVec.erase( _limitChatVec.begin()+pos );
	}
	return RC_FAILED;
}

EGameRetCode CLimitManager::updateLimitAccount( const TLimitAccountInfo * data )
{
	LimitAccountInfoContainer::size_type pos = findLimitAccountPos(data->uniqueId);
	if( pos!=_limitAccountInfo.size() )
	{
		_limitAccountInfo[data->uniqueId] = *data;
	}	
	return RC_FAILED;
}

EGameRetCode CLimitManager::updateLimitChat( const TLimitChatInfo * data )
{
	LimitChatInfoVec::size_type pos = findLimitChatPos(data->uniqueId);
	if( pos!=_limitChatVec.size() )
	{
		_limitChatVec[data->uniqueId] = *data;
	}
	return RC_FAILED;
}

bool CLimitManager::isExistLimitAccountInfo(const TLimitAccountInfo * data )
{
	//注：暂时运行出现重复记录
	return false;
	/*
	for( LimitAccountInfoContainer::iterator it=_limitAccountInfo.begin(); it!=_limitAccountInfo.end(); it++ )
	{		
		if( it->limitAccountID==data.limitAccountID && it->limitRoleID==data.limitRoleID && it->islimitAll==data.islimitAll
			&& it->worldserverAry==data.worldserverAry && it->begintime==data.begintime && it->endtime==data.endtime )
		{
			return true;
		}
	}
	return false;
	*/
}

bool CLimitManager::isExistLimitChatInfo(const TLimitChatInfo * data )
{
	//注：暂时运行出现重复记录
	return false;
	/*
	for( LimitChatInfoVec::iterator it=_limitChatVec.begin(); it!=_limitChatVec.end(); it++ )
	{		
		if( it->limitAccountID==data.limitAccountID && it->limitRoleID==data.limitRoleID && it->islimitAll==data.islimitAll
			&& it->worldserverAry==data.worldserverAry && it->begintime==data.begintime && it->endtime==data.endtime )
		{
			return true;
		}
	}
	return false;
	*/
}

TServerOperatorId_t CLimitManager::getUniqueId()
{
	_maxMakeId += 1;
	return _maxMakeId;
}

void CLimitManager::getLimitAccountByAccountId( TLimitAccountInfoVec *vec, TAccountID_t id )
{
	vec->clear();
	for( LimitAccountInfoContainer::iterator it=_limitAccountInfo.begin(); it!=_limitAccountInfo.end(); it++ )
	{
		if( it->limitAccountID == id )
		{
			vec->push_back(*it);
		}
	}
}

void CLimitManager::getLimitChatByAccountId( TLimitChatInfoVec *vec, TAccountID_t id )
{
	vec->clear();
	for( LimitChatInfoVec::iterator it=_limitChatVec.begin(); it!=_limitChatVec.end(); it++ )
	{
		if( it->limitAccountID == id )
		{
			vec->push_back(*it);
		}
	}
}

bool CLimitManager::isForbbidChat(TAccountID_t id)
{
	for( LimitChatInfoVec::iterator it=_limitChatVec.begin(); it!=_limitChatVec.end(); it++ )
	{
		if( it->limitAccountID==id )
		{
			if( (it->begintime).getGameTime() <= DTimeManager.nowSysTime() && (it->endtime).getGameTime() >= DTimeManager.nowSysTime() )
			{
				return true;
			}
		}		
	}
	return false;
}
