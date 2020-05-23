#ifndef _DATABASE_CONN_MGR_H_
#define _DATABASE_CONN_MGR_H_

#include <map>

#include "types_def.h"
#include "base_util.h"
#include "database_util.h"
#include "module_manager.h"
#include "database_conn_wrap.h"
#include "database_handler.h"

namespace GXMISC
{
    class CDbHostParam
    {
    public:
        CDbHostParam()
        {
            _dbID = INVALID_DATABASE_HOST_ID;
            _dbHost = "";
            _dbName = "";
            _dbUser = "";
            _dbPass = "";
            _connNum = 0;
            _maxUserNumPerConn = 0;
        }
        ~CDbHostParam(){}
    public:
        TDatabaseHostID_t   _dbID;                          // 数据库ID
        std::string         _dbTagName;                     // 数据库标记名(@todo, 用户添加的时候可以直接接添加到指定标记的数据库)
        std::string         _dbHost;						// IP
        std::string         _dbName;						// 数据库名
        std::string         _dbUser;						// 用户
        std::string         _dbPass;						// 密码
        sint32              _connNum;                       // 数据库连接数目
        sint32              _maxUserNumPerConn;             // 每个连接的最大用户数
    };

	typedef std::vector<CDbHostParam> TDatabaseParmMap;

	class CDatabaseConfig : public IModuleConfig
	{
		friend class CDatabaseConnMgr;

	public:
		CDatabaseConfig(const std::string& moduleName);
		~CDatabaseConfig();

	public:
		void setCleanupParm(sint32 reconnInterval);

    public:
		virtual bool onLoadConfig(const CConfigMap* configs) override;

    protected:
        TDatabaseParmMap            _dbParmMap;                     ///< 数据库连接参数
        sint32                      _reconnInterval;                ///< 重连的时间间隔
    };

    /**
    * @brief 数据库连接管理器 
    */
    class CDatabaseConnMgr : public CModuleBase
    {
		friend class CDatabaseConnWrap;
    public:
        CDatabaseConnMgr(const std::string& moduleName = "DatabaseConnManager");
        ~CDatabaseConnMgr();

    public:;
		// 配置
		CDatabaseConfig* getConfig();

    protected:
        virtual bool onBreath(TDiffTime_t diff);

    public:
        // 添加用户
		template<typename T>
		T* addUser(TDatabaseHostID_t dbID)
		{
			CDatabaseConnWrap* pConn = getLeastConn(dbID);
			gxAssert(pConn);
			if(pConn)
			{
				TUniqueIndex_t index = genUniqueIndex();
				T* handler = new T(pConn, index);
				gxAssert(handler != NULL);
				handler->setParam(pConn->getTaskQueueWrap()->getOutputQ(), index);
				if(NULL != handler)
				{
					if(!handler->start())
					{
						DSafeDelete(handler);
						return NULL;
					}
					_userList.insert(TDbConnUsers::value_type(index, handler));
					pConn->addUser(index, handler);

					return handler;
				}
			}

            return NULL;
        }

        // 删除用户
        void removeUser(TUniqueIndex_t index);
        CDatabaseHandler* getUser(TUniqueIndex_t index);

	public:
        // 发送任务
        void pushTask(CDbWrapTask* task, TUniqueIndex_t index);

	protected:
        // 某个数据库连接被断开
        void onDisconnected(std::vector<TUniqueIndex_t>& temp);

	public:
		// 连接数量
		uint32 size();

	protected:
		virtual CModuleThreadLoopWrap* createLoopWrap();
		virtual void onCreateThreadLoopWrap(CModuleThreadLoopWrap* threadLoopWrap, sint32 index);

    private:
        // 生成唯一ID
        TUniqueIndex_t      genUniqueIndex();
        // 获取人数最小的数据库链接
        CDatabaseConnWrap*  getLeastConn(TDatabaseHostID_t dbID);

    private:
        CDatabaseConfig             _config;				// 数据库配置
        TDbConnUsers                _userList;				// 用户列表
        TUniqueIndex_t              _index;					// 当前正在生成的唯一索引序列
    };
}

#endif