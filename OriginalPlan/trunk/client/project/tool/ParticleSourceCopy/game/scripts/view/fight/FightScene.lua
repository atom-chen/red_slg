--
-- Author:wdx
-- Date: 2014-04-15 21:39:41
--

isShowTile = true

FightMap = require("view.fight.map.FightMap")
Creature = require("view.fight.creature.Creature")

Tile = require("view.fight.map.Tile")
Range = require("view.fight.map.Range")

local FightScene = class("FightScene",function() return display.newLayer() end)

function FightScene:ctor()
	self.creatureList = {}
	
	self.elemList = {}

	self.bg = display.newSprite()
	self:addChild(self.bg)

	self.elemLayer = display.newNode()
	self:addChild(self.elemLayer)
	self:setAnchorPoint(ccp(0,0))
end


function FightScene:initBg(res)
	self.bg:setSpriteImage(res)
	self.bg:setPosition(self.width/2,self.height/2)
end

function FightScene:initMap(id)
	self.map = FightMap.new()
	self.map:initMap(id)

	self.width,self.height = self.map:getSize()

	if isShowTile then
		--self.map:setPosition(0,0)
		self.elemLayer:addChild(self.map)
	end

	self.elemLayer:setContentSize(CCSize(self.width,self.height))

	--self.elemLayer:setPosition(FightMap.TILE_W/2 ,FightMap.TILE_H/2*(FightMap.H + 1) )
end

--[[--
初始化场景   背景  双方玩家
]]
function FightScene:initScene(id)
	-- local mapInfo = MapCfg:getMap(id)
	self:initMap(id)
	local bgRes = "ui/fightBg.jpg"
	self:initBg(bgRes)
	

	--print(self.width,self.height)
	self:setContentSize(CCSize(self.width,self.height))

	self:setPosition(-(self.width - display.width)/2,0)
end

function FightScene:initCreature(info)
	self.team1 = {}
	for i,cInfo in ipairs(info["team1"]) do
		if cInfo and cInfo ~= 0 then
			local creature = self:_newCreature(cInfo)
			self:setCreatureAt(creature,cInfo.mx,cInfo.my)
			self.team1[#self.team1 + 1] = creature
		end
	end

	self.team2 = {}
	for i,cInfo in ipairs(info["team2"]) do
		if cInfo and cInfo ~= 0 then
			local creature = self:_newCreature(cInfo)
			self:setCreatureAt(creature,cInfo.mx,cInfo.my)
			self.team2[#self.team2  + 1] = creature
		end
	end
end

function FightScene:setCreatureAt(creature,mx,my)
	creature.mx = mx
	creature.my = my 
	local x,y = self.map:getTilePos(mx,my)
	creature:setPosition(x,y)

	self.map:setTileContent(creature.mx,creature.my,creature.id)
	print("坐标:"..x..","..y,mx,my,"id"..creature.id,"length:")

end

function FightScene:getCreatureList()
	return self.creatureList
end

function FightScene:getCreature(id)
	return self.creatureList[id]
end

function FightScene:addElem( elem )
	elem:retain()
	self.elemList[#self.elemList + 1] = elem
	self.elemLayer:addChild(elem,#self.elemList)
end

function FightScene:removeElem( elem )
	local index = table.indexOf(self.elemList, elem)
	if index ~= -1 then
		table.remove(self.elemList,index)
	end
	elem:removeFromParent()
	elem:release()
end

--获取敌方  队伍
function FightScene:getEnemyList(creature)
	if table.indexOf(self.team1,creature) == -1 then
		--print("team1")
		return self.team1
	else
		--print("team2")
		return self.team2
	end
end

--获取同队  队伍
function FightScene:getMateList(creature)
	if table.indexOf(self.team1,creature) == -1 then
		return self.team2
	else
		return self.team1
	end
end

function FightScene:run(dt)
	self:sortElem()
end

--y轴排序
function FightScene:sortElem()
	for i = 1 , #self.elemList do
		local maxY = self.elemList[i]:getPositionY()
		local index = i
		for j = i+1,#self.elemList do
			local y = self.elemList[j]:getPositionY()
			if y > maxY then
				index = j 
				maxY = y
			end
		end
		if index ~= i then
			--print("sort",j,i,maxY,y)
			local temp = self.elemList[i]
			self.elemList[i] = self.elemList[index]
			self.elemList[index] = temp
			self.elemLayer:reorderChild(temp,index)
			self.elemLayer:reorderChild(self.elemList[i],i)
		end
	end
end

function FightScene:_newCreature(info)
	local creature = Creature.new(info)
	self.creatureList[info.id] = creature
	self:addElem(creature)
	return creature
end

function FightScene:clearElem()
	for i,elem in ipairs(self.elemList) do
		elem:removeFromParent()
		if elem.dispose then
			elem:dispose()
		end
		elem:release()
	end
	self.elemList = {}

	self.creatureList = {}
	-- body
end

return FightScene

