
local HudPanel = class("HudPanel",PanelProtocol)

function HudPanel:ctor()
	PanelProtocol.ctor(self,GameLayer.HUD)
	self:initUI()
end

function HudPanel:initUI(  )
	-- body
end



function HudPanel:getRoot()
	return ViewMgr.hudRoot
end

function HudPanel:onEnter()
	--ViewMgr:open(Panel.HOME)
end

function HudPanel:onExit()
	--ViewMgr:close(Panel.HOME)
end

return HudPanel
