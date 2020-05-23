#include "db_task.h"
#include "database_conn_wrap.h"
#include "database_conn.h"

namespace GXMISC
{
	CDbConnTask::CDbConnTask() : CThreadToLoopTask(){
		_dbIndex = INVALID_DB_INDEX;
	}
	CDbConnTask::~CDbConnTask(){}

	void CDbConnTask::setDbUserIndex(TUniqueIndex_t index)
	{
		_dbIndex = index;
	}
	TUniqueIndex_t CDbConnTask::getDbUserIndex()
	{
		return _dbIndex;
	}

	CDatabaseConnWrap* CDbConnTask::getDbConnWrap()const
	{
		return dynamic_cast<CDatabaseConnWrap*>(getLoopThreadWrap());
	}

	CDbWrapTask::CDbWrapTask() : CLoopToThreadTask(){
		_dbIndex = INVALID_DB_INDEX;
	}
	CDbWrapTask::~CDbWrapTask(){}

	CDatabaseConn* CDbWrapTask::getDbConn() const
	{
		return dynamic_cast<CDatabaseConn*>(getLoopThread());
	}

	void CDbWrapTask::setDbUserIndex(TUniqueIndex_t index)
	{
		_dbIndex = index;
	}
	TUniqueIndex_t CDbWrapTask::getDbUserIndex()
	{
		return _dbIndex;
	}

    void CDbWrapTask::doRun()
    {
		doWork(getDbConn()->getConn());
    }

    void CDbWrapTask::doWork( mysqlpp::Connection * conn )
    {

    }

    void CDbWrapTask::pushTask( CDbConnTask* dbTask )
    {
		getDbConn()->pushTask(dbTask, dbTask->getDbUserIndex());
    }

    void CDbTaskConnected::doRun()
    {
		getDbConnWrap()->onConnected();
    }

    void CDbTaskClose::doRun()
    {
		getDbConnWrap()->onClose();
    }
}