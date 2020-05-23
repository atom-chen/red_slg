#ifndef _TASK_H_
#define _TASK_H_

#include "base_util.h"
#include "msg_queue.h"
#include "obj_mem_pool.h"
#include "interface.h"
#include "debug_control.h"
#include "service_profile.h"

namespace GXMISC
{
	class CSyncActiveQueueWrap;
	class CModuleThreadLoopWrap;
	class CModuleThreadLoop;
	
	typedef uint32 TTaskType_t;	// 任务类型
	static const TTaskType_t INVALID_TASK_TYPE = std::numeric_limits<TTaskType_t>::max();	// 无效的任务类型

	enum ETaskType
	{
		NET_TASK_SEND_MSG = 1,			// 发送消息
		NET_TASK_BROAD_CAST_MSG = 3,	// 广播消息
	};

	// 任务参数结构
	typedef struct _TaskArg
	{
		char* arg;	// 数据级冲区
		uint32 len;	// 缓冲区长度
	}TTaskArg;

	// 任务
	class CTask : public ISyncable
	{
		friend class CSyncActiveQueueWrap;
	protected:
		CTask();
	public:
		virtual ~CTask();

	public:
		// 清理
		void cleanUp();

	public:
		// 基类实现执行功能, 执行任务
		virtual void doRun() = 0;

	public:
		// 执行任务
		virtual void run();
		// @notice 在派生类中必须调用此函数
		virtual void doAfterUsed();

	public:
		// 得到任务名字
		virtual const std::string getName() const;
		// 设置任务唯一ID
		void setObjUID(TUniqueIndex_t uid);
		// 获取任务唯一ID
		TUniqueIndex_t getObjUID() const;
		// 获取开始时间
		TGameTime_t getStartTime();
		// 设置内存分配器
		void setAllocable(const IAllocatable* allocator);
		// 设置任务优先级
		void setPriority(uint8 prority);
		// 获取任务优先级
		uint8 getPriority();
		// 设置任务队列封装对象
		void setTaskQueueWrap(CSyncActiveQueueWrap* wrap);
		// @todo 添加任务类型, 用于性能统计
		virtual TTaskType_t type() const;
		// 获取循环封装对象
		CModuleThreadLoopWrap* getLoopThreadWrap()const;
		// 获取循环对象
		CModuleThreadLoop* getLoopThread()const;
		// 设置循环封装对象
		void setLoopThreadWrap(CModuleThreadLoopWrap* loopThreadWrap);
		// 设置循环对象
		void setLoopThread(CModuleThreadLoop* loopThread);

	public:
		// 添加参数
		void addArg(char* arg, uint32 argLen);
		// 得到参数
		template<typename T>
		T* getArg(uint32 index) const
		{
			//			gxAssert(sizeof(T) <= _args[index].len);
			return (T*)(_args[index].arg);
		}
		// 得到参数长度
		uint32 getArgLen(uint32 index) const;
		// 得到参数总体长度
		uint32 getTotalArgLen() const;
		// 得到参数数目
		uint32 getArgNum();

	public:
		// 分配参数
		template<typename ArgType>
		ArgType* allocArg()
		{
			return (ArgType*)allocArg(sizeof(ArgType));
		}
		// 分配参数
		char* allocArg(uint32 size);
		// 释放内存
		void freeArg();

	public:
		// 压入队列中
		void pushToQueue();

	private:
		IAllocatable*			_allocator;         // 用于分配动态参数
		bool					_isAllocArg;        // 参数是否为内部分配的

	protected:
		TUniqueIndex_t			_uid;               // 唯一标识
		std::vector<TTaskArg>	_args;				// 分配的参数
		TGameTime_t				_startTime;			// 开始时间
		uint8					_prority;			// 优先级
	
	private:
		CModuleThreadLoopWrap*	_loopThreadWrap;	// 循环封装对象
		CModuleThreadLoop*		_loopThread;		// 循环对象
		CSyncActiveQueueWrap*	_taskQueueWrap;		// 生成此任务的队列包装对象
	};

	/**
	* @brief 活动同步队列 
	*        1. 可动态分配内存
	*        2. 会定时检测
	*/
	class CSyncActiveQueue : public IAllocatable
	{
		friend class CSyncActiveQueueWrap;
	protected:
		typedef CMsgQueue<CTask*> SyncQueue;
		typedef std::list<CTask*> ObjList;

	public:
		CSyncActiveQueue(const std::string& name);
		CSyncActiveQueue();
		virtual ~CSyncActiveQueue(){}
	private:
		// 清零自身
		void _clearSelf();

		// 分配task
	protected:
		// 分配Task
		template<typename ObjType>
		ObjType* allocObj()
		{
			ObjType* pObject = allocArg<ObjType>();
			return new (pObject) ObjType();
		}
		// 释放Task
		void freeObj(CTask* obj);

	public:
		// 设置队列名
		void setQueueName(const std::string& queueName);

	public:
		// 设置写入线程ID
		void setWriteThreadID(TThreadID_t tid = gxGetThreadID());
		// 设置读取线程ID
		void setReadThreadID(TThreadID_t tid = gxGetThreadID());

	public:
		/** 
		* @brief 检测所有已经分配的消息是否可以释放, 如果可以释放则释放
		*        由分配这个消息的线程来调用
		*/
		void		updateWrite(uint32 diff, bool isAll = false);
		// 写入消息
		void		writeMsg(CTask*& t);
		// 写入消息
		void        writeMsg(ObjList* lst);
		// 刷新写入消息队列 @todo 参数意义
		void        flushWriteMsg(bool flag = false);
		// 计算写入消息数目
		sint32      calcWriteMsgNum();
		// 获取大小
		sint32		getTaskNum();

	public:
		// 更新读消息
		void        updateRead(uint32 diff);
		// 读出消息
		void 	    readMsg(ObjList* lst);
		// 读出消息
		void        readMsg(CTask*& t); 
		// 刷新读消息队列
		void        flushReadMsg(bool flag = false);
		// 计算读取消息数目
		sint32      calcReadMsgNum();
		// 清理读取的消息队列
		void		cleanReadMsg();

	public:
		// 更新统计数据
		void updateProfileData();
		// 设置统计标记
		void setProfileFlag(bool flag);
		// 执行统计
		void doProfile();
		// 清理
		void cleanUp();

	protected:
		SyncQueue           _syncQueue;                 // 同步队列
		TThreadID_t         _writeThreadID;             // 写入线程ID
		TThreadID_t			_readThreadID;				// 读取线程ID
		ObjList             _readMsgList;               // 需要读取的消息列表
		ObjList             _writeMsgList;              // 需要写入的消息列表
		ObjList	            _usedMsgList;				// 已经使用过的消息列表
		std::string			_queName;					// 队列名

		CFastLock::Lock_t	_syncQueMsgNum;				// 同步队列中消息个数
		CFastLock::Lock_t	_readMsgNum;				// 已经读取的消息个数
		CFastLock::Lock_t	_writeMsgNum;				// 写入的消息个数
		CFastLock::Lock_t	_usedMsgNum;				// 使用的消息个数
		TTime_t				_lastProfileTime;			// 上次统计时间
		bool				_profileFlag;				// 统计标记
	};

	// 任务队列封装
	class CSyncActiveQueueWrap
	{
	public:
		typedef std::list<CTask*> TaskObjList;
		typedef CSyncActiveQueue TSyncQ;

	public:
		CSyncActiveQueueWrap();
		virtual ~CSyncActiveQueueWrap();
	private:
		// 清零自身
		void _clearSelf();

	public:
		// 更新
		void update(uint32 diff);

	public:
		// 清理
		void flushQueue();
	private:
		// 清理写入队列
		void cleanWriteQue();
		// 清理读取队列
		void cleanReadQue();

	public:
		// 执行统计
		void doProfile();

	public:
		// 写入任务列表
		void push(TaskObjList* lst);
		// 写入单个任务
		void push(CTask* t);
		// 读取任务列表
		void get(TaskObjList* lst);
		// 得到单个任务
		void get(CTask*& t);

	public:
		// 设置任务ID
		void setThreadID(TThreadID_t tid = gxGetThreadID());
		// 生成任务唯一ID
		TUniqueIndex_t genUID();
		// 得到输入队列的任务数目
		sint32 getInputTaskNum() const;
		// 得到输出队列任务数目
		sint32 getOutputTaskNum() const;

	public:
		// 设置线程交互队列
		void setCommunicationQ(CSyncActiveQueue* inputQ, CSyncActiveQueue* outputQ);
		// 得到输入队列
		const CSyncActiveQueue* getInputQ()const;
		// 得到输出队列
		const CSyncActiveQueue* getOutputQ()const;
		// 设置循环对象
		void setLoopThread(CModuleThreadLoop* loopThread);
		// 获取循环对象
		CModuleThreadLoop* getLoopThread()const;
		// 设置循环封装对象
		void setLoopThreadWrap(CModuleThreadLoopWrap* loopThreadWrap);
		// 获取循环封装对象
		CModuleThreadLoopWrap* getLoopThreadWrap()const;

	public:
		// 处理任务
		void handleTask(TDiffTime_t diff);

	public:
		// 分配任务对象
		template<typename ObjType>
		ObjType* allocObj()
		{
			ObjType* temp = _outputQ->allocObj<ObjType>();
			temp->setAllocable(this->getOutputQ());
			temp->setTaskQueueWrap(this);
			temp->setLoopThreadWrap(_loopThreadWrap);
			temp->setLoopThread(_loopThread);
			temp->setObjUID(genUID());

			return temp;
		}

		// 释放任务
		void freeObj(CTask* task);

	private:
		CSyncActiveQueue* _inputQ;		// 输入任务队列
		CSyncActiveQueue* _outputQ;		// 输出任务队列
		TUniqueIndex_t _uid;			// 当前生成的任务UID
		TThreadID_t _threadID;			// 线程ID
		CModuleThreadLoopWrap* _loopThreadWrap;	// 循环封装对象
		CModuleThreadLoop* _loopThread;	// 循环对象
	};
}

#endif