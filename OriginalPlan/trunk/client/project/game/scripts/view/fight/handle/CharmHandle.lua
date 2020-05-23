local CharmHandle = {}

function CharmHandle:canBeCharm(creature)
	local flag = creature._isBeParasite ~= 1 and not creature.isBeCharm
	if flag then
		return true
	else
		return false
	end
end

local Charm_Magic_ID  = 12120
function CharmHandle:changeTeam(creature,team,srcId)
	if not team then
		team = Formula:getEnemyTeam(creature.cInfo.team)
	end
	creature.isBeCharm = true
	creature:changeColor()
	local mateList = FightDirector:getScene():getMateList(creature)
	local enemyList = FightDirector:getScene():getEnemyList(creature)
	for i,m in ipairs(mateList) do
		if m == creature then
			table.remove(mateList,i)
			break
		end
	end

	FightDirector:reducePopulace(creature.cInfo.team,creature.cInfo)

	enemyList[#enemyList+1]=creature
	creature._oldTeam = creature.cInfo.team
	creature.cInfo.team = team
	creature._charmSrcId = srcId

	FightDirector:addPopulace(team,creature.cInfo)

	local aiList = AIMgr:getAllAI()
	aiList[creature]:_setNewTarget(nil)
	aiList[creature]:updateBuildTarget()
	aiList[creature].standAI:run(30)
	creature.forbidMove = nil
	for c, ai in pairs(aiList) do
		if ai.target == creature then
			ai:_setNewTarget(nil)
		end
	end

	FightEngine:createMagic(creature,Charm_Magic_ID)
end

function CharmHandle:recoverTeam(creature)
	if not creature.isBeCharm then
		return
	end
	creature.isBeCharm = nil
	creature:changeColor()
	FightEngine:removeCreatureMagicById(creature,Charm_Magic_ID)

	if not creature:isDie() then
		FightDirector:reducePopulace(creature.cInfo.team,creature.cInfo)
		FightDirector:addPopulace(creature._oldTeam,creature.cInfo)
	end

	local mateList = FightDirector:getScene():getMateList(creature)
	local enemyList = FightDirector:getScene():getEnemyList(creature)
	for i,m in ipairs(mateList) do
		if m == creature then
			table.remove(mateList,i)
			break
		end
	end
	--local enemyList = FightDirector:getScene():getEnemyList(creature)
	enemyList[#enemyList+1]=creature
	creature.cInfo.team = creature._oldTeam
	creature._oldTeam = nil
	local aiList = AIMgr:getAllAI()
	aiList[creature]:_setNewTarget(nil)
	aiList[creature]:updateBuildTarget()
	for c, ai in pairs(aiList) do
		if ai.target == creature then
			ai:_setNewTarget(nil)
		end
	end
end

return CharmHandle