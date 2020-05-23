local SysFightHandle = game_require("view.fight.sysHandle.SysFightHandle")
local TestFightHandle = class("TestFightHandle",SysFightHandle)
local TEST_DUNGEON_ID = -2
function TestFightHandle:getSceneId()
	local autoCfg = DungeonCfg:getRefreshMonster(TEST_DUNGEON_ID)
	return autoCfg.sceneId
end

function TestFightHandle:getFightHeroList()
	local attackHeroList = {}
	local defenceHeroList = {}

	if self.refreshMonster.right_list then
		for k,hero in ipairs(self.refreshMonster.right_list) do
			if hero and not hero:isDie() and table.indexOf(HeroCfg.heroCareers,hero.cInfo.career) ~= -1 then
				table.insert(defenceHeroList,hero)
			end
		end
	end
	if self.refreshMonster.left_list then
		for k,hero in ipairs(self.refreshMonster.left_list) do
		if hero and not hero:isDie() and table.indexOf(HeroCfg.heroCareers,hero.cInfo.career) ~= -1 then
			table.insert(attackHeroList,hero)
		end
	end
	end
	return attackHeroList,defenceHeroList
end

function TestFightHandle:getHeroResList()
	local cfgs1 = {}
	local autoCfg = DungeonCfg:getRefreshMonster(TEST_DUNGEON_ID)
	if autoCfg.initMate then
		for k,v in ipairs(autoCfg.initMate) do
			cfg = 	MonsterCfg:getMonster( v[1] )
			if cfg then
				table.insert(cfgs1,cfg)
			end
		end
	end
	local cfgs2 = {}
	if autoCfg.initMonster then
		for k,v in ipairs(autoCfg.initMonster) do
			cfg = 	MonsterCfg:getMonster( v[1] )
			if cfg then
				table.insert(cfgs2,cfg)
			end
		end
	end
	return cfgs1,cfgs2
end

function TestFightHandle:reqFightBegin(callback)
	callback(true)
end

function TestFightHandle:fightBegin()
	if not FightDirector:isNetFight() then
		self:startRefreshMonsterDelegate(TEST_DUNGEON_ID)  --10111

		self:startCheckFightEndDelegate({winList={2},failList={1,4}})
	end
end

function TestFightHandle:fightEnd(isWin)
	self:_openResultPanel(isWin,{})
end


return TestFightHandle