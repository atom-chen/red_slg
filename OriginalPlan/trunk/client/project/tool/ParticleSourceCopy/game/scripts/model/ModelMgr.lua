local ModelMgrCls = class("ModelMgrCls")

--公共

NotifyCenter = require("model.center.NotifyCenter")
util = require("model.utils.util")

--VO类先声明
EquipInfo = require("model.bag.EquipInfo")
PetInfo   = require("model.pet.PetInfo")
RoleInfo = require("model.role.RoleInfo")


--角色
RoleModel = require("model.role.RoleModel")
RoleProxy = require("model.role.RoleProxy")

--背包
BagModel = require("model.bag.BagModel")

--宠物
PetModel = require("model.pet.PetModel")


--副本
DungeonModel = require("model.dungeon.DungeonModel")
DungeonProxy = require("model.dungeon.DungeonProxy")

BagModel = require("model.bag.BagModel")
BagProxy = require("model.bag.BagProxy")

function ModelMgrCls:init()
    -- 保存本次登陆不再提示等数据
    self._notTipData = {}
    --延迟通知数据
    self._deferData = {}
    --保存已经开启过的系统,Panel.XXX = true
    self._sysOpened = {}
    --开放功能是否已经初始化
    self._sysInited = false

    --公共
    NotifyCenter:init()
     
    --下面初始化各个系统模块
    DungeonModel:init()
    DungeonProxy:init()
	
	BagModel:init()
    BagProxy:init()
end

--[[--
  系统是否开放
  @param name String 系统的名称，Panel.xxx
]]
function ModelMgrCls:isSysOpen(name)
  local obj = self._ctrlSys[name]
  if not obj then return true end
  if self._sysOpened(name) then
    return true
  end
  return false
end

--[[--
   系统未开放时的提示
   @param name String 系统的key
   @return String 未开放时的提示语
]]
function ModelMgrCls:sysNotOpenTips(name)

end



--[[--
     检查某个功能是否需要提示
  @param key String 功能的key
  @return Boolean or nil 是否提示需要提示
]]
function ModelMgrCls:shouldTip(key)
  return self._notTipData[key]
end

--[[--
    设置某个功能点本次登陆不再提示
  @param key String 功能的key 
]]
function ModelMgrCls:setNotTip(key)
  self._notTipData[key] = true
end

--[[--
  开始每日刷新的处理
]]
function ModelMgrCls:startDailyRefresh()
  local refreshHour = RoleCfg:getRefreshHour()
  local refreshMin = RoleCfg:getRefreshMin()

  local now = os.time()*1000 --NetCenter.getTime()
  local nowTime = math.floor(now/1000)

  --算出从现在到下次更新的时间
  local nowDate = os.date("*t",nowTime)
  local nowHour = nowDate.hour
  local nowMin = nowDate.min
  --替换成刷新日期
  nowDate.hour = refreshHour
  nowDate.min = refreshMin
  nowDate.sec = 0
  local refreshTime = os.time(nowDate)

  local gap
  if (nowHour < refreshHour) or (nowHour == refreshHour and nowMin < refreshMin) then  --当天的刷新时间点还没有到
    gap = refreshTime-nowTime
  else                                        --当天的刷新时间点已经过去，下一天
    gap = 24*60*60-(nowTime - refreshTime)
  end

  self._tickHandle =CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(function() self:_onFirstTick() end,gap,false)
end

--[[--
 *第一次定时到后。
 *以后每隔24小时去请求一次
]]
function ModelMgrCls:_onFirstTick()
  CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(self._tickHandle)
  float("新的一天到来了，很多精彩内容开始刷新了！")
  NotifyCenter:dispatchEvent({name=Notify.DAILY_REFRESH})

  self._tickHandle =CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(function() self:_onTick() end,24*60*60,false)
end

--[[--
 * 每次到刷新的时间
--]]
function ModelMgrCls:_onTick()
  float("新的一天到来了，很多精彩内容开始刷新了！")
  NotifyCenter:dispatchEvent({name=Notify.DAILY_REFRESH})
end

local ModelMgr = ModelMgrCls.new()
return ModelMgr
