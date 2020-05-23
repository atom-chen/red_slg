local RoleCfgCls = class("RoleCfgCls")
local RoleCfg = RoleCfgCls.new()

function RoleCfgCls:init()
  --角色配置
  self._cfgObj = nil
  --系统开放配置
  self._openSysCfg = nil
  
  --向ConfigMgr请求角色配置
  ConfigMgr:requestConfig("role.json",function(cfgObj) self:_parseCfg(cfgObj) end)
  ConfigMgr:removeConfig("role.json")
  
  --向ConfigMgr请求系统开放配置
  ConfigMgr:requestConfig("opensys.json",function(cfgObj) self:_parseOpenSysCfg(cfgObj) end)
  ConfigMgr:removeConfig("opensys.json")
  
end

function RoleCfgCls:_parseCfg(cfgObj)
  self._cfgObj = cfgObj
end

function RoleCfgCls:_parseOpenSysCfg(cfgObj)
  self._openSysCfg = cfgObj
end

--[[--
    返回一个系统开启的条件
  @param name String Panel.xxx 系统的名字
  @param Table 开启条件的表格
]]
function RoleCfgCls:getSysOpenCondition(name)
    
end

--[[--
  返回每日刷新的小时设置
]]
function RoleCfgCls:getRefreshHour()
  return self._cfgObj.refreshHour or 0
end

--[[--
 返回每日刷新的分钟设置
]]
function RoleCfgCls:getRefreshMin()
  return self._cfgObj.refreshMin or 0
end


return RoleCfg