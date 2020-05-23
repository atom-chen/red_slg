#ifndef _STOP_TIMER_H_
#define _STOP_TIMER_H_

#include "core/service.h"

#include "script_engine_common.h"

class CStopTimer
{
public:
	CStopTimer();
	~CStopTimer();

public:
	void initData(); 
	void update(GXMISC::TDiffTime_t diff); 

public:
	void doStopSave(); 
	void doStop(); 
	void onStop(GXMISC::TDiffTime_t lastStopTime, GXMISC::TDiffTime_t saveTime); 

public:
	bool isStopTime(); 
	bool isSaveTime(); 
	bool isStop(); 

public:
	CScriptEngineCommon* getScriptEngine() const { return _scriptEngine; } 
	void setScriptEngine(CScriptEngineCommon* val) { _scriptEngine = val; } 
	GXMISC::TGameTime_t getStopStartTime() const { return _stopStartTime; } 
	void setStopStartTime(GXMISC::TGameTime_t val) { _stopStartTime = val; } 
	GXMISC::TDiffTime_t getStopLastTime() const { return _stopLastTime; } 
	void setStopLastTime(GXMISC::TDiffTime_t val) { _stopLastTime = val; } 
	GXMISC::TDiffTime_t getStopSaveTime() const { return _stopSaveTime; } 
	void setStopSaveTime(GXMISC::TDiffTime_t val) { _stopSaveTime = val; } 
	GXMISC::GxService* getService() const { return _service; } 
	void setService(GXMISC::GxService* val) { _service = val; } 

private:
	CScriptEngineCommon* _scriptEngine;
	GXMISC::GxService* _service;
	GXMISC::TGameTime_t _stopStartTime;
	GXMISC::TDiffTime_t _stopLastTime;
	GXMISC::TDiffTime_t _stopSaveTime;
};

#endif	// _STOP_TIMER_H_