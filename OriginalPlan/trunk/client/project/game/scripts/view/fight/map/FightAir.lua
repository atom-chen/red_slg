local FightAir = class("FightAir")


function FightAir:ctor()

end

function FightAir:init()
	self.airData = {}
end

function FightAir:updateCreaturePos(creature)
	local mx,my = FightDirector:getMap():getPreciseTilePos(creature)
	local x ,y = FightDirector:getMap():getElemMapXY(creature)
	-- print("模型   ",x,y,creature:getPosition(),FightDirector:getMap():toMapPos(x,y))
	if mx ~= creature.mx or my ~= creature.my then
		creature.mx = mx
		creature.my = my
		return true
	end
end

function FightAir:creatureMoveTo( creature,mx,my)
	if self:isCreatureTile(creature) then
		self:removeTileContent(creature)
	end
	creature.tMx,creature.tMy = mx,my
	self:setTileContentByCreature(creature,creature.id)
end

function FightAir:canStand(mx,my,creature)
	local content = self:getTileContent(mx,my)
	return not content or content == creature.id
end

function FightAir:isCreatureTile(creature)
	return self:getTileContent(creature.tMx,creature.tMy) == creature.id
end

function FightAir:getTileContent(mx,my)
	return self.airData[1000*mx+my]
end

function FightAir:setTileContent(mx,my,content,posLength)
	if posLength > 1 then
		self:setTileSquareContent(mx,my,content,posLength)
	else
		self.airData[1000*mx+my] = content
	end
end

function FightAir:setTileSquareContent(mx,my,content,posLength)
	for i=0,posLength-1 do
		local tx = mx + i
		for j=0,posLength-1 do
			local ty = my + j
			self.airData[1000*tx+ty] = content
		end
	end
end

function FightAir:setTileContentByCreature(creature,content)
	self:setTileContent(creature.tMx,creature.tMy,content ,creature.posLength)
end

function FightAir:removeTileContent(creature)
	if self:isCreatureTile(creature) then
		self:setTileContentByCreature(creature,nil)
	end
end

function FightAir:getCreatureRoundGap(creature,target)
	-- print(" 多少 啊啊 ",creature.posLength,creature.mx,creature.my,creature.cInfo and creature.cInfo.name)
	local mx,my = creature.mx,creature.my
	if self:canStand(mx,my,target) then
		return mx,my
	elseif creature.posLength > 1 then
		for i=0,creature.posLength-1 do
			local tx = mx + i
			for j=0,creature.posLength-1 do
				local ty = my + j
				if self:canStand(tx,ty,target) then
					return tx,ty
				end
			end
		end
	end
end

function FightAir:reset()
	self.airData = {}
end

function FightAir:clear()
	self.airData = nil
end

return FightAir