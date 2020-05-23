--
-- Author: wdx
-- Date: 2014-07-02 14:59:12
--
local SkillInfo = {}--class("SkillInfo")

function SkillInfo.new(skillId)
	local instance = {}
	for k,v in pairs(SkillInfo) do
		instance[k] = v
	end
	table.encrypt(instance) --加密
	instance:ctor(skillId)
	return instance
end

function SkillInfo:ctor( skillId )
	self.skillId = skillId
	self.cfg = SkillCfg:getSkill(skillId)
	self:setLevel(1)

	-- if DEBUG == 2 then  --加密 已经用了元表了
	-- 	setmetatable(self, {__index=self._debugGet})
	-- end
end

function SkillInfo._debugGet(t, k)
	v = rawget(t, k)
	if not v then
		if k ~= "skillId" then
			print("error SkillInfo's", k, " is nil, skillId:", t.skillId)
		else
			print("error SkillInfo's", k, " is nil")
		end
	end
	return v
end

function SkillInfo:getRoleAttrInfo()
	--return self.cfg.
end

function SkillInfo:getIcon()
	return SkillCfg:getIcon(self.skillId)
end

function SkillInfo:getTagIcon()
	return SkillCfg:getTagIcon(self.cfg.tag)
end

--不同等级  会有不同参数 攻击  防御变化
function SkillInfo:setLevel( level )
	self.level = level
	self.hitLevel = level   --命中等级  == 技能等级
end

function SkillInfo:getWeaponValue()
	local val = self.cfg.LVadd
	return val*self.level, val
end


return SkillInfo
