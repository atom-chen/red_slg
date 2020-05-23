--
-- Author: wdx
-- Date: 2014-06-14 11:04:38
--

local DungeonCfg = class("DungeonCfg")

function DungeonCfg:ctor(  )
	self._chapterDungeon = {}
end

function DungeonCfg:init(  )
	--初始化配置
	self._dungeonCfg = ConfigMgr:requestConfig("dungeon",nil,true)
	self._chapterCfg = ConfigMgr:requestConfig("chapter",nil,true)
	
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

--获取下一个副本id
function DungeonCfg:getNextDungeonId( id )
	if id == 0 then
		id = 1
	else
		local dInfo = self:getDungeon(id)
		if dInfo then
			return dInfo.next
		else
			return id
		end
	end
end


--获取章节的 副本列表
function DungeonCfg:getChaptherDungeon(id)
	local list = self._chapterDungeon[id]
	if list then
		return list
	else
		list = {}
		local chapter = self:getChapter(id)
		local dId = chapter.min  --开始副本id
		while true do
			local dInfo = self:getDungeon(dId)
			if dInfo == nil then
				break
			end
			list[#list+1] = dInfo
			if dId == chapter.max then  --章节的结束id了
				break
			end
			dId = dInfo.next
		end
		self._chapterDungeon[id] = list
	end
	return list
end


return DungeonCfg.new()