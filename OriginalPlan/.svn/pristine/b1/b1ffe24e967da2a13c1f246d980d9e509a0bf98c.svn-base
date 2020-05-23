local PanelShowExtend = {}

function PanelShowExtend.extend(panel)
	function panel:show(flag)
		local isRunning = self:isRunning()
	    if flag then
	        if not isRunning then
	            local gameLayer = ViewMgr:getGameLayer(self.layerID)
	            gameLayer:addPanel(self)
	        end
	    elseif isRunning then
	        local gameLayer = ViewMgr:getGameLayer(self.layerID)
	        gameLayer:removePanel(self)
	    end
	end
end

return PanelShowExtend