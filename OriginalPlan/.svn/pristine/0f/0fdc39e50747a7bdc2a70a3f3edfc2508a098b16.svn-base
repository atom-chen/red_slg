#include "module_base.h"
#include "thread.h"

namespace GXMISC
{
	CModuleThreadLoop::CModuleThreadLoop()
	{
		_clearSelf();
	}

	CModuleThreadLoop::~CModuleThreadLoop()
	{
		_clearSelf();
	}

	void CModuleThreadLoop::_clearSelf()
	{
		_loopWrap = NULL;
		_thread = NULL;
		_startTime = 0;
		_curTime = 0;
		_runSeconds = 0;
		_totalLoopCount = 0;
		_maxLoopCount = 0;
		_curLoopCount = 0;
		_lastLoopProfileTime = 0;
		_moduleConfig = NULL;
		_needFree = false;
	}

	void CModuleThreadLoop::setCommunicationQ(CSyncActiveQueue* inputQ, CSyncActiveQueue* outputQ)
	{
		_queueWrap.setCommunicationQ(inputQ, outputQ);
	}

	void CModuleThreadLoop::setModuleConfig(IModuleConfig* config)
	{
		_moduleConfig = config;
	}

	void CModuleThreadLoop::setLoopWrap(CModuleThreadLoopWrap* loopWrap)
	{
		_loopWrap = loopWrap;
	}

	void CModuleThreadLoop::setFreeFlag(bool flag)
	{
		_needFree = flag;
	}

	bool CModuleThreadLoop::needFree()
	{
		return _needFree;
	}

	const CSyncActiveQueueWrap* CModuleThreadLoop::getTaskQueueWrap() const
	{
		return &_queueWrap;
	}

	CModuleThreadLoopWrap* CModuleThreadLoop::getThreadLoopWrap() const
	{
		return _loopWrap;
	}

	void CModuleThreadLoop::run()
	{
		setStart();
		setThreadID(gxGetThreadID());
		_queueWrap.setThreadID();
		_startTime = std::time(NULL);
		_lastLoopProfileTime = _startTime;
		_curLoopCount = 0;
		initBeforeRun();
		
		while (!isStop())
		{
			_curTime = std::time(NULL);
			_runSeconds = (uint32)(_curTime - _startTime);
			_totalLoopCount++;
			_curLoopCount++;

			handleOutputTask();

			handleInputTask();

			if (false == onBreath())
			{
				gxWarning("loop error!LoopName = {0}", getName().c_str());
				break;
			}

			if (_curTime - _lastLoopProfileTime > 1)
			{
				// 一秒内的统计更新
				_lastLoopProfileTime = _curTime;
				if (_curLoopCount > _maxLoopCount)
				{
					_maxLoopCount = _curLoopCount;
				}
				_curLoopCount = 0;
			}

			gxSleep(0);
		}

		_queueWrap.flushQueue();

		onStop();

		setExitRun();
	}

	void CModuleThreadLoop::freeTask( CTask* arg )
    {
        _queueWrap.freeObj(arg);
    }

	void CModuleThreadLoop::onHandleTask(CTask* task)
	{

	}

	void CModuleThreadLoop::handleInputTask()
	{
		typedef CSyncActiveQueueWrap::TaskObjList __TTaskList;
		__TTaskList lst;

		_queueWrap.get(&lst);
		for (__TTaskList::iterator iter = lst.begin(); iter != lst.end(); iter++)
		{
			CTask* task = *iter;
			gxAssert(task);
			if (task)
			{
				task->run();
				onHandleTask(task);
				task->setFreed();
			}
		}
	}

	void CModuleThreadLoop::handleOutputTask()
	{
		_queueWrap.update(0);
	}

	bool CModuleThreadLoop::init()
	{
		_queueWrap.setLoopThread(this);
		_queueWrap.setLoopThreadWrap(_loopWrap);

		_thread = IThread::create(this);
		for (uint32 i = 0; i < _moduleConfig->getRunCPUFlag().size(); ++i)
		{
			_thread->setRunCPU(_moduleConfig->getRunCPUFlag().at(i));
		}

		return true;
	}

	bool CModuleThreadLoop::start()
	{
		return _thread->start();
	}

	void CModuleThreadLoop::cleanUp()
	{
		DSafeDelete(_thread);
	}

	CModuleThreadLoopWrap::CModuleThreadLoopWrap(CModuleBase* pModule)
	{
		_clearSelf();

		_moduleBase = pModule;
		_moduleConfig = _moduleBase->getModuleConfig();
	}

	CModuleThreadLoopWrap::~CModuleThreadLoopWrap()
	{
		_clearSelf();
	}

	bool CModuleThreadLoopWrap::init()
	{
		_threadLoop = createThreadLoop();
		if (NULL == _threadLoop)
		{
			gxError("Can't create thread loop!!!");
			return false;
		}

		_threadLoop->setLoopWrap(this);
		_threadLoop->setModuleConfig(_moduleBase->getModuleConfig());
		onCreateThreadLoop(_threadLoop);

		_queueWrap.setThreadID();
		_queueWrap.setLoopThread(_threadLoop);
		_queueWrap.setLoopThreadWrap(this);

		if (!_threadLoop->init())
		{
			return false;
		}

		return true;
	}

	void CModuleThreadLoopWrap::onCreateThreadLoop(CModuleThreadLoop* threadLoop)
	{
	}

	bool CModuleThreadLoopWrap::start()
	{
		return _threadLoop->start();
	}

	void CModuleThreadLoopWrap::stop()
	{
		_threadLoop->setStop();

		_queueWrap.flushQueue();

		onStop();
	}

	void CModuleThreadLoopWrap::cleanUp()
	{
		if(_threadLoop)
		{
			_threadLoop->cleanUp();
			if (_threadLoop->needFree())
			{
				DSafeDelete(_threadLoop);
			}
		}

//		if(_inputQ)
//		{
//			_inputQ->cleanUp();
//		}
//		if(_outputQ)
//		{
//			_outputQ->cleanUp();
//		}
	}
	
	void CModuleThreadLoopWrap::_clearSelf()
	{
		_threadLoop = NULL;
		_moduleBase = NULL;
		_inputQ = NULL;
		_outputQ = NULL;
		_genId = 0;
		_tagId = 0;
		_mainService = NULL;
		_moduleConfig = NULL;
	}

	void CModuleThreadLoopWrap::breath(GXMISC::TDiffTime_t diff)
	{
		handleOutputTask(diff);

		handleInputTask(diff);

		onBreath(diff);
	}

	void CModuleThreadLoopWrap::freeTask(CTask* arg)
	{
		_queueWrap.freeObj(arg);
	}

	void CModuleThreadLoopWrap::onHandleTask(CTask* task)
	{

	}

	void CModuleThreadLoopWrap::handleInputTask(TDiffTime_t diff)
	{
		typedef CSyncActiveQueueWrap::TaskObjList __TTaskList;
		__TTaskList lst;

		_queueWrap.get(&lst);
		for (__TTaskList::iterator iter = lst.begin(); iter != lst.end(); iter++)
		{
			CTask* task = *iter;
			gxAssert(task);
			if (task)
			{
				task->run();
				onHandleTask(task);
				task->setFreed();
			}
		}
	}

	void CModuleThreadLoopWrap::handleOutputTask(TDiffTime_t diff)
	{
		_queueWrap.update(diff);
	}

	bool CModuleThreadLoopWrap::isRunning()
	{
		return !_threadLoop->isStop();
	}

	bool CModuleThreadLoopWrap::isExitRun()
	{
		return _threadLoop->isExitRun();
	}

	sint32 CModuleThreadLoopWrap::getUserNum() const
	{
		gxAssert(false);
		return 0;
	}

	sint32 CModuleThreadLoopWrap::getMaxUserNum() const
	{
		return _moduleConfig->getMaxUserNumPerLoop();
	}

	bool CModuleThreadLoopWrap::isMaxUserNum() const
	{
		return getUserNum() >= getMaxUserNum();
	}

	void CModuleThreadLoopWrap::setTagId(uint8 tagId)
	{
		_tagId = tagId;
	}

	GXMISC::TUniqueIndex_t CModuleThreadLoopWrap::genUniqueIndex()
	{
		TUniqueIndex_t uid = _tagId;
		uid <<= sizeof(_genId)* 8;
		uid += _genId;
		_genId++;
		return uid;
	}

	uint8 CModuleThreadLoopWrap::getTagId()
	{
		return _tagId;
	}

	bool CModuleThreadLoopWrap::isUserIndex(TUniqueIndex_t uid)
	{
		return ((uid >> sizeof(_genId)* 8) & 0xff) == getTagId();
	}

	CModuleThreadLoop* CModuleThreadLoopWrap::getModuleThreadLoop() const
	{
		return _threadLoop;
	}

	void CModuleThreadLoopWrap::setService(GxService* service)
	{
		_mainService = service;
	}

	GxService* CModuleThreadLoopWrap::getService() const
	{
		return _mainService;
	}

	sint32 CModuleThreadLoopWrap::getOutputQSize() const
	{
		return _queueWrap.getOutputTaskNum();
	}

	void CModuleThreadLoopWrap::setCommunicationQ(CSyncActiveQueue* inputQ, CSyncActiveQueue* outputQ)
	{
		_inputQ = inputQ;
		_outputQ = outputQ;
		_queueWrap.setCommunicationQ(inputQ, outputQ);
		_threadLoop->setCommunicationQ(outputQ, inputQ);
	}

	const CSyncActiveQueueWrap* CModuleThreadLoopWrap::getTaskQueueWrap() const
	{
		return &_queueWrap;
	}

	CSimpleThreadLoopWrap::CSimpleThreadLoopWrap(CModuleBase* module) : CModuleThreadLoopWrap(module), _inputQue(module->getModuleName()), _outputQue(module->getModuleName())
	{

	}

	CSimpleThreadLoopWrap::~CSimpleThreadLoopWrap()
	{
	}

	void CSimpleThreadLoopWrap::onCreateThreadLoop(CModuleThreadLoop* threadLoop)
	{
		setCommunicationQ(&_inputQue, &_outputQue);
	}
 
	CModuleBase::CModuleBase(IModuleConfig* config) : IModuleManager(config)
 	{
		_clearSelf();
 	}
 
 	CModuleBase::~CModuleBase()
 	{
		_clearSelf();
 	}

	bool CModuleBase::init()
	{
		if (_moduleConfig->getLoopThreadNum() > 0)
		{
			_loopThreadWraps = new CModuleThreadLoopWrap*[_moduleConfig->getLoopThreadNum()];
			if (NULL == _loopThreadWraps)
			{
				return false;
			}
			memset(_loopThreadWraps, NULL, sizeof(CModuleThreadLoopWrap*)*_moduleConfig->getLoopThreadNum());
			for (sint32 i = 0; i < _moduleConfig->getLoopThreadNum(); ++i)
			{
				_loopThreadWraps[i] = createLoopWrap();
				if (NULL == _loopThreadWraps[i])
				{
					DSafeDeleteArrays(_loopThreadWraps, i);
					return false;
				}
				onCreateThreadLoopWrap(_loopThreadWraps[i], i);
				_loopThreadWraps[i]->setTagId(uint8(i + 1));
				_loopThreadWraps[i]->setService(_mainService);
			}
			for (sint32 i = 0; i < _moduleConfig->getLoopThreadNum(); ++i)
			{
				_loopThreadWraps[i]->init();
			}
		}

		return true;
	}

	bool CModuleBase::start()
	{
		for (sint32 i = 0; i < _moduleConfig->getLoopThreadNum(); ++i)
		{
			gxAssert(!_loopThreadWraps[i]->isRunning());
			if (!_loopThreadWraps[i]->isRunning()){
				if (!_loopThreadWraps[i]->start())
				{
					gxError("Loop cant start!!!LoopName=loop{0}", i);
					goto __lab_exit;
				}
			}
		}

		return true;

	__lab_exit:
		// 停止已经启动的程序
		onStop();

		return false;
	}
	
	void CModuleBase::onStop()
	{
		for (sint32 i = 0; i < _moduleConfig->getLoopThreadNum(); ++i)
		{
			if (_loopThreadWraps[i]->isRunning()){
				_loopThreadWraps[i]->stop();
			}
		}
	}

	bool CModuleBase::doLoop(TDiffTime_t diff)
	{
		for (sint32 i = 0; i < _moduleConfig->getLoopThreadNum(); ++i)
		{
			gxAssert(_loopThreadWraps[i]);
			_loopThreadWraps[i]->breath(diff);
		}

		return onBreath(diff);
	}

	void CModuleBase::cleanUp()
	{
		for (sint32 i = 0; i < _moduleConfig->getLoopThreadNum(); ++i)
		{
			_loopThreadWraps[i]->cleanUp();
		}

		DSafeDeleteArrays(_loopThreadWraps, _moduleConfig->getLoopThreadNum());
	}

	void CModuleBase::_clearSelf()
	{
		_loopThreadWraps = NULL;
		_mainService = NULL;
	}

 	sint32 CModuleBase::getMaxConnNum() const
 	{
		return _moduleConfig->getLoopThreadNum()*_moduleConfig->getMaxUserNumPerLoop();
	}

	sint32 CModuleBase::getLoopNum() const
	{
		return _moduleConfig->getLoopThreadNum();
	}
 
 	GxService* CModuleBase::getService() const
 	{
 		return _mainService;
 	}

 	void CModuleBase::setService( GxService* service )
 	{
		_mainService = service;
	}

	bool CModuleBase::checkAllLoopStop()
	{
		for (sint32 i = 0; i < _moduleConfig->getLoopThreadNum(); ++i){
			if (!_loopThreadWraps[i]->isExitRun()){
				return false;
			}
		}

		return true;
	}

	// 有对象产生事件
	void CModuleBase::onCreateThreadLoopWrap(CModuleThreadLoopWrap* threadLoopWrap, sint32 index)
	{

	}
	/*
	bool CModuleBase::waitQuit(sint32 secs)
	{
		uint32 sleepPerCount = 100;
		uint32 count = (_moduleConfig->getCloseWaitSecsAllLoop() * 1000) / sleepPerCount;

		sint32 stopCount = 0;

		for (uint32 i = 0; i < count; ++i)
		{
			stopCount = 0;
			for (sint32 j = 0; j < _moduleConfig->getLoopThreadNum(); ++j)
			{
				if (!_loopThreadWraps[j]->isRunning())
				{
					stopCount++;
				}
			}

			if (stopCount == _moduleConfig->getLoopThreadNum())
			{
				break;
			}

			gxSleep(sleepPerCount);
		}

		if (stopCount != _moduleConfig->getLoopThreadNum())
		{
			// 未全部关闭，等待一段额外时间, 然后彻底退出
			gxSleep(secs);
		}

		return checkAllLoopStop();
	}
	*/
	CModuleThreadLoopWrap* CModuleBase::getLeastLoop() const
	{
		sint32 num = MAX_SINT32_NUM;
		CModuleThreadLoopWrap* pLoop = NULL;
		for (sint32 i = 0; i < _moduleConfig->getLoopThreadNum(); ++i)
		{
			sint32 userNum = _loopThreadWraps[i]->getUserNum();
			if ((userNum <= num) && !_loopThreadWraps[i]->isMaxUserNum())
			{
				num = userNum;
				pLoop = _loopThreadWraps[i];
			}
		}

		return pLoop;
	}
}