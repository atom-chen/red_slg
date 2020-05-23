#ifndef THREAD_H
#define THREAD_H

#include "types_def.h"
#include "base_util.h"
#include "interface.h"
#include "debug.h"
#include "bit_set.h"

namespace GXMISC
{
	/**
	* 线程回调接口
	* 当线程被创建, 它会调用附加的对象的run()接口
	*\code

	#include "thread.h"

	class HelloLoopThread : public IRunnable
	{
	void run ()
	{
	for(;;)	printf("Hello World\n");
	}
	};

	IThread *thread = IThread::create (new HelloLoopThread);
	thread->start ();

	*\endcode
	*/

	// @TODO 采用线程本地存储线程ID, 重写是否主程线接口, 主要用于提高日志写入速度
	/**
	* @brief 线程基础接口
	*        它必须被各个操作系统实现
	*/
	class IThread
	{
	public:
		/**
		* @brief 创建新的线程
		*        需要继承类实现
		*/
		static IThread *create(IRunnable *runnable, uint32 stackSize = 0);

		/**
		* @brief 返回当前线程的指针
		*		  需要继承类实现, 在linux没有实现
		*/
		static IThread *getCurrentThread ();

		virtual ~IThread () { }

		// 线程运行
		virtual bool start()=0;

		// 判断线程是否仍然运行
		virtual bool isRunning() =0;

		// 结束运行的线程(仅在极端的情况下使用)
		virtual void terminate()=0;

		// 在调用程序内部, 会等待直到指定的线程退出. 在wait()返回之后, 你可以删除线程对象
		virtual void wait()=0;

		// 返回附加的运行对象
		virtual IRunnable *getRunnable()=0;

		/**
		* @brief 设置线程绑定掩码. 线程必须已经启动
		* 这个mask必须是通过IProcess::getCPUMask()返回的掩码子集合
		*/
		virtual bool setCPUMask(TBit64_t cpuMask)=0;

		/**
		* @brief 获取线程绑定掩码. 线程必须已经启动
		* 这个mask必须是通过IProcess::getCPUMask()返回的掩码子集合
		*/
		virtual TBit64_t getCPUMask()=0;

		/**
		* @brief 返回线程使用者的用户名
		* 在linux下返回线程拥有者, 在windows下返回登陆用户
		*/
		virtual std::string getUserName()=0;
		
		/**
		 * @brief 设置当前线程在哪个CPU上运行
		 */
        virtual void setRunCPU(sint32 index, bool clearFlag = false)
        {
            if(index <= 0)
            {
                return;
            }
			
			TBit64_t mask = (uint64)std::pow((double)2, index);
			if(!clearFlag)
			{
				TBit64_t oldMask = getCPUMask();
				mask |= oldMask;
			}

            setCPUMask(mask);
        }
		
		/**
		 * @brief 清除线程的CPU掩码
		 */
		void clearCPUMask(sint32 index)
		{
			setRunCPU(index, true);
		}
	};

	/**
	* @brief 进程接口类
	*        必须被各个操作系统实现
	*/
	class IProcess
	{
	public:
		virtual ~IProcess() {}

		/**
		* @brief 返回当前进程对象
		*        必须被继承类实现
		*/
		static IProcess *GetCurrentProcess ();
	
		/**
		 * @brief 获取当前CPU个数
		 */
		static uint32 GetCPUNum();

    public:

		// 返回进程cpu掩码. 每位代表一个能驱动线程的cpu
		virtual TBit64_t getCPUMask()=0;

		// 设置进程cpu掩码. 每位代表一个能驱动线程的cpu
		virtual bool setCPUMask(TBit64_t mask)=0;
	};

} // GXMISC


#endif // THREAD_H