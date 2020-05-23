local pairs = pairs
local ipairs = ipairs
local table = table

--基于格子 规则矩形的范围

local RectRange = class("RectRange")
game_require("math.MathUtil")
function RectRange:ctor( list )
	self.leftDown = {mx = 0,my =0}
	self.rightTop = {mx = 0,my =0}
	self:init(list)
	-- body
end

function RectRange:init(list)
	if not list then
		return
	end
	if #list < 4 then
		return
	else
		self.leftDown.mx = list[1]
		self.leftDown.my = list[2]
		self.rightTop.mx = list[3]
		self.rightTop.my = list[4]
	end
end

--判定目标是否在 源对象 的这个范围内
function RectRange:isTargetIn(target)
	local tPosLength = target.posLength
	local targetX,targetY
	targetX,targetY = target.mx,target.my
	if tPosLength > 1 then
		if self:_isInList(source,startPos,endPos,targetX,targetY,tPosLength,direction) then
			return true
		end
		return false
	else
		return self:_isIn(targetX,targetY)
	end
end

function RectRange:_isInList(targetX,targetY,tPosLength)
	for i=0,tPosLength-1 do
		local tx = targetX + i
		for j=0,tPosLength-1 do
			local ty = targetY + j
			if self:_isIn(tx,ty) then
				return true
			end
		end
	end
	return false
end

function RectRange:_isIn(targetX,targetY)
	if targetX >= self.leftDown.mx
		and targetX <= self.rightTop.mx
		and targetY >= self.leftDown.my
		and targetY <= self.rightTop.my then  --在范围内
		return true
	end
	return false
end

return RectRange