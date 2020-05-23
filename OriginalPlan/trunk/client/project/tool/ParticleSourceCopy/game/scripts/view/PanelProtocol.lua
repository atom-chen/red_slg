--[[--
module：      PanelProtocol
inhertit: CCLayerRGBA
desc：           界面类的基类
author:   HAN Biao
event：
		 无
example：

每个子类，根据需要复写此基类的：
    getAtlas：返回界面引用到的atlas列表
		getRoot： 返回要挂接到哪个容器上
		getOpenActionType：返回界面打开时动作类型
		getCloseActionType：返回界面关闭时动作类型
		
		open：打开界面,把子类对象挂接到对应的容器节点上
		close：关闭界面,把子类对象从对应的父容器节点上移除
		onOpened:界面完全打开时
    onClosed:界面完全关闭时
]]

local PanelProtocol = class("PanelProtocol",UINode)

--[[--
	构造函数
]]
function PanelProtocol:ctor(layerID,panelName)
  	self.layerID = layerID   --不同的面板  需要加在不同的 gamelayer 层
  	self.panelName = panelName   --面板名   在 common/Panel.lua  里面定义
  	UINode.ctor(self,self:getPriority(),false)
end

function PanelProtocol:initUINode(layname, plistPath)
	ResMgr:loadPvr(plistPath)
	self:setUI(layname)
	self:setPosition(display.cx,display.cy) --居中
	local closeBtn = self:getNodeByName("com_close1")
	if closeBtn then
		closeBtn:addEventListener(Event.MOUSE_CLICK,{self,self.closeSelf})
	end
end

--[[--
获取 面板的 事件优先级
]]
function PanelProtocol:getPriority()
	return GameLayer.priority[self.layerID]
end

--[[--
面板是否吞噬掉事件 
]]
function PanelProtocol:isSwallowEvent()
	return true
end

--[[--
    返回界面的打开动作类型
  	@return 动作类型，如无动作，则返回0
]]
function PanelProtocol:getOpenActionType()
  	return 0
end

--[[--
     返回界面的关闭动作类型
  @return 动作类型，如无动作，则返回0
]]
function PanelProtocol:getCloseActionType()
  	return 0
end

--[[--
	打开本界面
	@param Table params 可选参数，可以nil;params.noAction = true时此次打开可以忽视已设置的界面打开动作
	@return Boolean true:成功打开，false：已经在舞台上了
]]
function PanelProtocol:open(params)
	if self:getParent() then
		return false
	end
	local gameLayer = ViewMgr:getGameLayer(self.layerID)
	gameLayer:addPanel(self)
	local actionType = self:getOpenActionType()
	if (actionType < 1) or (params and params.noAction) then
	    self:onOpened(params)
	else
	    local action = PanelActionMgr:getOpenActionType(actionType)
	    local callback = CCCallFunc:create(function() self:onOpened(params) end)
	     
	    local openAction = CCSequence:createWithTwoActions(action,callback)
	    self:runAction(openAction)
	end
	return true
end

function PanelProtocol:onOpened(params)

end

--[[--
关闭自己
]]
function PanelProtocol:closeSelf()
	ViewMgr:close(self.panelName)
end

--[[--
	关闭本界面
	@param Table params 可选参数，可以nil;params.noAction = true时此次打开可以忽视已设置的界面关闭动作
	@return Boolean true:成功关闭，false：已经被关闭了
]]
function PanelProtocol:close(params)
	if not self:getParent() then
		return false
	end
	
	local actionType = self:getCloseActionType()
  	if  (actionType < 1) or (params and params.noAction) then
     	self:onCloseActionEnd(params)
  	else
     	local action = PanelActionMgr:getCloseActionType(actionType)
     	local callback = CCCallFunc:create(function() self:onCloseActionEnd(params) end)
   
     	local closeAction = CCSequence:createWithTwoActions(action,callback)
    	self:runAction(closeAction)
  	end
	return true
end

function PanelProtocol:onCloseActionEnd(params)
  	local gameLayer = ViewMgr:getGameLayer(self.layerID)
	gameLayer:removePanel(self)
  	self:onCloseed(params)
end

function PanelProtocol:onCloseed( params )
	-- body
end

return PanelProtocol

