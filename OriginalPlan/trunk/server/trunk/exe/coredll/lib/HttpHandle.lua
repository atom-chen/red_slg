reloadRequire("Class");
reloadRequire("Log");
reloadRequire("String");
reloadRequire("Util");
reloadRequire("Table");
reloadRequire("HttpData");

-------------------------------------------------------
-- 作用: 得到协议头大小
-- 参数: 协议解析后的行数
-- 返回: 协议头长
function httpGetHeaderLen(lines)
	local headerLen = 0;
	local headerEnd = false;
	for i, line in pairs(lines) do
		headerLen = headerLen+string.len(line);
		if line == "\r\n" then
			headerEnd = true;
			break;
		end
	end

	return headerEnd, headerLen;
end

-------------------------------------------------------
-- 作用: 解析选项行
-- 参数: 选项行
-- 返回: 选项名字, 选项值
function httpParseHeaderOptionLine(line)
	-- @TODO
end

-------------------------------------------------------
-- 作用: 解析协议URL行
-- 参数: 协议URL行
-- 返回: URL解析后的映射表 Method=** Url=** UrlParams=** Version=**
-- 参考: GET /gm?type=func&p1=xxx HTTP/1.1
function httpParseHeaderUrlLine(tempLine)
	local line = stringSrimCont1(tempLine, "\r\n");
--	print(line);
	local urlParams = {};
	urlParams["Valid"] = "0";
	local spliteParams = stringSplit(line, " ");
	if #spliteParams ~= 3 then
		log:error("Http request url not 3 parts!String = " .. line);
		return urlParams;
	end

	-- GET
	if not (spliteParams[1] == "GET" or spliteParams[1] == "POST") then
		log:error("Can't get http request method!String=" .. spliteParams[1] .. ".");
		return urlParams;
	end
	urlParams["Method"] = spliteParams[1];

	-- /test.html?test=1&a=c
	local urlLine = spliteParams[2];
	if string.char(string.byte(urlLine)) ~= '/' then
		log:error("Http request url start not by \'/\'!String = " .. urlLine);
		return urlParams;
	end
	local urlSpliteStrs = stringSplit(urlLine, "?");
	if #urlSpliteStrs ~= 2 then
		log:error("Http request url not 2 parts!String = " .. urlLine);
		return urlParams;
	end
	urlParams["Url"] = urlSpliteStrs[1];
	urlParams["UrlParams"] = urlSpliteStrs[2];

	-- HTTP/1.1
	local httpVersionStr = spliteParams[3];
	local httpVersionSplites = stringSplit(httpVersionStr, "/");
	if #httpVersionSplites ~= 2 then
		log:error("Http version not 2 parts!String = " .. httpVersionStr);
		return urlParams;
	end
	if httpVersionSplites[1] ~= "HTTP" then
		log:error("Http version not parse!String = " .. httpVersionSplites[1]);
		return urlParams;
	end
	if findString(httpVersionSplites[2], "[%d.]+") == "" then
		log:error("Http version number not correct!String = " .. httpVersionSplites[2]);
		return urlParams;
	end
	urlParams["Version"] = httpVersionSplites[2];
	urlParams["Valid"] = "1";

	return urlParams;
end

-------------------------------------------------------
-- 作用: 解析协议头
-- 参数: 协议头
-- 返回: 解析后的映射表
function httpParseHeader(msg)
	log:debug(msg);
	lines = stringSplit(msg, "\r\n", true);
	local options = {};
	local msgLen = string.len(msg);
	local headerFlag, headerLen = httpGetHeaderLen(lines);
	if not headerFlag then
		return options;
	end
	
	linesSize = #lines;
	if linesSize < 1 then
		log:error("http request header empty!");
		return options;
	end
	
	local lineIndex = 0;
	for i, line in pairs(lines) do
		if lineIndex == 0 then
			-- 处理请求的第一行
			local urlParams = httpParseHeaderUrlLine(line);
			if urlParams == nil then
				return options;
			end
			options = tableConnect(options, urlParams);
		else
			-- 处理协议头的选项
			-- local optionName, optionValue = httpParseHeaderOptionLine(line);
			-- if optionName == nil then
			--	return options;
			-- end

			-- options[optionName] = optionValue;
		end
		lineIndex = lineIndex+1;
	end

	options["HeaderLen"] = tostring(headerLen);

	printObject(options);
	return options;
end

-------------------------------------------------------
-- 作用: 检测http请求头是否完整
-- 参数: 消息缓冲
-- 返回: true或false
function httpCheckHeader(httpReqStr)
	str = findString(httpReqStr, "\r\n\r\n");
	if str ~= "" then
		return true;
	end

	return false;
end

-------------------------------------------------------
-- 作用: 解析协议体
-- 参数: 消息缓冲
-- 返回: 解析后的协议体
function httpParseBody(msg)
	-- log:error("Unimplementd parse http request body!");
	return "";
end

-------------------------------------------------------
-- 作用: 生成协议头
-- 参数: 无
-- 返回: 协议头
function httpGenHeader()
	local header = "";
	header = header .. "HTTP/1.0 200 OK\r\n";
	header = header .. "Server: GameManager/0.1.0\r\n";
	header = header .. "Content-Type: text/html\r\n";
	header = header .. "\r\n";

	return header;
end

-------------------------------------------------------
-- 作用: 未实现的方法
-- 参数: 无
-- 返回: 生成的html字符串
function httpUnimplemented()
	-- 协议头
	local header = "";
	header = header .. "HTTP/1.0 501 Method Not Implemented\r\n";
	header = header .. "Server: GameManager/0.1.0\r\n";
	header = header .. "Content-Type: text/html\r\n";
	header = header .. "\r\n";
	
	-- 协议体
	header = header .. "<HTML><HEAD><TITLE>Method Not Implemented\r\n";
	header = header .. "</TITLE></HEAD>\r\n";
	header = header .. "<BODY><P>HTTP request method not supported.\r\n";
	header = header .. "</BODY></HTML>\r\n";

	return header;
end

-------------------------------------------------------
-- 作用: 无法找到的文件或方法
-- 参数: 无
-- 返回: 生成的html字符串
function httpNotFound()
	-- 协议头
	local header = "";
	header = header .. "HTTP/1.0 404 NOT FOUND\r\n";
	header = header .. "Server: GameManager/0.1.0\r\n";
	header = header .. "Content-Type: text/html\r\n";
	header = header .. "\r\n";
	
	-- 协议体
	header = header .. "<HTML><TITLE>Not Found</TITLE>\r\n";
	header = header .. "<BODY><P>The server could not fulfill\r\n";
	header = header .. "your request because the resource specified\r\n";
	header = header .. "is unavailable or nonexistent.\r\n";
	header = header .. "</BODY></HTML>\r\n";

	return header;
end

-------------------------------------------------------
-- 作用: 无效的协议请求
-- 参数: 无
-- 返回: 生成的html字符串
function httpBadRequest()
	-- 协议头
	local header = "";
	header = header .. "HTTP/1.0 400 BAD REQUEST\r\n";
--	header = header .. "Server: GameManager/0.1.0\r\n";
	header = header .. "Content-Type: text/html\r\n";
	header = header .. "\r\n";
	
	-- 协议体
	header = header .. "<P>Your browser sent a bad request, ";
	header = header .. "such as a POST without a Content-Length.\r\n";

	return header;
end

-------------------------------------------------------
-- 作用: 无效法执行CGI或方法
-- 参数: 无
-- 返回: 生成的html字符串
function httpCannotExecute()
	-- 协议头
	local header = "";
	header = header .. "HTTP/1.0 500 Internal Server Error\r\n";
--	header = header .. "Server: GameManager/0.1.0\r\n";
	header = header .. "Content-Type: text/html\r\n";
	header = header .. "\r\n";
	
	-- 协议体
	header = header .. "<P>Error prohibited CGI execution.\r\n";

	return header;
end

-------------------------------------------------------
-- 作用: 处理文件
-- 参数: 文件名字
-- 返回: 生成的html字符串
function httpHandleFile(options, body, params, fileName)
	local genBody = "<body>test</body>";
	return genBody;
end

-------------------------------------------------------
-- 作用: 处理CGI
-- 参数: CGI名字
-- 返回: 生成的html字符串
function httpHandleCGI(options, body, params, cgiName)
	local genBody = "<body>test</body>";
	return genBody;
end

-------------------------------------------------------
-- 作用: 将URL参数排序 从p1-pn
-- 参数: 参数列表
-- 返回: 参数列表
function httpSortFuncParam(params)
	local funcParams = {};
	for i=1,20,1 do
		local paramName= "p" .. i;
		if params[paramName] == nil then
			return funcParams;
		end

		table.insert(funcParams, params[paramName]);
	end

	return funcParams;
end

-------------------------------------------------------
-- 作用: 处理函数
-- 参数: C函数名字
-- 返回: 生成的html字符串
function httpHandleFunction(options, body, params, funcName)
	-- local funcParams = httpSortFuncParam(params);
	-- printObject(funcParams);
	func = loadFuncByName1(funcName);
	if nil == func
	then
		return httpBadRequest();
	end
	
	local retString = func(params);
	-- print(retString);

	return httpGenHeader() .. retString;
end

-------------------------------------------------------
-- 作用: 解析URL参数
-- 参数: URL参数
-- 返回: 解析后的参数映射表
function httpParseUrlParams(urlParamsString)
	local tempUrlParams = stringSplit(urlParamsString, "&");
	-- printObject(tempUrlParams);
	local urlParams = {};
	for k, v in pairs(tempUrlParams) do
		local repString = stringSrimCont1(v, " ");
		local name,val = stringSplite1(repString, "=");
		if name == nil then
			log:error("Cant parase url params!String=" .. repString);
			return nil;
		end

		urlParams[name]=val;
	end

	return urlParams;
end

-------------------------------------------------------
-- 作用: 处理http请求
-- 参数: http请求
-- 返回: 生成的html字符串
function httpRequestHandle(options, body)
	local urlParams = httpParseUrlParams(options["UrlParams"]);
	if urlParams == nil then
		return httpBadRequest();
	end
	--printObject(urlParams);
	if urlParams["type"] == nil then
		log:error("Bad request, type is null!");
		return httpBadRequest();
	end

	if urlParams["type"] == "func" then
		local funcName = urlParams["name"];
		if funcName == nil then
			log:error("Bad request, function name is null!");
			return httpBadRequest();
		end

		return httpHandleFunction(options, body, urlParams, funcName);
	end

	return httpUnimplemented();
end

-------------------------------------------------------
-- 作用: http默认JSON错误信息
-- 参数: 空
-- 返回: 空
-- 说明: 错误码对应的错误信息
function httpJSonErrMsg()
	HttpErrCode.OK = "0";
	HttpJSonErrMsg["0"] = "OK";

	HttpErrCode.INVALID_URL = "1000";
	HttpJSonErrMsg["1000"] = "无效的URL";

	HttpErrCode.UNIMPLEMENTED_FUNC = "1001";
	HttpJSonErrMsg["1001"] = "未实现的方法";

	HttpErrCode.BAD_PARAMS = "1002";
	HttpJSonErrMsg["1002"] = "参数错误";
end
httpJSonErrMsg();
-------------------------------------------------------
-- 作用: http注册错误码
-- 参数: 错误码:错误信息
-- 返回: 空
function httpJSonErrMsgReg(errCode, errMsg)
	HttpJSonErrMsg[errCode] = errMsg;
end
-------------------------------------------------------
-- 作用: http得到错误信息
-- 参数: 错误码
-- 返回: 空
function httpJSonErrMsgGet(errCode)
	if not IsNull(HttpJSonErrMsg[errCode]) then
		return HttpJSonErrMsg[errCode];
	end

	return "未知错误信息";
end
-------------------------------------------------------
-- 作用: http错误信息格式化为JSON
-- 参数: 错误码
-- 返回: 空
function httpJSonErrMsgFmt(errCode)
	local cjson = require "cjson";
	local msg = {};
	msg[errCode] = HttpJSonErrMsg[errCode];
	local result = cjson.encode(msg);
	return result;
end

-------------------------------------------------------
-- 作用: http默认Html处理函数
-- 参数: 空
-- 返回: 空
function httpHtmlHandler()
	
end
-------------------------------------------------------
-- 作用: http默认JSON处理函数
-- 参数: 空
-- 返回: 空
function httpJSonHandler()
	
end

-------------------------------------------------------
-- 作用: http注册处理函数
-- 参数: 空
-- 返回: 空
function httpRegisteHandler(handleName, handle)
	
end