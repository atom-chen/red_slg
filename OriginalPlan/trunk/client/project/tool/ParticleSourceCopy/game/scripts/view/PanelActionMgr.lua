local PanelActionMgrCls = class("PanelActionMgr")
local PanelActionMgr = PanelActionMgrCls.new()

--[[--
     返回制定类型的界面打开动作
  @param PanelProtocol panel 界面
  @param Number type 动作类型,默认值为1
  @return CCAction
]]
function PanelActionMgrCls:getOpenAction(panel,type)
  type = type or 1
  local ret = nil
  
  if type == 1 then
       panel:setScale(0)
       local scale1 = CCScaleTo:create(0.15,1.25)
       local scale2 = CCScaleTo:create(0.1,1)
       ret = CCSequence:createWithTwoActions(scale1,scale2)
  elseif type == 2 then
  
  end
  
  return ret
end

--[[--
     返回制定类型的界面关闭动作
  @param PanelProtocol panel 界面
  @param Number type 动作类型，默认值为1
  @return CCAction
]]
function PanelActionMgrCls:getCloseAction(panel,type)
  type = type or 1
  local ret = nil
  if type == 1 then
     local scale1 = CCScaleTo:create(0.1,1.25)
     local scale2 = CCScaleTo:create(0.15,0)
     ret = CCSequence:createWithTwoActions(scale1,scale2)
  elseif type == 2 then
  
  end
  
  return ret
end

return PanelActionMgr