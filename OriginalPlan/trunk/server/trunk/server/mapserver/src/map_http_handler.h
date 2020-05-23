#ifndef _MAP_HTTP_HANDLER_H_
#define _MAP_HTTP_HANDLER_H_

#include "http_socket_handler.h"
#include "script_engine.h"

// class CMapHttpHandler : public CHttpHandler<CMapHttpHandler>
// {
// public:
// 	typedef CHttpHandler<CMapHttpHandler> TBaseType;
// 
// public:
// 	CMapHttpHandler(){}
// 	virtual ~CMapHttpHandler(){}
// 
// public:
// 	virtual bool start(){
// 		setHandleTimeoutTime(20);
// 		setStartRequestTime(DTimeManager.nowSysTime());
// 		setRequestHandleTime(50);
// 		return true;
// 	}
// 	virtual void close(){
// 
// 	}
// 	virtual void breath(GXMISC::TDiffTime_t diff){
// 		TBaseType::breath(diff);
// 	}
// 	void printOption(){
// 
// 	}
// 	virtual bool check();
// 
// 	template<typename T>
// 	T getOption(TRequestHeaderOptions& options, const std::string& name){
// 		if(options.find(name) == options.end()){
// 			return T();
// 		}
// 
// 		T val;
// 		std::string optionString = options[name];
// 		if(GXMISC::gxFromString(optionString, val)){
// 			return val;
// 		}
// 
// 		return T();
// 	}
// 
// 	virtual bool handleRequest();
// };

#endif	// _MAP_HTTP_HANDLER_H_