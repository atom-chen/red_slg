--
-- Author: wdx
-- Date: 2014-07-02 14:18:03
--
local HeroInfo = {}--class("HeroInfo")
--[[
HeroInfo.HAS_EQUIPED	= 1	--已装备
HeroInfo.CAN_EQUIP 		= 2	--可装备，背包内有该装备且符合装备等级
HeroInfo.CANNOT_EQUIP	= 3	--未装备，背包内有该装备且不符合装备等级
HeroInfo.NOTOWN_EQUIP	= 4	--无装备，背包内无该装备且不可合成
HeroInfo.CANCOM_EQUIP	= 5	--可合成，背包内无该装备且可合成, 等级足够
HeroInfo.CANCOM_NEQUIP	= 6 --可合成，背包内无该装备且可合成, 等级不够
HeroInfo.NONE			= 7 --无装备，且不知道装备状态。 用于其他人的装备状态
--]]
HeroInfo.ARM_0			= 0
HeroInfo.ARM_TANK		= 1
HeroInfo.ARM_CHARIOT	= 2
HeroInfo.ARM_PLAIN		= 3
HeroInfo.ARM_SOLDIER	= 4

function HeroInfo.new(heroId)
	local instance = {}
	table.encrypt(instance)

	for k,v in pairs(HeroInfo) do
		instance[k] = v
	end

	instance:ctor(heroId)
	return instance
end

function HeroInfo:ctor(heroId)
	self.heroId 	= heroId
	self.level 		= 1
	self.star		= HeroCfg:getMinStar(heroId)
	self.exp		= 1
	self.starExp 	= 0

	self.attr		= nil	-- final attr
	self.num 		= 0
	self.max_num 	= 0
	self.equality 	= 0 --elite quality
	self.cfg = HeroCfg:getHero(heroId)
	self._wearedEquip = {}
	self._eqmList = {}
	self._adjunct_list = {}
	self._adjunctIndex = {}
	self:_initQuality(1)
end


function HeroInfo.newBasic(heroId, level, star, quality)
	local heroInfo = HeroInfo.new(heroId)
	heroInfo.level = level or 1
	heroInfo.quality  = quality or 1
	heroInfo.equality = 0
	heroInfo.star = star or 1
	heroInfo:_initEquip({})
	heroInfo:_initAdjunctList({})
	heroInfo:_initQuality(quality)
	--heroInfo:updateAttr()
	return heroInfo
end

function HeroInfo:_initQuality(quality)
	self.quality = quality or 1
end

function HeroInfo:_initEquip(eqmList)
	if not self._own then return end
	self._eqmList = eqmList
	for i,uid in ipairs(eqmList) do
		local itemInfo = BagModel:getEquip(uid)
		if itemInfo then
			self._wearedEquip[itemInfo:getEquipPos()] = uid
		end
	end
end

function HeroInfo:_initAdjunctList( adjunctList)
	self._adjunct_list = adjunctList
	self._adjunctIndex = {}
	for i, adjunct in ipairs(self._adjunct_list) do
		local itemId = adjunct.adjunctID
		self._adjunctIndex[AdjunctCfg:getPosition(itemId)] = adjunct
	end
end

function HeroInfo:isAdjunctLocked(pos)
	--[[
	if self:existAdjunct(pos) then
		return false
	end
	--]]
	if self._adjunctIndex[pos] then
		return false
	end
	local quality = AdjunctCfg:getUnlocakQuality(self.heroId, pos)
	print("function HeroInfo:isAdjunctLocked(pos)", self.heroId, pos, quality)
	return quality > self.quality
end

function HeroInfo:existAdjunct(pos)
	--[[
	for i, adjunct in ipairs(self._adjunct_list) do
		local itemId = adjunct.adjunctID
		if AdjunctCfg:getPosition(itemId) == pos then
			return true
		end
	end
	return false
	--]]
	return tobool(self._adjunctIndex[pos])
end

function HeroInfo:getAdjunctId(pos)
	local adjunct = self._adjunctIndex[pos]
	if self._adjunctIndex[pos] then
		return adjunct.adjunctID
	end
end

function HeroInfo:getAdjunct(pos)
	local adjunct = self._adjunctIndex[pos]
	return adjunct
end

function HeroInfo:getAdjunctCount()
	return AdjunctCfg:getAdjunctCount(self.heroId)
end

function HeroInfo:getAdjunctAttr()
	local attrs = AttrCfg:newAttr()
	for i=1,self:getAdjunctCount() do
		local adjunct = self:getAdjunct(i)
		if adjunct then
			local attr = AdjunctCfg:getAttr(adjunct.adjunctID, adjunct.adjunct_add_list)
			AttrCfg:namedAttrAdd(attrs, attr)
		end
	end
	return attrs
end

--[[
function HeroInfo:getReadableAdjunctAttrByPos(pos)
	local adjunct = self:getAdjunct(pos)
		if adjunct then
			local attr = AdjunctCfg:getAttr(adjunct.adjunctID, adjunct.adjunct_add_list)

end

function HeroInfo:getReadableAdjunctAttrById(adjunctId)
end

--]]

function HeroInfo:getAdjunctAttrValueById(adjunctId)
	local pos = AdjunctCfg:getPosition(adjunctId)
	local adjunct = self:getAdjunct(pos)
	if adjunct then
		local attr = AdjunctCfg:getAttr(adjunct.adjunctID, adjunct.adjunct_add_list)
		for k,v in pairs(attr) do
			return v
		end
	end
	return 0
end

function HeroInfo:canWearAdjunct()
end

function HeroInfo:canUpAdjunct()

end

function HeroInfo:wearEquip(uid)
	local itemInfo = BagModel:getEquip(uid)
	local pos = itemInfo:getEquipPos()
	if self._wearedEquip[pos] then
		self:takeOffEquip(self._wearedEquip[pos])
	end
	self._wearedEquip[pos] = uid
	table.insert(self._eqmList, uid)
	BagModel:wearEquip(uid)
end

function HeroInfo:takeOffEquip(uid)
	if uid == 0 then return end
	local itemInfo = BagModel:getEquip(uid)
	local pos = itemInfo:getEquipPos()
	if not self._wearedEquip[pos] then return end
	for i,id in ipairs(self._eqmList) do
		if id == uid then
			table.remove(self._eqmList, i)
			break
		end
	end
	BagModel:takeOffEquip(uid)
	self._wearedEquip[pos] = nil
end

function HeroInfo:isEquiped(pos)
	return tobool(self._wearedEquip[pos])
end

function HeroInfo:getEquipId(pos)
	return self._wearedEquip[pos]
end

function HeroInfo:getEquip(pos)
	return BagModel:getEquip(self:getEquipId(pos))
end

function HeroInfo:isImmortal()
	return HeroCfg:isImmortalCfg(self.cfg)
end

function HeroInfo.newFromProtocol(hero, isOwn)
	local heroInfo = HeroInfo.new(hero.heroID)
	heroInfo:setFromProtocol(hero, isOwn)
	return heroInfo
end

function HeroInfo:setFromProtocol(hero, isOwn)
--	print("function HeroInfo:setFromProtocol(hero)")
	self.level 			= hero.lev
	self.exp			= hero.exp
	self.quality		= hero.quality
	self.equality		= hero.equality or 0
	self.num			= hero.num
	self.max_num		= hero.max_num
	self.star			= hero.star
	self.starExp		= hero.starExp
	--[[
	for k,v in ipairs(hero.heroEqm) do
		self:set_wearedEquip(v.itemID, v.pos)
	end
	--]]

	self._own = (isOwn ~= false)
	self:_initEquip(hero.eqmList)
	self:_initAdjunctList(hero.adjunct_list or {})
	--self:updateAttr()
	if not self._own then
		self._attrList = hero.attrList
		self:updateAttr()
	end

	--self:initFightNumber()
end

function HeroInfo:getInstAttr()
	local instAttr
	if self.level < 1 then
		instAttr = AttrCfg:newAttr()
	else
		instAttr = InstCfg:getHeroInstAttr(self.heroId, self.level)
	end
	return instAttr
end

function HeroInfo:getFinalInstAttr(equipAttr)
	local attr = self:getInstAttr()
	AttrCfg:attrRaise(attr, equipAttr)
	return attr
end

function HeroInfo:getFinalQualityAttr(equipAttr)
	local attr = self:getQualityAttr()
	local add = HeroCfg:getEQualityAddition(self.heroId, self.equality)
	local equalityPart = AttrCfg:attrRaisePercentPart(AttrCfg:cloneAttr(attr), add)
	AttrCfg:attrRaise(attr, equipAttr)
	AttrCfg:namedAttrAdd(attr, equalityPart)
	return attr
end

function HeroInfo:_initFixedAttr(attr) --fixed value. config in hero.xlsx
	for i,column in ipairs(AttrCfg:getAttrColumns()) do
		if column.type == 4 then
			self.attr[column.name] = self.cfg[column.name]
		end
	end
end

function HeroInfo:_getAtkRate()
	local attr = AttrCfg:newAttr()
	if self.cfg.atkRate then
		for i,val in ipairs(self.cfg.atkRate) do
			if i > 11 then
				break
			end
			attr[AttrCfg:getAttrName(i+AttrCfg:getAtkRateTypeMagicNumber())] = val
		end
	end
	return attr
end

function HeroInfo:updateAttr(fight)
	print("function HeroInfo:updateAttr(fight)", self.heroId)
	fight = true -- leader fighting attr add
	if not self._own then
		local attr = self:_getAtkRate()
		for i,attrInfo in ipairs(self._attrList) do
			attr[AttrCfg:getAttrName(attrInfo.type)] = attrInfo.value
		end
	--	self.attr = AttrCfg:finalAttr(attr) -- calc by server
		self.attr = attr
		self:_initFixedAttr(self.attr)
--		dump(self.attr)
		return
	end

	self._attrs = {}
--	local levelAttr = HeroCfg:getHeroLevelAttr(self.level)
	local equipAttr = self:getEquipAttr()
	local instAttr = self:getFinalInstAttr(equipAttr)
	self._attrs['atkRate'] = self:_getAtkRate()
	--self._attrs["level"] = levelAttr
	self._attrs['adjunct'] = self:getAdjunctAttr()
	self._attrs["equip"] = equipAttr
	self._attrs["inst"] = instAttr
	self._attrs["quality"] = self:getFinalQualityAttr(equipAttr)
	self._attrs["star"] =  HeroCfg:getStarAttr(self.heroId, self.star)

	-- [[
	local leaderMainAttr = nil
	local smeltAttr = nil
	if fight then
		leaderMainAttr = RoleModel:getFighttingLeaderAttr(self)
		smeltAttr = RoleModel:getLeaderSubAttr(self)
	end
	--]]




	if not self.attr then
		self.attr = AttrCfg:newAttr()
	else
		AttrCfg:zeroAttr(self.attr)
	end


	for name,pattr in pairs(self._attrs) do
		AttrCfg:namedAttrAdd(self.attr, pattr)
	end

	if smeltAttr then
		AttrCfg:addArmAttr(self.attr, smeltAttr, self.cfg.arm)
	end

	if leaderMainAttr then
		AttrCfg:attrRaise(self.attr, leaderMainAttr)
	end
--	print(self.heroId)
--	dump(self._attrs)
	--dump(self.attr)
	self:_initFixedAttr(self.attr)
--	dump(self.alphaAttr)
--	dump(self.attr)
end

function HeroInfo:getNextStarAttrChange()
	local change = AttrCfg:newAttr()
	if self:isMaxStar() then
		return change
	end

	local attrs = HeroCfg:getStarAttr(self.heroId, self.star)
	local nextAttrs = HeroCfg:getStarAttr(self.heroId, self.star+1)
	for k,v in pairs(nextAttrs) do
		change[k] = v - attrs[k]
	end
	return change
end

function HeroInfo:getReadableAttr()
	self:updateAttr()
	return AttrCfg:getReadableAttr(self.attr, true)
end

function HeroInfo:getEquipAttr()
--[[
	local attr = AttrCfg:newAttr()
	local suit = {}
	for i=1,6 do
		local equip = self:getEquip(i)
		if equip then
			AttrCfg:namedAttrAdd(attr, equip:getEqmAttr())
			local exclusiveAttr = equip:getExclusiveAttr(self.heroId)
			if exclusiveAttr then
				AttrCfg:namedAttrAdd(attr, exclusiveAttr)
			end
			local suitId = equip:getSuitId()
			if suitId then
				if suit[suitId] then
					suit[suitId] = suit[suitId] + 1
				else
					suit[suitId] = 1
				end
			end
		end
	end

	--suit attr
	for id,count in pairs(suit) do
		AttrCfg:namedAttrAdd(attr, ItemCfg:getSuitAttr(id, count))
	end

	return attr
--]]
	return HeroModel:getArmEqmAttr(self.cfg.arm)
end

function HeroInfo:clone()
	local instance = {}
	table.encrypt(instance)  --加密

	for k,v in pairs(self) do
		-- print("heroInfo 属性。。",k,v)
		instance[k] = v
	end
	instance._wearedEquip = table.encryptClone(self._wearedEquip)
	return instance
end


function HeroInfo:getQuality()
	return self.quality
end


function HeroInfo:upgradeQuality()
	if not self:canUpgradeQuality() then return false end
	self.quality = self.quality + 1

end

function HeroInfo:canUpgradeQuality()
	if not self:hasNextQuality() then return false end

	local needLevel = self:getUpQualityLevel()
	if self.level < needLevel then
		return false
	end

	local need = self:getUpQualityNeed()
	for i,item in ipairs(need.items) do
		local itemId, num = item[1], item[2]
		if BagModel:getItemNum(itemId) < num then
			return false
		end
	end
	--[[
	local coin = need.coin
	if coin and coin > 0 then
		if RoleModel:getCoin() < coin then
			return false
		end
	end
	--]]
	return true
end

function HeroInfo:getQualityAttr()
	return HeroCfg:getQualityAttr(self.heroId, self.quality, self.equality)
end

function HeroInfo:getNextQualityAttr()
	return HeroCfg:getQualityAttr(self.heroId, self.quality+1, self.equality)
end


function HeroInfo:getReadableQualityAttr()
	return HeroCfg:getReadableQualityAttr(self.heroId, self.quality, self.equality)
end

function HeroInfo:getNextReadableQualityAttr()
	return HeroCfg:getReadableQualityAttr(self.heroId, self.quality+1, self.equality)
end


function HeroInfo:getUpQualityNeed()
	return HeroCfg:getUpQualityNeed(self.heroId, self.quality)
end

function HeroInfo:hasNextQuality()
	if self.quality >= HeroCfg:getMaxQuality() then return false end
	return true
end

function HeroInfo:getQualityColorInfo(quality)
	local q = quality or self.quality
	return HeroCfg:getHeroQualityColorInfo(q)
end

function HeroInfo:_getFightValue(attr)
--[==[
	local val = 0
	local attr = self.attr
	local main_atkCD,minor_atkCD = 1,1
	if attr.main_atkCD > 0 then
		main_atkCD = attr.main_atkCD
	end
	if attr.minor_atkCD > 0 then
		minor_atkCD = attr.minor_atkCD
	end
	val = attr.main_atk/main_atkCD*1000+attr.minor_atk/minor_atkCD*1000+attr.hp/3+attr.def/5
	val = math.floor(val/self.cfg.populace)
--]==]
	local last = self._lastFightValue
	local num = 1
	if self.num > 1 then
		num = self.num
	end
	local val = self:getUnitFightNumber() * num
	print("function HeroInfo:_getFightValue(attr)", self.heroId, val)
	self._lastFightValue = val
	return val,last
end

function HeroInfo:getLastFightNumber()
	if self._lastFightValue == nil then
		self:_getFightValue()
	end
	return self._lastFightValue
end

function HeroInfo:getFightValue()
	return self:_getFightValue(self.attr)
end

function HeroInfo:getUnitFightNumber()
	local adjunct = 0
	local factors = {[1]=1, [2]=1.3, [3]=3.3, [4]=5, [5]=9}
	local starFactors = {0,3,6,12,18,28,40,55,70,90}

	for i,adjunctInfo in ipairs(self._adjunct_list) do
		local q = ItemCfg:getCfg(adjunctInfo.adjunctID).quality or 1
		local percent = AdjunctCfg:getAdjunctIncreasePercent(adjunctInfo.adjunct_add_list)
		adjunct = adjunct + (factors[q] or 0) * q * (1+percent/100)
	end
	adjunct = math.floor(adjunct)
	local starFactor = (starFactors[self.star] or 0) - (starFactors[HeroCfg:getMinStar(heroId)] or 0)
	if starFactor < 0 then
		starFactor = 0
	end
	local base = self.level*2+self.quality*12+starFactor*12+ (self.quality * (self.equality or 0)*0.3) + HeroModel:getArmScore(self.cfg.arm) + adjunct + RoleModel:getLeaderSmeltFightValue()
	return math.floor(base * HeroCfg:getFightValueFactor(self.heroId))
end

function HeroInfo:getNextStarUnitFightNumber()
	if self:isMaxStar() then
		return self:getUnitFightNumber()
	else
		self.star = self.star + 1
		local val = self:getUnitFightNumber()
		self.star = self.star - 1
		return val
	end
end

function HeroInfo:getFightNumber()
	--self:updateAttr()
	return self:getFightValue()
end

function HeroInfo.toHeroInfo(hero)
	local heroInfo
	if type(hero) == "number" then
		heroInfo = HeroModel:getHeroInfo(hero)
		if not heroInfo then
			heroInfo = HeroInfo.new(hero)
		end
	else
		heroInfo = hero
	end
	return heroInfo
end

function HeroInfo:getQualityColorNumber()
	local cn = {0,0,1,0,1,2,0,1,2,3}
	return cn[self.quality]
end

function HeroInfo:getQualityColorString()
	local cn = {0,0,1,0,1,2,0,1,2,3}
	local num = cn[self.quality]
	if num == 0 then
		return ""
	else
		local color = HeroCfg:getHeroQualityColorInfo(self.quality)
		local str = string.format("<font color=rgb(%d,%d,%d)>+%s</font>", color.r, color.g, color.b, num)
		return str
	end
end

function HeroInfo:getIcon()
	if self.cfg then
		return ResCfg:getRes(self.cfg.head, ".pvr.ccz")
	end
end

function HeroInfo:getCardIcon()
	if self.cfg then
		return ResCfg:getRes(self.cfg.card, ".w")
	end
end

function HeroInfo:getCard()
	return self:getCardIcon()
end

function HeroInfo:getMaxLevel()
	return HeroCfg:getCurrentMaxLevel()
end

function HeroInfo:isMaxLevel()
	return self.level == self:getMaxLevel()
end

function HeroInfo:getEquipList()
	return self._eqmList
end

function HeroInfo:getArmName()
	return HeroCfg:getArmName(self.cfg.arm)
end

function HeroInfo:getDefName()
	return HeroCfg:getDefName(self.cfg.defType)
end
--[[
function HeroInfo:getInsts(all, sort)
	local arm = self.cfg.arm
	local heroId = self.heroId
	local insts = {}

	local exists = {}
	local filter = function (inst)
		print(inst.id, inst.lev)

		local cfg = InstCfg:getCfg(inst.id, inst.lev)

		if cfg.refHero then
			dump(cfg.refHero)
			for i,id in ipairs(cfg.refHero) do
				if id == heroId then return true end
			end
		end

		if cfg.refClass then
			dump(cfg.refClass)
			for i,cls in ipairs(cfg.refClass) do
				if cls == arm then return true end
			end
		end
		return false
	end
	for i,inst in ipairs(InstModel:getInstList()) do
		if filter(inst) then
			table.insert(insts, inst)
		end

		exists[inst.id] = true
	end


	if all then
		for i,id in ipairs(InstCfg:getInstIds()) do
			if not exists[id] then
				local inst = InstModel:getInst(id)
				if filter(inst) then
					table.insert(insts, inst)
				end
			end
		end
	end

	if sort then
		local canUps = {}
		for i,inst in ipairs(insts) do
			local canUp = true
			local cfg = InstCfg:getCfg(inst.id, inst.lev)
			if cfg.preIDList then
				for i,info in ipairs(cfg.preIDList) do
					local id = info[1]
					local lev = info[2]
					if InstModel:getInstLevel(id) < lev then
						canUp = false
						break
					end
				end
			end
			canUps[inst.id] = canUp
		end

		table.sort(insts, function (lhs, rhs)
			if canUps[lhs.id] == canUps[rhs.id] then
				return lhs.id < rhs.id
			end
			if canUps[lhs.id] then
				return true
			end
			return false
		end)
	end


	return insts
end
--]]
function HeroInfo:getStockNum()
	return self.num--HeroCfg:getQualityCfg(self.heroId, self.quality).stockNum
end

function HeroInfo:getUpQualityLevel()
	return HeroCfg:minUpQualityLevel(self.heroId, self.quality)
end

function HeroInfo:canUpQuality()
	return self.level >= self:getUpQualityLevel()
end

function HeroInfo:isMaxEQualityLevel()
	local equality = self.equality or 0
	return equality >= HeroCfg:getMaxEQualityLevel(self.heroId)
end

function HeroInfo:hasAdjunctInfo( adjunctId )
	if self._adjunct_list then
			for k,v in pairs( self._adjunct_list ) do
				if adjunctId == v.adjunctID then
					return v.adjunct_add_list
				end
			end
		end
end

function HeroInfo:hasAdjunctItem(adjunctId, itemId )
	local adjunctItems = self:hasAdjunctInfo(adjunctId) or {}
	for k,v in pairs( adjunctItems ) do
		 if v == itemId then
		 	return true
		 end
	end

	return false
end

function HeroInfo:checkAdjunctRed()
	for i=1,self:getAdjunctCount() do
		if self:checkSingleAdjunctRed(i) then
			return true
		end
	end
	return false
end

function HeroInfo:checkSingleAdjunctRed( pos )
	local itemId = self:getAdjunctId(pos)
	if itemId then
		return self:canHandleSingleAdjunct(itemId)
	else
		local adjunctItems = AdjunctCfg:getAllAdjunctId(self.heroId, pos)

		local count = BagModel:getItemNum(adjunctItems[1])
		if count >0 then
			local cfgInfo = AdjunctCfg:getAdjunctAttr(adjunctItems[1])
			if cfgInfo.quality_level and cfgInfo.quality_level > self.quality then
				return false
			end
			return true
		end
	end

	return false
end

--校验配件是否有红点
function HeroInfo:canHandleSingleAdjunct( adjunctId )

	local cfgInfo = AdjunctCfg:getAdjunctAttr(adjunctId)
	if cfgInfo then
		if cfgInfo.add_list then
			for i,v in pairs(cfgInfo.add_list) do
				local isHas = self:hasAdjunctItem(adjunctId,v)
				if not isHas then
					local index = AdjunctCfg:getAddItemIndex(adjunctId,v)
					local item = BagModel:getItemById(v)
					if index >0 and item then
						return true
					end
				end
			end
		end
		local adjunctItems = self:hasAdjunctInfo(adjunctId) or {}

		----一下是校验能不能升级
		--装在的物品不足时不能升级
		if cfgInfo.add_list and #cfgInfo.add_list ~= #adjunctItems then
			return false
		end
		--消耗的物品数量不足时不能升级
		if cfgInfo.items then
			for k,v in pairs(cfgInfo.items) do
				local count = BagModel:getItemNum(v[1])
				if count< v[2] then
					return false
				end
			end
		end

		--金币不足时不能升级
		if cfgInfo.coin and cfgInfo.coin >0 then
			if cfgInfo.coin < RoleModel.roleInfo[RoleConst.COIN] then
				return false
			end
		end
		--到达最大等级时不能升级
		if (not cfgInfo.replace_id) or cfgInfo.replace_id==0 then
			return false
		end

		return true
	end
	return false
end

function HeroInfo:isMaxStar()
	return self.star >= HeroCfg:getMaxStar(self.heroId)
end

function HeroInfo:getMaxStar()
	return HeroCfg:getMaxStar(self.heroId)
end

function HeroInfo:upStarNeed()
	if self:isMaxStar() then
		return 0
	end
	return HeroCfg:upStarNeed(self.star, self.starExp)
end

function HeroInfo:upStarNeedItem()
	if self:isMaxStar() then
		return 0
	end
	local e = HeroCfg:getStarItemExp()
	local needE = HeroCfg:upStarNeed(self.star, self.starExp)
	print("function HeroInfo:upStarNeedItem()", self.star, self.starExp, e, needE)
	return math.ceil((needE+1) / e)
end

function HeroInfo:getStarExp()
	return self.starExp, HeroCfg:getStarMaxExp(self.star)
end

return HeroInfo
