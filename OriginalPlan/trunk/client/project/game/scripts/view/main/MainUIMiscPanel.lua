local WorldModel = game_require("model.world.WorldModel")
local MainUIMiscPanel = class('MainUIMiscPanel', PanelProtocol)

MainUIMiscPanel.LUA_PATH = 'main_ui_misc'
function MainUIMiscPanel:ctor()
    PanelProtocol.ctor(self, Panel.MAIN_UI_MISC)
end

function MainUIMiscPanel:init()
	self:initUINode(self.LUA_PATH)
	self.btnWorldMap = self:getNodeByName("btn_world_map")
	self.btnMail = self:getNodeByName("btn_mail")
end

function MainUIMiscPanel:onOpened(params)
	NotifyCenter:addEventListener(Notify.PANEL_OPEN, {self,self._onPanelOpen})
	self.btnMail:addEventListener(Event.MOUSE_CLICK, {self, self._onClickMail})
end

function MainUIMiscPanel:onCloseed(params)
	NotifyCenter:removeEventListener(Notify.PANEL_OPEN, {self,self._onPanelOpen})
	self.btnMail:removeEventListener(Event.MOUSE_CLICK, {self, self._onClickMail})
end

function MainUIMiscPanel:_onPanelOpen(event)
	if event.panelName == Panel.WORLD then
		self:setWorldMapBtn(true)
	else
		self:setWorldMapBtn(false)
	end
end

function MainUIMiscPanel:_onClickMail(event)
	floatText("功能暂未开放")
end

function MainUIMiscPanel:setWorldMapBtn(flag)
	self.btnWorldMap:setVisible(flag)
	self.btnWorldMap:setEnable(flag)
end

function MainUIMiscPanel:isShowMark()
    return false
end

function MainUIMiscPanel:isSwallowEvent()
	return false
end

return MainUIMiscPanel
