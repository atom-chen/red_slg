local MainUIFunctionPanel = class('MainUIFunctionPanel', PanelProtocol)

local WorldModel = game_require("model.world.WorldModel")

MainUIFunctionPanel.LUA_PATH = 'main_ui_function'
function MainUIFunctionPanel:ctor()
    PanelProtocol.ctor(self, Panel.MAIN_UI_FUNCTION)
end

function MainUIFunctionPanel:init()
	self:initUINode(self.LUA_PATH)
end

function MainUIFunctionPanel:isShowMark()
    return false
end

function MainUIFunctionPanel:isSwallowEvent()
	return false
end

return MainUIFunctionPanel