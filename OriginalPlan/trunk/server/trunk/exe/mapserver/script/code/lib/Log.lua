CLogSystem=Class("CLogSystem");		-- 定义日志类

function CLogSystem:info(str)
	ManCore:infoLog(str);
end

function CLogSystem:debug(str)
	ManCore:debugLog(str);
end

function CLogSystem:warn(str)
	ManCore:warnLog(str);
end

function CLogSystem:error(str)
	ManCore:errorLog(str);
end

log = CLogSystem.new();

function replaceLog(fmt, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14)
	local fmtPoss = findString3(fmt, "{%s*(%d+)%s*}");
	local tempStr = fmt;
	local params = {p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14};
	for k,v in pairs(fmtPoss) do
		local index = tonumber(v);
		if index == nil then
			index = 1;
		else
			index = index+1;
		end
		tempStr = string.gsub(tempStr, "{%s*"..v.."%s*}", tostring(params[index]));
	end

	return tempStr;
end

function logInfo(fmt, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14)
	ManCore:infoLog(replaceLog(fmt, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14));
end

function logDebug(fmt, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14)
	ManCore:debugLog(replaceLog(fmt, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14));
end

function logWarn(fmt, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14)
	ManCore:warnLog(replaceLog(fmt, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14));
end

function logError(fmt, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14)
	ManCore:errorLog(replaceLog(fmt, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14));
end