local GameCfg = {}

local cfg = nil
function GameCfg:init()
	cfg = CMJYXConfig:GetInst()
	-- self.platformID = cfg:getStringForKey("platform")
	-- self.gameName = cfg:getStringForKey("gameName")
	-- self.serverIP = cfg:getStringForKey("serverIP")
	-- self.port = cfg:getStringForKey("port")
	-- self.version = cfg:getStringForKey("version")

end

function GameCfg:getValue(key)
	if self.remoteVerInfo and self.remoteVerInfo[key] then
		return self.remoteVerInfo[key]
	end
	return cfg:getStringForKey(key)
end

function GameCfg:getBoolean(key)
	return self:getValue(key) == "1"
end

function GameCfg:setLocalVerInfo(verInfo)
	self.localVerInfo = verInfo
end

function GameCfg:getLocalVerInfo()
	return self.localVerInfo
end

function GameCfg:setRemoteVerInfo(verInfo)
	self.remoteVerInfo = verInfo
end

function GameCfg:getRemoteVerInfo()
	return self.remoteVerInfo
end

return GameCfg