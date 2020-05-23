require("framework.init")
require("framework.shortcodes")

local UpdateLaunch = {}
function UpdateLaunch:start()
    CCLuaLog("UpdateApp:start")
    
    self:launchUpdate()
end

function UpdateLaunch:launchUpdate()
  	local updateApp = require("update.UpdateApp")
  	updateApp:launch()
end

xpcall(function()
	UpdateLaunch:start()
end, __G__TRACKBACK__)