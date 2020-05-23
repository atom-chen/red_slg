local TagInfo = class("TagInfo")


function TagInfo:ctor(tType)
	self.tType = tType
end

function TagInfo:setText(str)
	self.text = str
end

local numAttr = {"fontSize","w","h"}  --number类型的属性
function TagInfo:setAttr(key,value)
	if table.indexOf(numAttr,key) > 0 then
		self[key] = tonumber(value)
	else
		self[key] = value
	end
end

--根据字符串设置参数 "color=rbg(23,3,4) src=wefadf.png"
function TagInfo:setInfoByString(str)
	local attrList  = string.split(str, " ")
	for k,attrStr in pairs(attrList) do
		local attr = string.split(attrStr,"=",2)
		self:setAttr(attr[1],attr[2])
	end
end


local inheritAttrList = {"color","colorCCC3","fontSize","align","alignV","fontType"}  --有往下传递的属性
function TagInfo:inheritTagInfo(tInfo)
	for i,v in pairs(inheritAttrList) do
		self:setAttr(v,tInfo[v])
	end
end

--完全拷贝
function TagInfo:cloneTagInfo(tInfo)
	for k,v in pairs(tInfo) do
		self:setAttr(k,v)
	end
end

function TagInfo:addChildTag(tagInfo)
	if not self._childList then
		self._childList = {}
	end
	self._childList[#self._childList+1] = tagInfo
end

function TagInfo:getChildTagList()
	return self._childList
end

return TagInfo