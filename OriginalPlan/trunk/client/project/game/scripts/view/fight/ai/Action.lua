--[[--
行为 ai   主要是 攻击  防御  治疗  施法  等
]]
local NewHandle = game_require("view.fight.handle.NewHandle")

local Action = class("Action")

function Action:init( creature)
	self.creature = creature
	self.curTime = 0
	self.lastAttackTime = -creature.cInfo.main_atkCD

	self.attackTime2 = 0

	self._curSkillIndex = 1
	self._minorSkillIndex = 1
end

function Action:getCurSkillIndex()
	return self._curSkillIndex
end

function Action:setTarget( target )
	if self.target then
		self.target:release()
	end
	self.target = target
	if self.target then
		self.target:retain()
	end
end

--攻击 敌人
function Action:attack(force)
	local creature = self.creature
	local target = self.target

	if self.creature.cInfo.id ==TEST_HEROID_ID then
		print("KKKKKKKKKKKKKbbbbbbbbb")
	end
	if target:isDie() then
		return
	end
	if not self.creature:canUseSkill() then
		return
	end
	if self.creature.cInfo.id ==TEST_HEROID_ID then
			print("KKKKKKKKKKKKKccccccccccc")
	end
	if self.curTime - self.lastAttackTime >= creature.cInfo.main_atkCD or force then  --间隔时间到了  直接攻击
		local direction = AIMgr:getDirection(self.creature,target:getPosition())

		if not self.creature:isAtkFaceto(direction) then
			self.creature:turnAtkDirection(direction)
			return true
		end
		if self.creature.cInfo.id ==TEST_HEROID_ID then
			print("KKKKKKKKKKKKKddddddddddddd")
		end
		self.lastAttackTime = self.curTime

		self.count = 0
		local skill = self:_getUseSkill(self.creature.cInfo.skills,self.creature.cInfo.skillTurn,self._curSkillIndex,FightCfg.MAIN_ATTACK,target)   --获取随机技能
		self:startSkill(skill)
		return true,skill
	else
		if self.creature.cInfo.id ==TEST_HEROID_ID then
			print("KKKKKKKKKKKKKeeeeeeeee")
		end
		local direction = AIMgr:getDirection(creature,target:getPosition())
		if not creature:isAtkFaceto(direction) then
			creature:turnAtkDirection(direction)
		end
		return false
	end
end

function Action:startSkill(skill)
end

function Action:run(dt)
	self.curTime = self.curTime + dt

	local atkCD = self.creature.cInfo.minor_atkCD

	if atkCD and atkCD > 0 and FightDirector.status == FightCommon.start and self.creature:canUseSkill() then
		if self.attackTime2 >= atkCD then
			if self:minorAttack(dt) then
				self.attackTime2 = self.attackTime2 - self.creature.cInfo.minor_atkCD
			end
		else
			self.attackTime2 = self.attackTime2 + dt
		end
	end
end

function Action:getSkillCd()
	return self.attackTime2,self.creature.cInfo.minor_atkCD
end
--副武器攻击
function Action:minorAttack(dt)
	if FightDirector:isNetFight() then
		return true
	end
	--print("   名字： ",self.creature.cInfo.name)
	--print("self.creature.cInfo.minor_atkCD",self.creature.cInfo.name,self.creature.cInfo.minor_atkCD)
	local atkRange = self.creature:getAtkRangeByWeapon(FightCfg.MINOR_ATTACK)  --副武器
	if not atkRange then
		if DEBUG == 2 then
			assert(false,"--副武器攻击范围 没配置 : "..self.creature.cInfo.name.."  id"..self.creature.cInfo.id)
		end
		return true
	end
	if (not self.creature.cInfo.skillTurn_1) or (not self.creature.cInfo.skills_1) then
		return true
	end
	local enemyList = {self.target}--self.creature:getTeamList(FightCommon.enemy)
	for i=#enemyList,1,-1 do
		local enemy = enemyList[i]
		--print("--检测到了。。。。",enemy:canBeSearch(self.creature,atkRange.atkScope),enemy.cInfo.scope, atkRange.atkScope)
		if not enemy:isDie() and enemy:canBeSearch(self.creature,atkRange.atkScope)
				and atkRange:isTargetIn(self.creature, enemy, true) then
			self.count = 0
			local skill,index = self:_getUseSkill(self.creature.cInfo.skills_1,self.creature.cInfo.skillTurn_1,self._minorSkillIndex,FightCfg.MINOR_
				,enemy)   --获取随机技能
			if skill then
				self._minorSkillIndex = index
			end
			return true
		end
	end
--	for i=#enemyList,1,-1 do
--		local enemy = enemyList[i]
--		if not enemy:isDie() and enemy:canBeSearchEx(self.creature,atkRange.atkScope)
--				and atkRange:isTargetIn(self.creature, enemy, true) then
--			self.count = 0
--			local skill,index = self:_getUseSkill(self.creature.cInfo.skills_1,self.creature.cInfo.skillTurn_1,self._minorSkillIndex,FightCfg.MINOR_ATTACK,enemy)   --获取随机技能
--			if skill then
--				self._minorSkillIndex = index
--			end
--			return true
--		end
--	end
	return false
end

function Action:_getUseSkill(skills,skillTurn,trunIndex,weapon,target)
	self.count = self.count + 1
	if self.count >= 15 then
		print("--英雄 没有适合使用的技能 英雄id :",self.creature.cInfo.id)
		dump(skills)
		return nil
	end
	local skillId = SkillCfg:calSkillId(skills,skillTurn,trunIndex)
	local skillObj = self.creature.cInfo.skillObj[skillId]
	skillObj.weapon = weapon
	skillObj.scope = self.creature:getAtkScope(weapon)
	local skillInfo = SkillCfg:getSkill(skillId)
	if skillObj and self:canUseSkill(skillInfo) then
		local skill = NewHandle:createSkill(self.creature,skillId,target,skillObj)
		return skill,trunIndex
	end
	--当前不能使用该技能
	return self:_getUseSkill(skills,skillTurn,trunIndex,weapon,target)
end


function Action:canUseSkill(info)
	return self.creature:canUseSkill(info)
end

function Action:dispose()
	if self.target then
		self.target:release()
		self.target = nil
	end
end

return Action