--
-- Author: wdx
-- Date: 2014-04-14 14:24:22
--
local RoleProxy = class("RoleProxy")

function RoleProxy:ctor()

end

--[[--
初始化消息监听
]]
function RoleProxy:init()
	NetCenter:addMsgHandler(MsgType.ENTRY_GAME,{self,self._resRoleInfo},-2)

end

--[[--
初始化  玩家所有信息
]]
function RoleProxy:_resRoleInfo( event )
	local msg = event.msg
	RoleModel:setRoleInfo(msg)
end








return RoleProxy.new()