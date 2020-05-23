--[[--
数据层的实用、辅助函数库,后续添加的函数，也都按编号将函数签名添加在此，
方便其他人查看:
1.mhtInstance(pt1,pt2)
2.formatValue(value) 1000000 => 100万
3.formatDate( data ) "2013-01-23 14:12:30" => {year=2013,month=1,day=23,hour=14,min=12,sec=30}
4.formatTime(seconds) 3601 => "01:00:01"
5.formatDay(seconds) 3601 => "1小时00分钟1秒"
9.filterHtmlStyle(msg)
11.filterHtmlControlCharacter(msg)
14.getNumberDigital(num) 123 => {1,2,3}
21.util.formatNumber(num) 100031 => "100,031"
]]

local util = {}

--[[
	格式化元宝、黄金等资源的数量显示
]]
function util.formatValue(value)
	local ret = value
	local w = value/10000
	local dot = 0
	if w >= 1 then
		w = math.floor(w)
		local yi = math.floor(w/10000)

		if yi>9 then
			dot = math.floor(w/1000)%10
			w = w - yi
			if dot > 0 then
				ret = string.format("%s.%s亿", yi, dot)
			else
				ret = yi.."亿"
			end
		else
			dot = math.floor(value/1000)%10
			if dot > 0 then
				ret = string.format("%s.%s万", w, dot)
			else
				ret = w.."万"
			end
		end
	end
	return ret
end

--[[
	格式化矿物等资源的数量显示
]]
function util.format2Value(value)
	local ret = value
	local thoursand = value/1000
	local million = value/1000000
	local dot = 0
	if million >= 1 then
		million = math.floor(million)
		dot = math.floor(million/10000)%100
		if dot > 0 then
			ret = string.format("%s.%sm", million, dot)
		else
			ret = million.."m"
		end
	elseif thoursand >= 1 then
		thourand = math.floor(thoursand)
		dot = math.floor(thoursand/10)%100
		if dot > 0 then
			ret = string.format("%s.%sk", thourand, dot)
		else
			ret = thourand..'k'
		end
		return ret
	end
	return ret
end

function util.toTimeStr(dt)
	local s = dt
	if s <3600 then
		return string.format("%d分钟",math.ceil(s/60))
	end
	s = s/3600
	if s < 24 then
		return string.format("%d小时",math.floor(s))
	end
	s = s/24
	if s < 7 then
		return string.format("%d小时",math.floor(s))
	end
	return string.format("7天以上")
end
-- end
--[[--
	格式化日期返回时间戳
	data:2013-01-23 14:12:30
]]
function util.formatDate( data )
	local dat={}
	local dt = util.split( data ," ")
	local yt = util.split( dt[1] ,"-")
	dat.year = yt[1]
	dat.month = yt[2]
	dat.day = yt[3]
	local tt = util.split( dt[2] ,":")
	dat.hour = tt[1]
	dat.min = tt[2]
	dat.sec = tt[3]
	-- dat.sec = 0
	return os.time(dat)
end

function util.formatSecond(ms)
	local ret = ""
	local s = math.floor(ms/1000)
	ms = ms%1000
	local m = math.floor(s / 60)
	local str = tostring(m)
	if m < 10 then
		str = "0" .. str
	end
	ret = ret .. str
	str = s % 60
	if str < 10 then
		str = "0" .. str
	end
	ret = ret .. ":" .. str

	ms = math.floor(ms/10)
	if ms < 10 then
		ms = "0" .. ms
	elseif ms == 100 then
		ms = 99
	end
	ret = ret .. ":" .. ms
	return ret
end

function util.formatSecondEx(ms)
	local ret = ""
	local s = math.floor(ms/1000)
	ms = ms%1000
	local str = s % 60
	if str < 10 then
		str = "0" .. str
	end

	ms = math.floor(ms/10)
	if ms < 10 then
		ms = "0" .. ms
	elseif ms == 100 then
		ms = 99
	end
	str = str .. ":" .. ms
	return str
end

--[[--
	格式化时间，将秒数转化为 **:**:**
	@param: seconds int
	@param: string "**:**:**"
]]
function util.formatTime(seconds,showH0,showM0)
	local ret = ""
	local h = math.floor(seconds / 3600)
	if h == 0 then
		if showH0 then
			ret = "00:"
		end
	elseif h < 10 then
		ret = "0" .. tostring(h) .. ":"
	else
		ret = ret..h..":"
	end

	seconds = seconds % 3600
	local m = math.floor(seconds / 60)
	local str = tostring(m)
	if m == 0 then
		if showM0 then
			str = "00"
		end
	elseif m < 10 then
		str = "0" .. str
	end
	ret = ret .. str
	seconds = seconds % 60
	str = tostring(seconds)
	if seconds < 10 then
		str = "0" .. str
	end
	ret = ret .. ":" .. str

	return ret
end


--[[--
	格式化时间，将秒数转化为 **:**:**
	@param: seconds int
	@param: string "**:**:**"
]]
function util.formatTime3(seconds)
	local ret = ""
	local h = math.floor(seconds / 3600)
	if h == 0 then
		ret = "00:"
	elseif h < 10 then
		ret = "0" .. tostring(h) .. ":"
	else
		ret = ret..h..":"
	end

	seconds = seconds % 3600
	local m = math.floor(seconds / 60)
	local str = tostring(m)
	if m < 10 then
		str = "0" .. str
	end
	ret = ret .. str
	seconds = seconds % 60
	str = tostring(seconds)
	if seconds < 10 then
		str = "0" .. str
	end
	ret = ret .. ":" .. str

	return ret
end

--[[--
	格式化时间，将秒数转化为   xx 天 xx小时  xx分钟
	@param: seconds int
	@param: string "**:**:**"
]]
function util.formatDay(seconds)
	local ret
	local d = math.floor(seconds /(24* 3600))
	if d > 0 then
		ret = d.."天"
	else
		ret = ""
	end

	seconds = seconds - d*(24* 3600)

	local h = math.floor(seconds / 3600)

	if h  < 10 then
		ret = ret.."0" .. h
	else
		ret = ret .. h
	end
	ret = ret.."小时"

	seconds = seconds % 3600
	local m = math.floor(seconds / 60)
	if m < 10 then
		ret = ret.. "0" .. m
	else
		ret = ret..m
	end
	ret = ret.."分钟"

	seconds = seconds % 60
	seconds = math.floor(seconds)
	if seconds < 10 then
		ret = ret.. "0" .. seconds
	else
		ret = ret..seconds
	end
	ret = ret.."秒"

	return ret
end

function util.formatDayEx(seconds)
	local ret
	local d = math.floor(seconds /(24* 3600))
	if d > 0 then
		ret = d.."天"
	else
		ret = ""
	end

	seconds = seconds - d*(24* 3600)

	if seconds == 0 then
		return ret
	end

	local h = math.floor(seconds / 3600)


	ret = ret .. h
	ret = ret.."小时"

	seconds = seconds % 3600

	if seconds == 0 then
		return ret
	end

	local m = math.floor(seconds / 60)
	ret = ret..m
	ret = ret.."分钟"
	return ret
end

local function chines2num(str, pos)
	pos = pos or 1
	local b1 = string.byte(str, pos)
	local b2 = string.byte(str, pos+1)
	local b3 = string.byte(str, pos+2)
	local b = (b1%0x20)*0x1000+(b2%0x40)*0x40+(b3%0x40)
	return b
end

--获取文本长度（汉字按一个算）
function util.getStringLength(str)
	local pos,strLength = 1,str:len()
	local num = 0
	while pos <= strLength do
		local letterLen = util.getLetterLenByPos(str,pos)
		pos = pos + letterLen
		num = num + 1
	end
	return num
end

--获取第x个字(汉字)
function util.getCharacterAt(str,pos)
	local index,curPos,strLength = 1,1,str:len()
	local letterLen = 0
	while curPos <= strLength do
		letterLen = util.getLetterLenByPos(str,curPos)
		if index == pos then  --到这个了
			return string.sub(str,curPos,curPos+letterLen-1),letterLen
		end
		index = index + 1
		curPos = curPos + letterLen
	end
	return "",letterLen
end

--根据宽度width切割成2个字符串
function util.splitString(str,fontsize,width)
	fontsize = fontsize or ui.DEFAULT_TTF_FONT_SIZE
	local pos,strLength = 1,str:len()
	local lenList = {}

	local index = strLength
	while pos <= strLength do
		local letterLen = util.getLetterLenByPos(str,pos)
		lenList[#lenList+1] = letterLen
		pos = pos + letterLen
		if pos*fontsize/3 >= width then  --初步预算一下宽度是不是差不多了
			index = pos - 1
			break
		end
	end
	local tStr = string.sub(str,1,index)
	local size = util.getTextSize(tStr,fontsize)
	local splitPos = lenList[1] or 0
	if size.width == width then
		splitPos = index
	elseif size.width > width then  --往前找
		splitPos = 0
		local endIndex = #lenList
		while endIndex > 0 do
			index = index-lenList[endIndex]
			tStr = string.sub(str,1,index)
			size = util.getTextSize(tStr,fontsize)
			if size.width <= width then
				splitPos = index
				break
			end
			endIndex = endIndex - 1
		end
	else
		splitPos = strLength
		while pos <= strLength do --往后找
			local letterLen = util.getLetterLenByPos(str,pos)
			pos = pos + letterLen
			tStr = string.sub(str,1,pos-1)
			size = util.getTextSize(tStr,fontsize)
			if size.width >= width then
				splitPos = pos-letterLen-1
				break
			end
		end
	end
	return string.sub(str,1,splitPos),string.sub(str,splitPos+1,strLength)
end

function util.getLetterLenByPos(str,pos)
	local sbyte = string.byte(str, pos)
	return util.getLetterLen(sbyte)
end

--获取utf8的字的字节数
local byteArr = {0x00,0x7F,0xDF,0xEF,0xF7,0xFB}
function util.getLetterLen(sbyte)
	for i=#byteArr,2,-1 do
		if sbyte > byteArr[i] then
			return i
		end
	end
	return 1
end

--[[--
	过滤掉html各种不能显示的标记
		html文本:
		<span style=\"font-family:宋体;color:white\">战斗力排名&nbsp;<span style=\"font-famile:宋体;color:#FF9F00\">第</span><span style=\"color:#FF9F00\">1</span><span style=\"font-family:宋体;color:white\">的玩家</span><a id=\"role_102006\" style=\"font-family:宋体;color:#a335ee\">南宫绿丝</a><span style=\"font-family:宋体;color:white\">上线了！</span>"
		转换后:
		<font color=white>战斗力排名 <font color=#FF9F00>第</font><font color=#FF9F00>1</font><font color=white>的玩家</font><font color=#a335ee>南宫绿丝<font color=white>上线了！</font>
	@return: string格式
]]
function util.filterHtmlStyle(msg)
	local styleColor= GameConst.Q_COLORS_STRING
	local pattern = nil
	for i=1,#styleColor do
		pattern = "class=\"quality"..i
		msg = string.gsub(msg, pattern, 'color:'..styleColor[i])
	end

	msg = string.gsub(msg,'</font>','')
	msg = string.gsub(msg,'%&%a*%;',' ')
	msg = string.gsub(msg,'</font>','</span>')
	msg = string.gsub(msg,'</a>','</span>')
	msg = string.gsub(msg,'color: rgb','')
	msg = string.gsub(msg,'color:','>font@ color=')
	msg = string.gsub(msg,'</span>','@font')
	msg = string.gsub(msg,'%b<>','')
	msg = string.gsub(msg,'font@','<font')
	msg = string.gsub(msg,'@font','</font>')
	msg = string.gsub(msg,";%\\\"",'')
	msg = string.gsub(msg,"\">",'>')
	msg = string.gsub(msg,"%;>",'>')
	msg = string.gsub(msg,"\r",'')
--	msg = string.gsub(msg,"\n",'')
	return msg
end


--[[-
	过滤字符串中所有控制符，例如过滤 \r \n 换行控制符..
	@return string
]]
function util.filterHtmlControlCharacter(msg)
	msg = util.filterHtmlStyle(msg)
	return string.gsub(msg,'%c','')
end

--[[
	返回一个正整数各位对应的数字从高开始
	@param num number
	@return table{}
]]
function util.getNumberDigital(num)
	local digitals= {}
	local d = 0

	repeat
		d = num % 10
		table.insert(digitals, 1, d)
		num = math.modf(num/10)
	until num < 1

	return digitals
end

function util.strFormat( src, arg )
    local Des = src
    for k,v in ipairs(arg) do
       Des = string.gsub(Des, LangCfg:get(1)..k, tostring(arg[k]))
    end
    return Des
end

--简单的乱序
function util.getRandomNumArray(arr,num)
	local rArr = {}
	table.merge(rArr,arr)
	local l = #rArr
	for i=1,num do
		local r = math.random(i,l)
		rArr[i],rArr[r] = rArr[r],rArr[i]
	end
	rArr[num+1] = nil
	return rArr
end

function util.formatNumber(num)
	if num < 1000 then
		return tostring(num)
	end
	local str = string.format("%03d", num%1000)
	num = math.floor(num/1000)
	while num >= 1000 do
		str =  string.format("%03d", num%1000) .. "," .. str
		num = math.floor(num/1000)
	end
	str = num ..","..str
	return str
end

function util.toFloatString(value)
	return string.format("%f",value)
end

function util.numberToWord(num)
	local nums = {"一","二","三","四","五","六","七","八","九","十",[0]="零"}
	local n1s = nums[num%10]
	local n10 = math.floor(num/10)
	n10 = n10%10
	local n10s = ""
	if n10 > 1 then
		n10s = nums[n10]
	elseif n10 == 1 then
		n10s = "十"
	end
	return n10s .. n1s
end

function util.getRichNumberText(params)
	local num = params.num
	local fmt = params.fmt
	if num <= 0 then num = 0 end

	local str = ""
	repeat
		local d  = num % 10
		num = math.floor(num / 10)
		str = string.format(fmt, d)..str
	until num <= 0
	return str
end
--[[
function util.formatPercent(value, base)
	local unit = base or 100

	return string.format("%.2f%%", value*100/base)
end
--]]
function util.formatPercent(value, base)
--	print("function util.formatPercent(value, base)", value, base)
	local unit = base or 100
	if base == 100 then
		return value .. "%"
	end
	if base == 10000 then
		local str = math.floor(value/100)
		local p = math.floor(value) % 100
		if p > 0 then
			str = str .. "." string.format("%02d", p)
		end
		return str
	end
	return string.format("%.2f%%", value*100/base)
end


function util.strtime(t)
	return os.date("%Y-%m-%d %H:%M:%S", t)
end

--获取字符串CCSize
function util.getTextSize(str,fontSize)
	fontSize = fontSize or ui.DEFAULT_TTF_FONT_SIZE
	return XUtil:getTextSize(str,fontSize,ui.DEFAULT_TTF_FONT)
end

return util
