--自己PanelProtocol要加的小方法可以加在下面
local PanelHelper = {}

function PanelHelper:addClickListener(uiNode,events)
	for name,listener in pairs(events) do
		uiNode:getNodeByName(name):addEventListener(Event.MOUSE_CLICK, listener)
	end
end

function PanelHelper:setTextCD(text,str,time,endCall)
    if text._cdTimer then
        scheduler.unscheduleGlobal(text._cdTimer)
    end

end

function PanelHelper:clearTextCD(text)

end

return PanelHelper
