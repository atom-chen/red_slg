#ifndef _DATABASE_CONN_WRAP_H_
#define _DATABASE_CONN_WRAP_H_

#include <map>

#include "base_util.h"
#include "database_util.h"
#include "db_task.h"
#include "database_conn.h"

namespace GXMISC
{
	class CDbHostParam;
    class CDatabaseConnWrap : public CSimpleThreadLoopWrap
    {
		typedef CSimpleThreadLoopWrap TBaseType;
    public:
        CDatabaseConnWrap(CDatabaseConnMgr* databaseMgr);
        ~CDatabaseConnWrap();
	private:
		void _clearSelf();

    public:
		// 启动
		virtual bool start();

	public:
		// 压入任务
		void pushTask(CDbWrapTask* task);

	public:
		// 添加用户
		void addUser(TUniqueIndex_t index, CDatabaseHandler* handler);
		// 查找用户
		CDatabaseHandler* findUser(TUniqueIndex_t index);
		// 移除用户
		void removeUser(TUniqueIndex_t index);
	
	public:
		// 获取用户数目
		virtual sint32 getUserNum() const override;
		// 获取最大数据
		virtual sint32 getMaxUserNum() const override;
		// 是否已经达到最大用户数目
		virtual bool isMaxUserNum() const override;
		// 是否还存活
		bool isActive();
		// 是否已经停止
		bool isStop();
		// 设置DB唯一标识
		void setDbHostID(TDatabaseHostID_t id);
		// 获取DB唯一标识
        TDatabaseHostID_t getDbHostID() const;
		// 获取对象字符串名
        std::string toString();
		// 获取标记
		uint8 getTag();
		// 设置标记
		void setTag(uint8 tag);
		// 获取数据库管理对象
		CDatabaseConnMgr* getDbConnMgr();
		// 设置启动参数
		void setStartParam(uint32 reconnInterval);
		// 设置数据库连接URL
		void setDbUrlInfo(const std::string& dbHost, const std::string& dbName, const std::string& dbUser, const std::string& dbPass);
		// 获取数据库线程对象
		const CDatabaseConn* getDbConn() const;
		// 设置数据库参数信息
		void setDbHostParam(CDbHostParam* dbParam);

	protected:
		// 创建一个线程对象
		virtual CModuleThreadLoop* createThreadLoop();

    public:
        // 连接关闭, 清空数据队列
        void onClose();
        // 接到连接关闭后, 返回响应通知
        void onConnected();
        // @todo 数据库断开连接, 将所有玩家断开连接
        void handleClearAllUser();

    private:
		bool				_isConnected;       // 是否已经建立成功
        TDbConnUsers		_userList;          // 用户列表
        CDatabaseConnMgr*	_connMgr;			// 连接管理器
        TDatabaseHostID_t   _dbHostID;          // 数据库标识
		uint8				_tagID;				// 当前连接标记,相当于ID
		CDbHostParam*		_dbHostParam;		// 数据库参数信息
		CDatabaseConn       _dbConn;			// 线程对象
    };
}

#endif