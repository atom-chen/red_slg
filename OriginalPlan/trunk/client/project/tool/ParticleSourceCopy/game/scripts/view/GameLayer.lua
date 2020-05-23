--
-- Author: wdx
-- Date: 2014-06-07 14:30:24
--
local GameLayer = class("GameLayer",function() return display.newLayer() end)

GameLayer.SCENE = "scene"  --场景层
GameLayer.HUD = "hud"   --主界面层
GameLayer.HUD_TOP = "hudTop"  --主界面top
GameLayer.POPUP = "popup"   --全屏界面层 
GameLayer.POPUP_TOP = "popupTop"   --全屏界面top   半屏窗口
GameLayer.NOTIFY = "notify"    --弹出框 
GameLayer.NOTIFY_TOP = "notifyTop"   --弹出框 top

GameLayer.layer = {GameLayer.SCENE,GameLayer.HUD,GameLayer.HUD_TOP,GameLayer.POPUP,GameLayer.POPUP_TOP,GameLayer.NOTIFY,GameLayer.NOTIFY_TOP}

--各个层的事件优先级
GameLayer.priority = {
  [GameLayer.SCENE]      = -0x0100,
  [GameLayer.HUD]     	= -0x0200,
  [GameLayer.HUD_TOP]   = -0x0300,
  [GameLayer.POPUP] 	= -0x0400,
  [GameLayer.POPUP_TOP]	= -0x0500,
  [GameLayer.NOTIFY]     = -0x0600,
  [GameLayer.NOTIFY_TOP]    = -0x0700
}


function GameLayer:ctor(name)
	local priority = GameLayer.priority[name]
	self:setTouchEnabled(true)
	self:addTouchEventListener(handler(self,self._onTouch),false,priority,true)  

	self.curOpenPanel = {}

	self.markLayer = display.newColorLayer(ccc4(0,0,0,100))
	self.markLayer:setContentSize(CCSize(display.width,display.height))
	self.markLayer:retain()
	self.markLayer:setVisible(false)
	self:addChild(self.markLayer)
end

--是否要吞掉事件
function GameLayer:_onTouch( e,x,y )
	for i,panel in ipairs(self.curOpenPanel) do
		if panel:isSwallowEvent() then  --上面有面板需要 吞掉事件
			return true
		end
	end
	return false
end

function GameLayer:addPanel( panel )
	self.curOpenPanel[#self.curOpenPanel+1] = panel
	self:addChild(panel)
	if #self.curOpenPanel == 1 then
		self.markLayer:setVisible(true)
	end
end

function GameLayer:removePanel( panel )
	local index = table.indexOf(self.curOpenPanel,panel)
	table.remove(self.curOpenPanel,index)
	self:removeChild(panel)
	if #self.curOpenPanel == 0 then
		self.markLayer:setVisible(false)
	end
end

return GameLayer