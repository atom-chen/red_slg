
#include "service_task.h"

GXMISC::CServiceTask::CServiceTask()
{
	executeNumPerFrame = -1;
	allocaFromQue = false;
}

GXMISC::CServiceTask::~CServiceTask()
{
	executeNumPerFrame = 0;
	allocaFromQue = false;
}

sint32 GXMISC::CServiceTask::getExcuteNumPerFrame()
{
	return executeNumPerFrame;
}

bool GXMISC::CServiceTask::isUnlimited()
{
	return executeNumPerFrame == -1;
}

void GXMISC::CServiceTask::setExcuteNumPerFrame( sint32 num/*=-1*/ )
{
	executeNumPerFrame = num;
}

bool GXMISC::CServiceTaskQue::pushTask( CServiceTask* task )
{
	gxAssert(task->allocaFromQue == true);
	_taskQue.push_back(task);
	return true;
}

void GXMISC::CServiceTaskQue::update( GXMISC::TDiffTime_t diff )
{
	sint32 executeNum = 0;
	_taskCount.clear();
	_taskAry.clear();
	while((executeNum < _excuteNumPerFrame || _excuteNumPerFrame == -1) && !_taskQue.empty())
	{
		CServiceTask* pTask = _taskQue.front();
		if(NULL != pTask)
		{
			if(pTask->isUnlimited() || pTask->getExcuteNumPerFrame() > _taskCount[pTask->getType()])
			{
				pTask->run();
				_taskCount[pTask->getType()]++;
				executeNum++;
				if(pTask->allocaFromQue)
				{
					pTask->cleanUp();
					freeArg((char*)pTask);
				}
			}
			else
			{
				_taskAry.push_back(pTask);
			}
		}
		_taskQue.pop_front();
	}

	for(sint32 i = (sint32)(_taskAry.size()-1); i >= 0 ; --i)
	{
		_taskQue.insert(_taskQue.begin(), 1, _taskAry[i]);
	}
}

void GXMISC::CServiceTaskQue::setExecuteNumPerFrame( sint32 num )
{
	_excuteNumPerFrame = num;
}

GXMISC::CServiceTaskQue::CServiceTaskQue()
{
	_excuteNumPerFrame = -1;
}

GXMISC::CServiceTaskQue::~CServiceTaskQue()
{
}