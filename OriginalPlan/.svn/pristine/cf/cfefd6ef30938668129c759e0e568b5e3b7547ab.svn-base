--
-- Author: wdx
-- Date: 2014-04-15 14:52:16
--
local SkillCfg = class("SkillCfg")

function SkillCfg:init()
  	self._cfgObj = ConfigMgr:requestConfig("skill",nil,true)
	-- self._skillBuy = ConfigMgr:requestConfig("skill_buy",nil,true)

  	self.PLAYER_SKILL = 1000    --从1000到1100  是玩家技能
	self._tagIcons = {
	[1] = '#hero_wu.png',
	[2] = '#hero_fa.png',
	[3] = '#hero_liao.png',
	[4] = '#hero_fu.png',
	[5] = '#hero_bei.png',
	}
end

--[[--

]]
function SkillCfg:getSkill(id)
  	return self._cfgObj[id]
end

function SkillCfg:getAllSkillCfg()
    return self._cfgObj
end

function SkillCfg:isPlayerSkill( id )
	if self.PLAYER_SKILL <= id and id <= self.PLAYER_SKILL + 200 then
		return true
	else
		return false
	end
end

-- function SkillCfg:getBuyNeed(times)
-- 	if not self._skillBuy[times] then
-- 		return 1000
-- 	end
-- 	return self._skillBuy[times].gold
-- end

function SkillCfg:getIcon(skillId)
	local cfg = self:getSkill(skillId)
	return ResCfg:getRes(cfg.icon, ".w")
end

function SkillCfg:getIconByResId(id)
	return ResCfg:getRes(id, ".w")
end

function SkillCfg:getTagIcon(tag)
	if tag then
		return self._tagIcons[tag]
	else
		return nil
	end
end

function SkillCfg:calSkillId(skills,skillTurn,trunIndex)
	if not skillTurn then
		return nil
	end
	local skillIndex
	local isOrderSkill = false
	if self.nextSkillIndex then
		skillIndex = self.nextSkillIndex
		self.nextSkillIndex = nil
		isOrderSkill = true
	else
		local useList = skillTurn
		if trunIndex > #useList then
			trunIndex = 1
		end
		skillIndex = useList[trunIndex]
		trunIndex = trunIndex +1
	end

	local skillId = skills[skillIndex]
	return skillId
end
return SkillCfg.new()