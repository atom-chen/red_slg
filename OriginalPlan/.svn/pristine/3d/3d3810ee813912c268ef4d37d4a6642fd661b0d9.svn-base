#include "task.h"
#include "module_base.h"

namespace GXMISC
{
#pragma region sync_able
    bool ISyncable::canFree()
    {
        return !CFastLock::isLocked(_lockVar);
    }

    void ISyncable::setFreed()
    {
		DTaskLog("task freed : {0}", getName().c_str());
        CFastLock::unlock(_lockVar);
    }

    void ISyncable::setUsed()
    {
        DTaskLog("task used : {0}", getName().c_str());
        gxAssert(!CFastLock::isLocked(_lockVar));
        bool ret = CFastLock::tryLock(_lockVar);
        gxAssert(ret);
        if(!ret)
        {
            gxError("Can't lock!");
        }
    }

    void IAllocatable::freeArg(char* arg)
    {
        _blockAllocator.free(arg);
    }

    char* IAllocatable::allocArg(uint32 size)
    {
        return _blockAllocator.alloc(size);
    }
#pragma endregion sync_able

#pragma region task
	CTask::CTask() : ISyncable()
	{
		cleanUp();
	}

	CTask::~CTask()
	{
		gxAssert(_isAllocArg == false);
		gxAssert(_allocator);

		freeArg();

		_allocator = NULL;
		_isAllocArg = false;
	}

	void CTask::cleanUp()
	{
		ISyncable::cleanUp();

		_isAllocArg = false;
		_allocator = NULL;
		_uid = 0;
		_prority = 0;
		_startTime = 0;
		setThreadID(gxGetThreadID());
		_taskQueueWrap = NULL;
		_loopThreadWrap = NULL;
		_loopThread = NULL;
	}

	void CTask::run()
	{
		gxAssert(!canFree());
		DTaskLog("run task: {0}", getName().c_str());
		doRun();
	}

	const std::string CTask::getName() const
	{
		return IRunnable::getName() + ":UID=" + gxToString(getObjUID()) + ":TID=" + gxToString(getThreadID()) ;
	}

	void CTask::setObjUID(TUniqueIndex_t uid)
	{
		_uid = uid;
		_startTime = (decltype(_startTime))SystemCall::time(NULL);
	}
	TUniqueIndex_t CTask::getObjUID() const
	{
		return _uid;
	}

	TGameTime_t CTask::getStartTime()
	{
		return _startTime;
	}

	void CTask::setAllocable(const IAllocatable* allocator)
	{
		_allocator = const_cast<IAllocatable*>(allocator);
	}

	void CTask::setPriority(uint8 prority)
	{
		_prority = prority;
	}
	uint8 CTask::getPriority()
	{
		return _prority;
	}

	// @todo 添加任务类型, 用于性能统计
	TTaskType_t CTask::type() const
	{
		return INVALID_TASK_TYPE;
	}

	// @notice 在派生类中必须调用此函数
	void CTask::doAfterUsed()
	{
		freeArg();
	}

	void CTask::addArg(char* arg, uint32 argLen)
	{
		char* tempArg = allocArg(argLen);
		memcpy(tempArg, arg, argLen);
	}

	uint32 CTask::getArgLen(uint32 index) const
	{
		return _args[index].len;
	}

	uint32 CTask::getTotalArgLen() const
	{
		uint32 totalArgsLen = 0;
		for(uint32 i = 0; i < _args.size(); ++i)
		{
			totalArgsLen += _args[i].len;
		}

		return totalArgsLen;
	}

	uint32 CTask::getArgNum()
	{
		return (uint32)_args.size();
	}

	// 分配参数
	char* CTask::allocArg(uint32 size)
	{
		char* arg = NULL;
		gxAssert(_allocator);
		_isAllocArg = true;
		arg = (char*)_allocator->allocArg(size);
		TTaskArg taskArg;
		taskArg.arg = arg;
		taskArg.len = size;
		_args.push_back(taskArg);
		return (char*)arg;
	}

	// 释放内存
	void CTask::freeArg()
	{
		gxAssert(_allocator);
		if(!_isAllocArg || !_allocator)
		{
			return;
		}

		for(uint32 i = 0; i < _args.size(); ++i)
		{
			_allocator->freeArg(_args[i].arg);
		}

		_isAllocArg = false;
		_args.clear();
	}

	// 压入队列中
	void CTask::pushToQueue()
	{
		_taskQueueWrap->push(this);
	}

	void CTask::setTaskQueueWrap( CSyncActiveQueueWrap* wrap )
	{
		_taskQueueWrap = wrap;
	}

	CModuleThreadLoopWrap* CTask::getLoopThreadWrap()const
	{
		return _loopThreadWrap;
	}

	void CTask::setLoopThreadWrap(CModuleThreadLoopWrap* loopThreadWrap)
	{
		_loopThreadWrap = loopThreadWrap;
	}

	CModuleThreadLoop* CTask::getLoopThread() const
	{
		return _loopThread;
	}

	void CTask::setLoopThread(CModuleThreadLoop* loopThread)
	{
		_loopThread = loopThread;
	}

	CLoopToThreadTask::CLoopToThreadTask()
	{

	}

	CLoopToThreadTask::~CLoopToThreadTask()
	{
	}

	CThreadToLoopTask::CThreadToLoopTask()
	{
		errorCode = 1;
	}

	CThreadToLoopTask::~CThreadToLoopTask()
	{
	}

	bool CThreadToLoopTask::isSuccess()
	{
		return errorCode == 0;
	}

	void CThreadToLoopTask::setSuccess(TErrorCode_t flag)
	{
		errorCode = flag;
	}

	TErrorCode_t CThreadToLoopTask::getErrorCode()
	{
		return errorCode;
	}

#pragma endregion task

#pragma region active_queue
	CSyncActiveQueue::CSyncActiveQueue(const std::string& name) : IAllocatable()
	{
		_clearSelf();
		_queName = name;
	}

	CSyncActiveQueue::CSyncActiveQueue()
	{
		_clearSelf();
	}

	void CSyncActiveQueue::_clearSelf()
	{
		_writeThreadID = INVALID_THREAD_ID;
		_readThreadID = INVALID_THREAD_ID;
		_syncQueMsgNum = 0;
		_readMsgNum = 0;
		_writeMsgNum = 0;
		_usedMsgNum = 0;
		_profileFlag = false;
		_lastProfileTime = 0;
		_queName = "";
	}

	void CSyncActiveQueue::freeObj(CTask* obj)
	{
		obj->~CTask();
		freeArg((char*)obj);
	}

	// 设置队列名
	void CSyncActiveQueue::setQueueName(const std::string& queueName)
	{
		_queName = queueName;
	}

	void CSyncActiveQueue::setWriteThreadID(TThreadID_t tid)
	{
		_writeThreadID = tid;
#ifdef LIB_DEBUG
		_blockAllocator.setThreadID(tid);
#endif
	}

	void CSyncActiveQueue::setReadThreadID(TThreadID_t tid)
	{
		_readThreadID = tid;
	}

	sint32 GXMISC::CSyncActiveQueue::getTaskNum()
	{
		return (sint32)_syncQueue.size();
	}

	void GXMISC::CSyncActiveQueue::updateProfileData()
	{
		if(_writeThreadID == gxGetThreadID())
		{
			sint32 syncQueMsgNum = 0;
			sint32 writeMsgNum = 0;
			sint32 usedMsgNum = 0;

			syncQueMsgNum = _syncQueue.size();
			writeMsgNum = (sint32)_writeMsgList.size();
			usedMsgNum = (sint32)_usedMsgList.size();

			CFastLock::Set(_syncQueMsgNum, syncQueMsgNum);
			CFastLock::Set(_writeMsgNum, writeMsgNum);
			CFastLock::Set(_usedMsgNum, usedMsgNum);
		}

		if(_readThreadID == gxGetThreadID())
		{
			sint32 readMsgNum = 0;
			readMsgNum = (sint32)_readMsgList.size();
			CFastLock::Set(_readMsgNum, readMsgNum);
		}
	}

	void GXMISC::CSyncActiveQueue::cleanUp()
	{
		gxAssert(_syncQueue.size() <= 0);
		gxAssert(_readMsgList.size() <= 0);
		gxAssert(_writeMsgList.size() <= 0);

		updateWrite(0, true);
	}

	void GXMISC::CSyncActiveQueue::doProfile()
	{
		if(_profileFlag)
		{
			return;
		}

		if(!gxIsMainThread())
		{
			return;
		}

		TTime_t curTime = time(NULL);
		if(curTime-_lastProfileTime > SERVICE_TASK_PROFILE_TIME)
		{
			uint32 memSize = _blockAllocator.getTotalAllocSize();
			DTaskProfileLog("QueueName={0}, WriteThreadID={1}, ReadThreadID={3}, UsedNum={4}, "
				"SyncQueMsgNum={5}, WriteMsgNum={6}, ReadMsgNum={7}, MemSize={8}",
				_queName.c_str(), gxToString(_writeThreadID).c_str(), gxToString(_readThreadID).c_str(), _usedMsgNum, _syncQueMsgNum, _writeMsgNum, _readMsgNum, memSize);

			_lastProfileTime=curTime;
		}
	}

	void GXMISC::CSyncActiveQueue::setProfileFlag(bool flag)
	{
		_profileFlag = flag;
	}

	sint32 GXMISC::CSyncActiveQueue::calcReadMsgNum()
	{
		gxAssert(_writeThreadID != gxGetThreadID());
		gxAssert(_readThreadID == gxGetThreadID());
		// @todo 计算消息个数方式, 根据上一次刷新时间, 当前队列个数及同步队列的个数计算
		// @todo 在空闲时间强制全部写入
		return 100*2048;
	}

	void GXMISC::CSyncActiveQueue::cleanReadMsg()
	{
		for(ObjList::iterator iter = _readMsgList.begin(); iter != _readMsgList.end(); ++iter)
		{
			CTask* task = *iter;
			gxAssert(NULL != task)
			{
				task->setFreed();
			}
		}

		_readMsgList.clear();
	}

	void GXMISC::CSyncActiveQueue::flushReadMsg(bool flag)
	{
		gxAssert(_writeThreadID != gxGetThreadID());
		gxAssert(_readThreadID == gxGetThreadID());
		if(flag)
		{
			_syncQueue.pop(_readMsgList, MAX_SINT32_NUM);
		}
		else
		{
			_syncQueue.pop(_readMsgList, calcReadMsgNum());
		}

		_syncQueMsgNum = _syncQueue.size();
		CFastLock::Set(_readMsgNum, (sint32)_readMsgList.size());
	}

	void GXMISC::CSyncActiveQueue::readMsg( CTask*& t )
	{
		gxAssert(_writeThreadID != gxGetThreadID());
		gxAssert(_readThreadID == gxGetThreadID());
		if(_readMsgList.empty())
		{
			flushReadMsg();
		}

		if(!_readMsgList.empty())
		{
			t = _readMsgList.front();
			_readMsgList.pop_front();
		}

		_readMsgNum = _readMsgList.size();
	}

	void GXMISC::CSyncActiveQueue::readMsg( ObjList* lst )
	{
		gxAssert(_writeThreadID != gxGetThreadID());
		gxAssert(_readThreadID == gxGetThreadID());

		flushReadMsg();

		if(!_readMsgList.empty())
		{
			lst->assign(_readMsgList.begin(), _readMsgList.end());
			_readMsgList.clear();
		}

		// @todo 这里对网络底层影响比较大, 性能测试的时候需要重点关注
		//         for(typename TaskObjList::iterator iter = lst.begin(); iter != lst.end(); ++iter)
		//         {
		//             T* tmp = *iter;
		//             tmp->doAfterFromQueue();
		//         }

		CFastLock::Set(_readMsgNum, (sint32)_readMsgList.size());
	}

	void GXMISC::CSyncActiveQueue::updateRead( uint32 diff )
	{
		gxAssert(_writeThreadID != gxGetThreadID());
		gxAssert(_readThreadID == gxGetThreadID());
		flushReadMsg();
	}

	sint32 GXMISC::CSyncActiveQueue::calcWriteMsgNum()
	{
		// gxAssert(_writeThreadID == gxGetThreadID());
		// gxAssert(_readThreadID != gxGetThreadID());
		// @todo 计算消息个数方式, 根据上一次刷新时间, 当前队列个数及同步队列的个数计算
		// @todo 在空闲时间强制全部写入
		return 100*2048;
	}

	void GXMISC::CSyncActiveQueue::flushWriteMsg( bool flag )
	{
		// 		gxAssert(_writeThreadID == gxGetThreadID());
		// 		gxAssert(_readThreadID != gxGetThreadID());
		sint32 num = flag ? MAX_SINT32_NUM : calcWriteMsgNum();
		sint32 count = 0;
		ObjList::iterator iter = _writeMsgList.begin();

		// @todo 这里对网络底层影响比较大, 性能测试的时候需要重点关注
		for(; iter != _writeMsgList.end() && count < num; ++iter, ++count)
		{
			CTask* tmp = *iter;
			// @todo 将这个提取出去
			tmp->setUsed();
			//tmp->doBeforeToQueueue();
		}

		_syncQueue.push(_writeMsgList, num);

		uint32 usedNum = (uint32)_usedMsgList.size();
		if(iter != _writeMsgList.begin())
		{
			_usedMsgList.insert(_usedMsgList.end(), _writeMsgList.begin(), iter);
			_writeMsgList.erase(_writeMsgList.begin(), iter);
		}
		gxAssert(_usedMsgList.size() == usedNum+count);

		_syncQueMsgNum = _syncQueue.size();
		CFastLock::Set(_writeMsgNum, (sint32)_writeMsgList.size());
		CFastLock::Set(_usedMsgNum, (sint32)_usedMsgList.size());
	}

	void GXMISC::CSyncActiveQueue::writeMsg( ObjList* lst )
	{
		gxAssert(_writeThreadID == gxGetThreadID());
		gxAssert(_readThreadID != gxGetThreadID());
		_writeMsgList.insert(_writeMsgList.end(), lst->begin(), lst->end());
		_writeMsgNum = _writeMsgList.size();
	}

	void GXMISC::CSyncActiveQueue::writeMsg( CTask*& t )
	{
		gxAssert(_writeThreadID == gxGetThreadID());
		gxAssert(_readThreadID != gxGetThreadID());

		if(t->getPriority() > 0)
		{
			// 插入优先级高的任务, 有优先级表示对顺序不敏感(@TODO 改成任意优先级的)
			t->setUsed();
			_syncQueue.pushFront(t);
			_usedMsgList.push_front(t);
		}
		else
		{
			_writeMsgList.push_back(t);
			CFastLock::Set(_writeMsgNum, (sint32)_writeMsgList.size());
		}
	}

	void GXMISC::CSyncActiveQueue::updateWrite( uint32 diff, bool isAll /*= false*/ )
	{
		// 		gxAssert(_writeThreadID == gxGetThreadID());
		// 		gxAssert(_readThreadID != gxGetThreadID());

		//         if(_usedMsgList.size() > 500)
		//         {
		//             gxDebug("UsedSize={0}, BlockSize={1}", _usedMsgList.size(), _blockAllocator.getNumAllocatedBlocks());
		//         }
		//        gxAssert(_threadID == gxGetThreadID());
		for(ObjList::iterator iter = _usedMsgList.begin(); iter != _usedMsgList.end();)
		{
			CTask* msg = *iter;
			gxAssert(msg);
			if(msg->canFree())
			{
				msg->doAfterUsed();
				//msg->reset();
				//                gxInfo("free task: {0}", msg->getName().c_str());
				freeObj(msg);
				iter = _usedMsgList.erase(iter);
			}
			else
			{
#if 0               // 调试运行
				++iter;
				if(iter != _usedMsgList.end())
				{
					// 下一个消息未被释放的机率很大
					T* temp = *iter;
					gxAssert(!temp->canFree());
					--iter;
				}
#endif
				if(!isAll)
				{
					// 剩余消息块未被处理, 不需要再进行检测
					break;
				}
				else
				{
					++iter;
				}
			}
		}

		CFastLock::Set(_usedMsgNum, (sint32)_usedMsgList.size());

		// @TODO 间隔一定时间处理
		flushWriteMsg(false);
	}

#pragma endregion active_queue

#pragma region queue_wrap

	CSyncActiveQueueWrap::CSyncActiveQueueWrap()
	{
		_clearSelf();
	}

	CSyncActiveQueueWrap::~CSyncActiveQueueWrap()
	{
		_clearSelf();
	}

	void CSyncActiveQueueWrap::_clearSelf()
	{
		_inputQ = NULL;
		_outputQ = NULL;
		_uid = 0;
		_threadID = 0;
		_loopThreadWrap = NULL;
		_loopThread = NULL;
	}

	void CSyncActiveQueueWrap::setCommunicationQ(CSyncActiveQueue* inputQ, CSyncActiveQueue* outputQ)
	{
		_inputQ = inputQ;
		_outputQ = outputQ;

		if (inputQ)
		{
			inputQ->setProfileFlag(true);
		}
		if (outputQ)
		{
			outputQ->setProfileFlag(true);
		}
	}

	void CSyncActiveQueueWrap::push(TaskObjList* lst)
	{
		_outputQ->writeMsg(lst);
	}

	void CSyncActiveQueueWrap::push(CTask* t)
	{
		_outputQ->writeMsg(t);
	}

	void CSyncActiveQueueWrap::get(TaskObjList* lst)
	{
		_inputQ->readMsg(lst);
	}

	void CSyncActiveQueueWrap::get(CTask*& t)
	{
		_inputQ->readMsg(t);
	}

	void CSyncActiveQueueWrap::update(uint32 diff)
	{
		_outputQ->updateWrite(diff);
		_inputQ->updateRead(diff);

		// @TODO 更新性能统计信息
//		_inputQ->updateProfileData();
//		_outputQ->updateProfileData();
//		_inputQ->doProfile();
//		_outputQ->doProfile();
	}

	void CSyncActiveQueueWrap::cleanWriteQue()
	{
		_outputQ->flushWriteMsg(true);
	}

	void CSyncActiveQueueWrap::flushQueue()
	{
		cleanReadQue();
		cleanWriteQue();
	}

	void CSyncActiveQueueWrap::cleanReadQue()
	{
		_inputQ->flushReadMsg(true);
		_inputQ->cleanReadMsg();
	}

	void CSyncActiveQueueWrap::doProfile()
	{
		_inputQ->doProfile();
		_outputQ->doProfile();
	}

	void CSyncActiveQueueWrap::setThreadID(TThreadID_t tid)
	{
		_threadID = tid;
		_outputQ->setWriteThreadID();
		_inputQ->setReadThreadID();
	}

	/*
	CTask* CSyncActiveQueueWrap::getSendMsg()
	{
		CTask* temp = _outputQ->getSendMsg();
		temp->setAllocable(this->getOutputQ());
		temp->setTaskQueueWrap(this);
		temp->setLoopThreadWrap(_loopThreadWrap);
		temp->setLoopThread(_loopThread);
		temp->setObjUID(genUID());
		
		return temp;
	}
	*/

	void CSyncActiveQueueWrap::freeObj(CTask* task)
	{
		_outputQ->freeObj(task);
	}

	TUniqueIndex_t CSyncActiveQueueWrap::genUID()
	{
		return _uid++;
	}

	sint32 CSyncActiveQueueWrap::getInputTaskNum() const
	{
		return _inputQ->getTaskNum();
	}

	sint32 CSyncActiveQueueWrap::getOutputTaskNum() const
	{
		return _outputQ->getTaskNum();
	}

	const CSyncActiveQueue* CSyncActiveQueueWrap::getInputQ()const
	{
		return _inputQ;
	}
	
	const CSyncActiveQueue* CSyncActiveQueueWrap::getOutputQ()const
	{
		return _outputQ;
	}

	void CSyncActiveQueueWrap::setLoopThread(CModuleThreadLoop* loopThread)
	{
		_loopThread = loopThread;
	}

	CModuleThreadLoop* CSyncActiveQueueWrap::getLoopThread()const
	{
		return _loopThread;
	}

	void CSyncActiveQueueWrap::setLoopThreadWrap(CModuleThreadLoopWrap* loopThreadWrap)
	{
		_loopThreadWrap = loopThreadWrap;
	}

	CModuleThreadLoopWrap* CSyncActiveQueueWrap::getLoopThreadWrap()const
	{
		return _loopThreadWrap;
	}

	void CSyncActiveQueueWrap::handleTask(TDiffTime_t diff)
	{
		TaskObjList lst;
		get(&lst);
		for (TaskObjList::iterator iter = lst.begin(); iter != lst.end(); iter++)
		{
			CTask* task = *iter;
			gxAssert(task);
			if (task)
			{
				task->run();
				task->setFreed();
			}
		}
	}

#pragma endregion queue_wrap
}