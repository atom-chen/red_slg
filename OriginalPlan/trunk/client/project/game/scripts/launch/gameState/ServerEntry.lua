
local ServerEntry = class("ServerEntry",UIButton)

function ServerEntry:setServerInfo(sInfo)
	self:setTextPadding({left=35,top=2})
	self.sInfo = sInfo
	if not self.pointSp then
		self.pointSp = display.newXSprite()
		self:addChild(self.pointSp)
		self.pointSp:setPosition(18,16)
	end
	local res = {"#login_wlqd3.png","#login_wlqd1.png",[0]="#login_wlqd2.png"}
	self.pointSp:setSpriteImage(res[sInfo.status])
	if sInfo.status == 0 then
		ShaderMgr:setColor(self.pointSp)
	else
		ShaderMgr:removeColor(self.pointSp)
	end

	local id = sInfo.showIndex or sInfo.serverId
	-- text, fontSize, fontName, fontColor, align, valign, useRTF, shadow, outline
	self:setText(tostring(id).."服—"..sInfo.serverName,21,"",ccc3(255,255,255),UIInfo.alignment.LEFT,nil,nil,nil,display.COLOR_BLACK)
end

return ServerEntry