local personInfo = class("personInfo")

function personInfo:ctor(id )
    self:init(id)
end

function personInfo:init( id )
    self.index = index or 0
    self.logID = WildBattleModel.PERSON
    self.type = 0
    self.status = 0
    self.unionName = ""
    self.unionTitile = 0
    self.roleName = ""
    self.is_win = 1
    self.x = 0
    self.y = 0
    self.time = 0
    self.is_read = 0
end

function personInfo:setData( info )
    self.index = info.index
    self.type = info.type
    self.status = info.status
    self.unionName = info.unionName
    self.unionTitile = info.unionTitile
    self.roleName = info.roleName
    self.is_win = info.is_win
    self.x = info.wildernessPos.x
    self.y = info.wildernessPos.y
    self.time = info.time
    self.is_read = info.is_read
end

return personInfo