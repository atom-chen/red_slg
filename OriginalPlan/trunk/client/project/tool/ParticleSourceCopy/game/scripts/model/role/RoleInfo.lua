local RoleInfo = class("RoleInfo")

function RoleInfo:ctor()
  self.roleId = 0  --角色id
  self.roleName = 0 --角色名字
  self.level = 0   --角色等级
  self.exp   = 0   --角色当前经验值
  self.vipLevel = 0   --角色vip等级
  self.vipExp = 0     --角色当前vip经验值
  self.gender = GameConst.FEMALE --角色的性别
  self.lp = 0 --领导力
  self.vit = 0  --行动力
  
  --角色的货币信息
  self.ccy = 0   
  self.gcy = 0   
  self.bcy = 0 
end

return RoleInfo