#include "stop_event.h"

CServiceStopEvent::CServiceStopEvent()
{
	initData();
}

CServiceStopEvent::~CServiceStopEvent()
{
}

void CServiceStopEvent::initData()
{
	_service = NULL;
	_scriptEngine = NULL;
}

void CServiceStopEvent::stop()
{
	if (_scriptEngine)
	{
		_scriptEngine->vCall("StopService");
	}
}