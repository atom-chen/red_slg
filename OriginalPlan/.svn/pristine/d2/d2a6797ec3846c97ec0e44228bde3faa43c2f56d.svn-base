--
-- Author: wdx
-- Date: 2014-07-29 15:04:23
--

local WorldCfg = class("WorldCfg")

function WorldCfg:ctor()

end

function WorldCfg:init()
    self._distance = ConfigMgr:requestConfig("wilder_distance", nil, true)
    self.buyCfg = ConfigMgr:requestConfig('wilder_buy', nil, true)
    self._mine = ConfigMgr:requestConfig("wilder_mine", nil, true)
    self._army = ConfigMgr:requestConfig("wilder_army", nil, true)
    self._monster = ConfigMgr:requestConfig("wilder_monster", nil, true)
    self._monsterReward = ConfigMgr:requestConfig("wilder_monster_reward", nil, true)
	self._camp = ConfigMgr:requestConfig("wilder_camp_defend", nil, true)
    self._armyFix = ConfigMgr:requestConfig("wilder_army_fix", nil, true)
    self._feat = ConfigMgr:requestConfig("wilder_feat", nil, true)
end

function WorldCfg:getCost( time)
    if time > self:getMaxTimes() then
        time = self:getMaxTimes()
    -- else
    --     self.buyCfg[self:getMaxTimes()].costGold
    end
        return self.buyCfg[time].costGold
end

function WorldCfg:getOre( time, type )
    if time > self:getMaxTimes() then
        time = self:getMaxTimes()
    end
        local timeInfo = self.buyCfg[time]
        if type == 1 then
            return self.buyCfg[time].getcrystal
        elseif type == 2 then
            return self.buyCfg[time].getiron
        elseif type == 3 then
            return self.buyCfg[time].getu
        end
end

function WorldCfg:getMaxTimes(  )
    return #self.buyCfg
end

function WorldCfg:getDistanceCfgIndex( pos , basePos)
    local nowPosX,nowPosY = pos.x,pos.y
    local basePosX,basePosY = basePos.x,basePos.y

    local distance = math.ceil( math.sqrt( math.pow(nowPosX - basePosX,2) + math.pow(nowPosY - basePosY,2) ) )

    local index = 50
    local max = 0
    local maxList = {}
    for i,v in pairs(self._distance) do
        if distance <= v.distance then
            table.insert(maxList,v.distance)
        end

        if max <= v.distance then
            max = v.distance
        end
    end

    table.sort(maxList)
    if #maxList == 0 then
        index = max
    else
        index = maxList[1]
    end
    return index,distance
end

function WorldCfg:getDistanceCost( pos , basePos)
    local index,distance = self:getDistanceCfgIndex( pos , basePos)
    local cost = self._distance[index].tran_cost

    return distance,cost
end

function WorldCfg:getDistanceRate( pos , basePos)
    local index,distance = self:getDistanceCfgIndex( pos , basePos)
    local rate =  self._distance[index].decay_rate

    return rate
end

function WorldCfg:getMoveCampCost( pos , basePos)
    local index,distance = self:getDistanceCfgIndex( pos , basePos)
    local cost =  self._distance[index].tranbase_cost

    return cost
end

function WorldCfg:getSpyCost(lev)
    return 100 + lev*10
end

function WorldCfg:getMineSpeed( id , lev)
    local speed = 0
    for i,v in pairs(self._mine) do
        if v.resoure_ID == id and v.resoure_lev == lev then
            speed = v.max_velocity
        end
    end
    return speed
end

function WorldCfg:getPopRate( index )
    local rate = 1
    for i,v in pairs(self._army) do
        if index ~= 0 then
            rate = v.sendarmy_rate / 100
        else
            rate = v.guard_rate / 100
        end
    end
    return rate
end

function WorldCfg:getFightRate( pos )
    local rate = {}
    for i,v in pairs(self._army) do
        rate = v.joblayer
        break
    end

    local num = rate[1][pos]
    return num
end

function WorldCfg:getCost(status)
    if status == WildernessModel.CAMP_ENEMY then
        return self:getRobCost()
    elseif status == WildernessModel.MONSTER then
        return  self:getMonsterCost()
    else
        return  self:getTranCost()
    end
end

function WorldCfg:getTranCost()
    local cost = 0
    for i,v in pairs(self._army) do
        cost = v.tran_cost
        break
    end

    return cost
end

function WorldCfg:getRobCost()
    local cost = 0
    for i,v in pairs(self._army) do
        cost = v.rob_cost
        break
    end

    return cost
end

function WorldCfg:getMonsterCost()
    local cost = 0
    for i,v in pairs(self._army) do
        cost = v.monster_cost
        break
    end

    return cost
end

function WorldCfg:getMonsterLead( lev )
    if self._monster[lev] then
        return self._monster[lev].lead[1][1]
    end
    return nil
end

function WorldCfg:getMonsterReward( lev )
    local reward = {}
    if self._monster[lev] then
        for i,v in ipairs(self._monster[lev].reward[1]) do
            reward[i] = v
        end
    end
    return reward
end

function WorldCfg:getMonsterCoin( lev )
    if self._monster[lev] then
        return self._monster[lev].coinreward
    end
    return nil
end

function WorldCfg:getMonsterItemsReward( id )
    if self._monsterReward[id] then
        local reward = {}
        for i,v in ipairs(self._monsterReward[id].monitem) do
            reward[v[1]] = v[2]
        end
        return reward
    end
    return nil
end

function WorldCfg:getMonsterFirstKill( id )
    if self._monsterReward[id] and self._monsterReward[id].first_kill_monitem then
        local reward = {}
        for i,v in ipairs(self._monsterReward[id].first_kill_monitem) do
            reward[v[1]] = v[2]
        end
        return reward
    end
    return nil
end

--根据战斗力获取颜色
function WorldCfg:getColorByFightValue(fightValue)
    -- local diff = fightValue - HeroModel:getFightNumber()
    -- if diff >= 4001 then
    --     return UIInfo.color.purple
    -- elseif diff >= -2009 then
    --     return UIInfo.color.red
    -- else
    --     return UIInfo.color.white
    -- end
    return UIInfo.color.red
end

--根据关系获取颜色
function WorldCfg:getColorByRelationShip(relationShip)
    if relationShip == 1 then  --自己
        --return UIInfo.color.white
		return ccc3(255,215, 0)
    elseif relationShip == 2 then  --盟友
        return UIInfo.color.green
    else --非盟友
        --return UIInfo.color.red
		return UIInfo.color.white
    end
end

WorldCfg.MINE_LEV_COLOR = {
    [1] = ccc3(24,254,0),
    [2] = ccc3(24,254,0),
    [3] = ccc3(15,210,254),
    [4] = ccc3(15,210,254),
    [5] = ccc3(171,91,255),
    [6] = ccc3(171,91,255),
}
--根据等级获取颜色
function WorldCfg:getColorByLevel(level)
    return WorldCfg.MINE_LEV_COLOR[level] or WorldCfg.MINE_LEV_COLOR[6]
end

WorldCfg.MINE_LEV = {
    [1] = "green",
    [2] = "green",
    [3] = "blue",
    [4] = "blue",
    [5] = "purple",
    [6] = "purple",
}
--根据等级获取颜色
function WorldCfg:getColorStrByLevel(level)
    return WorldCfg.MINE_LEV[level] or WorldCfg.MINE_LEV[6]
end

function WorldCfg:getCampFixCost()
    return self._camp[1].cost[1][2],self._camp[1].cost[1][1]
end

function WorldCfg:getCampDefendReward()
    return self._camp[1].base_lev_reward
end

function WorldCfg:getArmyFixCost( fight )
    local index = 100
    local max = 0
    local maxList = {}
    for i,v in pairs(self._armyFix) do
        if fight <= v.repairforce then
            table.insert(maxList,v.repairforce)
        end

        if max <= v.repairforce then
            max = v.repairforce
        end
    end

    table.sort(maxList)
    if #maxList == 0 then
        index = max
    else
        index = maxList[1]
    end
    return self._armyFix[index].require_iron
end

function WorldCfg:getFeatList()
    return self._feat
end

function WorldCfg:getFeatCrystal( index )
    if self._feat[index] then
        return self._feat[index].crystal
    end

    return nil
end

return WorldCfg.new()
