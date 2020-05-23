// #include "map_http_handler.h"
// #include "script_engine.h"
// 
// bool CMapHttpHandler::check()
// {
// 	return DScriptEngine.vCall("httpCheckHeader", _buffer.toString());
// }
// 
// bool CMapHttpHandler::handleRequest()
// {
// 	if(!TBaseType::handleRequest()){
// 		return false;
// 	}
// 	if(!check())
// 	{
// 		return true;
// 	}
// 
// 	gxDebug("{0}", _buffer.toString());
// 	TRequestHeaderOptions options;
// 	options = DScriptEngine.call("httpParseHeader", TRequestHeaderOptions(), _buffer.toString());
// 	sint32 headerLen = getOption<sint32>(options, "HeaderLen");
// 	if(headerLen <= 0){
// 		return false;
// 	}
// 	bool urlValid = getOption<bool>(options, "Valid");
// 	std::string htmlString = "";
// 	if(urlValid)
// 	{
// 		std::string bodyString = DScriptEngine.call("httpParseBody", "", _buffer.toString());
// 		htmlString = DScriptEngine.call("httpRequestHandle", "", options, bodyString);
// 		_bufferCurrentPos += headerLen;
// 	}else
// 	{
// 		htmlString = DScriptEngine.call("httpBadRequest", "");
// 	}
// 	gxDebug("{0}", htmlString);
// 	send(htmlString.c_str(), (sint32)htmlString.size());
// 	kick();
// 	return true;
// }