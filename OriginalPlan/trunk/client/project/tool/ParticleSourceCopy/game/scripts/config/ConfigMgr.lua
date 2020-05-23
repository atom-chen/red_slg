--[[--
module：    ConfigMgr
desc：        各个系统的配置管理器
author:  HAN Biao
event：
	无
example：
	ConfigMgr:requestConfig("role.json",RoleCfg._parseConfig)

	function RoleCfg._parseConfig(cfgObj)
		RoleCfg._cfgObj = cfgObj
	end
]]
local ConfigMgrCls = class("ConfigMgrCls")



RoleCfg = require("config.role.RoleCfg")

FightCfg = require("config.fight.FightCfg")

HeroCfg = require("config.hero.HeroCfg")
SkillCfg = require("config.skill.SkillCfg")
ParticleEftCfg = require("config.particle.ParticleEftCfg")
DungeonCfg = require("config.dungeon.DungeonCfg")
ItemCfg = require("config.item.ItemCfg")
ItemInfo = require("config.item.ItemInfo")


function ConfigMgrCls:ctor( )
	self._configMap = {}
end

function ConfigMgrCls:init()
	HeroCfg:init()
	SkillCfg:init()
	FightCfg:init()
	ParticleEftCfg:init()

	DungeonCfg:init()
	ItemCfg:init()
end

function ConfigMgrCls:requestConfig(name,handler,isRemoveCfg)
  local fileName = "config/"..name
	local cfgObj = self._configMap[fileName]
	if not cfgObj then
	   	local filePath = CCFileUtils:sharedFileUtils():fullPathForFilename(fileName)
    --    local str = util.readfile(filePath)
       -- cfgObj = json.decode(str,true)
       	cfgObj = require(filePath)
       	if not isRemoveCfg then
			self._configMap[fileName] = cfgObj
		end
	elseif isRemoveCfg then
		self:removeConfig(name)
	end
	if handler then
		handler(cfgObj)
	end
	return cfgObj
end

function ConfigMgrCls:removeConfig(name)
    self._configMap["config/"..name] = nil
end

local ConfigMgr = ConfigMgrCls.new()
return ConfigMgr