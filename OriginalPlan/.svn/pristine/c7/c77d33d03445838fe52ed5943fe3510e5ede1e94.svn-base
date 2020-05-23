local HeroCfg = {}
--[[--
ur"英雄基础信息配置表":ur"hero_info",
ur"英雄基础属性配置表":ur"hero_attr",
ur"英雄升级配置表":ur"hero_lv",
ur"英雄进阶配置表":ur"hero_quality",
ur"英雄获得配置表":ur"hero_gain"
--]]



function HeroCfg:init()
  	--英雄配置
  	self._demoHeroCfg = ConfigMgr:requestConfig("demo",nil,true)

  	--等级配置
	self._heroBasic 		= ConfigMgr:requestConfig("hero_info", nil, true)
	self._heroLv			= ConfigMgr:requestConfig("hero_lv", nil, true)
	self._heroQuality		= ConfigMgr:requestConfig("hero_quality", nil, true)
	self._heroQualityColor 	= ConfigMgr:requestConfig("hero_quality_color", nil, true)
	self._heroAttrColumn 	= ConfigMgr:requestConfig("hero_attr_column", nil, true)
	self._heroQualityElite	= ConfigMgr:requestConfig("hero_quality_elite", nil, true)
	self._starAttr 			= ConfigMgr:requestConfig("hero_star_attr", nil, true)
	self._starCfg 			= ConfigMgr:requestConfig("hero_star_cfg", nil, true)[1]
	self._starExp 			= ConfigMgr:requestConfig("hero_star_exp", nil, true)
	self._starLimit			= ConfigMgr:requestConfig("hero_star_limit", nil, true)
	self._starExpEx = LevelHelper:getHelperArray(self._starExp, 1)
	self.heroCareers = {15,16}
	self:_initMaxQuality()
end

function HeroCfg:getOpenedHeroListByArm(arm)
	return InstCfg:getOpenedHeroList(arm)
end

function HeroCfg:getOpenedHeroList()
	return InstCfg:getOpenedHeroList(nil)
end

function HeroCfg.dbgget(str, t, k)
	local v = rawget(t, k)
	if not v then
		print(str, "get ", k, "error, not exists")
	end
	return v
end

function HeroCfg:getHeroesBasicCfg()
	return self._heroBasic
end

function HeroCfg:getHero(id)
    local hero = self._heroBasic[id]
    if not hero then
    	StatSender:sendBug("not hero : "..(id or "nil"))
    end
    hero.hp = hero.maxHp
    return hero
end

function HeroCfg:hasHero(id)
	return self._heroBasic[id] ~= nil
end

function HeroCfg:getName(id)
	print('function HeroCfg:getName(id)', id)
	return self._heroBasic[id].name
end

function HeroCfg:getCard(id)
	return ResCfg:getRes(self._heroBasic[id].card, ".w")
end

function HeroCfg:getIcon(id)
	local cfg = self._heroBasic[id]
	return ResCfg:getRes(cfg.head, ".pvr.ccz")
end


function HeroCfg:getHeroName(id)
	local hero = self._heroBasic[id]
	return hero.name
end

function HeroCfg:getPortrait(heroId)
	local cfg = self._heroBasic[heroId]
	if not cfg then return end
	return self:getPortraitRes(cfg.portrait)
end

function HeroCfg:getPortraitRes(portraitId)
	return ResCfg:getRes(portraitId, ".pvr.ccz")
end

function HeroCfg:getHeroAvatar(heroId)
	local cfg = self._heroBasic[heroId]
	if not cfg then return "" end
	return cfg.res
end

function HeroCfg:isOpen(id)
	return InstCfg:isOpen(id)
end

function HeroCfg:getNotOpenCard()
	return ResCfg:getRes(111000, ".w")
end

function HeroCfg:isImmortalCfg(cfg)
	return cfg and cfg.immortal == 1
end

function HeroCfg:isImmortal(heroId)
	return self:isImmortalCfg(self:getHero(heroId))
end

--clone --一个英雄配置出来   测试用
function HeroCfg:getCloneHero( id )
    local hero = self._demoHeroCfg[id]
    hero.maxHp = hero.hp
    hero.skillObj= {}
    for i,skillId in ipairs(hero.skills) do
    	local obj = {}
    	hero.skillObj[skillId] = obj
    	obj.level = 1
    	obj.hit = 1
    end
    if hero.skills_1 then
	    for i,skillId in ipairs(hero.skills_1) do
	    	local obj = {}
	    	hero.skillObj[skillId] = obj
	    	obj.level = 1
	    	obj.hit = 1
	    end
	end
	hero.id = id
    return clone(hero)
end

function HeroCfg:getHeroCfg()
	return self._demoHeroCfg
end

function HeroCfg:getDemoHero(id)
	return self._demoHeroCfg[id]
end

function HeroCfg:isShow(heroId)
	local cfg = self._heroBasic[heroId]
	if cfg then
		return cfg.show == 1
	end
	return false
end

--获取英雄属性
function HeroCfg:getAttrCfg(level)
	return self._heroLv[level]
end

function HeroCfg:getLevelAttr(level)
	local attr = AttrCfg:newAttr()
	AttrCfg:addAttrs(attr, self:getAttrCfg(level).attrList)
	return attr
end

--获取升级所需经验
function HeroCfg:getLevelCfg( level )
	return self._heroLv[level]['exp']
end

--获取英雄等级配置
function HeroCfg:getHeroLevelCfg( level )
	return self._heroLv[level]
end

function HeroCfg:getHeroLevelAttr(level)
	local cfg = self:getHeroLevelCfg(level)
	return AttrCfg:addAttrs(AttrCfg:newAttr(), cfg.attrList)
end

function HeroCfg:getQualityCfg(heroId, quality)
	local qualityCfg = self._heroQuality[quality]
	if not qualityCfg then return end
	return qualityCfg[heroId]
end

function HeroCfg:minUpQualityLevel(heroId, quality)
	return self:getQualityCfg(heroId, quality).level
end

function HeroCfg:getAllHeroIds()
	local ids = {}
	for id,hero in pairs(self._heroBasic) do
		table.insert(ids, id)
	end
	return ids
end

function HeroCfg:getHeroQualityColorInfo(quality)
	print('function HeroCfg:getHeroQualityColorInfo(quality)', quality)
	local hqc = self._heroQualityColor[quality]
	if not hqc then
		print('error function HeroCfg:getHeroQualityColorInfo(quality)', quality)
		return
	end
	local rgbs = {UIInfo.color.white, UIInfo.color.green, UIInfo.color.blue,
		UIInfo.color.purple, UIInfo.color.orange}
	return rgbs[hqc.color], hqc.name
end


function HeroCfg:getQualiyName(quality)
	return self._heroQualityColor[quality].name
end


function HeroCfg:getQualityName(quality)
	return self._heroQualityColor[quality].name
end

function HeroCfg:getQualityIcon(quality)
	print("function HeroCfg:getQualityIcon(quality)", quality, ResCfg:getRes(self._heroQualityColor[quality].icon, ".pvr.ccz"))
	return ResCfg:getRes(self._heroQualityColor[quality].icon, ".pvr.ccz")
end

function HeroCfg:_initMaxQuality()
	for i=1,128 do
		if not self._heroQualityColor[i] then
			self._maxQuality = i-1
			return
		end
	end
end

function HeroCfg:getMaxQuality()
	return self._maxQuality
end

function HeroCfg:getUpQualityNeed(heroId, quality)
	print("function HeroCfg:getUpQualityNeed(heroId, quality)", heroId, quality, self._heroQuality[heroId])
	return self:getQualityCfg(heroId, quality)
end

function HeroCfg:getQualityAttr(heroId, quality, equality)
	local cfg = self:getQualityCfg(heroId, quality)
	if not cfg then return AttrCfg:newAttr() end
	local attrs = AttrCfg:addAttrs(AttrCfg:newAttr(), cfg.attrList)
	--[[
	if equality > 0 then
		local addition = HeroCfg:getEQualityAddition(heroId, equality)
		if addition > 0 then
			local qattr = attrs
			for k,v in pairs(qattr) do
				qattr[k] = math.floor(v*(1+addition/100))
			end
		end
	end
	--]]
	return attrs
end

function HeroCfg:getReadableQualityAttr(heroId, quality, equality)
	local attr  = self:getQualityAttr(heroId, quality, equality)
	if attr then
		return AttrCfg:getReadableAttr(attr)
	end
end

function HeroCfg:getHeroArm(heroId)
	return self:getHero(heroId).arm
end

function HeroCfg:getArmName(arm)
	local armName = {"坦克", "战车", "飞机", "士兵"}
	return armName[arm]
end

function HeroCfg:getDefName(defType)
	local defTypes = {
	[1]="无盔甲",[2]="英雄盔甲",[3]="重型盔甲",[4]="轻型装甲",[5]="中型装甲",[6]="重型装甲",[7]="建筑",[8]="建筑",[9]="建筑",[10]="建筑",[11]="建筑"
	}
	return defTypes[defType]
end

function HeroCfg:getCurrentMaxLevel()
	local roleLv = RoleModel.roleInfo[RoleConst.LEVEL]
	return RoleLevCfg:getHeroLevAt(roleLv)
end

function HeroCfg:getMaxLevel()
	return InstCfg:getMaxLevel()
end

function HeroCfg:getFightValueFactor(heroId)
	return InstCfg:getFightFactor(heroId)
end

function HeroCfg:getMaxEQualityLevel(heroId)
	--print("function HeroCfg:getMaxEQualityLevel(heroId)", heroId)
	local cfg = self._heroQualityElite[heroId]
	if not cfg.maxLevel then
		cfg.maxLevel = #cfg
	end

	return cfg.maxLevel
end

function HeroCfg:getEQuality(heroId, level)
	return self._heroQualityElite[heroId][level]
end

function HeroCfg:getEQualityAddition(heroId, level)

	if level <= 0 or level == nil then
		return 0
	end
	local cfg = self:getEQuality(heroId, level)
	return cfg and cfg.attrPercent or 0
end

function HeroCfg:getHeroQuality(heroId)
	return InstCfg:getHeroQuality(heroId)
end
--[[
self._starAttr 			= ConfigMgr:requestConfig("hero_star_attr", nil, true)
	self._starCfg 			= ConfigMgr:requestConfig("hero_star_exp", nil, true)[1]
	self._starCost 			= ConfigMgr:requestConfig("hero_star_cost", nil, true)
--]]

function HeroCfg:getStarAttrCfg(heroId, star)
	print("function HeroCfg:getStarAttrCfg(heroId, star)", heroId, star)
	return self._starAttr[heroId][star]
end


function HeroCfg:upStar(star, curExp, addExp)
	return LevelHelper:up(self._starExpEx, star, curExp, addExp)
end

function HeroCfg:upStarNeed(star, curExp)
	return LevelHelper:upNeed(self._starExpEx, star, curExp, star+1)
end

function HeroCfg:getStarMaxExp(star)
	return self._starExp[star][1]
end


function HeroCfg:getStarAttr(heroId, star)
	local attrCfg = self:getStarAttrCfg(heroId, star)
	if not attrCfg then
		return AttrCfg:newAttr()
	end

	local attrs = AttrCfg:addAttrs(AttrCfg:newAttr(), attrCfg.attrList)
	return attrs
end

function HeroCfg:getStarCostItemId()
	return self._starCfg.id
end

function HeroCfg:getStarItemId()
	return self._starCfg.id
end

function HeroCfg:getStarItemExp()
	return self._starCfg.exp
end

function HeroCfg:getStarShopInfo()
	return self._starCfg.shop_id, self._starCfg.shop_pos
end

function HeroCfg:getStarItemCost()
	return self._starCfg.gold
end

function HeroCfg:getStarLimit(heroId)
	local cfg = self._starLimit[heroId]
	if not cfg then
		return 1,1
	end
	return cfg.min_star, cfg.max_star
end

function HeroCfg:getMaxStar(heroId)
local cfg = self._starLimit[heroId]
	if not cfg then
		return 1
	end
	return cfg.max_star
end

function HeroCfg:getMinStar(heroId)
	local cfg = self._starLimit[heroId]
	if not cfg then
		return 1
	end
	return cfg.min_star
end

return HeroCfg
