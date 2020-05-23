#ifndef _SERVICE_TASK_H_
#define _SERVICE_TASK_H_

#include "interface.h"

namespace GXMISC
{
	// @TODO 重新设计
	class CServiceTask : public IRunnable
	{
		friend class CServiceTaskQue;
	protected:
		CServiceTask();
	public:
		virtual ~CServiceTask();

	public:
		void setExcuteNumPerFrame(sint32 num=-1);
		bool isUnlimited();
		sint32 getExcuteNumPerFrame();
		virtual sint32 getType()=0;
		virtual void cleanUp() = 0;		// 在内部调用析构函数

	protected:
		sint32 executeNumPerFrame;
		bool allocaFromQue;
	};

	class CServiceTaskQue : protected IAllocatable
	{
	public:
		CServiceTaskQue();
		~CServiceTaskQue();

	public:
		bool pushTask(CServiceTask* task);
		template<typename T>
		bool pushTask(const T& task);
		template<typename T>
		T* allocateTask();
		void update(GXMISC::TDiffTime_t diff);
		void setExecuteNumPerFrame(sint32 num);

	private:
		typedef std::deque<CServiceTask*> TTaskQue;
		TTaskQue _taskQue;
		sint32 _excuteNumPerFrame;
		std::map<sint32, sint32> _taskCount;
		std::vector<CServiceTask*> _taskAry;
	};

	template<typename T>
	T* CServiceTaskQue::allocateTask()
	{
		CServiceTask* tempTask = (CServiceTask*)IAllocatable::allocArg(sizeof(T)+10);
		T* ttemp = new(tempTask) T();
		tempTask->allocaFromQue = true;
		return ttemp;
	}

	template<typename T>
	bool CServiceTaskQue::pushTask(const T& task)
	{
		T* tempTask = allocateTask<T>();
		if(NULL == tempTask)
		{
			return false;
		}
		*tempTask = task;
		tempTask->allocaFromQue = true;
		_taskQue.push_back(tempTask);
		return true;
	}
}

#endif // _SERVICE_TASK_H_