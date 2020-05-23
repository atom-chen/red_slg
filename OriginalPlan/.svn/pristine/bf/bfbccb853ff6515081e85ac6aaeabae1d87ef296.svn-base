#include "socket_broad_cast.h"
#include "socket_event_loop_wrap.h"
#include "socket_event_loop_wrap_mgr.h"
#include "service.h"

namespace GXMISC
{
	bool CSocketBroadCast::init()
	{
		if (!TBaseType::init())
		{
			return false;
		}

		for (size_t i = 0; i < _netWraps.size(); ++i)
		{
			_sockTaskQueueWrap[i].setCommunicationQ(&_sockLoopInputQ[i], &_sockLoopOutputQ[i]);
			_netWraps[i]->initBroadcastQ(&_sockLoopOutputQ[i], &_sockLoopInputQ[i]);
		}

		return true;
	}

	void CSocketBroadCast::cleanUp()
	{
		TBaseType::cleanUp();
	}

	void GXMISC::CSocketBroadCast::broadMsg(const char* msg, sint32 len, const TSockIndexAry& socks)
	{
		for (size_t i = 0; i < _netWraps.size(); ++i)
		{
			broadMsg(msg, len, socks, _netWraps[i], i);
		}
	}

	void GXMISC::CSocketBroadCast::broadMsg(const char* msg, sint32 len, const TSockIndexAry& socks, CNetLoopWrap* wrap, uint32 index)
	{
		TSockIndexAry sockAry;
		for (TSockIndexAry::size_type i = 0; i < socks.size(); ++i)
		{
			if (wrap->isUserIndex(socks[i]))
			{
				sockAry.pushBack(socks[i]);
			}
		}

		if(!sockAry.empty())
		{
			CBroadcastPacketTask* packTask = _sockTaskQueueWrap[index].allocObj<CBroadcastPacketTask>();
			packTask->setLoopThread(wrap->getSocketEventLoop());
			char* msgBuff = packTask->allocArg(len);
			char* socksBuff = packTask->allocArg(sockAry.sizeInBytes());
			memcpy(msgBuff, msg, len);
			memcpy(socksBuff, &sockAry, sockAry.sizeInBytes());
			_sockTaskQueueWrap[index].push(packTask);
		}
	}

	void CSocketBroadCast::initBeforeRun()
	{
		for (size_t i = 0; i < _sockTaskQueueWrap.size(); ++i)
		{
			_sockTaskQueueWrap[i].setThreadID();
		}
	}

	void CSocketBroadCast::onStop()
	{
		for (size_t i = 0; i < _netWraps.size(); ++i)
		{
			_sockTaskQueueWrap[i].flushQueue();
		}

		TBaseType::onStop();
	}
	
	bool CSocketBroadCast::onBreath()
	{
		for (size_t i = 0; i < _sockTaskQueueWrap.size(); ++i)
		{
			_sockTaskQueueWrap[i].update(0);
		}

		return true;
	}

	GXMISC::CSocketBroadCast::CSocketBroadCast()
	{
	}

	GXMISC::CSocketBroadCast::~CSocketBroadCast()
	{

	}

	void CSocketBroadCast::setNetLoopWraps(CNetLoopWrap** wraps, sint32 wrapNum)
	{
		_netWraps.assign(wraps, wraps+wrapNum);
		_sockTaskQueueWrap.resize(wrapNum);
		_sockLoopInputQ.resize(wrapNum);
		_sockLoopOutputQ.resize(wrapNum);

		for (std::vector<CSyncActiveQueue>::iterator iter = _sockLoopInputQ.begin(); iter != _sockLoopInputQ.end(); ++iter)
		{
			iter->setQueueName("BroadcastInputQ");
		}

		for (std::vector<CSyncActiveQueue>::iterator iter = _sockLoopOutputQ.begin(); iter != _sockLoopOutputQ.end(); ++iter)
		{
			iter->setQueueName("BroadcastOutputQ");
		}
	}

	CNetBroadcastWrap::CNetBroadcastWrap(CNetBroadcastModule* moduleMgr) : TBaseType(moduleMgr)
	{

	}
	CNetBroadcastWrap::~CNetBroadcastWrap()
	{

	}

	CModuleThreadLoop* CNetBroadcastWrap::createThreadLoop()
	{
		_broadcastThread.setFreeFlag(false);
		return &_broadcastThread;
	}

	void CNetBroadcastWrap::onCreateThreadLoop(CModuleThreadLoop* threadLoop)
	{
		_broadcastThread.setNetLoopWraps(_mainService->getNetMgr()->getAllNetLoopWrap(), _mainService->getNetMgr()->getLoopNum());

		TBaseType::onCreateThreadLoop(threadLoop);
	}

	void CNetBroadcastWrap::broadMsg(const char* msg, sint32 len, const TSockIndexAry& socks)
	{
		CNetWrapBroadCastTask* pTask = newTask<CNetWrapBroadCastTask>();
		char* msgBuff = pTask->allocArg(len);
		char* socksBuff = pTask->allocArg(socks.sizeInBytes());
		memcpy(msgBuff, msg, len);
		memcpy(socksBuff, &socks, socks.sizeInBytes());
		pTask->pushToQueue();
	}

	CNetBroadcastModule::CNetBroadcastModule(const std::string& moduleName) : CModuleBase(&_config), _config(moduleName)
	{

	}

	CNetBroadcastModule::~CNetBroadcastModule()
	{

	}

	void CNetBroadcastModule::broadMsg(const char* msg, sint32 len, const TSockIndexAry& socks)
	{
		gxAssert(_moduleConfig->getLoopThreadNum() > 0);
		if (_moduleConfig->getLoopThreadNum() > 0)
		{
			((CNetBroadcastWrap*)_loopThreadWraps[0])->broadMsg(msg, len, socks);
		}
	}

	CModuleThreadLoopWrap* CNetBroadcastModule::createLoopWrap()
	{
		return new CNetBroadcastWrap(this);
	}
}