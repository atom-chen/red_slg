--
--
local NewHandle = {}

local BUFF_ID = -400
function NewHandle:init()
	self.teamBuff = {}
	self.teamBuff[FightCommon.mate] = {}
	self.teamBuff[FightCommon.enemy] = {}

end

--间谍加属性
function NewHandle:addNewCreatureBuff(team,arm,attrTypes,values)
	local buffMap = self.teamBuff[team]

	if buffMap[arm] then
		local buff = FightCfg:getBuff(buffMap[arm])
		if buff.num >= 3 then
			return nil
		end
		local num = buff.num+1
		local magicId = 13510 + buff.num
		local buffCfg = {attrTypes=attrTypes,values=values,num=num,magic=magicId}

		for key,value in pairs(buffCfg.values) do
			buffCfg.values[key] = buffCfg.values[key] + buff.values[key]
		end
		FightCfg:addBuff(buffMap[arm],buffCfg)
	else
		buffMap[arm] = BUFF_ID + arm
		local buffCfg = {attrTypes=attrTypes,values=values,num=1,magic=13510}
		FightCfg:addBuff(buffMap[arm],buffCfg)
	end
	return buffMap[arm]
end

function NewHandle:getTeamBuff(team,arm)
	return self.teamBuff[team][arm]
end

function NewHandle:createSkill(creature,skillId,target,skillParams)

	local params = {}
	if skillParams then
		table.merge(params,skillParams)
	end
	local skill = FightEngine:createSkill(creature, skillId, target,params)
	return skill,skillId
end

function NewHandle:createHeroEx(hero,mx,my,team)
	local num = hero.cfg.heroNum or 1
	if not mx then
		mx,my = FightDirector:getMap():getRandomBorn(team, hero.cfg.scope)
	end
	local flag = false
	for i=1,num do
		if self:createHero(hero,mx,my,team) then
			flag = true
		end
	end
	return flag
end


function NewHandle:createHero(hero,mx,my,team)
	local map = FightDirector:getMap()
	local cfg = hero.cfg
	if cfg.scope ~= FightCfg.FLY then
		local beginPos,endPos = FightDirector:getMap():getHeroStandPos(cfg,team)
		if not map:canOccupyRang(mx,my,cfg.posLength) then
			local tile = map:getNearGapInRect(mx,my,beginPos,endPos,{posLength=cfg.posLength,id=-100})
			if tile then
				mx,my = tile.mx,tile.my
			else
				mx = nil
			end
		end
	end

	if mx then
		if FightDirector.fightType == FightCfg.TEST_FIGHT then
			hero = HeroCfg:getCloneHero(hero.id)
			hero.team = team
		else
			hero = FightCfg:getFightHero(hero, team)
			FightDirector:addTacticAttr(hero)  --添加策略属性
		end
		hero.mx = mx
		hero.my = my

		local creature = FightDirector:getScene():initCreature(hero)
		-- creature:turnDirection(Creature.RIGHT)
		if team == FightCommon.mate and  hero.effect then
			local index = math.random( 1, #hero.effect)
			FightAudio:playEffect(hero.effect[index])
		end

		if creature then
			local buffId = self:getTeamBuff(team,hero.arm)
			if buffId then
				FightEngine:createBuff(creature, buffId, 99999999)
			end
			if creature.cInfo.equality and creature.cInfo.equality > 0 and creature.cInfo.equality <= 6 then
				local mId = 159 + (creature.cInfo.equality - 1)
				FightEngine:createMagic(creature, mId,creature)
			end

		end
		return true
	end
	return false
end

function NewHandle:_getTechnologyBuffID(team,technology)
	return -1000*team + FightCfg.GUILD_TECHNOLOGY_BUFF + technology
end

function NewHandle:_addBuff(creature,buffId,attrTypes,rates,values)
	local buffCfg = {attrTypes=attrTypes,rates=rates,values=values,num=1}
	FightCfg:addBuff(buffId,buffCfg)
	FightEngine:createBuff(creature, buffId, 99999999)
end

function NewHandle:createMonsterEx(mInfo,mx,my,team,populace)
	local num = mInfo.heroNum or 1
	local flag = false
	if not mx then
		mx,my = FightDirector:getMap():getRandomBorn(team, mInfo.scope)
	end
	for i=1,num do
		if self:createMonster(mInfo,mx,my,team,populace) then
			flag = true
		end
	end
	return flag
end

function NewHandle:createMonster(mInfo,mx,my,team,populace)
	if mInfo.scope ~= FightCfg.FLY then
		local map = FightDirector:getMap()
		local beginPos,endPos = FightDirector:getMap():getHeroStandPos(mInfo,team)
		if not map:canOccupyRang(mx,my,mInfo.posLength) then
			local tile = map:getNearGapInRect(mx,my,beginPos,endPos,{posLength=mInfo.posLength,id=-100})
			if tile then
				mx,my = tile.mx,tile.my
			else
				mx = nil
			end
		end
	end

	if mx then
		local hero = FightCfg:getFightMonster(mInfo.id)
		hero.mx = mx
		hero.my = my
		hero.team = team

		if populace then
			hero.populace = populace
		end
		FightDirector:addTacticAttr(hero)

		local creature = FightDirector:getScene():initCreature(hero)

		if creature then
			local buffId = self:getTeamBuff(team,hero.arm)
			if buffId then
				FightEngine:createBuff(creature, buffId, 99999999)
			end
		end

		return creature
	else
		return nil
	end
end


return NewHandle