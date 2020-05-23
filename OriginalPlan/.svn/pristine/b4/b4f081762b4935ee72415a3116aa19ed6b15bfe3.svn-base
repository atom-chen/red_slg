--野外
local WorldModel = {}
local ArmyInfo = game_require("model.world.ArmyInfo")

WorldModel.ARMY_STATUS = {
	NONE_HERO = -1,   --没单位
	FREE = 1,  --空闲 在主基地
	FIX = 2,    --维修中
	BACK = 3, --撤回中
	STATION = 4 , --驻扎中
	MINING = 5 ,--采矿中
	CAMP_FIX = 6 ,--基地维修中
}

WorldModel.MINE = {
    [1] = {name = "水晶矿", icon = "#yw_icon_sj.png"},
    [2] = {name = "铁矿", icon = "#yw_icon_t.png"},
    [3] = {name = "铀矿", icon = "#yw_icon_y.png"},
}

WorldModel.GROUND = {
	[0] = "雪地",
    [1] = "山脉",
    [2] = "湖泊",
}

WorldModel.CARRY_BUFF = {
	[HeroInfo.ARM_CHARIOT] = {name = "战车",buff = "carryArmy_2"},
    [HeroInfo.ARM_TANK] = {name = "坦克",buff = "carryArmy_1"},
    [HeroInfo.ARM_PLAIN] = {name = "空军",buff = "carryArmy_3"},
    [HeroInfo.ARM_SOLDIER] = {name = "士兵",buff = "carryArmy_4"},
}

WorldModel.EMPTY = "empty"
WorldModel.ARMY_MINE = "army_mine"
WorldModel.ARMY_FRIEND = "army_friend"
WorldModel.ARMY_ENEMY = "army_enemy"
WorldModel.CAMP_FRIEND = "camp_friend"
WorldModel.CAMP_ENEMY = "camp_enemy"
WorldModel.CAMP_MINE = "camp_mine"
WorldModel.MONSTER = "monster"

WorldModel.RELATION = {
    [0] = WorldModel.EMPTY,
    [1] = WorldModel.ARMY_MINE,
    [2] = WorldModel.ARMY_FRIEND,
    [3] = WorldModel.ARMY_ENEMY ,
    [4] = WorldModel.CAMP_MINE,
    [5] = WorldModel.CAMP_FRIEND,
    [6] = WorldModel.CAMP_ENEMY ,
    [7] = WorldModel.MONSTER ,
}

WorldModel.STATION_HELP = 3
WorldModel.ATTACK_HELP = 4
WorldModel.MINE_HELP = 5
WorldModel.CAMP_HELP = 6

function WorldModel:init()
	self.baseInfo = nil
	self.coordList = nil
	self.armyList = nil
	self._nowPop = 0
	self._resTime = {}
	if self._timer then
		for i,timerId in pairs(self._timer) do
			scheduler.unscheduleGlobal(timerId)
		end
	end
	self._timer = {}
	self.oreImage = {[1] = '#yw_icon_sj.png', [2]='#yw_icon_t.png',[3]='#yw_icon_y.png'}
	self._message = {}
	self._feat = {}
	NotifyCenter:addEventListener(Notify.SYS_OPEN, {self,self._onSysOpen})
	NotifyCenter:addEventListener(TimeNotify.DAILY_REFRESH, { self, self._resetDaily})
end

function WorldModel:clear()
	if self._timer then
		for i,timerId in pairs(self._timer) do
			scheduler.unscheduleGlobal(timerId)
		end
	end
end

function WorldModel:_onSysOpen(e)
	if e.sys == SysConst.WORLD then  --系统开放了
		NotifyCenter:removeEventListener(Notify.SYS_OPEN, {self,self._onSysOpen})
		if not e.isInit then
			WorldModel:getBaseInfo()
		end
	end
end

function WorldModel:initBaseInfo(info,armyList)
	self.baseInfo = info --自己基地信息
	if not self.armyList then
		self.armyList = {}
	end

	local heroArmyNum = 0
	for i,v in pairs(armyList) do
		local armyInfo = ArmyInfo.new()
		armyInfo:setData(v)
		self.armyList[armyInfo.id] = armyInfo
		if self.armyList[armyInfo.id].res_time > 0 then
			self._resTime[armyInfo.id] = self.armyList[armyInfo.id].res_time
			self:countDown(armyInfo.id)
		end

		if #v.heroList > 0 then
			heroArmyNum = heroArmyNum + 1
		end
	end
	if heroArmyNum <= 0 then
--		self:_autoArrange()
	end
--	self:_checkTip()
	NotifyCenter:dispatchEvent({name=Notify.WORLD_INIT})
end

function WorldModel:updateBaseInfo(baseInfo)
	self.baseInfo = baseInfo
end

function WorldModel:setBasePos( pos )
	if self.baseInfo then
		self.baseInfo.x = pos.x
		self.baseInfo.y = pos.y
	end
end

function WorldModel:getBaseInfo()
	if self.baseInfo then
		return self.baseInfo
	else
		WorldProxy:reqWildernessInfo()
	end
end

function WorldModel:clearBaseInfo(  )
	-- body
	self.baseInfo = nil
end

function WorldModel:getArmyList()
	return self.armyList
end

function WorldModel:getArmy(index)
	if self.armyList then
		return self.armyList[index]
	else
		return nil
	end
end

function WorldModel:getArmyByPos( pos )
	if self.armyList then
		for i,army in pairs(self.armyList) do
			if army:isThisPos(pos) then
				return army
			end
		end
	else
		return nil
	end
	return nil
end

function WorldModel:setArmy(id,armyInfo)
	local oldArmy = self:getArmy(id)
	local oldState = self:getArmyStatus(id)
	local isMultiMine = oldArmy and oldArmy:isMultiMine()
	local info = ArmyInfo.new()
	info:setData(armyInfo)

	if self.armyList then
		self.armyList[id] = info
		self._resTime[id] = info.res_time
		if self._resTime[id] > 0 then
			self:countDown(id)
		end
		self:_checkTip()
	end

	NotifyCenter:dispatchEvent({name= Notify.WORLD_ARMY_UPDATE, index = id})

	if RoleModel.roleInfo.lev < 60 and oldState ~= WorldModel.ARMY_STATUS.MINING
		and self:getArmyStatus(id) == WorldModel.ARMY_STATUS.MINING then
		floatText(LangCfg:getWildernessText( 17 ))
	end
end

function WorldModel:_checkTip()
	local fixList = WorldModel:getNeedFixArmy()
	if #fixList > 0 then
		TipCenter:setTip(TipCommon.WORLD,1)
	else
		TipCenter:removeTip(TipCommon.WORLD)
	end
end


--获取第几个部队的状态
--返回：状态 1.待机(在家里)2.维修中; 3.撤回中; 4.出征中; 5.采矿中 -1没部队
function WorldModel:getArmyStatus(index)
	local army = self:getArmy(index)
	local num = WorldModel:getArmyHeroNum(index)

	if army and num > 0 then
		return army.status
	else
		return -1
	end
end

--获取传送cd时间
function WorldModel:getArmyTime(index)
	local armyInfo = self:getArmy(index)

	if armyInfo then
		if not self._resTime[index] then
			self._resTime[index] = armyInfo.res_time
		end
		return self._resTime[index],armyInfo.max_time
	end
	return nil
end

function WorldModel:countDown(index)
	if not self._timer[index] then
		self._timer[index] = scheduler.scheduleGlobal(function() self:_click_resTime(index) end, 1)
		-- self.armyList[index].status = WorldModel.ARMY_STATUS.FREE
	end
end

function WorldModel:_click_resTime(index)
	self._resTime[index] = self._resTime[index] - 1
	-- print("WorldModel:_click_resTime(index)...",index,self._resTime[index])
	if self._resTime[index] <= 0 then
		self._resTime[index] = 0
		scheduler.unscheduleGlobal(self._timer[index])
		self._timer[index] = nil

		self:_changeLocalStatus(index)
		scheduler.performWithDelayGlobal(function() WildernessProxy:reqRefreshArmy() end, 1)
	end
end

function WorldModel:_changeLocalStatus(index)
	if self.armyList then
		if self.armyList[index] and self.armyList[index].status == WorldModel.ARMY_STATUS.BACK then
			self.armyList[index].status = WorldModel.ARMY_STATUS.FREE
		end
	end
end

function WorldModel:getArmyPos(index)
	local armyInfo = self:getArmy(index)
	if armyInfo then
		return armyInfo.wildernessPos
	end
	return nil
end

--参数 heroList = { heroId=heroNum,heroId=heroNum,heroId=heroNum  }
function WorldModel:setArmyHero(index,heroList)
	local armyInfo = self:getArmy(index)

	local status = WorldModel:getArmyStatus(index)
	if status ~= WorldModel.ARMY_STATUS.NONE_HERO and status ~= WorldModel.ARMY_STATUS.FREE then
		return
	end
	if armyInfo then
		local tempList = {}
		table.merge(tempList,heroList)
		local curHeroList = armyInfo:getHeroList()
		local isSame = true
		for heroId,info in pairs(curHeroList) do
			if heroList[heroId] and heroList[heroId].max_num == info.max_num then
				heroList[heroId] = nil
			else
				isSame = false
				break
			end
		end
		if isSame then
			for _,_ in pairs(heroList) do
				isSame = false
				break
			end
		end
		if not isSame then  --不一样 有修改
			WildernessProxy:reqChangeArmyHero(index,tempList)
		end
	else
		local tempList = {}
		table.merge(tempList,heroList)
		WildernessProxy:reqChangeArmyHero(index,tempList)
	end
end

function WorldModel:getArmyHero(index)
	local armyInfo = self:getArmy(index)
	if armyInfo then
		return armyInfo:getHeroList()
	end
	return nil
end

function WorldModel:getArmyHeroNum(index)
	local armyInfo = self:getArmy(index)
	local num = 0
	if armyInfo and armyInfo:getHeroList() then
		for i,v in pairs(armyInfo:getHeroList()) do
			num = num + 1
		end
	end

	return num
end

--获取所有部队已使用的单位总和 {heroId=num,heroId=num}
function WorldModel:getTotalArmyHero()
	local totalList = {}
	if self.armyList then
		for i,armyInfo in pairs(self.armyList) do
			local heroList = armyInfo.heroList
			for heroId,info in pairs(heroList) do
				if totalList[heroId] then
					totalList[heroId] = totalList[heroId] + info.max_num
				else
					totalList[heroId] = info.max_num
				end
			end
		end
	end
	return totalList
end

--获得闲置部队
function WorldModel:getFreeHero()
	local total = HeroModel:getHeroList()
	local army = WorldModel:getTotalArmyHero()
	local free = {}
	for i,heroInfo in pairs(total) do
		local leftNum = heroInfo:getStockNum()
		for id,num in pairs(army) do
			local armyHero = HeroInfo.new(id)
			if armyHero.heroId == heroInfo.heroId then
				leftNum = leftNum - num
				table.remove(army,id)
				break
			end
		end

		if leftNum > 0 then
			local hero = { id = heroInfo.heroId, num = leftNum}
			table.insert(free,hero)
		end
	end

	return free
end

function WorldModel:getArmyPop( index )
	local armyInfo = self:getArmy(index)
	local usedPop = 0
-- dump(armyInfo)
	if armyInfo then
		for id,v in pairs(armyInfo.heroList) do
			local cfg = HeroCfg:getHero(id)
			if cfg then
				local cost = cfg.populace
				usedPop = usedPop + cost*v.max_num
			end
		end
	end

	return usedPop
end

--收藏坐标
function WorldModel:saveCoord(x,y)
	if self.coordList then
		if #self.coordList > 9 then
			floatText("收藏夹已满")
			return
		end

		for i,pos in ipairs(self.coordList) do
			if pos.x == x and pos.y == y then  --已经收藏过了
				floatText("已收藏该坐标")
				return
			end
		end
		self.coordList[#self.coordList+1] = {x=x,y=y}
	end
	WildernessProxy:reqSaveCoord(x,y)
end

function WorldModel:delCoord( pos )
	local x,y = pos.x,pos.y
	for i,pos in ipairs(self.coordList) do
		if pos.x == x and pos.y == y then  --已经收藏过了
			table.remove(self.coordList,i)
		end
	end
	NotifyCenter:dispatchEvent({name= Notify.WORLD_DEL_COORD,pos = pos})
end

function WorldModel:getCoordList()
	if self.coordList then
		return self.coordList
	else
		WildernessProxy:reqCoordList()
	end
	return nil
end
--初始化收藏的坐标列表
function WorldModel:initCoordList(coordList)
	self.coordList = coordList --收藏的坐标列表
	NotifyCenter:dispatchEvent({name= Notify.WORLD_UPDATE_COLLECTION})
end

--增加(减少)当前选择部队已用人口
function WorldModel:setPop( pop )
	local nowPop = pop
	self._nowPop = nowPop
end

function WorldModel:getPop()
	return self._nowPop
end

function WorldModel:_autoArrange()
	local totalPop = math.floor(BuildingModel:getPopulation() * WorldCfg:getPopRate())
	local armyNum = BuildingCfg:getArmyPop( BuildingCfg:getZJDId(), BuildingModel:getBuildingLevel(BuildingCfg:getZJDId()) )
	local total = HeroModel:getHeroList()
	-- local army = WorldModel:getTotalArmyHero()
	local totalNum = #total
	local armyHeroList = {}
	local num = 0
	local pop = 0
	local index = 0
	local maxPop = 0
	for i,heroInfo in pairs(total) do
		maxPop = maxPop + heroInfo.cfg.populace*heroInfo.num
	end
	maxPop = maxPop/3
	maxPop = math.min(totalPop-1,maxPop)
	maxPop = math.max(3,maxPop)
	for i,heroInfo in pairs(total) do
		pop = pop + heroInfo.cfg.populace*heroInfo.num
		if pop >= (maxPop) then
			index = index + 1
			pop = heroInfo.cfg.populace*heroInfo.num
		end
		if not armyHeroList[index] then
			armyHeroList[index] = {}
		end
		armyHeroList[index][heroInfo.heroId] = {max_num = heroInfo.num,bad_num = 0}
	end
	for i = 0,2 do
		if armyHeroList[i] then
			self:setArmyHero(i,armyHeroList[i])
		end
	end
end

function WorldModel:buyOreResult( msg )
	if msg.result == 0 then
		floatText('购买成功')
	end
end

function WorldModel:setBuyOreTimes( msg )
	self._buyTimesList = msg.resources_list
	NotifyCenter:dispatchEvent({name=Notify.WORLD_BUY_TIME})
end

function WorldModel:getBuyTimes( type )
	dump(self._buyTimesList)
	for i,v in ipairs(self._buyTimesList) do
		if v.rosources_id == type then
			return v
		end
	end
end

function WorldModel:getOreImage( type )
	return self.oreImage[type]
end

function WorldModel:getAllArmyStatus( )
    local num = BuildingCfg:getArmyPop( BuildingCfg:getZJDId(), BuildingModel:getBuildingLevel(BuildingCfg:getZJDId()) )
    local list = WorldModel:getArmyList()
    if list then
	    num = -1
	    for i,v in pairs(list) do
	        num = num + 1
	    end
	end

    local free = 0
    for i =1 ,num do
    	local status = WorldModel:getArmyStatus(i)
    	if status ~= 1 and status ~= -1 then
    		free = free + 1
    	end
    end

    return free,num
end

function WorldModel:initMessage( list )
	self._message = {}
	for i,v in pairs(list) do
		table.insert(self._message,v)
	end
end

--info是array但只有一条
function WorldModel:setMessage(info)
	for i,v in pairs(info) do
		if v.roleId == RoleModel.roleInfo[RoleConst.ID] then
			NotifyCenter:dispatchEvent({name=Notify.WORLD_LEAVE_MESSAGE,chat = v})
		else
			table.insert(self._message,v)
			NotifyCenter:dispatchEvent({name=Notify.WORLD_ADD_MESSAGE,chat = v})
			TipCenter:setTipByKey(TipCommon.WORLD_NEWS,Panel.WILD_MESSAGE,#self._message)
		end
	end
end

function WorldModel:getMessage()
	local plist = {}

    for i,v in pairs(self._message) do
        table.insert(plist ,v)
    end

    local fun = function(role1 , role2)
        if role1.time < role2.time then
            return true
        else
            return false
        end
    end

    table.sort(plist,fun)
    return plist
end

function WorldModel:getMiningList( index )
	local army = WorldModel:getArmy(index)
	if army then
		return army:getMiningList()
	end
	return nil
end

function WorldModel:getMaxPop( index )
	local army = WorldModel:getArmy(index)
	if army then
		return army.max_populace
	end
	return nil
end

--需要维修的部队
function WorldModel:getNeedFixArmy()
	local list = WorldModel:getArmyList()
	local needFix = {}

	for i,v in pairs(list) do
		local status = WorldModel:getArmyStatus(v.id)
		if status == WorldModel.ARMY_STATUS.FIX then
			table.insert(needFix,v.id)
		end
	end

	return needFix
end

--买部队使用时间
function WorldModel:getArmyResTime( index )
local resTime = 0
if index == 4 then
	resTime = TimeCenter:getTimeStamp() + 86400
end
	-- local army = WorldModel:getArmy(index)
	-- if army and resTime > 0 then
		return resTime
	-- end
	-- return 0
end

function WorldModel:getSingleHeroCarry( id )
	return 20
end

function WorldModel:getArmyCarry( index )
	local heroList = WorldModel:getArmyHero(index)
	local carry = 0

	for id,v in pairs(heroList) do
		local single = self:getSingleHeroCarry(id)
		carry = carry + single * v.max_num
	end
	return carry
end

function WorldModel:getArmySpeedUp( index )
	local heroList = WorldModel:getArmyHero(index)
	local heroNum = WorldModel:getArmyHeroNum(index)
	local isGoldCar = 0
	local speedUp = 0
	for id,v in pairs(heroList) do
		if id == 2009 then  --采矿车
			isGoldCar = isGoldCar + 1
		end
	end

	if isGoldCar > 0 and isGoldCar == heroNum then
		local heroInfo = HeroModel:getHeroInfo(2009)
		heroInfo:updateAttr()
		speedUp = heroInfo.attr['mine_add']
	end
	return speedUp
end

function WorldModel:setFeatDrawList( list )
	if list then
		self._feat = clone(list)
	end

	WorldModel:checkFeatTip()
end

function WorldModel:isFeatDraw( index )
	for i,v in pairs(self._feat) do
		if index == v then
			return true
		end
	end

	return false
end

function WorldModel:_resetDaily( event )
	self._feat = {}
end

function WorldModel:checkFeatTip()
	local list = WorldCfg:getFeatList()
	local value = 0
	for i,v in ipairs(list) do
		if RoleModel.roleInfo[RoleConst.FEATS] >= v.score and not WorldModel:isFeatDraw( v.index ) then
			value = value + 1
		end
	end
	if value > 0 then
		TipCenter:setTip(TipCommon.WILD_FEAT,value)
	else
		TipCenter:removeTip(TipCommon.WILD_FEAT)
	end
end

return WorldModel
