local MainUIChatPanel = class('MainUIChatPanel', PanelProtocol)

local WorldModel = game_require("model.world.WorldModel")

MainUIChatPanel.LUA_PATH = 'main_ui_chat'
function MainUIChatPanel:ctor()
    PanelProtocol.ctor(self, Panel.MAIN_UI_CHAT)
end

function MainUIChatPanel:init()
	self:initUINode(self.LUA_PATH)
end

function MainUIChatPanel:isShowMark()
    return false
end

function MainUIChatPanel:isSwallowEvent()
	return false
end

return MainUIChatPanel