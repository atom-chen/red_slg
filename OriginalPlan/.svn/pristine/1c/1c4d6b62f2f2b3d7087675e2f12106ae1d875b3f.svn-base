
local ConfigMgr = {}

--加对应的模块直接在里面加就够了
local Config_List = {
	{"ResCfg",                  "config.ResCfg"}
	,{"BiaoQingCfg",			"config.biaoqing.BiaoQingCfg"}
	-- ,{"RandNameCfg",            "config.role.RandNameCfg"}
	,{"FightCfg",                "config.fight.FightCfg"}
	,{"DungeonCfg",              "config.dungeon.DungeonCfg"}
	,{"HeroCfg", 				 "config.hero.HeroCfg"}
	-- ,{"InstCfg", 				 "config.hero.InstCfg"}
	-- ,{"AttrCfg", 				 "config.hero.AttrCfg"}
	,{"LevelHelper", 				 "config.common.LevelHelper"}
	,{"MonsterCfg", 				 "config.monster.MonsterCfg"}
	,{"SkillCfg",                     "config.skill.SkillCfg"}
	,{"WorldCfg",                   "config.world.WorldCfg"}
	,{"WorldMapCfg",                "config.world.WorldMapCfg"}
	,{"BuildingCfg",				"config.building.BuildingCfg"}
	}

local Config_infoList = {
	{"HeroInfo",					"config.hero.HeroInfo"}
	,{"MonsterInfo",				"config.monster.MonsterInfo"}
	,{"SkillInfo",					"config.skill.SkillInfo"}
}
--------------------------------------

for i,cfg in ipairs(Config_List) do
	_G[cfg[1]] = game_require(cfg[2])
end

for i,cfg in ipairs(Config_infoList) do
	_G[cfg[1]] = game_require(cfg[2])
end

function ConfigMgr:init()
	for i,cfg in ipairs(Config_List) do
		local v = _G[cfg[1]]

		if v.init then
			v:init()
		end
	end
end

function ConfigMgr:requestConfig(name)
    local fileName = name
    if REQUIRE_MOUDLE then
    	local filePath = CCFileUtils:sharedFileUtils():fullPathForFilename("config/"..fileName..".lua")
	    if CCFileUtils:sharedFileUtils():isFileExist(filePath) then
	    	fileName = "config/"..fileName
	    else
        	fileName = "config."..fileName
        end
    else
        fileName = "config/"..fileName
        -- fileName = CCFileUtils:sharedFileUtils():fullPathForFilename(fileName)
    end
    return require(fileName)
end

return ConfigMgr
