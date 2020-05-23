local TagFactory = {}

local TatInfo = game_require("uiLib.component.richText.TagInfo")

TagFactory.tagType = {
	span = "span",
	font = "font",
	img = "img",
	node = "node",
	line = "line",
	block = "block",
	num = "num",
}


TagFactory.glyphCfgList = {
	[TagFactory.tagType.span] = {
		class = game_require("uiLib.component.richText.tag.TagBase")
	}
	,[TagFactory.tagType.font] = {
		class = game_require("uiLib.component.richText.tag.TextTag")
	}
	,[TagFactory.tagType.img] = {
		class = game_require("uiLib.component.richText.tag.ImageTag")
	}
	,[TagFactory.tagType.node] = {
		class = game_require("uiLib.component.richText.tag.NodeTag")
	}
	,[TagFactory.tagType.line] = {
		class = game_require("uiLib.component.richText.tag.LineTag")
	}
	,[TagFactory.tagType.block] = {
		class = game_require("uiLib.component.richText.tag.BlockTag")
	}
	,[TagFactory.tagType.num] = {
		class = game_require("uiLib.component.richText.tag.NumTag")
	},
}

function TagFactory:createTag(info)
	local tagCfg = TagFactory.glyphCfgList[info.tType]
	local tag = tagCfg.class.new(info)
	tag:setText(info.text)
	return tag
end

function TagFactory:createTagInfo(tType)
	return TatInfo.new(tType)
end

function TagFactory:inheritTagInfo(tType,tInfo)
	local newInfo = TagFactory:createTagInfo(tType)
	newInfo:inheritTagInfo(tInfo)
	return newInfo
end

function TagFactory:cloneTagInfo(tType,tInfo)
	local newInfo = TagFactory:createTagInfo(tType)
	newInfo:cloneTagInfo(tInfo)
	return newInfo
end

function TagFactory:createTagByType(tType)
	local info = TagFactory:createTagInfo(tType)
	local tagCfg = TagFactory.glyphCfgList[tType]
	return tagCfg.class.new(info)
end

--解析字符串 返回图元信息列表
function TagFactory:parseString(str,tInfo)
	local tagInfoList = {}
	local strInfoList = TagFactory:_splitStr(str)
	for i,info in ipairs(strInfoList) do
		local tagInfo = TagFactory:inheritTagInfo(info.tagType,tInfo)
		if info.tagParamsStr then
			tagInfo:setInfoByString(info.tagParamsStr)  --文本参数str
			if info.tagType == TagFactory.tagType.block then  --现在只有block支持嵌套
				local childStrInfoList = TagFactory:_splitStr(info.text)
				for i,info in ipairs(childStrInfoList) do
					local tInfo = TagFactory:inheritTagInfo(info.tagType,tagInfo)
					tInfo:setInfoByString(info.tagParamsStr or "")  --文本参数str
					tInfo:setText(info.text)
					tagInfo:addChildTag(tInfo)
				end
				tagInfoList[#tagInfoList+1] = tagInfo
			else
				TagFactory:_parseTextStr(tagInfoList,info.text,tagInfo)
			end
		else
			TagFactory:_parseTextStr(tagInfoList,info.text,tagInfo)
		end
	end
	return tagInfoList
end


function TagFactory:_splitStr(str)
	local strList = {}
	local pos,len = 1,str:len()
	while pos <= len do
		local tagType,typePos,typeEndPos = TagFactory:_getTagType(str,pos)
		if not tagType then
			break
		end
		local endPos = string.find(str,">",typeEndPos)
		if not endPos then
			print("warn:  > pos  not find",tagType)
			break
		end

		local tagEndStart,tagEndPos = string.find(str,string.format("</%s>",tagType),typeEndPos )
		if not tagEndStart or endPos > tagEndStart then
			print("warn:  </> pos  not find",tagType)
			break
		end
		if typePos > pos then
			local strInfo = {text=string.sub(str,pos,typePos-1),tagType=TagFactory.tagType.font}
			strList[#strList+1] = strInfo
		end

		local strInfo = {}
		--<font size=2 color=4>  取出　"size=2 color=4"
		strInfo.tagParamsStr = string.sub(str,typeEndPos+1,endPos-1) --参数str
		strInfo.tagType = tagType  --类型
		strInfo.text = string.sub(str,endPos+1,tagEndStart-1)  --文本
		strList[#strList+1] = strInfo
		pos = tagEndPos+1
	end
	if pos <= len then
		local strInfo = {text=string.sub(str,pos,len),tagType=TagFactory.tagType.font}
		strList[#strList+1] = strInfo
	end
	return strList
end

--从字符串获取tag类型
function TagFactory:_getTagType(str,startPos)
	while true do
		local typePos = string.find(str,"<",startPos)
		if not typePos then
			return nil
		end
		local typeEndPos = string.find(str," ",typePos+1)
		if not typeEndPos then
			return nil
		end
		local tagType = string.sub(str,typePos+1,typeEndPos-1)
		if TagFactory.glyphCfgList[tagType] then  --没定义的类型 忽略掉
			return tagType,typePos,typeEndPos
		else
			startPos = typeEndPos+1
		end
	end
end

--解析普通文本 （可能有\n的情况 需要拆成多个图元)
function TagFactory:_parseTextStr(tInfoList,str,tInfo)
	tType = tType or TagFactory.tagType.font
	local arr = string.splitEx(str,"\n")
	if #arr > 1 then
		for i,str in ipairs(arr) do
			local info
			if str == "" then
				info = TagFactory:createTagInfo(TagFactory.tagType.span)
			else
				info = TagFactory:cloneTagInfo(tType,tInfo)
			end
			if i > 1 then
				info.newLine = true  --换行
			end
			info:setText(arr[i])
			table.insert(tInfoList,info)
		end
	else
		tInfo:setText(str)
		table.insert(tInfoList,tInfo)
	end
end

---------------------------------下面的不用了-------------------------------------------------
--解析字符串 返回图元信息列表
function TagFactory:parseStringEx(str,tInfo)
	local tInfoList ={}
	local letter = string.gmatch(str,"(.-<[^%z]-.</[^%z]->)")
	local totalLengh = str:len()
	local splLengh = 0
	for sv in (letter) do
		splLengh = splLengh + sv:len()
		local spt = string.gmatch(sv,"(<[^%z]-.</[^%z]->)")
		for v in spt do
			if sv:len() >v:len() then
				local text = sv:sub(1, sv:len()-v:len())
				local info = TagFactory:inheritTagInfo(TagFactory.tagType.font,tInfo)
				TagFactory:_parseTextStr(tInfoList,text,info)
			end
			TagFactory:_parseParamStr(tInfoList,v,tInfo)
		end
	end
	if splLengh < totalLengh then
		local text =str:sub(splLengh+1,totalLengh)
		local info = TagFactory:inheritTagInfo(TagFactory.tagType.font,tInfo)
		TagFactory:_parseTextStr(tInfoList,text,info)
	end
	return tInfoList
end

--解析单个<font bb=cc>ddd</font> 格式的字符串
function TagFactory:_parseParamStr(tInfoList,str,tInfo)
	local arr={}
 	for rls in string.gmatch(str,"(<.->)") do
		arr[#arr + 1] = rls
	end
	local text = str:sub(arr[1]:len()+1, str:len()-arr[2]:len())  --获取到"ddd"

	local paramStr = arr[1]  --获取到<font bb=cc>
	-- paramStr = string.gsub(paramStr, "%s+", " ")  --应该不用？
	local typeIndex = string.find(paramStr," ")
	local tType = paramStr:sub(2,typeIndex-1) --获取到类型"font"
	local info = TagFactory:inheritTagInfo(tType,tInfo)
	info:setInfoByString(paramStr:sub(typeIndex+1,paramStr:len()-1))  --去掉 "<font "以及最后的">"
	TagFactory:_parseTextStr(tInfoList,text,info,tType)
end

return TagFactory