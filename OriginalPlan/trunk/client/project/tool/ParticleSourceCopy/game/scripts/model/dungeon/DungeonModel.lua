--
-- Author: wdx
-- Date: 2014-06-13 14:07:15
--

local DungeonModel = class("DungeonModel")

function DungeonModel:ctor()
	self.NORMAL_DUNGEON = 1  --普通副本
	self.ELITE_DUNGEON = 2  --精英副本
end

function DungeonModel:init()
	self.curId = 0  
	self.curElite = 0
	self.starMap = {}
end

--初始化副本信息
function DungeonModel:initDungeon( curId,eliteId,starList )
	self.curId = DungeonCfg:getNextDungeonId(curId)
	self.curElite = DungeonCfg:getNextDungeonId(eliteId) 
	self:initStar(starList)
	NotifyCenter:dispatchEvent({name=Notify.DUNGEON_INIT})
end

--初始化各个副本星星 评级
function DungeonModel:initStar( starList )
	for i,starInfo in ipairs(starList) do
		local dId = starInfo.dungeonId 
		self.starMap[dId] = starInfo.star
	end
end

--设置普通副本进度
function DungeonModel:setCurDungeon(id)
	self.curId = id
	NotifyCenter:dispatchEvent({name=Notify.DUNGEON_PROGRESS,id = id,dType = self.NORMAL_DUNGEON})
end

--设置精英副本进度
function DungeonModel:setCurElite( id )
	self.curElite = id
	NotifyCenter:dispatchEvent({name=Notify.DUNGEON_PROGRESS,id = id,dType = self.ELITE_DUNGEON})
end

--设置副本星星 评级
function DungeonModel:setStar( dId,star )
	self.starMap[dId] = star
	NotifyCenter:dispatchEvent({name=Notify.DUNGEON_INFO,id = dId})
end

--获取副本状态
function DungeonModel:getDungeonStatus( id )
	if self.starMap[id] then  --已经打过
		return 2
	elseif id == self.curId then  --是当前最大进度
		return 1
	else  --还没开启
		return 0
	end
end


return DungeonModel.new()