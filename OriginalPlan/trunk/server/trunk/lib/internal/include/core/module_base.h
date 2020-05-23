#ifndef _MODULE_BASE_H_
#define _MODULE_BASE_H_

#include "module_manager.h"
#include "task.h"

namespace GXMISC
{
	class GxService;
	class IThread;
	class CModuleBase;
	class CModuleThreadLoopWrap;

	// 模块线程运行对象
	class CModuleThreadLoop : public IRunnable
	{
	protected:
		CModuleThreadLoop();
	public:
		virtual ~CModuleThreadLoop();
	
	public:
		// 初始化(分配线程等)
		virtual bool init();
		// 启动运行(启动线程)
		virtual bool start();
		// 清理(释放线程)
		virtual void cleanUp();
		
	public:
		// 设置线程交互队列
		void setCommunicationQ(CSyncActiveQueue* inputQ, CSyncActiveQueue* outputQ);
		// 设置模块配置
		void setModuleConfig(IModuleConfig* config);
		// 设置循环封装对象
		void setLoopWrap(CModuleThreadLoopWrap* loopWrap);
		// 设置是否需要释放
		void setFreeFlag(bool flag);
		// 获取是否需要释放
		bool needFree();
		// 获取任务队列
		const CSyncActiveQueueWrap* getTaskQueueWrap() const;
		// 获取线程包装对象
		CModuleThreadLoopWrap* getThreadLoopWrap() const;
	public:
		// 运行函数
		virtual void run();
	protected:
		// 在run之前初始化
		virtual void initBeforeRun(){}
		// 具体的运行函数
		virtual bool onBreath(){ return true;  };
		// 处理任务事件
		virtual void onHandleTask(CTask* task);

	public:
		// 分配任务
		template<typename T>
        T* newTask()
        {
            return _queueWrap.allocObj<T>();
        }
		// 释放任务
		void	freeTask(CTask* arg);
	protected:
		// 处理输入任务
		void handleInputTask();
		// 处理输出任务
		void handleOutputTask();

	private:
		// 清零自身
		void _clearSelf();

	protected:
		IThread* _thread;  // 线程
		CModuleThreadLoopWrap* _loopWrap;   // 循环封装对象
		IModuleConfig*			_moduleConfig;	// 模块配置
		CSyncActiveQueueWrap _queueWrap;	// 队列封装对象
		bool _needFree; // 是否需要释放

	protected:
		TTime_t					_startTime;					// 开启时间
		TTime_t					_curTime;					// 当前时间
		uint32					_runSeconds;				// 运行时间(秒)
		uint64					_totalLoopCount;			// 循环计数
		uint32					_maxLoopCount;				// 一秒之内最大的循环数
		uint32					_curLoopCount;				// 当前秒内的循环数
		TTime_t                 _lastLoopProfileTime;       // 上次统计时间
	};

	// 模块主线程对线程运行对象的封装
	class CModuleThreadLoopWrap
	{
	protected:
		CModuleThreadLoopWrap(CModuleBase* pModule);
	public:
		virtual ~CModuleThreadLoopWrap();

	public:
		// 初始化数据(创建线程对象等)
		virtual bool init();
		// 启动(线程对象等)
		virtual bool start();
		// 停止(线程对象等)
		virtual void stop();
		// 清理
		virtual void cleanUp();
		// 每帧循环
		virtual void breath(GXMISC::TDiffTime_t diff);
	private:
		// 清空自身
		void _clearSelf();
		
	protected:
		// 帧循环事件
		virtual void onBreath(GXMISC::TDiffTime_t diff){};
		// 停止事件
		virtual void onStop(){};
		// 处理任务事件
		virtual void onHandleTask(CTask* task);

	public:
		// 分配任务
		template<typename T>
		T* newTask()
		{
			return _queueWrap.allocObj<T>();
		}
		// 释放任务
		void	freeTask(CTask* arg);
	protected:
		// 处理输入任务
		void handleInputTask(TDiffTime_t diff);
		// 处理输出任务
		void handleOutputTask(TDiffTime_t diff);

	public:
		// 是否正在运行
		bool isRunning();
		// 是否已经退出运行
		bool isExitRun();
	protected:
		// 创建线程对象
		virtual CModuleThreadLoop* createThreadLoop() = 0;
		// 有对象产生事件
		virtual void onCreateThreadLoop(CModuleThreadLoop* threadLoop);

	public:
		// 设置标记ID
		void setTagId(uint8 tagId);
		// 获取标记ID
		uint8 getTagId();
		// 生成唯一标记
		TUniqueIndex_t genUniqueIndex();
		// Socket是否为当前循环对象生成
		bool isUserIndex(TUniqueIndex_t uid);
		// 获取线程对象
		CModuleThreadLoop* getModuleThreadLoop() const;
	public:
		// 设置主服务
		void setService(GxService* service);
		// 获取主服务
		GxService* getService() const;
		// 获取工作队列中的任务数
		sint32 getOutputQSize() const;

	public:
		// 得到用户数据
		virtual sint32 getUserNum() const;
		// 得到最大的用户数目
		virtual sint32 getMaxUserNum() const;
		// 是否已经达到最大的用户数
		virtual bool isMaxUserNum() const;

	public:
		// 获取任务队列
		const CSyncActiveQueueWrap* getTaskQueueWrap() const;
	protected:
		// 设置线程交互队列
		void setCommunicationQ(CSyncActiveQueue* inputQ, CSyncActiveQueue* outputQ);
		
	protected:
		CModuleThreadLoop* _threadLoop;		// 循环线程对象
		CModuleBase *_moduleBase;           // 模块对象
 		CSyncActiveQueue* _inputQ;			// 输入队列
 		CSyncActiveQueue* _outputQ;			// 输出队列
		GxService* _mainService;			// 主服务
		CSyncActiveQueueWrap _queueWrap;	// 队列封装对象
		uint8 _tagId;						// 标记ID
		uint32 _genId;						// 初始化的生成ID
		IModuleConfig* _moduleConfig;		// 模块配置
	};
	
	// 简单循环封装对象
	class CSimpleThreadLoopWrap : public CModuleThreadLoopWrap
	{
	protected:
		CSimpleThreadLoopWrap(CModuleBase* module);
	public:
		virtual ~CSimpleThreadLoopWrap();

	protected:
		virtual void onCreateThreadLoop(CModuleThreadLoop* threadLoop);
		
	protected:
		CSyncActiveQueue _inputQue;		// 输入队列
		CSyncActiveQueue _outputQue;	// 输出队列
	};

	// 模块基类
	class CModuleBase : public IModuleManager
	{
	protected:
		CModuleBase(IModuleConfig* config);
	public:
		virtual ~CModuleBase();

	private:
		// 清空自身
		void _clearSelf();

	public:
		// 初始化
		virtual bool init();
		// 启动
		virtual bool start();
		// 清理
		virtual void cleanUp();

	public:
		// 停止事件
		virtual void onStop();
	protected:
		// 循环事件
		virtual bool doLoop(TDiffTime_t diff);

	protected:
		// 帧循环事件
		virtual bool onBreath(TDiffTime_t diff){ return true; };

	public:
		// 得到最大线程数
		sint32 getMaxConnNum() const;
		// 获取循环线程数
		sint32 getLoopNum() const;
		// 设置主服务
		void setService(GxService* service);
		// 获取主服务
		GxService* getService() const;

	public:
		// 得到一个最小的循环对象
		CModuleThreadLoopWrap* getLeastLoop() const;
		// 所有的循环对象是否已经停止
		bool checkAllLoopStop();

	protected:
		// 创建循环包装对象
		virtual CModuleThreadLoopWrap* createLoopWrap() = 0;
		// 有对象产生事件
		// @param index 从0开始计数
		virtual void onCreateThreadLoopWrap(CModuleThreadLoopWrap* threadLoopWrap, sint32 index);
	protected:
		CModuleThreadLoopWrap** _loopThreadWraps;	// 所有的循环线程
		GxService* _mainService;					// 主服务
	};

	// 主逻辑线程发送到处理线程的任务
	class CLoopToThreadTask : public CTask
	{
	protected:
		CLoopToThreadTask();
	public:
		virtual ~CLoopToThreadTask();

	public:
		// 分配新的任务
		template<typename T>
		T* newTask()
		{
			return getLoopThread()->newTask<T>();
		}

	private:
		// 多线程原因, 禁止使用此函数
		virtual CModuleThreadLoopWrap* getLoopThreadWrap() const{ gxAssert(FALSE_COND);  return NULL; };
	};

	// 处理线程发送到主逻辑线程的任务
	class CThreadToLoopTask : public CTask
	{
	protected:
		CThreadToLoopTask();
	public:
		virtual ~CThreadToLoopTask();

	public:
		// 是否处理成功
		bool isSuccess();
		// 设置成功标记
		void setSuccess(TErrorCode_t flag = 0);
		// 获取成功标记
		TErrorCode_t getErrorCode();

	protected:
		TErrorCode_t errorCode;		///< 错误码

	private:
		// 多线程原因, 禁止使用此函数
		virtual CModuleThreadLoop* getLoopThread() const { gxAssert(false);  return NULL; };
	};
}

#endif // _MODULE_BASE_H_