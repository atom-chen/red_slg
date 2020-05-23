--[[

	class：ArtNumber
	inherit: CCSpriteBatchNode
	author:  zl
	example:
		local artNum = ArtNumber.new("number_c")
		artNum:setNumber(102233444556789)
		self:addChild(artNum)

]]

local ArtNumber = class("ArtNumber", function()
		return display.newNode()
	end)


--[[
	useCache一般为false  战斗特殊需要缓存的才为true
]]
function ArtNumber:ctor(namePrefix, num, spanWide,useCache)
	self:retain()

	self._namePrefix = namePrefix --前置
	self._spanWide = spanWide or 0

	self._useCache = useCache
	self._numNodeList = {}

	if num then
		self:setNumber(num)
	end
end

--[[
	设置需要生成美术数字的正数
	@param mubmer
]]
ArtNumber.convert = {
	["%"]="percent",
	["-"]="reduce",
	["+"]="add",
	["/"]="slash",
	["c"]="charge",
	[":"]="dian",
}
function ArtNumber:setNumber(num)
	if self._number == num then
		return
	end
	self._number = num
	if self._useCache then
		for i,numNode in ipairs(self._numNodeList) do
		    ArtNumber._setCacheNum(self._namePrefix,numNode._artNum,numNode)
		end
	end
	self:removeAllChildren()
	self._numNodeList = {}
	if num == nil then
		return
	end

	local str = tostring(num)
	local digitals = {}
	for i=1,#str do
		local ch = string.sub(str,i,i)
		if ArtNumber.convert[ch] then
			ch = ArtNumber.convert[ch]
		end
		table.insert(digitals,ch)
	end

	self:_update(digitals)
end

function ArtNumber:_update(digitals)
	local width = 0
	local height = 0
	local sprite = nil
	for k, digital in ipairs(digitals) do
		sprite = self:_getNumNode(digital,width)
		self._numNodeList[#self._numNodeList+1]=sprite
		sprite:setAnchorPoint(ccp(0, 0.5))
		local spSize = sprite:getContentSize()
		width = width + spSize.width + self._spanWide
		height = (height >= spSize.height and height) or spSize.height
		self:addChild(sprite)
	end

	self:setContentSize(CCSize(width, height))
end

function ArtNumber:clear()
	self:removeAllChildren()
	self._number = nil
end

--[[
	设置需要生成美术的字符串    支持number_b  的  (  )  /
	@param string
]]
function ArtNumber:setString(str)
	self:setNumber(str)
end

function ArtNumber:getNumber()
	return self._number
end

ArtNumber.SPECIAL_RES={
	-- ["V"] = "#vip_tt.png"
}

function ArtNumber:_getNumberFileName(num)
	return ArtNumber.SPECIAL_RES[num] or "#"..self._namePrefix..num..".png"
end

function ArtNumber:_getNumNode( num,x )
	if self._useCache then
		local numNode = ArtNumber._getCacheNum(self._namePrefix,num)
		numNode:setPositionX(x)
		return numNode
	else
		return display.newXSprite(self:_getNumberFileName(num), x, 0)
	end
end

--[[
	销毁
]]
function ArtNumber:dispose()
	self:setNumber(nil)
	self:removeFromParent()

	self._namePrefix = nil

	self._number = nil
	self._numNodeList = nil

	self:release()
end





----------------------------缓存方法---------------------
ArtNumber._cacheList = {}
--公用方法 获取num
ArtNumber._getCacheNum = function( namePrefix,num )
	local prefixList = ArtNumber._cacheList[namePrefix]
	if prefixList and prefixList[num] and #prefixList[num] >0 then
		local numList = prefixList[num]
		local numNode = numList[#numList]
		numList[#numList] = nil
		numNode:setOpacity(255)
		return numNode
	end
	local numNode = display.newXSprite("#"..namePrefix..num..".png")
	numNode._artNum = num
	numNode:retain()
	return numNode
end

--放进缓存里面
ArtNumber._setCacheNum = function( namePrefix,num,artNum )
	local prefixList = ArtNumber._cacheList[namePrefix]
	if not prefixList then
		prefixList = {}
		ArtNumber._cacheList[namePrefix] = prefixList
	end
	if not prefixList[num] then
		prefixList[num] = {}
	end
	prefixList[num][#prefixList[num]+1] = artNum
end

--清除缓存cacheNum
ArtNumber.clearCache = function( )
	for k,numCache in pairs(ArtNumber._cacheList) do
		for num,list in pairs(numCache) do
			for i,artNum in ipairs(list) do
				artNum:release()
			end
		end
	end
	ArtNumber._cacheList = {}
end

return ArtNumber