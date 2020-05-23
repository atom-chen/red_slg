local LevelHelper = {}

function LevelHelper:getHelperArray(levelCfg, expKey, start)
	if expKey then
		return self:_getHelperArray2(levelCfg, expKey, start or 1)
	else
		return self:_getHelperArray(levelCfg, start or 1)
	end
end

function LevelHelper:_getHelperArray(levelCfg, start)
	local array = {}
	local total = 0
	for lv=start, #levelCfg do
		array[lv] = total
		total = total + (levelCfg[lv] or 0)
	end
	return array
end

function LevelHelper:_getHelperArray2(levelCfg, expKey, start)
	local array = {}
	local total = 0
	for lv=start, #levelCfg do
		array[lv] = total
		total = total + (levelCfg[lv][expKey] or 0)
	end
	return array
end


function LevelHelper:getNeedExpHelperArray(levelCfg, expKey, start)
	if expKey then
		return self:_getNeedExpHelperArray2(levelCfg, expKey, start or 1)
	else
		return self:_getNeedExpHelperArray(levelCfg, start or 1)
	end
end

function LevelHelper:_getNeedExpHelperArray(levelCfg, start)
	local array = {}
	local total = 0
	for lv=start, #levelCfg do
		total = total + levelCfg[lv]
		array[lv] = total
	end
	return array
end

function LevelHelper:_getNeedExpHelperArray2(levelCfg, expKey, start)
	local array = {}
	local total = 0
	for lv=start, #levelCfg do
		total = total + levelCfg[lv][expKey]
		array[lv] = total
	end
	return array
end


function LevelHelper:upNeed(helperCfg, curLevel, curExp, nextLevel)
	local e = (helperCfg[curLevel] or 0) + curExp
	local maxLevel = #helperCfg
	if nextLevel > maxLevel then
		nextLevel = maxLevel
	end
	local nextE = helperCfg[nextLevel]
	return nextE - e
end

function LevelHelper:up(helperCfg, curLevel, curExp, addExp)
	local e = (helperCfg[curLevel] or 0) + curExp + addExp
	local maxLevel = #helperCfg
	local level = curLevel
	for i=curLevel,maxLevel do
		if e > helperCfg[i] then
			lv = i
		else
			break
		end
	end
	return lv, e - helperCfg[lv]
end
return LevelHelper