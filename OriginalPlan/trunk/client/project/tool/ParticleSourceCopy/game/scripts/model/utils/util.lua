--[[--
数据层的实用、辅助函数库,后续添加的函数，也都按编号将函数签名添加在此，
方便其他人查看:
1.mhtInstance(pt1,pt2)
2.formatValue(value)
3.formatDate( data )
4.formatTime(seconds)
5.formatDay(seconds)
6.addHtmlStr(htmlStr)
7.splitToLetter(str)
8.split( str ,separator,num)
9.filterHtmlStyle(msg)
10.convSysCharIco(msg)
11.filterHtmlControlCharacter(msg)
12.createHtmlStrInfo()
13.parseHtmlStr(str)
14.getNumberDigital(num)
15.getRemainTime(time)
16.getMonthDay(t)
17.getDay(t)
18.getRemianTimeByString(str)
19.getTableByKeyAsc(info)
20.readfile( path )


]]

local util = {}

--[[--
-- 点与点的曼哈顿距离
--]]
function util.mhtInstance(pt1,pt2)
	local x = math.abs(pt1.x-pt2.x)
	local y = math.abs(pt1.y-pt2.y)
	return x+y
end

--[[
	格式化元宝、铜币等资源的数量显示
]]
function util.formatValue(value)
	local ret = value
	local w = value/10000
	if w >= 10 then
		w = math.floor(w)
		local yi = math.floor(w/10000)
		if yi>9 then
			w = w - yi;
			ret = yi.."亿"
		else
			ret = w.."万"
		end
	end
	return ret
end
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
--[[--
	格式化时间，将秒数转化为 **:**:**
	@param: seconds int
	@param: string "**:**:**"
]]
function util.formatTime(seconds)

	local h = math.floor(seconds / 3600)
	local ret = tostring(h)
	if h  < 10 then
		ret = "0" .. tostring(h)
	end

	seconds = seconds % 3600
	local m = math.floor(seconds / 60)
	local str = tostring(m)
	if m < 10 then
		str = "0" .. str
	end
	ret = ret .. ":" .. str
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
	
	seconds = seconds - d*seconds /(24* 3600)

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

function util.addHtmlStr(htmlStr)
	local hmtlInfos = util.parseHtmlStr(htmlStr)


	lineArr = {str = ""}
end

--[[--
	切割字符串成一个一个的字母的数组
	@param stting str
	@return 字母数组,字母数量，单个字母大小数组，字母总大小
	example：
	 	str="H字母la字"
		util.splitToLetter(str) --{1=H,2=字,3=母,4=l,5=a,6=字},6,{H=0.5,字=1,母=1,l=0.5,a=0.5},4.5
]]
function util.splitToLetter(str)
	local letter={}
	local letterSize={}
	local index = 0
	local conutWith = 0
	if not str then
		return letter ,index , letterSize, conutWith
	end
	local pos = 1
	local length = str:len()
	while pos <= length do
		--todo
		index=index+1
		local sbyte = string.byte(str, pos)
		local l = 1
		local w = 1
		if sbyte > 0xFB then
			l = 6
		elseif sbyte > 0xF7 then
			l = 5
		elseif sbyte > 0xEF then
			l = 4
		elseif sbyte > 0xDF then
			l = 3
		elseif sbyte > 0x7F then
			l = 2
		else
			l = 1
			w = 0.5
		end
		local font = str:sub(pos , pos+l-1)
		letter[index]= font
		letterSize[font] = w
		pos = pos + l
		conutWith = conutWith +w
	end
	return letter ,index , letterSize, conutWith
end
--[[--
	字符串切割
	@param string str 字符串
	@param string separator 切割符
	@param number num  数量
	@return table,number 返回数组和数组长度 {}/{1=str1,2=str2,...},0/n

	example：
	 	str="s1 s2 s3 s4"
		util.split( str ," ")   ---{1=s1,2=s2,3=s3,4=s4},4
		util.split( str ," ",1) ---{1=s1},1
]]
function util.split( str ,separator,num)
	-- body
	if not num then
		--todo
		num = str:len()
	end
	local nFindStartIndex = 1
	local nSplitIndex = 0
	local nSplitArray = {}
	while true do
		if nSplitIndex>=num then break end
   		local nFindLastIndex = string.find(str, separator, nFindStartIndex)
   		nSplitIndex = nSplitIndex + 1
   		if not nFindLastIndex then
    		nSplitArray[nSplitIndex] = string.sub(str, nFindStartIndex, string.len(str))
    		break
   		end
   		nSplitArray[nSplitIndex] = string.sub(str, nFindStartIndex, nFindLastIndex - 1)
   		nFindStartIndex = nFindLastIndex + string.len(separator)
	end
	return nSplitArray,nSplitIndex
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


function util.convSysCharIco(msg)
	msg = string.gsub(msg,"%[签到%]","<font color="..GameConst.Q_COLORS_STRING[5]..">[签到]</font>")
	msg = string.gsub(msg,"/:(%d+)","<img src=#face_s%1.png></img>")
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

util.HMTLSTR_FONT = "font"
util.HTMLSTR_IMAGE = "img"
--[[--
	创建一个html图文格式
	return html table 格式
]]
function util.createHtmlStrInfo()
	local htmlStrInfo = {}
	htmlStrInfo.type = nil
	htmlStrInfo.value = nil
	htmlStrInfo.color = nil
	htmlStrInfo.fontName = nil
	htmlStrInfo.src = nil
	return htmlStrInfo
end

--[[--
	解析一个Hmtl字符串，返回每个分段字符串的值、颜色、字体名字
	"我爱你<font color=rgb(255,0,0) fontName=宋体>中 国 </font>,Hello <img src=ui/face.png></img>rld!"
	返回 {{type="font",value="我爱你""},{type="font",value="中 国 ",color="rgb(255,0,0)",fontName="宋体"},{type="font",value=",Hello "},{type="img",value="ui/face.png"},{value="World"}}
	@return 解析好的字符串信息数组
]]
function util.parseHtmlStr(str)
	--[[
		@param string  labelStr  格式 <x k1=v1 k2=v2 ...>
		@return table  {type=x,k1=v1,k2=v2,...}
	]]
	local  readLabelProperty = function( labelStr )
		local propertyTable = util.createHtmlStrInfo()
		labelStr = string.gsub(labelStr, "%s+", " ")
		labelStr = labelStr:sub(2,labelStr:len()-1)
		labelStr = "type=" .. labelStr
		local propertys  = util.split(labelStr, " ")
		for k,proStr in pairs(propertys) do
			local pros = util.split(proStr,"=",2)
			propertyTable[pros[1]] = pros[2]
		end
		return propertyTable
	end
	--[[
		@param string  htmlStr格式:  <x k1=v1 k2=v2 ...>aaa</x>
		@return table  {type=x,k1=v1,k2=v2,...,value=aaa}
	]]
	local readLabel = function ( lableStr )
		local arr ={}
		local index =1
		for rls in string.gmatch(lableStr,"(<.->)") do
			arr[index] = rls
			index = index + 1
		end
		local value = lableStr:sub(arr[1]:len()+1, lableStr:len()-arr[2]:len())
		local pTable =  readLabelProperty(arr[1])
		pTable["value"] = value
		return pTable
	end
	----

	local arr ={}
	local letter = string.gmatch(str,"(.-<[^%z]-.</[^%z]->)")
	local totalLengh = str:len()
	local splLengh = 0
	local index = 1
	for sv in (letter) do
		splLengh = splLengh + sv:len()
		local spt = string.gmatch(sv,"(<[^%z]-.</[^%z]->)")
		for v in spt do
			if sv:len() >v:len() then
				local htmlStrInfo = util.createHtmlStrInfo()
				htmlStrInfo.value = sv:sub(1, sv:len()-v:len())
				arr[index]=htmlStrInfo
		        index = index + 1
			end
			arr[index]=readLabel(v)
		    index = index + 1
		end
	end
	if splLengh<totalLengh then
		local htmlStrInfo = util.createHtmlStrInfo()
		htmlStrInfo.value = str:sub(splLengh+1,totalLengh)
		arr[index]=htmlStrInfo
	end

	return arr
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
--[[--
local str = "解析一个Hmtl字符串，**~  返回每个分段字符串的值、颜色、字体名字"
local letter , num = util.splitToLetter(str)
print(letter,num)
for k,v in ipairs(letter) do
	print(k,v)
end

local str = "我爱你<font color=rgb(255,0,0) fontName=宋体>中 国 </font>,Hello <img src=ui/face.png></img>rld!"
local letter = util.parseHtmlStr(str)
print((letter))
for k,v in ipairs(letter) do
	--print(k,v)
	print()
	for k1,v1 in pairs(v) do
		print(k1,v1)
	end
end

local htmlStr = "<font color=rgb(255,0,0) fontName=宋体>中 国 </font>"

for v in string.gmatch(htmlStr,"(<.->)") do
	print(v)
end
labelStr = "arr    aa"
labelStr=string.gsub(labelStr, "%s+", " ")
print(labelStr)
local list = util.split(labelStr, " ",1)
print(list)
for k,v in ipairs(list) do
	print(k,v)
end
]]


--[[--
	 * 获取  到  某个时候的  剩余时间     毫秒数
]]
function util.getRemainTime(time)
	local now = NetCenter.getTime();
	local remain = time - now;
	return  remain;
end


--[[
	获取预设时间对应月份的最后一天
	默认为服务器时间
]]
function util.getMonthDay(t)
	t = t or NetCenter.getTime()/1000
	local y = os.date("%Y", t)
	local m = os.date("%m", t)
	local date = {
		year = y,
		month = m+1,
		day  = 1,
		hour = 0,
		min  = 0,
		second = 0
	}

	local time = os.time(date) - 1
	return util.getDay(time)
end

--[[
	获取预设时间在当月天数
	默认为服务器时间
]]

function util.getDay(t)
	t = t or NetCenter.getTime()/1000
	local day = os.date("%d", t)
	return tonumber(day)
end

--[[--*
	 * 获取   2014-3-25 12:32:32  这种格式的    时间    到当前时间 的剩余时间
	 ]]
function util.getRemianTimeByString(str)
	local arr = string.split(str," ");
	local day = string.split(arr[1],"-");
	local time = string.split(arr[2],":");
	local t = os.time{year=tonumber(day[1]), month=tonumber(day[2]), day=tonumber(day[3])
					, hour=tonumber(time[1]),min=tonumber(time[2]),sec=tonumber(time[3])};
	return t - math.floor(NetCenter.getTime()/1000);
end


-- 按照KEY升序排列一下table
-- 暂时支持 string 和 number 的数字key
-- 避免pairs 和 ipairs的排序
-- 原来key会封装到_key字段里面，然后用数字代替。
function util.getTableByKeyAsc(info)
	local result={};
	local oldKeys = table.keys(info);
	local newKeys={};
	function removeAndAddMin( oldTable,newTable )
		if #oldTable>0 then
			local min = oldTable[1]
			local delIndex = 1
			for index,key in ipairs(oldTable) do
				if (tonumber(key) < tonumber(min))then
					min = key
					delIndex = index
				end
			end
			newTable[#newTable+1]=min;
			table.remove(oldTable,delIndex);
			removeAndAddMin(oldTable,newTable);
		end
	end
	local a=removeAndAddMin;
	removeAndAddMin(oldKeys,newKeys);
	for i,v in ipairs(newKeys) do
		info[v]._key=v;
		result[i]=info[v];
	end
	a=nil;
	return result;
end

-- 修改排序方法
function util.tabelSort(info,dataKey,sortType)
	info=clone(info);
	local result={};
	local curIndex=1;
	function removeAndAddMax( oldTable,newTable )
		if #oldTable>0 then
			local delIndex=1;
			local max=oldTable[1];
			for index,data in ipairs(oldTable) do
				-- 初始化min
				-- print("data[dataKey]",data[dataKey])
				-- print("max[dataKey]",max[dataKey])
				if sortType=="desc"	then
					if tonumber(data[dataKey])>tonumber(max[dataKey]) then
						max=data;
						delIndex=index;
					end
				else
					if tonumber(data[dataKey])<tonumber(max[dataKey]) then
						max=data;
						delIndex=index;
					end
				end
			end
			newTable[#newTable+1]=max;
			table.remove(oldTable,delIndex);
			-- print("需要删除",delIndex)
			removeAndAddMax( oldTable,newTable )
		end
	end
	local a=removeAndAddMax;
	removeAndAddMax(info,result);
	return result;
end

function util.readfile( path )
	local content = io.readfile(path)
	if not content then
		path=path:sub(8,path:len())
    	return luacall.readFile(path)
	end
	return content
end
return util