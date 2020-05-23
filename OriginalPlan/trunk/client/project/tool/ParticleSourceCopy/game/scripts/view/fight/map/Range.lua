--
-- Author:wdx
-- Date: 2014-05-12 20:30:32
--

--基于格子  的 不规则的范围  

local Range = class("Range")

function Range:ctor( list )
	if list then
		self:init(list)
	end
	-- body
end

function Range:init(list)
	self.w = list[1] 
	self.h = list[2] 
	self.sourcePos = self:getPos(list[3])


	self.exclude = {}
	for i = 4,#list do
		self.exclude[#self.exclude + 1] = self:getPos(list[i])   --排除的格子
	end
	if #self.exclude == 0 then
		self.isWhole = true  --整个w * h 区域
	else
		self.isWhole = false
	end

	--self.isWhole = true
end

function Range:getExtendRange( time )
	local range = Range.new()
	range.w = self.w*time
	range.h = self.h*time
	range.sourcePos = {mx = (self.sourcePos.mx )*time , my = (self.sourcePos.my )*time  }
	range.exclude = {}
	range.isWhole = true
	return range
end


--判定目标是否在 源对象 的这个范围内
function Range:isTargetIn(source,target,isPrecise,direction)
-- do
-- 	return false
-- end
	direction = direction or source:getDirection()
	local startPos,endPos = self:getBorderPos(source,direction)

	--print(source.)
	--print("range",startPos.x,startPos.y,self.w,self.h,target.mx,target.my)
	--print("range",self.w,self.h)
	
	local targetX,targetY
	if isPrecise then   --是否 需要获取精确的格子 坐标
		targetX,targetY = FightDirector:getMap():getPreciseTilePos(target) 
	else
		targetX,targetY = target.mx,target.my
	end

	-- if source.id == 11 and source.mx == 8 and source.my == 5 and isPrecise then
	-- 	print("range",startPos.mx,startPos.my,self.w,self.h,source.mx,source.my,targetX,targetY)
	-- end

	if targetX >= startPos.mx and targetX <= endPos.mx and targetY >= startPos.my and targetY <= endPos.my then  --在范围内
		if self.isWhole then
			return true
		else
			
			for i,pos in ipairs(self.exclude) do
				pos.mx = pos.mx - self.sourcePos.mx
				pos.my = pos.my - self.sourcePos.my
				local newPos = self:_getPosWitchSource(pos,source,direction)

				-- if source.id == 11  then
				-- 	print("range",startPos.mx,startPos.my,newPos.mx,newPos.my,pos.mx,pos.my ,target.mx ,target.my)
				-- end

				if  newPos.mx == targetX and newPos.my  == targetY then
					--print("在排除格子范围内")
					return false --在排除个 格子里面
				end
			end
			return true
		end
	end
	return false
end

function Range:getPos(index)
	return {mx = index%(self.w ), my = math.floor( index/ (self.w))}
end

--返回开始点  和 结束点   就可得一个完整的矩形
function Range:getBorderPos(source,direction)
	local startPos,endPos = {},{}
	local sourcePos = self.sourcePos
	startPos.mx, startPos.my = -sourcePos.mx, -sourcePos.my
	if direction == Creature.RIGHT_DOWN then
		endPos.mx, endPos.my = startPos.mx + self.w - 1, startPos.my + self.h - 1
		startPos.mx, startPos.my = -sourcePos.mx, -sourcePos.my
	elseif direction == Creature.LEFT_DOWN then
		endPos.mx, endPos.my = startPos.mx + self.w - 1, startPos.my
		startPos.mx, startPos.my = startPos.mx, startPos.my + self.h - 1
	elseif direction == Creature.RIGHT_UP then
		endPos.mx, endPos.my = startPos.mx, startPos.my + self.h - 1
		startPos.mx, startPos.my = startPos.mx + self.w - 1, startPos.my
	elseif direction == Creature.LEFT_UP then
		endPos.mx, endPos.my = -sourcePos.mx, -sourcePos.my
		startPos.mx, startPos.my = startPos.mx + self.w - 1, startPos.my + self.h - 1
	end 
	--print("pos1",startPos.mx,startPos.my,endPos.mx,endPos.my)
	startPos = self:_getPosWitchSource(startPos,source,direction)
	endPos = self:_getPosWitchSource(endPos,source, direction)
	--print("pos2",startPos.mx,startPos.my,endPos.mx,endPos.my)
	return startPos,endPos
end

function Range:_getPosWitchSource( pos,source,direction )
	local newPos = self:_getPosWithDirection(pos,direction)
	--print("pos2",pos.mx,pos.my,newPos.mx,newPos.my)
	newPos.mx = newPos.mx + source.mx
	newPos.my = newPos.my + source.my
	return newPos
end

function Range:_getPosWithDirection(pos,direction)
	local newPos = {}
	if direction == Creature.RIGHT_DOWN then
		newPos.mx, newPos.my = pos.mx, pos.my
	elseif direction == Creature.LEFT_DOWN then
		newPos.mx, newPos.my = -pos.my, pos.mx
	elseif direction == Creature.RIGHT_UP then
		newPos.mx, newPos.my = pos.my, -pos.mx
	elseif direction == Creature.LEFT_UP then
		newPos.mx, newPos.my = -pos.mx, -pos.my
	end 
	return newPos
end



return Range