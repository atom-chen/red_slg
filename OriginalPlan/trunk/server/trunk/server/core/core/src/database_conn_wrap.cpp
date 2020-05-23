#include "database_conn_wrap.h"
#include "database_handler.h"
#include "database_conn_mgr.h"
#include "database_conn.h"
#include "db_task.h"

namespace GXMISC
{
	CDatabaseConnWrap::CDatabaseConnWrap(CDatabaseConnMgr* databaseMgr) : TBaseType(databaseMgr)
	{
		_clearSelf();
		_connMgr = databaseMgr;
	}

	CDatabaseConnWrap::~CDatabaseConnWrap()
	{
		_clearSelf();
	}

	void CDatabaseConnWrap::pushTask(CDbWrapTask* task)
	{
		gxAssert(isActive());
		if (isActive())
		{
			//task->doBeforeToQue(); @TODO
			task->pushToQueue();
		}
	}

	void CDatabaseConnWrap::addUser(TUniqueIndex_t index, CDatabaseHandler* handler)
	{
		_userList.insert(TDbConnUsers::value_type(index, handler));
	}

	void CDatabaseConnWrap::removeUser(TUniqueIndex_t index)
	{
		_userList.erase(index);
	}

	void CDatabaseConnWrap::onClose()
	{
		handleClearAllUser();
		_isConnected = false;
	}

	void CDatabaseConnWrap::onConnected()
	{
		_isConnected = true;
	}

	bool CDatabaseConnWrap::start()
	{
		if (TBaseType::start())
		{
			_isConnected = true;
			return true;
		}

		return false;
	}

	bool CDatabaseConnWrap::isMaxUserNum() const
	{
		return TBaseType::isMaxUserNum() || !_isConnected;
	}

	sint32 CDatabaseConnWrap::getUserNum() const
	{
		return (uint32)_userList.size();
	}

	const CDatabaseConn* CDatabaseConnWrap::getDbConn() const
	{
		return &_dbConn;
	}

	bool CDatabaseConnWrap::isActive()
	{
		return _isConnected && getDbConn()->isActive();
	}

	void CDatabaseConnWrap::handleClearAllUser()
	{
		std::vector<TUniqueIndex_t> temp;
		for (TDbConnUsers::iterator iter = _userList.begin(); iter != _userList.end(); ++iter)
		{
			CDatabaseHandler* handler = iter->second;
			if (NULL != handler)
			{
				handler->close();
			}

			temp.push_back(iter->first);
		}

		if (temp.size())
		{
			_connMgr->onDisconnected(temp);
		}
	}

	bool CDatabaseConnWrap::isStop()
	{
		return _dbConn.isStop();
	}

	void CDatabaseConnWrap::setDbHostID(TDatabaseHostID_t id)
	{
		_dbHostID = id;
	}

	TDatabaseHostID_t CDatabaseConnWrap::getDbHostID() const
	{
		return _dbHostID;
	}

	std::string CDatabaseConnWrap::toString()
	{
		return _dbConn.toString();
	}

	CDatabaseHandler* CDatabaseConnWrap::findUser(TUniqueIndex_t index)
	{
		if (_userList.find(index) != _userList.end())
		{
			return _userList[index];
		}

		return NULL;
	}

	uint8 CDatabaseConnWrap::getTag()
	{
		return _tagID;
	}

	void CDatabaseConnWrap::setTag(uint8 tag)
	{
		_tagID = tag;
	}

	CDatabaseConnMgr* CDatabaseConnWrap::getDbConnMgr()
	{
		return _connMgr;
	}

	void CDatabaseConnWrap::setStartParam(uint32 reconnInterval)
	{
		const_cast<CDatabaseConn*>(getDbConn())->setStartParam(reconnInterval);
	}

	void CDatabaseConnWrap::setDbUrlInfo(const std::string& dbHost, const std::string& dbName, const std::string& dbUser, const std::string& dbPass)
	{
		_dbConn.setDbUrlInfo(dbHost, dbName, dbUser, dbPass);
	}
	
	CModuleThreadLoop* CDatabaseConnWrap::createThreadLoop()
	{
		_dbConn.setFreeFlag(false);
		return &_dbConn;
	}

	sint32 CDatabaseConnWrap::getMaxUserNum() const
	{
		return _dbHostParam->_maxUserNumPerConn;
	}

	void CDatabaseConnWrap::setDbHostParam(CDbHostParam* dbParam)
	{
		_dbHostParam = dbParam;
	}

	void CDatabaseConnWrap::_clearSelf()
	{
		_isConnected = false;
		_connMgr = NULL;
		_dbHostID = 0;
		_tagID = 0;
		_dbHostParam = NULL;
	}

}