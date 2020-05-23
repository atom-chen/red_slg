#ifndef _DB_TASK_H_
#define _DB_TASK_H_

#include "task.h"
#include "mysql++.h"
#include "base_util.h"
#include "database_util.h"
#include "module_base.h"

namespace GXMISC
{
    class CDbTask;
    class CDatabaseConn;
    class CDbTaskConnected;
    class CDbTaskClose;

    // 从DatabaseConn发送到DatabaseConnWrap的任务
	class CDbConnTask : public CThreadToLoopTask
    {
	protected:
		CDbConnTask();
	public:
		virtual ~CDbConnTask();

	public:
		void setDbUserIndex(TUniqueIndex_t index);
		TUniqueIndex_t getDbUserIndex();

	public:
		CDatabaseConnWrap* getDbConnWrap()const;

	private:
		TDbIndex_t _dbIndex;
    };
    
    // 从DatabaseConnWrap发送到DatabaseConn的任务
    class CDbWrapTask : public CLoopToThreadTask
    {
	protected:
		CDbWrapTask();
	public:
		virtual ~CDbWrapTask();

    public:
        virtual void doRun();

	protected:
        virtual void doWork(mysqlpp::Connection * conn) = 0;
	
	protected:
        void pushTask(CDbConnTask* dbTask);

	public:
		CDatabaseConn* getDbConn() const;

	public:
		void setDbUserIndex(TUniqueIndex_t index);
		TUniqueIndex_t getDbUserIndex();

	private:
		TDbIndex_t _dbIndex;
    };

    /**
     * @brief 数据库连接成功 
     */
    class CDbTaskConnected : public CDbConnTask
    {
    public:
        CDbTaskConnected() : CDbConnTask()
        {
            setName("CDbTaskConnected");
        }
        ~CDbTaskConnected(){}
    public:
        virtual void doRun();
    };

    /**
     * @brief 数据库连接关闭 
     */
    class CDbTaskClose : public CDbConnTask
    {
    public:
        CDbTaskClose() : CDbConnTask()
        {
            setName("CDbTaskClose");
        }
        ~CDbTaskClose(){}
    public:
        virtual void doRun();
    private:
        CDatabaseConnWrap* _connWrap;
    };
}

#endif