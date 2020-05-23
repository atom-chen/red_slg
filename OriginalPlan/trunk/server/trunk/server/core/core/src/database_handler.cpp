#include "database_handler.h"
#include "db_task.h"
#include "database_conn_wrap.h"

namespace GXMISC
{
    bool CDatabaseHandler::isValid()
    {
        return !isInvalid() && _dbWrap != NULL;
    }

    void CDatabaseHandler::freeDatabaseTask( CDbWrapTask* task )
    {
        _dbWrap->freeTask(task);
    }

    CDatabaseConnWrap* CDatabaseHandler::getDbWrap()
    {
        return _dbWrap;
    }

    void CDatabaseHandler::pushTask( CDbWrapTask* task )
    {
		task->setDbUserIndex(getUniqueIndex());
        _dbWrap->pushTask(task);
    }

    void CDatabaseHandler::kick()
    {
        setInvalid();
    }

    CDatabaseHandler::CDatabaseHandler( CDatabaseConnWrap* dbWrap, TUniqueIndex_t index)
		: IHandler(dbWrap->getTaskQueueWrap()->getOutputQ(), index), _dbWrap(dbWrap)
    {

    }

	uint8 CDatabaseHandler::getTag()
	{
		return _dbWrap->getTag();
	}
}