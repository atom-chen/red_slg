local ArmyInfo = class("ArmyInfo")
-- local ArmyInfo = {}

function ArmyInfo:ctor(id )
    self:init(id)
end

function ArmyInfo:init( id )
    self.id = id or 0
    self.status = -1
    self.wildernessPos = { x = 0, y = 0}
    self.max_time = 0
    self.res_time = 0
    self.heroList = {}
    self.miningInfoList = {}
    self.max_populace = 0
end

function ArmyInfo:setData( info )
    self.id = info.id
    self.heroList = {}
    self.miningInfoList = {}
    -- self.heroList = info.heroList
    for i,v in pairs(info.heroList) do
        self.heroList[v.heroId] = v
    end

    for i,v in pairs(info.miningInfoList) do
        table.insert(self.miningInfoList,v)
    end
    self.status = info.status
    self.wildernessPos = info.wildernessPos
    self.max_time = info.max_time
    self.res_time = info.res_time
    self.max_populace = info.max_populace
end

function ArmyInfo:addHero(heroId,num)
    local info = self.heroList[heroId]
    if info then
        info.max_num = info.max_num + num
    else
        self.heroList[heroId] = {max_num = num,bad_num=0,heroId = heroId}
    end
end

function ArmyInfo:removeHero(heroId,num)
    local info = self.heroList[heroId]
    if info then
        info.max_num = info.max_num - num
        if info.max_num <= 0 then
            self.heroList[heroId] = nil
        end
    end
end

function ArmyInfo:getStatus()
    return self.status
end

function ArmyInfo:isMultiMine()
    return (#self.miningInfoList > 1 and self.status == WildernessModel.ARMY_STATUS.MINING)
end

function ArmyInfo:setHeroList( heroList )
    self.heroList = heroList
end

function ArmyInfo:getHeroList( )
    if self.heroList then
        return clone(self.heroList)
    end
    return nil
end

function ArmyInfo:getMiningList( )
    if self.miningInfoList then
        return clone(self.miningInfoList)
    end
    return nil
end

function ArmyInfo:isThisPos( pos )
    if pos.x == self.wildernessPos.x and pos.y == self.wildernessPos.y then
        return true
    else
        return false
    end
end

return ArmyInfo