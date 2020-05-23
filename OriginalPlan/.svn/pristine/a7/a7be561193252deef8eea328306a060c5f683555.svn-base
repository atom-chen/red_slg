local pairs = pairs
local ipairs = ipairs
local table = table
--基于格子 规则圆形的范围
local CircleRange = class("CircleRange")
game_require("math.MathUtil")

function CircleRange:ctor( list )
	self.centerPos = {mx = 0,my =0}
	self.radius = 0
	self:init(list)
	-- body
end

function CircleRange:init(list)
	if not list then
		return
	end
	if #list < 3 then
		return
	else
		self.centerPos.mx = list[1]
		self.centerPos.my = list[2]
		self.radius= list[3][1]
	end
end

--判定目标是否在 源对象 的这个范围内
function CircleRange:isTargetIn(target)
	local tPosLength = target.posLength
	local targetX,targetY
	targetX,targetY = target.mx,target.my
	if tPosLength > 1 then
		if self:_isInList(targetX,targetY,tPosLength) then
			return true
		end
		return false
	else
		return self:_isIn(targetX,targetY)
	end
end

function CircleRange:_isInList(targetX,targetY,tPosLength)
	tPosLength = tPosLength or 1
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

function CircleRange:_isIn(targetX,targetY)
	local dis = MathUtil.Distance(self.centerPos.mx,self.centerPos.my,targetX,targetY)

	if dis <= self.radius then  --在范围内
		return true
	end
	return false
end

return CircleRange