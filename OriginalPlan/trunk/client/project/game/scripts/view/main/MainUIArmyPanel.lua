local MainUIArmyPanel = class('MainUIArmyPanel', PanelProtocol)

local WorldModel = game_require("model.world.WorldModel")

MainUIArmyPanel.LUA_PATH = 'main_ui_army'
function MainUIArmyPanel:ctor()
    PanelProtocol.ctor(self, Panel.MAIN_UI_ARMY)
end

function MainUIArmyPanel:init()
	self:initUINode(self.LUA_PATH)
end

function MainUIArmyPanel:isShowMark()
    return false
end

function MainUIArmyPanel:isSwallowEvent()
	return false
end

return MainUIArmyPanel