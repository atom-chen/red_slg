--
-- Author: wdx
-- Date: 2014-04-22 16:49:18
--

local FightCfg = class("FightCfg")

function FightCfg:ctor( ... )

end

function FightCfg:init(  )
	self._magicCfg = ConfigMgr:requestConfig("magic",nil,true)
end

function FightCfg:getSkill(id)
	return SkillCfg:getSkill(id)
end

function FightCfg:getMagic(id)
	return self._magicCfg[id]
end

function FightCfg:getBuffCfg(id)

end

function FightCfg:getAI(id)
	
end

function FightCfg:getKeyFrameCfg(info,keyType)
	if info["keyframe"] then
		for _,fCfg in pairs(info["keyframe"]) do
			if fCfg.keyType == keyType then
				return fCfg
			end
		end
	end
	return nil
end

return FightCfg.new()