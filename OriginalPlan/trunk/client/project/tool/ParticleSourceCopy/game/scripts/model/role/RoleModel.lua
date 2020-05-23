--
-- Author: wdx
-- Date: 2014-04-14 14:22:50
--
local RoleModel = class("RoleModel")

function RoleModel:ctor()
   self.accountId = 0  --玩家的账号id，不属于具体某个角色信息，因此在RoleModel中声明
end

function RoleModel:init()
	
end

function RoleModel:setRoleInfo( info )
	self.roleInfo = info
end

function RoleModel:updateRoleInfo(key,value)
	self.roleInfo[key] = value
end


return RoleModel.new()