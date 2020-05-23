local MainUIDetailPanel = class('MainUIDetailPanel', PanelProtocol)

local WorldModel = game_require("model.world.WorldModel")

MainUIDetailPanel.LUA_PATH = 'main_ui_detail'
function MainUIDetailPanel:ctor()
    PanelProtocol.ctor(self, Panel.MAIN_UI_DETAIL)

	NotifyCenter:addEventListener(Notify.ROLE_UPDATE, {self, self.roleUpdate})
end

function MainUIDetailPanel:init()
	self:initUINode(self.LUA_PATH)

	self._txtLevel = self.uiNode:getNodeByName("txt_level")
	self._txtLevel:setText("")
	self._txtVipLevel = self.uiNode:getNodeByName("txt_vip")
	self._txtVipLevel:setText("")
	self._txtName = self.uiNode:getNodeByName("txt_name")
	self._txtName:setText("")
	self._txtChargeGold = self.uiNode:getNodeByName("txt_chargegold")
	self._txtChargeGold:setText("")
	self._txtGold = self.uiNode:getNodeByName("txt_gold")
	self._txtGold:setText("")
	self._txtExp = self.uiNode:getNodeByName("txt_exp")
	self._txtExp:setText("")

	self:roleInit()
end
function MainUIDetailPanel:roleInit()
	self._txtLevel:setText("LV"..RoleModel:getLevel())
	self._txtVipLevel:setText("VIP"..RoleModel:getVipLevel())
	self._txtName:setText(RoleModel:getName())
	self._txtChargeGold:setText(RoleModel:getChargeGold())
	self._txtGold:setText(RoleModel:getGold())
	self._txtExp:setText(RoleModel:getExp())
end

function MainUIDetailPanel:roleUpdate(event)
	self:roleInit()
end

function MainUIDetailPanel:onOpened()
	NotifyCenter:addEventListener(Notify.ROLE_UPDATE, {self, self.roleUpdate})
end

function MainUIDetailPanel:onCloseed()
	NotifyCenter:removeEventListener(Notify.ROLE_UPDATE, {self, self.roleUpdate})

	self._txtLevel:setText("")
end

function MainUIDetailPanel:isShowMark()
    return false
end

function MainUIDetailPanel:isSwallowEvent()
	return false
end

return MainUIDetailPanel