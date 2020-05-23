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

local PanelProtocol = class("PanelProtocol",PanelNodeProtocol)

PanelProtocol.CLOSE_BTN = 1
PanelProtocol.OUTSIDE_CLOSE = 2
PanelProtocol.CLICK_CLOSE	= 3

function PanelProtocol:initUINode(layname, pvrPath)
    PanelNodeProtocol.initUINode(self,layname,pvrPath)
    self:setPosition(display.cx,display.cy) --居中
end

--[[--
    构造函数
]]
function PanelProtocol:initBgImage(res,w,h)
    if not self._pBgImage then
        self._pBgImage = display.newXSprite(res)
        self:addChild(self._pBgImage,-1)
    else
        self._pBgImage:setSpriteImage(res)
    end
    self._pBgImage.imageRes = res
    self._pBgImage.w = w
    self._pBgImage.h = h
end

function PanelProtocol:loadRes(...)
    PanelNodeProtocol.loadRes(self,...)
    if self._pBgImage then
        self._pBgImage:setSpriteImage(self._pBgImage.imageRes)
        if self._pBgImage.w then
            self._pBgImage:setImageSize(CCSize(self._pBgImage.w,self._pBgImage.h))
        end
    end
end

function PanelProtocol:unloadRes(...)
    if self._pBgImage then
        self._pBgImage:setSpriteImage(nil)
    end
    PanelNodeProtocol.unloadRes(self,...)
end

function PanelProtocol:setTitleText(str,isRichText)
    if not self._panelTitleText then
        self._panelTitleText = UIText.new(200, 30, 32, nil, UIInfo.color.white, UIInfo.alignment.LEFT, UIInfo.alignment.CENTER, isRichText, false, true)
        local bg = self.uiNode:getNodeByIndex(1)
        local size = bg:getContentSize()
        local x,y = bg:getPosition()
        self._panelTitleText:setPosition(x + 92,y+size.height-50)
        self.uiNode:addNodeWithName(self._panelTitleText, "_panelTitleText")
    end
    self._panelTitleText:setText(str)
end

function PanelProtocol:setCloseBtn( name,func )
    local closeBtn
    if name == PanelProtocol.CLOSE_BTN then
        closeBtn = UIButton.new({"#com_btn_8.png"},self:getPriority(),true)
        closeBtn:setEnlarge(true) --扩大点击范围
        local bg = self.uiNode:getNodeByIndex(1)
        local size = bg:getContentSize()
        local x,y = bg:getPosition()
        closeBtn:setPosition(x+size.width+5,y+size.height-2)
        closeBtn:setAnchorPoint(ccp(1,1))
        self.uiNode:addNodeWithName(closeBtn, "_panelCloseBtn",100)
        self.closeFun = func
        closeBtn:setAudioId(nil)
        closeBtn:addEventListener(Event.MOUSE_CLICK,{self,self._onCloseEvent})
    elseif name == PanelProtocol.OUTSIDE_CLOSE then
        self.outsideClose = true  --点击到面板外部 关闭面板   需要再调用 setPanelRectByName  方法 设置 面板的真实区域
        self.closeFun = func
	elseif name == PanelProtocol.CLICK_CLOSE then
		self.clickClose = true
		self.closeFun = func
    else
        closeBtn = self.uiNode:getNodeByName(name)
        self.closeFun = func
        closeBtn:setAudioId(nil)
        if closeBtn.setEnlarge then
            closeBtn:setEnlarge(true)
        end
        closeBtn:addEventListener(Event.MOUSE_CLICK,{self,self._onCloseEvent})
    end
end

function PanelProtocol:_onCloseEvent( event )
    -- AudioMgr:playEffect("u_slide1")
    if self.closeFun then
        self.closeFun()
    else
        self:closeSelf(self.isLinkPanel)
    end
end

-- 在指定的面板容器containerName区域外面的时候自动关闭
function PanelProtocol:setOutsideClose(containerName,func)
    if type(containerName) == "string" then
        self:setPanelRectByName(containerName)
    else
        self:setPanelRectByNode(containerName)
    end
    self:setCloseBtn(self.OUTSIDE_CLOSE,func)
end

function PanelProtocol:setClickClose(func)
	self:setCloseBtn(self.CLICK_CLOSE, func)
end

--设置面板区域
function PanelProtocol:setPanelRectByName( nodeName )
    self.panelRectNode = self:getNodeByName(nodeName)
end

function PanelProtocol:setPanelRectByNode( node )
    self.panelRectNode = node
end


--是否显示半透明遮罩
function PanelProtocol:isShowMark( )
    return true
end

--[[--
面板是否吞噬掉事件
]]
function PanelProtocol:isSwallowEvent()
    return true
end

--[[--
获取面板区域大小
]]
function PanelProtocol:getPanelRect()
    if self.panelRectNode then
        local rectNode = self.panelRectNode
        return rectNode:boundingBox(), rectNode
    end
    return nil
end

function PanelProtocol:isTouchOn(x, y)
    local rect,node = self:getPanelRect()
    if rect then
        local pos = node:getParent():convertToNodeSpace(ccp(x,y))
        if rect:containsPoint(pos) then
            return true
        end
    end
end

--[[--
点击到面板
]]
function PanelProtocol:onPanelTouchUp( x,y,downX,downY )
	local closed = false
    if self.outsideClose and (math.abs(x-downX) + math.abs(y-downY) < 30) then
        local rect,node = self:getPanelRect()
        if rect then
            local pos = node:getParent():convertToNodeSpace(ccp(x,y))
            if rect:containsPoint(pos) then
                return true
            else
				closed = true
            end
        end
	elseif self.clickClose then
		closed = true
    end
	if closed then
		if self.closeFun then
			self.closeFun(self)  --点在面板区域外面了  关闭面板
		else
			self:closeSelf(self.isLinkPanel)
		end
	end
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
function PanelProtocol:checkOpen(params)
    return true
end

function PanelProtocol:preOpen(params)

end

function PanelProtocol:open(params)
    if self:getParent() then
        return false
    end
    --在viewMgr里面已经有 checkOpen了
    -- if self:checkOpen(params) == false then
    --  return false
    -- end
    self:preOpen(params)
    local gameLayer = ViewMgr:getGameLayer(self.layerID)
    gameLayer:addPanel(self)
    local actionType = self:getOpenActionType()
    if (actionType < 1) or (params and params.noAction) then
        self:onOpened(params)
    else
        --local callback1 = CCCallFunc:create(function() self:preOpen(params) end)
        local action = PanelActionMgr:getOpenAction(self,actionType)
        local callback2 = CCCallFunc:create(function() self:onOpened(params) end)

        local openAction = nil
        if true == self._onOpenedBeforeActionFlag then
            self:onOpened(params)
            openAction = action
        else
            openAction = transition.sequence({ action, callback2})--CCSequence:createWithTwoActions(action,callback2)
        end

        self:runAction(openAction)
    end
    return true
end

function PanelProtocol:onOpened(params)

end

--[[--
关闭自己
]]
function PanelProtocol:closeSelf(isLinkPanel,params)
    if self.parentPanelName then
        local parentPanel = ViewMgr:getPanel(self.parentPanelName)
        parentPanel:closeChild(self.panelName)
    else
        print('self.panelName ..' .. self.panelName ..'close',self.isLinkPanel,isLinkPanel)
        ViewMgr:close(self.panelName,params,isLinkPanel)
    end
end

--[[--
    关闭本界面
    该方法只给ViewMgr调用   其他情况一般不调用  需要的话只是调用 closeSelf（）

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
        local action = PanelActionMgr:getCloseAction(self,actionType)
        local callback = CCCallFunc:create(function() self:onCloseActionEnd(params) end)
        print("function PanelProtocol:close(params)", action, callback)
        local closeAction = CCSequence:createWithTwoActions(action,callback)
        self:runAction(closeAction)
    end
    return true
end

function PanelProtocol:onCloseActionEnd(params)
    local gameLayer = ViewMgr:getGameLayer(self.layerID)
    gameLayer:removePanel(self)
    self:onCloseed(params)
    --NotifyCenter:dispatchEvent({ name=Notify.PANEL_CLOSE, panelName = self.panelName})
end

function PanelProtocol:onCloseed( params )
    -- body
end


--清除整个面板对象
function PanelProtocol:dispose()
    local gameLayer = ViewMgr:getGameLayer(self.layerID)
    gameLayer:removePanel(self)
    PanelNodeProtocol.dispose(self)
end

return PanelProtocol
