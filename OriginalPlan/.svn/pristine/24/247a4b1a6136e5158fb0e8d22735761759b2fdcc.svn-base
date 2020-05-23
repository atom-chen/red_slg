#include "database_conn_mgr.h"
#include "time_manager.h"
#include "database_handler.h"
#include "debug.h"
#include "database_conn_wrap.h"
#include "lib_config.h"

namespace GXMISC
{
	CDatabaseConnMgr::CDatabaseConnMgr(const std::string& moduleName) : CModuleBase(&_config), _config(moduleName)
    {
        _index = 0;
		_userList.clear();
    }

    CDatabaseConnMgr::~CDatabaseConnMgr()
    {
    }

    void CDatabaseConnMgr::pushTask( CDbWrapTask* task, TUniqueIndex_t index )
    {
		task->setDbUserIndex(index);
        gxAssert(_userList.find(index) != _userList.end());
        CDatabaseConnWrap* pConn = _userList[index]->getDbWrap();
        gxAssert(pConn);
        pConn->pushTask(task);
    }

    void CDatabaseConnMgr::removeUser( TUniqueIndex_t index )
    {

        CDatabaseHandler* handler = getUser(index);
        gxAssert(handler != NULL);
        if(handler)
        {
            handler->getDbWrap()->removeUser(index);
            handler->onDelete();
            handler->reset();
            DSafeDelete(handler);
            _userList.erase(index);
        }
    }

    CDatabaseHandler* CDatabaseConnMgr::getUser( TUniqueIndex_t index )
    {
        if(_userList.find(index) == _userList.end())
        {
            return NULL;
        }

        return _userList[index];
    }

    CDatabaseConnWrap* CDatabaseConnMgr::getLeastConn(TDatabaseHostID_t dbID)
    {
        sint32 nNum = MAX_SINT32_NUM;
        CDatabaseConnWrap* pConn = NULL; 
        for(sint32 i = 0; i < _config.getLoopThreadNum(); ++i)
        {
			if ((((CDatabaseConnWrap*)_loopThreadWraps[i])->getDbHostID() == dbID) && !_loopThreadWraps[i]->isMaxUserNum() && (_loopThreadWraps[i]->getUserNum() <= nNum))
			{
				pConn = (CDatabaseConnWrap*)_loopThreadWraps[i];
				nNum = _loopThreadWraps[i]->getUserNum();
            }
        }

        return pConn;
    }

    GXMISC::TUniqueIndex_t CDatabaseConnMgr::genUniqueIndex()
    {
        return _index++;
    }

	CModuleThreadLoopWrap* CDatabaseConnMgr::createLoopWrap()
	{
		return new CDatabaseConnWrap(this);
	}
	void CDatabaseConnMgr::onCreateThreadLoopWrap(CModuleThreadLoopWrap* threadLoopWrap, sint32 index)
	{
		CDatabaseConnWrap* pConnWrap = (CDatabaseConnWrap*)threadLoopWrap;
		CDbHostParam& param = _config._dbParmMap[index];
		pConnWrap->setDbHostID(param._dbID);
		pConnWrap->setDbUrlInfo(param._dbHost, param._dbName, param._dbUser, param._dbPass);
		pConnWrap->setStartParam(_config._reconnInterval);
		pConnWrap->setDbHostParam(&param);
	}

    CDatabaseConfig* CDatabaseConnMgr::getConfig()
    {
        return &_config;
    }

    void CDatabaseConnMgr::onDisconnected( std::vector<TUniqueIndex_t>& temp )
    {
		// @todo
//         for(uint32 i = 0; i < temp.size(); ++i)
//         {
//             removeUser(temp[i]);
//         }
    }

	// 连接数量
	uint32 CDatabaseConnMgr::size()
	{
		return (uint32)_userList.size();
	}

    bool CDatabaseConnMgr::onBreath( TDiffTime_t diff )
    {
        std::vector<TUniqueIndex_t> temp;
        for(TDbConnUsers::iterator iter = _userList.begin(); iter != _userList.end(); ++iter)
        {
            CDatabaseHandler* handler = iter->second;
            gxAssert(handler);
            if(handler)
            {
                if(handler->isValid())
                {
                    handler->breath(diff);
                }
                else
                {
                    temp.push_back(handler->getUniqueIndex());
                }
            }
        }

        for(uint32 i = 0; i < temp.size(); ++i)
        {
            removeUser(temp[i]);
        }

		return true;
    }

    CDatabaseConfig::CDatabaseConfig( const std::string& moduleName ) : IModuleConfig(moduleName)
    {
        _reconnInterval = 0;   
    }

    CDatabaseConfig::~CDatabaseConfig()
    {
    }

    void CDatabaseConfig::setCleanupParm( sint32 reconnInterval )
    {
        _reconnInterval = std::max(reconnInterval, _reconnInterval);
    }

	bool CDatabaseConfig::onLoadConfig(const CConfigMap* configs)
    {
		if (false == IModuleConfig::onLoadConfig(configs))
        {
            return false;
        }

		// 重连的时间间隔(秒)
		sint32 reconnInterval;
		if (false == configs->readTypeIfExist(_moduleName.c_str(), "ReconnTime", reconnInterval))
		{
			if (_reconnInterval == 0)
			{
				_reconnInterval = 3;
			}
		}
		else
		{
			_reconnInterval = reconnInterval;
		}

		// =================数据库配置模块=================
		sint32 count = 0;
		while(count < 30)
		{
			CDbHostParam parm;
			std::string section = gxToString("DatabaseHost%d", count);
			if (false == configs->readTypeIfExist(section.c_str(), "DbHostID", parm._dbID))
			{
				count++;
				continue;
			}

			if (false == configs->readTypeIfExist(section.c_str(), "DbHost", parm._dbHost))
			{
				gxError("Can't read DbHost! DatabaseID = {0}", parm._dbID);
				return false;
			}

			if (false == configs->readTypeIfExist(section.c_str(), "DbName", parm._dbName))
			{
				gxError("Can't read DbName! DatabaseID = {0}", parm._dbID);
				return false;
			}

			if (false == configs->readTypeIfExist(section.c_str(), "DbUser", parm._dbUser))
			{
				gxError("Can't read DbUser! DatabaseID = {0}", parm._dbID);
			}

			if (false == configs->readTypeIfExist(section.c_str(), "DbPass", parm._dbPass))
			{
				gxError("Can't read DbPass! DatabaseID = {0}", parm._dbID);
			}

			if (false == configs->readTypeIfExist(section.c_str(), "ConnNum", parm._connNum))
			{
				gxError("Can't read ConnNum! DatabaseID = {0}", parm._dbID);
				return false;
			}

			if (false == configs->readTypeIfExist(section.c_str(), "MaxUserNumPerConn", parm._maxUserNumPerConn))
			{
				gxError("Can't read MaxUserNumPerConn! DatabaseID = {0}", parm._dbID);
				return false;
			}

			for(sint32 i = 0; i < parm._connNum; ++i)
			{
				_dbParmMap.push_back(parm);
			}

			count++;
		}
		_loopThreadNum = (sint32)_dbParmMap.size();

        _loaded = true;

        return true;
    }
}