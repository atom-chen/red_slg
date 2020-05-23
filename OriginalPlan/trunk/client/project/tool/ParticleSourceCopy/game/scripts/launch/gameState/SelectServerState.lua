--
-- Author: wdx
-- Date: 2014-06-03 10:43:02
--

local SelectServerState = class("SelectServerState",StateBase)

function SelectServerState:init()
	-- body
	self.SERVER_LIST_MSG = 2002    --服务器列表
	self.SELECT_SERVER_MSG = 2003   --选择服务器
	self.LOGIN_GAME_SERVER_MSG = 3001  --登陆游戏服务器
	self.ROLE_INFO_MSG = 3003 --玩家信息

	local bg = display.newXSprite("ui/login/loginBg.w")
	bg:setPosition( display.cx,display.cy )
	self:addChild(bg)
	
	self:initUI()

end

function SelectServerState:initUI()
	ResMgr:loadPvr("ui/login/login")

	self.server = UIButton.new({"#login_serverBg.png"})
	self.server:setSize(CCSize(480,70))
	self.server:setAnchorPoint(ccp(0.5,0))
	self.server:setPosition(display.cx,150)
	self:addChild(self.server)

	self.okBtn = UIButton.new({"#login_okBtn.png"})
	self.okBtn:setAnchorPoint(ccp(0.5,0))
	self.okBtn:setPosition(display.cx,40)
	self.okBtn:setText("进入游戏",30,"",ccc3(0, 0, 0))
	self:addChild(self.okBtn)
	self.okBtn:addEventListener(Event.MOUSE_CLICK,{self,self._onEnterBtn})
end

function SelectServerState:show(mgr)
	StateBase.show(self,mgr)


	--login_serverBg

	NetCenter:addMsgHandler(self.SERVER_LIST_MSG, {self,self.onServerList},1,true)


	--scheduler.performWithDelayGlobal(function() self:changeState(StateBase.UPDATE) end ,1)
end

function SelectServerState:onServerList( pack )
	local msg = pack.msg
	NetCenter:removeMsgHandler(self.SERVER_LIST_MSG, {self,self.onServerList})

	for i,info in ipairs(msg.platformList) do  --服务器列表
		-- "server_id", "int32"}
  --       ,{"server_name", "string"}
  --       ,{"status", "int8"
  		self.server:setText(info.serverName.."(火爆)        点击换区",30,"",ccc3(253, 110, 15))
		self.serverId = info.serverId
  		--self:toSelectServer(info.serverId)  --暂时直接选择第一个服务器
		break
	end
end

function SelectServerState:_onEnterBtn()
	self:toSelectServer(self.serverId)
end

function SelectServerState:toSelectServer(id)
	NetCenter:addMsgHandler(self.SELECT_SERVER_MSG, {self,self.onSelectServer},1,true)
	NetCenter:send(self.SELECT_SERVER_MSG,id)  --选择服务器id
end

function SelectServerState:onSelectServer(pack)
	local msg = pack.msg
	NetCenter:removeMsgHandler(self.SELECT_SERVER_MSG, {self,self.onSelectServer})
	-- {"selectResult", "int8"} 
 --            ,{"md5", "string"}
 --            ,{"ip", "string"}
 --            ,{"port", "int32"}

 	--断开  于 登录服务器的链接    重新链接游戏服务器
 	ACCOUNT_MD5 = msg.md5
 	if NetCenter.serverIp ~= NetCenter.port ~= msg.port then
 		NetCenter:connect(msg.ip,msg.port)
 		NetCenter:addMsgHandler(NetCenter.CONNECT_SUCCESS,{self,self.onConnect})
 	else
		self:onConnect()
 	end
 	
end

--链接上 游戏服了
function SelectServerState:onConnect()
	NetCenter:removeMsgHandler(NetCenter.CONNECT_SUCCESS,{self,self.onConnect})

	NetCenter:send(self.LOGIN_GAME_SERVER_MSG,PLATFORM_ID,ACCOUNT_ID,ACCOUNT_MD5)  --登陆游戏服

	NetCenter:addMsgHandler(self.LOGIN_GAME_SERVER_MSG, {self,self.onLoginGameServer},1,true)
	NetCenter:addMsgHandler(self.ROLE_INFO_MSG, {self,self.onRoleMsg},1,true)
end

--登陆游戏
function SelectServerState:onLoginGameServer( pack )
	local msg = pack.msg
	NetCenter:removeMsgHandler(self.LOGIN_GAME_SERVER_MSG, {self,self.onLoginGameServer})
	if msg.loginResult == 0 then  --登陆成功
		
	else  --登陆失败
		print("@@@@~   登陆失败   @@@@~！")
		NetCenter:removeMsgHandler(self.LOGIN_GAME_SERVER_MSG, {self,self.onLoginGameServer})
		NetCenter:removeMsgHandler(self.ROLE_INFO_MSG, {self,self.onRoleMsg})
	end
end

--玩家信息
function SelectServerState:onRoleMsg( pack )
	local msg = pack.msg
	NetCenter:removeMsgHandler(self.LOGIN_GAME_SERVER_MSG, {self,self.onLoginGameServer})
	NetCenter:removeMsgHandler(self.ROLE_INFO_MSG, {self,self.onRoleMsg})
	self.stateMgr:saveRoleInfo(msg.roleInfo)

	--NetCenter:send(3004,msg.role_info.role_id)  
	self:changeState(StateBase.UPDATE)
end


function SelectServerState:dispose()
	self.server:dispose()
	self.okBtn:dispose()
	self:removeSelf(true)

	ResMgr:unload("ui/login/login")
end

return SelectServerState