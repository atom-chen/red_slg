
local pairs = pairs
local ipairs = ipairs
local table = table

local CStatus = class("CStatus")

function CStatus:ctor( creature )
	self.creature = creature
	self.buffList = {}

	self:reset()

	self.passiveSkill = {}  --被动技能
end

--初始化被动技能
function CStatus:startPassiveSkill(  )

	local skillList = self.creature.cInfo.skills
	if skillList then
		for _,skillId in ipairs(skillList) do
			local sInfo = FightCfg:getSkill(skillId)
			if sInfo and sInfo.skillType == 2 then  --被动技能
				local skillObj = self.creature.cInfo.skillObj[skillId]
				if skillObj then
					local pSkill = PassiveSkill.new(self.creature,skillId,skillObj)
					pSkill:start()
					self.passiveSkill[#self.passiveSkill + 1] = pSkill
				end
			end
		end
	end
end

function CStatus:addBuff( buff )
	self.buffList[#self.buffList +1] = buff

	self:_buffEffect(buff)
end

function CStatus:removeBuff( buff )
	for i,b in ipairs(self.buffList) do
		if b == buff then
			table.remove(self.buffList,i)
			break
		end
	end

	self:reset()

	for i,buff in ipairs(self.buffList) do
		self:_buffEffect(buff)
	end
end

function CStatus:reset()
	self._canMove = true
	self._canBeEnemySearch = true
	self._canBeMateSearch = true
	self._canBeBreak = true
	--self._canNormalSkill = true
	self._canUseSkill = true
	self._canBeHurt = true
	self._fear = false --恐惧
	self._disorder = false  --混乱
end

function CStatus:_buffEffect(buff)
	if self._canMove then
		self._canMove = buff:canMove()
	end
	if self._canBeEnemySearch then
		self._canBeEnemySearch = buff:canBeSearch(FightCommon.enemy)
	end
	if self._canBeMateSearch then
		self._canBeMateSearch = buff:canBeSearch(FightCommon.mate)
	end

	if self._canBeBreak then
		self._canBeBreak = buff:canBeBreak()
	end

	if self._canUseSkill then
		self._canUseSkill = buff:canUseSkill()
	end

	if self._canBeHurt then
		self._canBeHurt = buff:canBeHurt()
	end

	if not self._fear then --恐惧
		self._fear = buff.info.fear or false
	end

	if not self._disorder then --混乱
		self._disorder = buff.info.disorder or false
	end

end

function CStatus:run(dt)
	for _,pSkill in ipairs(self.passiveSkill) do
		pSkill:run(dt)
	end
end

function CStatus:getBuffList(  )
	return self.buffList
end

function CStatus:getBuffById(id)
	for i,buff in ipairs(self.buffList) do
		if buff.buffId == id then
			return buff
		end
	end
end

--是否有某个buff
function CStatus:hasBuff( id )
	for i,b in ipairs(self.buffList) do
		if b.buffId == id then
			return true
		end
	end
	return false
end


--受伤多少   会触发一些效果
function CStatus:beHurt( value,source,isDirect )
	if value and value <= 0 then
		for _,buff in pairs(self.buffList) do
			if buff:reduceHurtTimes(1) then
				break
			end
		end
	end
end

--对别人造成伤害 或者 加血   buff加成
function CStatus:getBuffEffectValue( value,effect )
	if effect == FightCfg.ASSIST then  --治疗

	else
		value = self:effectHurt(value,effect)
	end
	return value
end

--被别人伤害 或者 被加血 buff加成
function CStatus:getBuffFilterValue( value,effect )
	if effect == FightCfg.ASSIST or value > 0 then  --治疗

	else
		value = self:filterHurt(value,effect)
	end
	return value
end

--能否释放技能
function CStatus:canUseSkill( info )
	return self._canUseSkill
end

--获取技能目标列表
function CStatus:getMagicTarget( magic,targetType )
	if not targetType then
		if Formula:isHurtMagic(magic) then  --攻击类型的
			targetType = 3  --敌人
		else
			targetType = 2  --队友
		end
	end

	if self._disorder then  --混乱
		local targetList = FightDirector:getScene():getMateList(self.creature)
		local list = {}
		for i,c in ipairs(targetList) do
			if c ~= self.creature then
				list[#list+1] = c
			end
		end
		return list
	end

	if targetType == 3 then  --敌人
		return FightDirector:getScene():getEnemyList(self.creature)
	elseif targetType == 2 then   --队友
		return FightDirector:getScene():getMateList(self.creature)
	elseif targetType == 4 then
		return FightDirector:getScene():getCreatureList()
	end
end

--是否可以移动
function CStatus:canMove(  )
	return self._canMove
end

--是否能被技能命中
function CStatus:canBeHit( skillInfo )
	-- print("canBeHit",skillInfo.effect,skillInfo.name,self._canBePhyHit,self._canBeMgHit)
	return true
end

function CStatus:getTeamList(team)
	if self._disorder then
		team = (team == FightCommon.mate and FightCommon.enemy) or FightCommon.mate
	end
	if team == FightCommon.mate then
		return FightDirector:getScene():getMateList(self.creature)
	else
		return FightDirector:getScene():getEnemyList(self.creature)
	end
end

--打断
function CStatus:canBeBreak(  )
	return self._canBeBreak
end

--能否被搜索到
function CStatus:canBeSearch( source )
	local sType = (AIMgr:isEnemy(self.creature,source) and FightCommon.enemy ) or FightCommon.mate
	local beSearch = true
	if sType == FightCommon.mate then
		beSearch = self._canBeMateSearch
	else
		beSearch = self._canBeEnemySearch
	end
	if beSearch and self._disorder and self.creature == source then
		beSearch = false
	end
	return beSearch
end

--能否被杀死
function CStatus:checkDie(value)
	if -value >= self.creature.cInfo.hp then  --要死了
		for i,pSkill in ipairs(self.passiveSkill) do  --看看还是不是有被动技能可以 免死
			value = pSkill:checkDie(value)
		end
	end
	return value
end

--能否搜索   恐惧
function CStatus:canSearch(  )
	return not self._fear
end

--增加 或者减少  对别人的 伤害
function CStatus:effectHurt(value)
	local nValue = value
	for _,buff in ipairs(self.buffList) do
		nValue = nValue + buff:addHurt(value)
	end
	return nValue
end

--过滤伤害   增加或者减少伤害
function CStatus:filterHurt( value,hType )
	if not self._canBeHurt then  --无敌
		return 0
	end

	for _,pSkill in ipairs(self.passiveSkill) do
		value = pSkill:filterHurt(value,hType) --被动技能过滤伤害
	end
	if value == 0 then
		return 0
	end

	local nValue = value
	for _,buff in ipairs(self.buffList) do
		nValue = nValue + buff:filterHurt(value,hType)
	end
	if nValue > 0 then
		nValue = 0
	end
	--最后再减掉魔法盾
	for _,buff in ipairs(self.buffList) do
		nValue = buff:shieldHurt(nValue,hType)
	end
	return nValue
end

--免疫什么buff
function CStatus:immuneBuff( buffId )
	local buff = FightCfg:getBuff(buffId)
	if self.creature:isDie() then
		if buff and buff.ignore ~= 1 then
			return true
		end
	end

	for _,buff in ipairs(self.buffList) do
		if buff:immuneBuff(buffId) then
			return true
		end
	end

	return false
end

function CStatus:dispose(  )
	for i=#self.buffList,1,-1 do
		local buff = self.buffList[i]
		FightEngine:removeBuff(buff)
	end
	self.buffList = nil
	for _,skill in ipairs(self.passiveSkill) do
		skill:dispose()
	end
	self.creature = nil
	self.passiveSkill = nil
end

return CStatus