--
-- Author: wdx
-- Date: 2014-06-07 14:30:24
--
local GameLayer = class("GameLayer",function() return display.newLayer() end)

GameLayer.layer = {Panel.PanelLayer.SCENE,Panel.PanelLayer.HUD,Panel.PanelLayer.POPUP,Panel.PanelLayer.MENU_LAYER,Panel.PanelLayer.POPUP_TOP
				,Panel.PanelLayer.NOTIFY,Panel.PanelLayer.NOTIFY_TOP,Panel.PanelLayer.MASK_LAYER,Panel.PanelLayer.ERROR_LAYER}

--各个层的事件优先级
GameLayer.priority = {
  [Panel.PanelLayer.SCENE]      = -0x0100,
  [Panel.PanelLayer.HUD]     	= -0x0200,
  [Panel.PanelLayer.POPUP] 	= -0x0300,
  [Panel.PanelLayer.MENU_LAYER]   = -0x0400,   --右边菜单栏层次
  [Panel.PanelLayer.POPUP_TOP]	= -0x0500,
  [Panel.PanelLayer.NOTIFY]     = -0x0600,
  [Panel.PanelLayer.NOTIFY_TOP]    = -0x0700,
  [Panel.PanelLayer.MASK_LAYER]     = -0x0800,
  [Panel.PanelLayer.ERROR_LAYER]    = -0x0900
}

function GameLayer:ctor(name)
	local priority = GameLayer.priority[name]
	self:setTouchEnabled(true)
	self:addTouchEventListener(handler(self,self._onTouch),false,priority + 1,true)

	self.curOpenPanel = {}

	self.layerName = name

	self.maskLayer = display.newXSprite("#tt_6.png")
	uihelper.setRect9(self.maskLayer, "#tt_6.png")
	-- self.maskLayer:setOpacity(255*0.85)
	self.maskLayer:setImageSize(CCSize(display.width+60,display.height+30))
	self.maskLayer:setAnchorPoint(ccp(0,0))
	self.maskLayer:setPosition(-40,-15)
	self.maskLayer:retain()
	self.maskLayer:setVisible(false)
    --self.maskLayer:registerWithTouchDispatcher()
	self:addChild(self.maskLayer)
	self._downX,self._downY = 0,0

end

--是否要吞掉事件
function GameLayer:_onTouch( e,x,y )
	if e == "began" then
		if self.isShowMask then
			return true
		end
		if true == self._bTouchCover then
			return true
		end
		for i=#self.curOpenPanel,1,-1 do
			local panel = self.curOpenPanel[i]
			if panel:isSwallowEvent() then  --上面有面板需要 吞掉事件
				self._downX,self._downY = x,y
				print("游戏层吞事件，",self.layerName,GameLayer.priority[self.layerName],self.layerName)
				return true
			end
		end
		return false
	elseif e == "ended" then
		for i=#self.curOpenPanel,1,-1 do
			local panel = self.curOpenPanel[i]
			if panel:isSwallowEvent() then  --上面有面板需要 吞掉事件
				panel:onPanelTouchUp(x,y,self._downX,self._downY)	-- 未点击到面板
				break
			end
		end
		NotifyCenter:dispatchEvent({name=Notify.MOUSE_CLICK})
	end
end

function GameLayer:setTouchCover(flag)
	if true == flag then
		self._bTouchCover = true
	else
		self._bTouchCover = false
	end
end

function GameLayer:hasPanel()
	--[[
	print('#self.curOpenPanel ..' .. #self.curOpenPanel)
	if 0 == #self.curOpenPanel then
		return false
	else
		return true
	end
	--]]
	for _,v in ipairs(self.curOpenPanel) do
		if v:isOpen() == true then
			-- print('v.name ' .. v:getPanelName() .. ' isOpen')
			return true
		end
	end
	return false
end

function GameLayer:hasPanel(panel)
	return table.indexOf(self.curOpenPanel,panel) > 0
end

function GameLayer:addPanel( panel )
	self.curOpenPanel[#self.curOpenPanel+1] = panel
	self:addChild(panel)
	if panel:isShowMark() then
		self.maskLayer:setVisible(true)
	end
end

function GameLayer:removePanel( panel )
	local index = table.indexOf(self.curOpenPanel,panel)
	if index > 0 then
		table.remove(self.curOpenPanel,index)
		self:removeChild(panel)

		local isHideMask = true
		for _,panel in ipairs(self.curOpenPanel) do
			if panel:isShowMark() then
				isHideMask = false
				break
			end
		end
		if isHideMask then
			self.maskLayer:setVisible(false)
		end
	end
end

function GameLayer:showMask(isShow )
	self.isShowMask = isShow
	if isShow then
		self.maskLayer:setVisible(true)
	else
		self.maskLayer:setVisible(false)
	end
end

function GameLayer:closeAllPanel()
	for _,panel in ipairs(self.curOpenPanel) do
		ViewMgr:close(panel:getPanelName())
	end
end

function GameLayer:getPriority()
	return GameLayer.priority[self.layerName]
end

return GameLayer