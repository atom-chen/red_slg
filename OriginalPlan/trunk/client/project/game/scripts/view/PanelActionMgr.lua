local PanelActionMgrCls = class("PanelActionMgr")
--local PanelActionMgr = PanelActionMgrCls.new()

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
	   local size = panel:getContentSize()
	   panel:setPosition(ccp(size.width/2+70,size.height/2+5))
	   --panel:setPosition(ccp(-size.width/2, -size.height/2))
	   --ret = CCMoveTo:create(0.6, ccp((size.width+62)/2, panel:getPositionY()))
	   ret = CCMoveTo:create(0.1, ccp(size.width/2+70,size.height/2+5))
	elseif type == 3 then
	   local size = panel:getContentSize()
	   ret = CCMoveTo:create(0.1, ccp(panel:getPositionX(),panel:getPositionY()+size.height))
	elseif type == 4 then
	    panel:setPositionY(-display.cy)
	    local x = panel:getPositionX()
	    ret = CCMoveTo:create(0.3, ccp(x,display.cy))
	elseif type == 11 then
		ret = panel:getHungAppearAction()
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
		local size = panel:getContentSize()
		--ret = CCMoveTo:create(0.6, ccp(-size.width/2, panel:getPositionY()))
		ret = CCMoveTo:create(0.3, ccp(-size.width/2,-size.height/2))
	elseif type == 3 then
	    local size = panel:getContentSize()
	    ret = CCMoveTo:create(0.1, ccp(panel:getPositionX(),panel:getPositionY()-size.height))
	elseif type == 4 then
	    local x = panel:getPositionX()
	    ret = CCMoveTo:create(0.3, ccp(x,-display.cy))
	elseif type == 11 then
		ret = panel:getHungDisappearAction()
	end
  return ret
end

return PanelActionMgrCls