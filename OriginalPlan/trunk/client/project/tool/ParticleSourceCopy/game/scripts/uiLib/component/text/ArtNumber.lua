--[[

	class：ArtNumber
	inherit: CCSpriteBatchNode
	desc：美术数字组件
	author:  zl
	example:
		local artNum = ArtNumber.new("number_c")
		artNum:setNumber(102233444556789)
		self:addChild(artNum)

]]

local ArtNumber = class("ArtNumber", function()
		return display.newBatchNode("ui/number.png")
	end)

--[[

]]
function ArtNumber:ctor(namePrefix, num, spanWide)
	self:retain()

	self._namePrefix = namePrefix
	self._number = num or 0
	self._spanWide = spanWide or 0

	self:setNumber(self._number)
end

function ArtNumber:_update(digitals)
	local width = 0
	local height = 0
	local sprite = nil
	for k, digital in ipairs(digitals) do
		sprite = display.newSprite(self:_getNumberFileName(digital), width, 0)
		sprite:setAnchorPoint(ccp(0, 0))
		local spSize = sprite:getContentSize()
		width = width + spSize.width + self._spanWide
		height = (height >= spSize.height and height) or spSize.height
		self:addChild(sprite)
	end

	self:setContentSize(CCSize(width, height))
end

--[[
	设置需要生成美术数字的正数
	@param mubmer
]]
function ArtNumber:setNumber(num)
	self:removeAllChildren()
	self._number = num

	local digitals = Util.getNumberDigital(self._number)
	self:_update(digitals)
end

--[[
	设置需要生成美术的字符串    支持number_b  的  (  )  /
	@param string
]]
function ArtNumber:setString(str)
	self:removeAllChildren()
	self._str = str

	local convert = {["("]="left",[")"]="right",["/"]="slash",["v"]="vip",["c"]="charge"}
	local digitals = {}
	for i=1,#str do
		local ch = string.sub(str,i,i)
		if(convert[ch])then
			ch = convert[ch]
		end
		table.insert(digitals,ch)
	end
	self:_update(digitals)
end

--[[
	返回当前显示的数字值
	@return number nil 表示没有设置数字
]]
function ArtNumber:getNumber()
	return self._number
end

function ArtNumber:_getNumberFileName(digital)
	return "#"..self._namePrefix..digital..".png"
end

--[[
	销毁
]]
function ArtNumber:dispose()
	self:cleanup()
	self:removeFromParentAndCleanup(true)

	self._namePrefix = nil

	self._number = nil

	self:release()
end

return ArtNumber