#include "database_conn.h"
#include "mysql++.h"
#include "db_task.h"

namespace GXMISC
{
	CDatabaseConn::CDatabaseConn() : TBaseType()
    {
		_clearSelf();
    }

	CDatabaseConn::~CDatabaseConn()
	{
		_clearSelf();
	}

	void CDatabaseConn::_clearSelf()
	{
		_dbHost = "";
		_dbName = "";
		_dbUser = "";
		_dbPass = "";

		_isConntected = false;
		_thread = NULL;
		_dbConn = NULL;
		_reconnInterval = 0;
		_stopMsgHandle = false;
		_pingTime = time(NULL);
	}

	void CDatabaseConn::setDbUrlInfo(const std::string& dbHost, const std::string& dbName, const std::string& dbUser, const std::string& dbPass)
	{
		_dbName = dbName;
		_dbHost = dbHost;
		_dbUser = dbUser;
		_dbPass = dbPass;
	}

	void CDatabaseConn::setStartParam(uint32 reconnInterval)
	{
		_reconnInterval = reconnInterval;
	}

	void CDatabaseConn::onBeforeConn()
	{
		if (!isEmptyConn())
		{
			mysqlpp::Option* pOption = new mysqlpp::ReconnectOption(true);
			_dbConn->set_option(pOption);
			pOption = new mysqlpp::CompressOption();
			_dbConn->set_option(pOption);
			pOption = new mysqlpp::MultiStatementsOption(true);
			_dbConn->set_option(pOption);
		}
	}

	void CDatabaseConn::onAfterConn()
	{
		if (!isEmptyConn())
		{
			mysqlpp::Query query = _dbConn->query("SET CHARACTER_SET_CONNECTION=utf8,character_set_results=utf8,character_set_client=BINARY,SQL_MODE='';");
 			query.execute();
 			query.clear();
			query = _dbConn->query("set interactive_timeout=8640000");
			query.execute();
			query.clear();
			query = _dbConn->query("set global max_allowed_packet=50*1024*1024");
			query.execute();
			query.clear();
			query = _dbConn->query("set global wait_timeout=8640000");
			query.execute();
			query.clear();
		}
	}

	bool CDatabaseConn::init()
	{
		if (!TBaseType::init())
		{
			return false;
		}

		if (!isEmptyConn())
		{
			_dbConn = new mysqlpp::Connection(false);
			gxAssert(_dbConn);
			if (NULL == _dbConn)
			{
				gxError("Can't new db connect!");
				return false;
			}
		}

		return true;
	}

    bool CDatabaseConn::start()
    {
		if (!isEmptyConn())
		{
			onBeforeConn();
			if (!_dbConn->connect(_dbName.c_str(), _dbHost.c_str(), _dbUser.c_str(), _dbPass.c_str()))
			{
				gxError("Can't connect db!ErrMsg={0},DbName={1},DbHost={2},DbUser={3},DbPass={4}",
					_dbConn->error(), _dbName, _dbHost, _dbUser, _dbPass);
				cleanUp();
				return false;
			}
			onAfterConn();
		}

		if (!TBaseType::start())
		{
			return false;
		}

		_isConntected = true;

        return true;
    }

	void CDatabaseConn::cleanUp()
	{
		TBaseType::cleanUp();

		DSafeDelete(_dbConn);
	}

	bool CDatabaseConn::onBreath()
	{
		if (!TBaseType::onBreath())
		{
			return false;
		}

		updatePing(0);
		updateDelUser(0);

		return true;
	}

	void CDatabaseConn::updatePing(TDiffTime_t diff)
	{
		if (!isEmptyConn())
		{
			if (CTimeManager::SysNowTime() - _pingTime > 3)
			{
				if (!ping())
				{
					// 数据库连接断开
					std::string errorStr;
					if (NULL != _dbConn->error())
					{
						errorStr = _dbConn->error();
					}
					gxError("Database disconnect!{0}", errorStr.c_str());

					_dbConn->disconnect();
					if (!reconnect())
					{
						// 无法重连表示连接被关闭
						onClose();
					}

					errorStr.clear();
					if (NULL != _dbConn->error())
					{
						errorStr = _dbConn->error();
					}
					gxError("Database after connect!{0}", errorStr.c_str());
				}

				_pingTime = CTimeManager::SysNowTime();
			}
		}
	}

	void CDatabaseConn::updateDelUser(TDiffTime_t diff)
	{
		TTime_t curTime = CTimeManager::SysNowTime();
		for (TDbDelUserMap::iterator iter = _delUserMap.begin(); iter != _delUserMap.end();)
		{
			if ((curTime - iter->second.startTime) > DB_DEL_USER_EXIST_TIME)
			{
				_delUserMap.erase(iter++);
				continue;
			}

			iter++;
		}
	}

    bool CDatabaseConn::isActive() const
    {
		if (isEmptyConn())
		{
			return true;
		}

        return _dbConn->connected();
    }

    bool CDatabaseConn::reconnect( uint32 num )
    {
		if (isEmptyConn())
		{
			gxAssert(false);
			return true;
		}

        for(uint32 i = 0; i < num; ++i)
        {
			onBeforeConn();
            if(_dbConn->connect(_dbName.c_str(), _dbHost.c_str(), _dbUser.c_str(), _dbPass.c_str()))
            {
				onAfterConn();
                onConntected();
                return true;
            }

            gxSleep(_reconnInterval);
        }

        return false;
    }

    void CDatabaseConn::pushTask( CDbConnTask* task, TUniqueIndex_t index )
    {
		task->setDbUserIndex(index);

        if(!isStopMsgHandle())
        {
			task->pushToQueue();
        }
        else
        {
			freeTask(task);
        }
    }

    void CDatabaseConn::onClose()
    {
        if(_isConntected)
        {
            _isConntected = false;
            CDbTaskClose* closeTask = newTask<CDbTaskClose>();
            gxAssert(closeTask);
            pushTask(closeTask, INVALID_UNIQUE_INDEX);

			gxError("Database disconnect, can't reconnect!");
        }
    }

    void CDatabaseConn::onConntected()
    {
        if(!_isConntected)
        {
            _isConntected = true;
            CDbTaskConnected* conntected = newTask<CDbTaskConnected>();
            gxAssert(conntected);
            pushTask(conntected, INVALID_UNIQUE_INDEX);
        }
    }

    mysqlpp::Connection* CDatabaseConn::getConn()
    {
        return _dbConn;
    }

    bool CDatabaseConn::ping()
    {
		if (!_dbConn)
		{
			return true;
		}

        return _dbConn->ping();
    }

    std::string CDatabaseConn::toString()
    {
        std::string str = gxToString("DbHost=%s,DbName=%s", _dbHost.c_str(), _dbName.c_str());
        return str;
    }

	void CDatabaseConn::onStop()
	{
		stopMsgHandle();

		if (_dbConn)
		{
			if (_dbConn->connected())
			{
				_dbConn->disconnect();
			}
		}
	}

    void CDatabaseConn::stopMsgHandle()
    {
        _stopMsgHandle = true;
    }

    bool CDatabaseConn::isStopMsgHandle()
    {
        return _stopMsgHandle;
    }

	void CDatabaseConn::pushDelUser( TUniqueIndex_t uid )
	{
		TDbDelUser delUserS;
		delUserS.uid = uid;
		delUserS.startTime = SystemCall::time(NULL);
		_delUserMap.insert(TDbDelUserMap::value_type(uid, delUserS));
	}

	bool CDatabaseConn::isDelUser( TUniqueIndex_t uid )
	{
		return _delUserMap.find(uid) != _delUserMap.end();
	}

	bool CDatabaseConn::isEmptyConn() const
	{
		return _dbUser.empty();
	}

}
