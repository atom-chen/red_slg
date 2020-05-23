--
-- Author: wdx
-- Date: 2015-01-26 15:28:07
--

PlatformEvent = {}

PlatformEvent.LUANCH_END = "platformLaunchEnd"  --平台启动返回
PlatformEvent.LOGIN_END = "platformLoginEnd"  --平台登录返回   账号登录了
PlatformEvent.CHANGE_SERVER_BEG = "changeServerBeg"  --切换服务器 开始
PlatformEvent.CHANGE_SERVER_END = "changeServer"  --切换服务器 完成
PlatformEvent.LOGIN_GAME_END = "platformLoginGameEnd"  --登录游戏服返回  有可能登录不成功
PlatformEvent.BING_USER_END = "bindUserEnd"   --绑定用户   有可能绑定不成功  不是游客的话会出现绑定不成功
PlatformEvent.CHARGE_END = "chargeEnd"  --充值结束   不一定是真的充值了
PlatformEvent.EXIT_GAME = "exit_game"
PlatformEvent.INVITE_FRIEND_LIST = 'invite_friend_list'
PlatformEvent.INVITE_FRIEND = 'invite_friend'
PlatformEvent.ANTIADDICTION = 'antiAddicition'
PlatformEvent.REAL_NAME_REGISTER = 'realNameRegister'
PlatformEvent.GAME_LOGOUT = "gameLogout"
PlatformEvent.SYNCH_ACCOUNT_INFO = "synch_account_info"
PlatformEvent.WEB_RECHARGE = "web_charge"

PlatformSupport = {}  --平台支持的配置在gameConfig.xml
PlatformSupport.LOGIN = "supportLogin"
PlatformSupport.CHANGE_SERVER = "supportChangeServer"
PlatformSupport.CUSTOMER_SERVICE = "supportCS"
PlatformSupport.CHANGE_ACCOUNT = "supportChangeAccount"
PlatformSupport.CHARGE_IN_GAME = "supportChargeInGame"
PlatformSupport.CHARGE = "supportCharge"
PlatformSupport.EXIT_GAME = "supportExitGame"
PlatformSupport.INVITE_FRIEND = "supportInviteFriend"
PlatformSupport.REMOVE_GAMELOGO = "removeGameLogo"

--安卓  平台相关的处理
local PlatformSDK = {}

--初始化平台
function PlatformSDK:init()
	EventProtocol.extend(self)   --发出通知

	gamePlatform:addEventListener(PlatformEvent.LOGIN_END, {self,self._onLoginEnd},-1)
	gamePlatform:addEventListener(PlatformEvent.CHANGE_SERVER_END, {self,self._onChangeServerEnd},-1)
	gamePlatform:addEventListener(PlatformEvent.LOGIN_GAME_END, {self,self._onLoginGameEnd},-1)
	gamePlatform:addEventListener(PlatformEvent.BING_USER_END, {self,self._onBingUserEnd},-1)
	gamePlatform:addEventListener(PlatformEvent.EXIT_GAME, {self, self._onExitGame}, -1)

	gamePlatform:addEventListener(PlatformEvent.ANTIADDICTION, {self,self._antiAddicition},-1)
	gamePlatform:addEventListener(PlatformEvent.REAL_NAME_REGISTER, {self, self._realNameRegister}, -1)
	gamePlatform:addEventListener(PlatformEvent.GAME_LOGOUT,{self,self._gameLogout},-1)
	gamePlatform:addEventListener(PlatformEvent.CHARGE_END,{self,self._chargeEnd},-1)
	gamePlatform:addEventListener(PlatformEvent.SYNCH_ACCOUNT_INFO,{self,self._synchAccountInfo},-1)

	self:_initSupport()

	--注册回调方法进去
	if device.platform == "android" then
		local userInfo = {"userId","userType","md5","sessionId","status"}
		local serverInfo = {"serverId","sName","IP","port","md5","status"}
		self.javaEventParams = {
			[PlatformEvent.LUANCH_END] = {},
			[PlatformEvent.WEB_RECHARGE]={},
			[PlatformEvent.LOGIN_END] = {{"userInfo",userInfo},{"serverInfo",serverInfo}},
			[PlatformEvent.CHANGE_SERVER_END] = {serverInfo},
			[PlatformEvent.LOGIN_GAME_END] = {serverInfo},
			[PlatformEvent.BING_USER_END] = {userInfo},
			[PlatformEvent.CHARGE_END] = {},
			[PlatformEvent.EXIT_GAME] = {"sendToServer"},
			[PlatformEvent.SYNCH_ACCOUNT_INFO] = {{"userInfo",userInfo},{"serverInfo",serverInfo}},
		}

		self.PlatformJavaClassName = "com/game/platform/PlatformManager"
		self:_callFunc("setLuaCallback",{function(param) self:_onJavaCallback(param) end})
	--	self:_callFunc("setLuaCallback",{function(param) self:_onJavaCallback(param) end})

	elseif device.platform == "ios" then
		self:_callFunc("setObjcCallback",{functionId = function(param) self:_onObjcCallback(param) end})
	end
end

function PlatformSDK:getUserInfo()
	return self.userInfo
end

function PlatformSDK:getServerInfo()
	return self.serverInfo
end

function PlatformSDK:setUserInfo(userInfo)
	if userInfo then
		if userInfo.isEncodeMD5 then
			local md5 = self:_callFunc("urlDecodeStr", {userInfo.md5},"(Ljava/lang/String;)Ljava/lang/String;",GameJavaCallCalss)
			if md5 and md5 ~= "" then
				userInfo.md5 = md5
				userInfo.sessionId = md5
			end
		end
		self.userInfo = userInfo
		ACCOUNT_ID = userInfo.userId or '';
		ACCOUNT_MD5 = userInfo.md5
		self:_callFunc("setUserInfo",{ACCOUNT_ID, ACCOUNT_ID, ACCOUNT_MD5})
	end
end

function PlatformSDK:_antiAddicition(event)
	if event.status == "ok" then
		if event.result == "0" then -- 0 无此用户数据
			CCLuaLog("_antiAddicition 无此数据")
		elseif event.result == "1" then --1:未成年
			CCLuaLog("_antiAddicition 未成年")
		elseif event.result == "2" then -- 2：已成年
			CCLuaLog("_antiAddicition 已成年")
		end
	end
end

function PlatformSDK:_realNameRegister(event)
	if event.status == "ok" then
	end
end


--登录成功  保存相关信息
function PlatformSDK:_onLoginEnd(event)
	CCLuaLog("---- PlatformSDK:_onLoginEnd  begin");
	if event.status == "ok" then
		if device.platform == "android" then
			GAME_ID = event.gameId
			--CCLuaLog("zzzz authorizeCode "..event.authorize_code)
			AUTHORIZE_CODE = event.authorize_code
			self.channelID = event.channelID
			self:setUserInfo(event.userInfo)
			self.serverInfo = event.serverInfo

			local vInfo = GameCfg:getRemoteVerInfo()
			if vInfo and self.channelID and self.channelID ~= "" then
				if vInfo[self.channelID] then
					for k,v in pairs(vInfo[self.channelID]) do
		                vInfo[k] = v
		            end
				end
				PLATFORM_ID = GameCfg:getValue("platform")
				SERVER_IP = GameCfg:getValue("serverIP")
				SERVER_PORT = tonumber(GameCfg:getValue("port"))
			end
		elseif device.platform == "ios" then
			local params = event.params
			GAME_ID = params.gameId
			self.channelID = params.channelID
			AUTHORIZE_CODE = params.authorize_code
			local serverInfo = params.userInfo.serverInfo
			params.userInfo.serverInfo = nil
			self:setUserInfo(params.userInfo)
			self.serverInfo = serverInfo
		end

		-- if params.userInfo then
		-- 	CCLuaLog("params.userInfo")
		-- end
		 -- CCLuaLog("zhanghao:mima==="..tostring(self.userInfo.userId).."  "..tostring(self.userInfo.md5))
	end
	CCLuaLog("---- PlatformSDK:_onLoginEnd  end");
end

function PlatformSDK:_synchAccountInfo(event)
	self:_onLoginEnd(event)
end

function PlatformSDK:_onChangeServerBeg(event)
--[[ --平台未提供选服的时候. 被调用. 创建选服界面
	if event.status == "ok" then
	end
--]]
end

function PlatformSDK:_onChangeServerEnd(event)
	if event.status == "ok" then
		if device.platform == "android" then
			self.serverInfo = event.serverInfo
		else
			self.serverInfo = event.params.userInfo.serverInfo
		end
	end
end

function PlatformSDK:_onLoginGameEnd(event)
	if event.status == "ok" then
		if device.platform == "android" then
			self.serverInfo = event.serverInfo
		elseif device.platform == "ios" then
			local params = event.params
			local serverInfo = params.userInfo.serverInfo
			params.userInfo.serverInfo = nil
			self:setUserInfo(params.userInfo)
			self.serverInfo = serverInfo
		end
	end
end

function PlatformSDK:_onBingUserEnd(event)
	if event.status == "ok" then
		if device.platform == "android" then
			self:setUserInfo(event.userInfo)
		end
	end
end

function PlatformSDK:_onExitGame(event)
	if event.status == "ok" then
		if device.platform == "android" then
			CCLuaLog("---- cclualog platformSDK exit game")
			if _exitGame then
				CCLuaLog("---- exit game    11111111111111")
				if event.sendToServer and tonumber(event.sendToServer) ~= 0 then
					_exitGame(true)
				else
					_exitGame(false)
				end
			else
				CCLuaLog("---- exit game    22222222222")
				CCDirector:sharedDirector():endToLua()   --退出游戏
			end
		end
	end
end

--notice: http://blog.csdn.net/yuanfengyun/article/details/23408549
function PlatformSDK:stringToTable(str)
	local ret = loadstring("return "..str)()
	return ret
end

function PlatformSDK:callStringMethod(funcName, paramsJson)
	if device.platform == "android" then
		CCLuaLog(string.format("PlatformSDK:callStringMethod(%s,%s)", funcName, paramsJson or ""))
		local params
		if not paramsJson or paramsJson == "" then
			params = "{}"
		else
			params = paramsJson
		end

		local str = self:_callFunc("callStringMethod", {funcName, params},"(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;")
		CCLuaLog(string.format("PlatformSDK:callStringMethod(%s,%s) ret:%s", funcName, params, str))
		if not str then
			return nil
		end

		local tab = self:stringToTable(str)
		return tab
	elseif device.platform == 'ios' then
		return self:_callFunc(funcName, paramsJson)
	end
end

--调用平台相关方法
function PlatformSDK:_callFunc(funcName,params,javaMethodSig,calssName)
	CCLuaLog("call sdk function:"..funcName)
	if device.platform == "android" then
		local javaClassName = calssName or self.PlatformJavaClassName
	    local flag,ret = luaj.callStaticMethod(javaClassName, funcName, params, javaMethodSig)
	    CCLuaLog("call sdk function end:"..tostring(flag).."  "..tostring(ret))
		if flag then
			return ret
		end
	elseif device.platform == "ios" then
		local flag1,ret1 = luaoc.callStaticMethod("PlatformSDK", funcName, params)
		CCLuaLog("call sdk function end:"..tostring(flag1).."  "..tostring(ret1))
		if flag1 then
			return ret1
		end
	end
end

-------------------------------------------android 相关 --------------------------------------------
--java callback   java回调过来的
function PlatformSDK:_onJavaCallback(str)
	scheduler.performWithDelayGlobal(
		function()
			xpcall(function()
			    CCLuaLog("java callback:"..str)
				local event = self:stringToTable(str)
				if event then
					CCLuaLog("java event:"..event.name)
				end
				self:dispatchEvent(event)   --发出通知
			end, __G__TRACKBACK__)
		end
		, 0.1)
end

function PlatformSDK:_onJavaCallback_old(params)
	local arg = splitString(params,"#:")
	local event = arg[1]  --第一个是事件名  --第二个是status
	table.remove(arg,1)
	local status = arg[1]
	table.remove(arg,1)

	CCLuaLog("sdk call back:"..event.." "..status)
	local tb = {}
	if status == "ok" then
		local eventParams = self.javaEventParams[event]
		local count = 1
		for i,info in ipairs(eventParams) do
			if arg[i] == nil then
				break
			end
			if type(info) == "table" then
				if #info == 2 then
					local key = info[1]
					local cfg = info[2]
					local sArg = splitString(arg[i],"#|")
					local ktb = {}
					tb[key] = ktb
					for j,key in ipairs(cfg) do
						ktb[key] = sArg[j]
					end
				else
					local sArg = splitString(arg[i],"#|")
					for j,key in ipairs(info) do
						tb[key] = sArg[j]
					end
				end
			else
				tb[info] = arg[i]
			end
		end
	elseif status == "error" then
		tb.errorCode = arg[1]  --错误码 之类的
		tb.errorMsg = arg[2]   --错误弹窗提示
	end
	self:dispatchEvent({name=event, params = tb , status = status})   --发出通知
end
-----------------------------------------------------------------------------------------------------

function PlatformSDK:_onObjcCallback( params )
	local event = params
	event.name = params.event
	self:dispatchEvent(event)   --发出通知
end
--平台启动
function PlatformSDK:platformLaunch()
	self:_callFunc("platformLaunch")
	if device.platform == "windows" then
		self:dispatchEvent({name=PlatformEvent.LUANCH_END,status = "ok"})
	end
end

--平台账号登录
function PlatformSDK:platformLogin()
	self:_callFunc("platformLogin")
end

--是否是访客
function PlatformSDK:isVisitor()
	return self:_callFunc("isVisitor",{},"()Z")
end

--切换账号
function PlatformSDK:changeAccount()
	CCLuaLog("---- PlatformSDK:changeAccount  begin");
	self:_callFunc("changeAccount")
end

--选服
function PlatformSDK:changeServer()
	self:_callFunc("changeServer")
end

--登录游戏服    --服务器id   服务器名字
function PlatformSDK:loginGameServer(sId,sName)
	if device.platform == "android" then
		self:_callFunc("loginGameServer",{tostring(sId),sName})
	elseif device.platform == "ios" then
		self:_callFunc("loginGameServer")
	end
end

--游客绑定
function PlatformSDK:bindUser()
	self:_callFunc("bindUser")
end

function PlatformSDK:charge(json)
	-- openTipPanel("测试")
	if device.platform == "android" then
		local ret = self:callStringMethod("charge", json)
		if ret and ret.exist then
			return ret.result
		end
	elseif device.platform == "ios" then
		self:_callFunc("charge",json)
	end
end


--客服
function PlatformSDK:csCenter( _rolename )
	if device.platform == "android" then
		self:_callFunc("csCenter",{_rolename})
	elseif device.platform == "ios" then
		self:_callFunc("csCenter",{rolename = _rolename})
	end
end

--显示平台浮标
function PlatformSDK:showPlatformIcon(flag)
	if device.platform == "android" then
		self:_callFunc("showPlatformIcon",{flag})
	end
end

--sdk退出游戏
function PlatformSDK:exitGame(sendToServer)
	local arg = 0
	if sendToServer then
		arg = 1
	end
	local params = string.format("{sendToServer:%d}", arg)
	if device.platform == "ios" then
		params = {sendToServer = arg}
	end

	local ret = self:callStringMethod("exit",params )
	if ret and ret.exist then
		return ret.result
	end
end

--退出
function PlatformSDK:logout()
	local ret = self:callStringMethod("logout")
	if ret and ret.exist then
		return ret.result
	end
end

--登录成功后,通知sdk一些信息
function PlatformSDK:notifySDK(json)
	CCLuaLog("submitUserData:444444444444")
	local ret = self:callStringMethod("notifySDK", json)
	if ret and ret.exist then
		return ret.result
	end
end

function PlatformSDK:loginNotifySDK(json)
	local params = json
	if device.platform == "ios" then
		params = { json_string = json}
	end

	local ret = self:callStringMethod("loginNotifySDK", params)
	if ret and ret.exist then
		return ret.result
	end
end

function PlatformSDK:reqInviteFriendList()
	self:callStringMethod("reqInviteFriendList")
end

function PlatformSDK:getChannelId()
	if  self.channelID then
		return self.channelID
	end
	local ret = self:_callFunc("reqChannelId",{},"()Ljava/lang/String;")

	if ret and ret~= "" then
		self.channelID = ret
		return self.channelID
	else
		return CMJYXConfig:GetInst():getStringForKey("channel")
	end
	return "0"
end

function PlatformSDK:antiAddicition()
	self:callStringMethod("antiAddicition")
end

function PlatformSDK:realNameRegister()
	self:callStringMethod("realNameRegister")
end

-- function PlatformSDK:inviteFriends(id,isAll,des)
-- 	if device.platform == "android" then
-- 		isAll = isAll or false
-- 		local json = "{'id'='"..id.."','isAll'="..tostring(isAll)..",'des'='"..des.."'}"
-- 		self:callStringMethod("inviteFriends",json)
-- 	elseif device.platform == "ios" then
-- 		if isAll then
-- 			isAll ="1"
-- 		else
-- 			isAll ="0"
-- 		end
-- 		self:_callFunc("inviteFriends",{_id = id,_isAll = isAll,_des = des})
-- 	end
-- end

function PlatformSDK:inviteFriends(roleID,serverID)
	local roleId_str = string.format("%.0f",roleID)
	if device.platform == "android" then
		local json = "{'roleID'='"..roleId_str.."','serverID'='"..tostring(serverID).."'}"
		CCLuaLog("sdk inviteFriends json:"..json)
		self:callStringMethod("inviteFriends",json)
	elseif device.platform == "ios" then
		self:_callFunc("inviteFriends",{roleID = roleId_str,serverID = tostring(serverID)})
	end
end

function PlatformSDK:share()
	-- local title = "坦克战争"
	-- local message = "加入我们，用策略和战争宣泄你的激情"
	-- local iconUrl = "https://lh3.googleusercontent.com/jw0F1-BOF7r8bm4hEvoG6RE0yC8edTo2fmgSTOH0NYEPrJ-UayfJ5G1k1D2hE97FrWue=w300-rw"
	-- local url = "https://play.google.com/store/apps/details?id=com.rxtk.highgame.com"
	local title = GameCfg:getValue("fbsShareTitle") or ""
	local message = GameCfg:getValue("fbsShareMessage") or ""
	local iconUrl = GameCfg:getValue("fbsShareIconUrl") or ""
	local url = GameCfg:getValue("fbsShareUrl") or ""
	if device.platform == "android" then
		local json = "{'title'='"..title.."','message'='"..message.."','iconUrl'='"..iconUrl.."','url'='"..url.."'}"
		CCLuaLog("sdk share json:"..json)
		self:callStringMethod("share",json)
	elseif device.platform == "ios" then

		self:_callFunc("share",{title = title,message = message,iconUrl = iconUrl,url= url})
	end
end

-- {desc=,finishTime=}
function PlatformSDK:setNotification(arr)
	local json = '{"inst":[';
	for i,item in ipairs(arr) do
		json = json .. ('{"desc":"%s", "leftTime":%s}'):format(item.desc, item.leftTime)
	end

	json = json .. ']}'
	local ret = self:callStringMethod("setNotification", json)
	if ret and ret.exist then
		return ret.result
	end
end



--[[
function PlatformSDK:supportLogout()
	local ret = self:callStringMethod("supportLogout")
	if ret and ret.exist then
		return ret.result
	end
end
--]]


----------------------------------------------------------------------------------------------------------------
function PlatformSDK:_initSupport()
	self.supportCfg = {}
	for i,key in pairs(PlatformSupport) do
		self.supportCfg[key] = GameCfg:getBoolean(key)
	end
end

-- Remote resInfo.txt
function PlatformSDK:getRemoteValue(key)
	local remoteVerInfo = GameCfg:getRemoteVerInfo()
	if remoteVerInfo then
		return remoteVerInfo[key]
	end
	return nil
end

function PlatformSDK:support(key)
	local flag = self:getRemoteValue(key)
	if flag == nil then
		return self.supportCfg[key]
	else
		return flag
	end
end

--datatype  1:进入服务器  2创建角色 3:升级
function PlatformSDK:submitUserData( datatype, roleId,name,level,vipLv,gold,guildName )
		CCLuaLog("submitUserData:1111111111111111111")
		local data = "{}"
		if device.platform == "android" then
			data = string.format('{"action":%d,"serverID":"%s","serverName":"%s"\
									,"roleID":"%s","roleName":"%s","roleLevel":"%d"\
									,"vipLevel":"%d","balance":"%d","partyName":"%s"}',
			datatype,
			GAME_SERVER_ID,
			SERVER_NAME,
			roleId,
			name,
			level,
			vipLv,
			gold,
			guildName
			)
			CCLuaLog("submitUserData:2222222"..data)
		elseif device.platform == "ios" then
			data = {action = datatype,serverID=tostring(GAME_SERVER_ID),serverName=SERVER_NAME,
					roleID = tostring(roleId),roleName = name,roleLevel = level,vipLevel = vipLv,
					balance = gold,partyName = guildName }

		end

		self:notifySDK(data)
end

function PlatformSDK:_gameLogout(event)
	CCLuaLog("PlatformSDK:_cleargameInfo....clear game info !!")
	if event.status == "ok" then
	CCLuaLog("PlatformSDK:_cleargameInfo....111111")
		if GameLaunch then
			CCLuaLog("PlatformSDK:_cleargameInfo....22222")
			GameLaunch:relaunchGame()
		end
	end
end

function PlatformSDK:_chargeEnd(event)

end

function PlatformSDK:gameLogoutFinish()
	self.userInfo = nil
	self:_callFunc("gameLogoutFinish")
end

function PlatformSDK:webReCharge( json)
	if device.platform == "android" then
		self:callStringMethod("webReCharge",json)
	elseif device.platform == "ios" then
		self:_callFunc("webReCharge",json)
	end
end

function PlatformSDK:webReChargeClose()
	if device.platform == "android" then
		self:callStringMethod("webReChargeClose")
	elseif device.platform == "ios" then
		self:_callFunc("webReChargeClose")
	end
end

function PlatformSDK:canelWebReCharge()
	if device.platform == "android" then
		self:callStringMethod("canelWebReCharge")
	elseif device.platform == "ios" then
		self:_callFunc("canelWebReCharge")
	end
end

return PlatformSDK