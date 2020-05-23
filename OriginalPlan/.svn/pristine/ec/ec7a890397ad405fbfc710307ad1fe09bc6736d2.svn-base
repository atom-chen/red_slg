#ifndef _HTTP_DEFAULT_HANDLER_H_
#define _HTTP_DEFAULT_HANDLER_H_

#include <string>

#include "http_socket_handler.h"

class CScriptEngineCommon;

class CHttpDefaultHandler
	: public CHttpHandler<CHttpDefaultHandler>
{
public:
	typedef CHttpHandler<CHttpDefaultHandler> TBaseType;

public:
	CHttpDefaultHandler(){
		_scriptEngine = NULL;
	}
	virtual ~CHttpDefaultHandler(){}

public:
	virtual bool start();
	virtual void breath(GXMISC::TDiffTime_t diff);
	virtual bool check();
	virtual void close(){}

public:
	template<typename T>
	T getOption(TRequestHeaderOptions& options, const std::string& name){
		if(options.find(name) == options.end()){
			return T();
		}

		T val;
		std::string optionString = options[name];
		if(GXMISC::gxFromString(optionString, val)){
			return val;
		}

		return T();
	}

	virtual bool handleRequest();

public:
	std::string getHandleIp();			// 得到处理IP 
	GXMISC::TPort_t getHandlePort();	// 得到处理端口 

public:
	CScriptEngineCommon* getScriptEngine() const { return _scriptEngine; }
	void setScriptEngine(CScriptEngineCommon* val) { _scriptEngine = val; }

private:
	CScriptEngineCommon* _scriptEngine;
};

#endif	// _HTTP_DEFAULT_HANDLER_H_