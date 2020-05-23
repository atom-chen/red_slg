#include "http_default_handler.h"
#include "script_engine_common.h"

bool CHttpDefaultHandler::check()
{
	return _scriptEngine->bCall("httpCheckHeader", _buffer.c_str());
}

bool CHttpDefaultHandler::handleRequest()
{
	if(!TBaseType::handleRequest()){
		return false;
	}
	if(!check())
	{
		return true;
	}

	gxInfo("Handle http url: IP={0},Port={1}", getHandleIp(), getHandlePort());

	//gxDebug("{0}", _buffer.c_str());
	std::map<std::string, std::string> options;
	options = _scriptEngine->call("httpParseHeader", TBaseType::TRequestHeaderOptions(), _buffer.c_str());
	sint32 headerLen = getOption<sint32>(options, "HeaderLen");
	if(headerLen <= 0){
		return false;
	}
	bool urlValid = getOption<bool>(options, "Valid");
	std::string htmlString = "";
	if(urlValid)
	{
		std::string bodyString = _scriptEngine->call("httpParseBody", "", _buffer.c_str());
		htmlString = _scriptEngine->call("httpRequestHandle", "", options, bodyString);
		_bufferCurrentPos += headerLen;
	}else
	{
		htmlString = _scriptEngine->call("httpBadRequest", "");
	}
	gxDebug("{0}", htmlString);
	send(htmlString.c_str(), (sint32)htmlString.size());
	kick();
	return true;
}

bool CHttpDefaultHandler::start()
{
	setHandleTimeoutTime(20);
	setStartRequestTime(DTimeManager.nowSysTime());
	setRequestHandleTime(50);
	return true;
}

void CHttpDefaultHandler::breath( GXMISC::TDiffTime_t diff )
{
	TBaseType::breath(diff);
}

std::string CHttpDefaultHandler::getHandleIp()
{
	return getRemoteIp();
}
GXMISC::TPort_t CHttpDefaultHandler::getHandlePort()
{
	return getRemotePort();
}