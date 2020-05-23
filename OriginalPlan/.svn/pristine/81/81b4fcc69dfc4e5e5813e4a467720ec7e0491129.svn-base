local InstCfg = {}

function InstCfg:init()
	-- self._instAttr = ConfigMgr:requestConfig("inst_attr",nil,true)
	self._instLevelAttr = ConfigMgr:requestConfig("inst_level",nil,true)
	self._instLayout = ConfigMgr:requestConfig("inst_layout",nil,true)

	self._instUp = ConfigMgr:requestConfig("inst_up",nil,true)
	self._instCommon = ConfigMgr:requestConfig("inst_common",nil,true)[1]
	self._instBuy = ConfigMgr:requestConfig("inst_buy",nil,true)
	self._instProduceHero = ConfigMgr:requestConfig("inst_produce_hero",nil,true)
	self._instHeroMaxNum = ConfigMgr:requestConfig("inst_hero_max_num",nil,true)
	self._instUnLockHero = ConfigMgr:requestConfig("inst_unlock_hero",nil,true)
	self:_initLayout()
	self:_initSubInst()
	self._heroLists = {}
end

function InstCfg:getHeroQuality(heroId)
	local cfg = InstCfg:getProduceHeroCfg(heroId)
	if cfg then
		return cfg.quality
	end
	return 2
end

function InstCfg:_initLayout()
	self._cards = {}
	for id,info in pairs(self._instLayout) do
		if not self._cards[info.class] then
			self._cards[info.class] = {}
		end
		table.insert(self._cards[info.class], info)
	end
	--dump(self._cards)
end

function InstCfg:getOpenedHeroList(arm)
	if arm and self._heroLists[arm] then
		return self._heroLists[arm]
	end
	local heroIds = {}

	for tarm, infos in pairs(self._cards) do
		if arm == nil or tarm == arm then
			for i,info in ipairs(infos) do
				dump(info)
				if self:isOpen(info.id) then
					table.insert(heroIds, info.id)
				end
			end
		end
	end
	if arm then
		self._heroLists[arm] = heroIds
	end
	return heroIds
end

function InstCfg:getHeroIdByDrawing(itemId)
	print("function InstCfg:getHeroIdByDrawing(itemId)", itemId)
	for heroId,info in pairs(self._instProduceHero) do
		info = info[1]
		if info.items then
			for i,item in ipairs(info.items) do
				if item[1] == itemId then
					return heroId
				end
			end
		end
	end
	return nil
end

function InstCfg:getInstAttr(heroId)
	return self._instAttr[heroId]
end

function InstCfg:_initSubInst()
	self._subInst = {}
end

function InstCfg:_createInst(heroId)
	print('function InstCfg:_createInst(heroId)', heroId)
	local attr = self._instAttr[heroId]
	local names = {{name='sub_1_name',valueName='mainAttFactor',attr='main_atk',icon='sub_1_icon'},
					{name='sub_2_name',valueName='minorAttFactor',attr='minor_atk',icon='sub_2_icon'},
					{name='sub_3_name',valueName='HPFactor',attr='hp',icon='sub_3_icon'},
					{name='sub_4_name',valueName='defFactor',attr='def',icon='sub_4_icon'},
	}
	local insts = {}
	local count = 0
	for i,name in ipairs(names) do

		if attr[name.name] and attr[name.valueName] and attr[name.valueName] > 0 then
			local inst = {id=i, name=attr[name.name], icon = ResCfg:getRes(attr[name.icon], ".pvr.ccz"), factor=attr[name.valueName], attrName=name.attr}
			table.insert(insts, inst)
			count = count + 1
		end
	end
	insts.count = count
	self._subInst[heroId] = insts
	return insts
end

function InstCfg:getSubInst(heroId)
--	print("function InstCfg:getSubInst(heroId)", heroId)
	local insts = self._subInst[heroId]
	if not insts then
		insts = self:_createInst(heroId)
	end
	return insts
end

function InstCfg:getAdornName(heroId, attrName)
	local index = {main_atk=1, minor_atk=2}--, hp=3, def=4
	local idx = index[attrName]
	if not idx then return end
	local insts = self:getSubInst(heroId)
	for i,inst in ipairs(insts) do
		if inst.id == idx then
			return inst.name
		end
	end
end

function InstCfg:getSubInstAttr(heroId, level, subId)
	local inst = self:getSubInst(heroId)[subId]
	if inst then
		return self:getInstLevelAttr(level, inst.attrName) * inst.factor/10000
	end
end

function InstCfg:getHeroInstAttr(heroId, level)
	local attr = AttrCfg:newAttr()
	local cfg = self._instUp[heroId][level]
	if cfg and cfg.attr then
		AttrCfg:addAttrs(attr, cfg.attr)
	end
	local subs = InstCfg:getSubInst(heroId)
	local levelAttr = self._instLevelAttr[level]
	for i,inst in ipairs(subs) do
		attr[inst.attrName] = inst.factor * levelAttr[inst.attrName] / 10000
	end
	return attr
end


function InstCfg:getInstLevelAttr(level, name)
	--print("function InstCfg:getInstLevelAttr(level, name)", level, name, self._instAttr[level])
	--print('self._instLevelAttr[level][name]', self._instLevelAttr[level][name])
	return self._instLevelAttr[level][name]
end

function InstCfg:getHeroesLayout(cls)
	return self._cards[cls]
end

function InstCfg:isOpen(id)
	return self._instLayout[id].open == 1
end

function InstCfg:getFightFactor(id)
	local cfg = self._instLayout[id]
	if not cfg then return 1 end
	return (cfg.ForceFactor or 100)/100
end

function InstCfg:getPreCondition(id, level)
	if not level then
		level = 1
	end
	print("function InstCfg:getPreCondition(id, level)", id, level)
	local hero = self._instUp[id]
	if not hero then return end
	local cfg = hero[level]
	if not cfg then return end
	dump(cfg.preBuild)
	return cfg.preBuild,cfg.needTips
end

function InstCfg:getUpCfg(id)
	return self._instUp[id]
end

function InstCfg:getCost(id, level)
	if not level then
		level = 0
	end
	print("function InstCfg:getCost(id, level)", id, level)
	local hero = self._instUp[id]
	if not hero then return end
	local cfg = hero[level]
	if not cfg then return end
	return {items=cfg.items,coin=cfg.costCoin}
end

function InstCfg:getGainExp(id, level)
	if not level then
		level = 0
	end
	print("function InstCfg:getGainExp(id, level)", id, level)
	local hero = self._instUp[id]
	if not hero then return end
	local cfg = hero[level]
	if not cfg then return end
	return cfg.getExp
end

function InstCfg:getBasic(id)
	return self._instBasic[id]
end

function InstCfg:getName(id)
	return self._instBasic[id].name
end

function InstCfg:getInstsByClass(cls)
	return self._classBasic[cls]
end

function InstCfg:getCfg(id, lev)
	return self._instCfg[id][lev or 0]
end

function InstCfg:getNextCfg(id, lev)
	local cfgs = self._instCfg[id]
	if lev < cfgs.maxLv then
		return self._instCfg[id][lev+1]
	end
end

function InstCfg:getInst(id, lev)
	return self:getCfg(id, lev)
end

function InstCfg:getNextInst(id, lev)
	return self:getNextCfg(id, lev)
end

function InstCfg:getIconById(iconId)
	return ResCfg:getRes(iconId, ".pvr.ccz")
end

function InstCfg:getIcon(id)
	return self:getIconById(self:getBasic(id).icon)
end

function InstCfg:getMaxLv(id)
	return self._instCfg[id].maxLv
end

function InstCfg:getInstIds()
	return self._instIds
end

function InstCfg:getNeedRoleLevel(id, lev)
	return self:getCfg(id, lev).roleLevel
end

function InstCfg:getAttr(inst, lev)
	local id
	if type(inst) == "number" then
		id = inst
	else
		id = inst.id
		lev = inst.lev
	end
	local cfg = self:getCfg(id, lev)
	if not cfg then return end


	return AttrCfg:addAttrs(AttrCfg:newAttr(), cfg.attrList)
end

function InstCfg:getReadableAttr(inst, lev)
	local id
	if type(inst) == "number" then
		id = inst
	else
		id = inst.id
		lev = inst.lev
	end
	local attr  = self:getAttr(id, lev)
	if attr then
		return AttrCfg:getReadableAttr(attr)
	end
end

function InstCfg:getNextReadableAttr(inst, lev)
	local id
	if type(inst) == "number" then
		id = inst
	else
		id = inst.id
		lev = inst.lev
	end
	if self:getMaxLv(id) <= lev then return nil end
	local attr  = self:getAttr(id, lev+1)
	if attr then
		return AttrCfg:getReadableAttr(attr)
	end
end

function InstCfg:getPreReadableAttr(inst, lev)
	local id
	if type(inst) == "number" then
		id = inst
	else
		id = inst.id
		lev = inst.lev
	end
	if self:getMaxLv(id) <= lev then return nil end
	local attr  = self:getAttr(id, lev-1)
	if attr then
		return AttrCfg:getReadableAtt(attr)
	end
end

function InstCfg:getBuyGold(times)
	return self._instBuy[times].gold
end

function InstCfg:getMaxLevel()
	--print("function InstCfg:getMaxLevel() return #self._instLevelAttr", #self._instLevelAttr)
	return #self._instLevelAttr
end

function InstCfg:getProduceHeroCfg(heroId, num)
	return self._instProduceHero[heroId][num or 1]
end

function InstCfg:getProduceHeroCfgEx(heroId)
	print("function InstCfg:getProduceHeroCfgEx(heroId)")
	local hero = HeroModel:getHeroInfo(heroId)
	local nextNum = 0
	local num = 0
	if not hero then
		num = 0
		nextNum = 1
	else
		num = hero.num
		nextNum = hero.max_num
	end
	num = num + 1
	if num <= 0 then
		num = 1
	end
	print(heroId, num)
	return self._instProduceHero[heroId][num]
end

function InstCfg:getHeroMaxNumCfg(heroId, curNum)
	print("function InstCfg:getHeroMaxNumCfg(heroId, curNum)", heroId, curNum)
	return self._instHeroMaxNum[heroId][curNum]
end

function InstCfg:getHeroMaxNumLimit(heroId)
	local cfg = self._instHeroMaxNum[heroId]
	if not cfg.max_num then
		local num = 1
		for i,_ in ipairs(cfg) do
			num = i
		end
		cfg.max_num = num
	end
	return cfg.max_num
end


function InstCfg:isLocked(id)
	if not InstCfg:isOpen(id) then
		return true, ""
	end
	local heroInfo = HeroModel:getHeroInfo(id)
	if heroInfo then return false end
	local conds,tips = InstCfg:getPreCondition(id, 1)
	local preCond,tips = HeroModel:enougthPreCondition(id, 1)
	print("function InstCfg:isLocked(id)", id, not preCond)
	return not preCond, tips
end

function InstCfg:unlockHeroes(buildingId, level)
	print("function InstCfg:unlockHeroes(buildingId, level)", buildingId, level)
	local cfg = self._instUnLockHero[buildingId]
	if not cfg then return end
	cfg = cfg[level]
	return cfg and cfg.heroes
end

return InstCfg