#ifndef _DATABASE_CONN_H_
#define _DATABASE_CONN_H_

#include <string>

#include "msg_queue.h"
#include "mysql++.h"
#include "database_util.h"
#include "interface.h"
#include "db_task.h"
#include "thread.h"
#include "module_base.h"

class Connection;

namespace GXMISC
{
	class CDatabaseConfig;

	class CDatabaseConn : public CModuleThreadLoop
	{
		typedef CModuleThreadLoop TBaseType;

	public:
        CDatabaseConn();
		~CDatabaseConn();
	private:
		// 清零自身
		void _clearSelf();

	public:
		// 初始化
		virtual bool init();
		// 启动
        virtual bool start();
		// 清理数据
		virtual void cleanUp();

	protected:
		// 帧更新事件
		virtual bool onBreath();
		// 停止事件
		virtual void onStop();

	public:
		// 设置数据库连接信息
		void setDbUrlInfo(const std::string& dbHost, const std::string& dbName, const std::string& dbUser, const std::string& dbPass);
		// 设置启动参数
		void setStartParam(uint32 reconnInterval);

	public:
		// 停止消息处理
        void stopMsgHandle();
		// 是否已经停止消息处理
        bool isStopMsgHandle();
		// 数据库连接是否还存活
        bool isActive() const;
		// 获取数据库链接
		mysqlpp::Connection* getConn();
		// 获取字符串名
		std::string toString();
		// 是否空连接(用户名为空, 不连mysql, 只做空的任务处理)
		bool isEmptyConn() const;

	private:
		// 定时更新ping
		void updatePing(TDiffTime_t diff);
		// 更新删除对象
		void updateDelUser(TDiffTime_t diff);

    public:
		// 重连
        bool reconnect(uint32 num = 1);
		// 测试链接
        bool ping();

	public:
		// 压入任务
        void pushTask(CDbConnTask* task, TUniqueIndex_t index);

	public:
		// 压入删除用户
		void pushDelUser(TUniqueIndex_t uid);
		// 用户是否已经删除
		bool isDelUser(TUniqueIndex_t uid);

    public:
		// 链接关闭事件
        void onClose();
		// 链接成功事件
        void onConntected();

	private:
		// 连接前事件
		void onBeforeConn();
		// 连接后事件
		void onAfterConn();

    private:
        bool _isConntected;			// 是否已经连接成功
        uint32 _reconnInterval;		// 重连间隔
        bool _stopMsgHandle;		// 停止消息处理
        TTime_t _pingTime;			// 上次ping的时间
		TDbDelUserMap _delUserMap;	// 删除用户表

    private:
        std::string _dbName;		// 数据库名
        std::string _dbHost;		// 数据库地址
        std::string _dbUser;		// 数据库用户名
        std::string _dbPass;		// 数据库密码

        mysqlpp::Connection* _dbConn; // 数据库连接
    };
}

#endif