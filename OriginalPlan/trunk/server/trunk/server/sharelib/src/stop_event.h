#ifndef _STOP_EVENT_H_
#define _STOP_EVENT_H_

#include "core/interface.h"
#include "core/service.h"

#include "script_engine_common.h"


class CServiceStopEvent : public GXMISC::IStopHandler
{
public:
	CServiceStopEvent();
	~CServiceStopEvent();

public:
	void initData();

public:
	virtual void stop();

public:
	CScriptEngineCommon* getScriptEngine() const { return _scriptEngine; }
	void setScriptEngine(CScriptEngineCommon* val) { _scriptEngine = val; }
	GXMISC::GxService* getService() const { return _service; }
	void setService(GXMISC::GxService* val) { _service = val; }

private:
	GXMISC::GxService* _service;
	CScriptEngineCommon* _scriptEngine;
};

#endif	// _STOP_EVENT_H_