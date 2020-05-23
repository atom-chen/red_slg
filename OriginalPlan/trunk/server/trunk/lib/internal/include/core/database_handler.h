#ifndef _DATABASE_HANDLER_H_
#define _DATABASE_HANDLER_H_

#include "handler.h"
#include "base_util.h"
#include "database_util.h"
#include "database_conn_wrap.h"

namespace GXMISC
{
    class CDatabaseHandler : public IHandler
    {
	protected:
         CDatabaseHandler(CDatabaseConnWrap* dbWrap, TUniqueIndex_t index);
	public:
        virtual ~CDatabaseHandler(){_dbWrap = NULL;}

    public:
		template<typename T>
		T* newDatabaseTask()
		{
			T* pTask =  _dbWrap->newTask<T>();
			pTask->setDbUserIndex(getUniqueIndex());
			return pTask;
		}
		void freeDatabaseTask(CDbWrapTask* task);
        void pushTask(CDbWrapTask* task);

    public:
        //  «∑Ò”––ß
        virtual bool isValid();
		uint8 getTag();
		CDatabaseConnWrap* getDbWrap();

    public:
        void kick();
        
    public:
        virtual EHandleRet handle(char* msg, uint32 len){ return HANDLE_RET_FAILED;};

    private:
        CDatabaseConnWrap*  _dbWrap;
    };
}

#endif