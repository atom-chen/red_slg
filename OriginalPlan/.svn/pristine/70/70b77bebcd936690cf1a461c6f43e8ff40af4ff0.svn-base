--
-- Author: wdx
-- Date: 2014-06-14 11:04:38
--

local DungeonCfg = class("DungeonCfg")

-- DungeonCfg.STAR_TO_DATA = { [10] = 1 ,[20] = 11 ,[30] = 111}
DungeonCfg.DATA_TO_STAR = { [-1] = 0, [0] = 0, [1] = 1 ,[11] = 2 ,[111] = 3}

function DungeonCfg:ctor(  )
	self.NORMAL_DUNGEON = -1
	self.UNKNOWN_DUNGEON = 0
	self.COMMON_DUNGEON = 1
	self.ELITE_DUNGEON = 2
	self.DAILY_DUNGEON = 3
	self.COORPERATION_DUNGEON = 4 --组队副本
	self.GUILD_DUNGEON = 5  --军团副本
	self.DEKARON_DUNGEON = 8  --王牌挑战副本
end

function DungeonCfg:init(  )
	--初始化配置
	self._dungeonCfg = ConfigMgr:requestConfig("dungeon",nil,true)
	--self._chapterCfg = ConfigMgr:requestConfig("chapter",nil,true)  --章节配置表
	self._starRequestCfg = ConfigMgr:requestConfig('dungeon_star_request', nil, true)
	self._fightTypeCfg = ConfigMgr:requestConfig('dungeon_fight_type', nil, true)
	self._dungeonTimeCfg = ConfigMgr:requestConfig("dungeon_time",nil,true)  --副本 重置次数消耗表
	self._starRewardCfg = ConfigMgr:requestConfig("dungeon_star",nil,true)
	self._eliteCostCfg = ConfigMgr:requestConfig("dungeon_elite_cost",nil,true)

	self._dungeonRefreshMonsterCfg = ConfigMgr:requestConfig("dungeon_refresh_monster",nil,true)

	self._dungeonRefreshMonsterCfg[-100] = {sceneId = 12}
end

function DungeonCfg:getRefreshMonster(id)
	return self._dungeonRefreshMonsterCfg[id]
end

function DungeonCfg:getDungeonFightValue(id)
	local cfg = self:getDungeon(id)
	return cfg.leaderScore or 100000
end

function DungeonCfg:getDungeonTotalPopulace(id)
	local cfg = self:getDungeon(id)
	local refreshCfg = self:getRefreshMonster(cfg.monsterProduct)
	if refreshCfg then
		return FightCfg:getRefreshTotalPop(refreshCfg)
	else
		return 50
	end
end

function DungeonCfg:getDungeonStartId(dType)
	return dType*10000
end

function DungeonCfg:getNextDungeonId(dId)
	local dInfo = self:getDungeon(dId)
	if dInfo and dInfo.next then
		return dInfo.next[1]
	end
end

-- 根据副本id获取副本类型
function DungeonCfg:getDungeonType( dId )
	local dNumLen = string.len(dId)
	local dIdHeight = math.modf( dId / math.pow(10, dNumLen - 1) )
	if dIdHeight == 1 then
		return self.COMMON_DUNGEON
	elseif dIdHeight == 2 then
		return self.ELITE_DUNGEON
	elseif dIdHeight == 3 then
		return self.DAILY_DUNGEON
	elseif dIdHeight == 4 then
		return self.COORPERATION_DUNGEON
	elseif dIdHeight == 5 then
		return self.GUILD_DUNGEON
	elseif dIdHeight == 8 then
		return self.DEKARON_DUNGEON
	else
		return self.UNKNOWN_DUNGEON
	end
end

--获取某个副本信息
function DungeonCfg:getDungeon( id )
	local dInfo = self._dungeonCfg[id]
	if dInfo then
		dInfo.id = id
	end
	return dInfo
end

--获取某个章节信息
function DungeonCfg:getChapter( id )
	return self._chapterCfg[id]
end

--根据副本获取章节id
function DungeonCfg:getChapterByDungeonId(dId)
	local dInfo = self._dungeonCfg[dId]
	if dInfo then
		return dInfo.chapter
	end
	return nil
end

--根据章节id获取第一个副本id
function DungeonCfg:getDungeonByChapter(cId,dungeonType)
	local cInfo = self._chapterCfg[cId]
	if cInfo then
		return cInfo.dungeons[1]
	end
	return nil
end

--根据id及副本类型取得副本列表
function DungeonCfg:getDungeonList(id,dungeonType)
	local cInfo = self._chapterCfg[id]
	local dungeonList
	if cInfo then
		if dungeonType and dungeonType == self.ELITE_DUNGEON then
			dungeonList = cInfo.elites
		else
			dungeonList = cInfo.dungeons
		end
	end
	return dungeonList
end

--获取副本通关条件描述
function DungeonCfg:getFightTypeCfg( flightTypeId)
	return self._fightTypeCfg[flightTypeId]
end

--获取副本星星获取条件描述
function DungeonCfg:getStarRequestCfg( starRequestId )
	-- body
	return self._starRequestCfg[starRequestId]
end

function DungeonCfg:getChapterListByType( dungeonType )
	-- body
	print('getChapterListByType ..' .. dungeonType)
	local dungeonTypeTable = {
		[self.COMMON_DUNGEON] = {min =100, max =199},
		[self.ELITE_DUNGEON] = {min =200, max =299},
		[self.COORPERATION_DUNGEON] = {min =400, max =499},
		[self.DAILY_DUNGEON] = {min=300, max = 399},
		[self.GUILD_DUNGEON] = {min =500,max=599},
		[self.DEKARON_DUNGEON] = {min =800,max=899}
	}
	if nil == dungeonTypeTable[dungeonType] then
		return {}
	end
	local minChapterId = dungeonTypeTable[dungeonType].min
	print('minChapterId ..' .. minChapterId)
	local maxChapterId = dungeonTypeTable[dungeonType].max
	print('maxChapterId ..' .. maxChapterId)

	local chapterList = {}
	for i,v in pairs(self._chapterCfg) do
		-- print('i ..' .. i)
		if i <= maxChapterId and i >= minChapterId then
			-- print('i <= maxChapterId and i >= minChapterId ..' .. i)
			chapterList[#chapterList + 1] = i
		end
	end
	table.sort( chapterList )
	return chapterList
end


--清除cd需要多少元宝
function DungeonCfg:getResetGold(time)
	if self._dungeonTimeCfg[time] then
		return self._dungeonTimeCfg[time].resetGold
	else
		for i=time-1,1,-1 do
			if self._dungeonTimeCfg[time] then
				return self._dungeonTimeCfg[time].resetGold
			end
		end
	end
end

function DungeonCfg:getDungeonFightTime(dId)
	local dInfo = self:getDungeon(dId)
	return dInfo.fightTime
end

--清除cd需要多少元宝
function DungeonCfg:isBoss(dId)
	local dInfo = self:getDungeon(dId)
	if dInfo.isBoss == 1 then
		return true
	end
	return false
end


function DungeonCfg:getStarReward(cId ,index , dungeonType)
	local cfgInfo

	for i,v in pairs(self._starRewardCfg) do
		if v.chapter_id == cId % 100 and v.dungeonType == dungeonType then
			cfgInfo = v
		end
	end

	if not cfgInfo then
		return
	end
	print("DungeonCfg:getStarReward(cId , index )...",cId , index,cfgInfo.chapter_id)

	local itemList = {}
	local money = {}
	for i,v in pairs( cfgInfo["itemList"..index]) do
		table.insert(itemList,v)
	end

	if cfgInfo["Gold_reward"..index] and cfgInfo["Gold_reward"..index] >0 then
		money[1] = {gold = cfgInfo["Gold_reward"..index]}
	end
	if cfgInfo["Coins_reward"..index] and cfgInfo["Coins_reward"..index] >0 then
		money[2] = {coin = cfgInfo["Coins_reward"..index]}
	end

	return money, itemList
end

function DungeonCfg:getNeedStar(cId)
	local cfgInfo
	for i,v in pairs(self._starRewardCfg) do
		if v.chapter_id == cId % 100 and v.dungeonType == math.floor(cId / 100) then
			cfgInfo = v
		end
	end

	if not cfgInfo then
		return
	end

	local totalStar = 0
	local needStar = {}
	totalStar = cfgInfo.stars
	needStar[1] = cfgInfo.drawType1
	needStar[2] = cfgInfo.drawType2
	needStar[3] = cfgInfo.drawType3

	return totalStar,needStar
end

function DungeonCfg:getEliteCost( time )
	if time > #self._eliteCostCfg then
		return self._eliteCostCfg[#self._eliteCostCfg].costGold
	else
		return self._eliteCostCfg[time].costGold
	end
end

function DungeonCfg:getDungeonTarget( id )
	local dInfo = self:getDungeon( id )
	while dInfo do
		if dInfo.story_target then
			local currProcess, needProcess = self:getTargetProcess( dInfo.target_begin, dInfo.id, id )
			if not currProcess then
				return nil
			end
			local targetInfo = {
				targetName = dInfo.story_target,
				beginId = dInfo.target_begin,
				targetId = dInfo.id,
				currPorcess = currProcess,
				needProcess = needProcess,
			}
			return targetInfo
		end
		if not dInfo.next then
			break
		end
		dInfo = self:getDungeon( dInfo.next[1] )
	end
end

function DungeonCfg:getTargetProcess( beginId, targetId, currId )
	local needProcess = 1
	local currProcess = 0
	local dbeginInfo = self:getDungeon( beginId )
	if not dbeginInfo then
		return nil
	end
	while dbeginInfo.id ~= currId do
		currProcess = currProcess + 1
		dbeginInfo = self:getDungeon( dbeginInfo.next[1] )
		needProcess = needProcess + 1
	end
	while dbeginInfo.id ~= targetId do
		dbeginInfo = self:getDungeon( dbeginInfo.next[1] )
		needProcess = needProcess + 1
	end
	return currProcess, needProcess

end

return DungeonCfg.new()
