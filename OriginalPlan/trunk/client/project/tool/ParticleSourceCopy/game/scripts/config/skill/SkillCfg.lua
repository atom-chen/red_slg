--
-- Author: wdx
-- Date: 2014-04-15 14:52:16
--
local SkillCfgCls = class("SkillCfgCls")
local SkillCfg = SkillCfgCls.new()

function SkillCfgCls:init()
  	self._cfgObj = ConfigMgr:requestConfig("skill",nil,true)
end

--[[--
    
]]
function SkillCfgCls:getSkill(id)
  	return self._cfgObj[id]
end




return SkillCfg