local UpdateControl = {}

local verCheck = require("update.VerCheck")

function UpdateControl:startUpdate(callback)
	self.updateEndCall = callback

	if not UpdateApp.helper:isNetAvailable() then
		UpdateApp.helper:tipNetAvailable("网络环境异常，请确保正常网络连接。",function() self:startUpdate(callback) end)
		return
	end
	self.scene = UpdateApp.scene
	self.update = Updater:new()
	scheduler.performWithDelayGlobal(function() self:checkVer() end, 0.01)
end

function UpdateControl:checkVer()
	verCheck:init(self.update,function(isOk,info) self:verInitOk(isOk,info) end)
end

function UpdateControl:verInitOk(isOk,info)
	if isOk then
		self.scene:setVersionText(verCheck.localVerInfo.version)
		if verCheck.remoteVerInfo.version ~= verCheck.localVerInfo.version then
			self.scene:setNextVersionText(verCheck.remoteVerInfo.version)
		else
			self.scene:setNextVersionText("")
		end
		self:loopUpdate()
	else
		scheduler.performWithDelayGlobal(function()
			UpdateApp.helper:tipNetAvailable("获取版本文件出错，请确保网络连接正常。",function()
			 self.scene:setTipText("重新获取游戏版本....")
			 self:checkVer() end)
		 end, 0.1)

		self.scene:setTipText("获取游戏版本出错："..(info or ""))
	end
end

function UpdateControl:loopUpdate()
	self.scene:setTipText("检测游戏版本...")
	if self:checkUpdate() then
		self.updateEndCall()
		self:dispose()
	end
end

function UpdateControl:checkUpdate()
	local flag = verCheck:checkVer()
	CCLuaLog("checkVer() : "..flag)
	if flag == "error" then
		UpdateApp.helper:tipToExitGame("版本文件错误，请尝试重启游戏。")
		StatSender:sendBug("z verCheck:checkVer error")
		return false
	elseif flag == "newApp" then
		local newAppUrl = verCheck:getNewAppUrl()
		if newAppUrl then
			self:_downApp(newAppUrl,verCheck:getRemoteVerDate())
		else
			UpdateApp.helper:tipToExitGame("当前游戏版本太旧，请下载安装最新版本游戏。")
		end
		return false
	elseif flag == "resUpdate" then
		local resUrl = verCheck:getResUpdateUrl()
		if resUrl then
			self:_downRes(resUrl)
			return false
		else
			return true
		end
	else
		return true
	end
end

function UpdateControl:_downApp(newAppUrl,apkName)
	local appDown = require("update.DownApk")
	if appDown:init(self.update) then
		local func = function()
			appDown:startDownApp(newAppUrl,apkName)
		end
		self:_checkWifi(func)
	else
		UpdateApp.helper:tipToExitGame("本地资源路径错误，请腾出足够存储空间后重试。")
		StatSender:sendBug("z UpdateControl:_downApp appDown:init  error")
	end
end

function UpdateControl:_downRes(resUrl)
	if (not UpdateApp.storePath) or (UpdateApp.storePath == "") then
		UpdateApp.helper:tipToExitGame("初始化资源路径失败，请腾出足够存储空间后重试。")
		StatSender:sendBug("z UpdateControl:_downRes UpdateApp.storePath  error")
		return false
	end
	local downRes = require("update.DownRes")
	if downRes:init(self.update) then
		local func = function()
			downRes:startDown(resUrl,function() self:resUpdateEnd() end)
		end
		self:_checkWifi(func)
	else
		UpdateApp.helper:tipToExitGame("本地资源路径错误，请腾出足够存储空间后重试。")
		StatSender:sendBug("z UpdateControl:_downRes downRes:init  error")
	end
end

function UpdateControl:_checkWifi(func)
	if not UpdateApp.helper:isWifi() then
		UpdateApp.helper:nativeMessageBox( "提示","当前网络环境非wifi，确定继续更新？","确定","退出",
                    func, function() UpdateApp:exit() end)
	else
		func()
	end
end

function UpdateControl:resUpdateEnd()
	self.scene:setTipText("重新检测游戏版本...")
	scheduler.performWithDelayGlobal(function() self:checkVer() end, 0.01)
	CCUserDefault:sharedUserDefault():setStringForKey("updateNewVer",verCheck.remoteVerInfo.version or "")
	CCUserDefault:sharedUserDefault():flush()
end

function UpdateControl:dispose()
	if self.update then
        self.update:unregisterScriptHandler()
        self.update:delete()
        self.update = nil
	end
end

return UpdateControl