local DownApp = {}

local ConstValue = UpdateApp.Update_Const
function DownApp:init(update)
	self.tempPath,self.zipPath = UpdateApp.helper:getTempPath()
	self.update = update

	self.downError = 0

	self.scene = UpdateApp.scene
	self.scene:setTipText("准备下载新安装包...")
	if self.tempPath then
		UpdateApp.helper:emptyFile(self.tempPath )
		return true
	else
		return false
	end 
end

function DownApp:startDownApp(url,fileName)
	if not fileName then
		local arr = string.split(url, "/")
		fileName = arr[#arr]
	else
		fileName = fileName..".apk"
	end
	self:_startDown(url,self.zipPath..fileName)
end

function DownApp:_startDown(url,file)
	self.appUrl = url
	self.appFile = file

	self.netErrCount = 0

	self.isError = false

	if not self._firstUrl then
		self._firstUrl = url
	end

	self.scene:addProgress()

	self.update:registerScriptHandler(function(event, value) self:downHandler(event,value) end)
	-- self.update:update(remoteResInfo.apkurl, updater.path)
	self.update:update(url, self.appFile)
end


function DownApp:downHandler(event, value)
    if event == ConstValue.updateEvent.eUpdateSucess then
        self:_installApp()

    elseif event == ConstValue.updateEvent.eUpdateError then
    	local errCode = value:getCString()
    	self:errorHandler(errCode)

    elseif event == ConstValue.updateEvent.eUpdateProgress then
	    local _array = value
	    local child0 = _array:objectAtIndex(0);
	    local percent = tolua.cast(child0,"CCInteger")
	    local child1 = _array:objectAtIndex(1);
	    local totalToDownload = tolua.cast(child1,"CCDouble")
	    local child2 = _array:objectAtIndex(2);
	    local nowDownloaded =  tolua.cast(child2,"CCDouble")

	    totalToDownload = math.max(totalToDownload,1)

	    self.scene:setProgress(nowDownloaded/totalToDownload)
	    
	    local down_detail = "已下载"
	    down_detail = down_detail..tostring(math.ceil(nowDownloaded:getValue()/1024)).."k/"..tostring(math.ceil(totalToDownload:getValue()/1024)).."k"
	    self.scene:setTipText(down_detail)

    elseif event == ConstValue.updateEvent.eUpdateState then
    	value = value:getCString()
        local tip = ConstValue.tipString[value] or value
        self.scene:setTipText(tip)

        if value == ConstValue.updateState.kDownStart then
        	self.scene:setProgress(0)
        elseif value == ConstValue.updateState.kDownDone then
        	self.scene:setProgress(1)
        else

        end
    end
end

function DownApp:errorHandler(err)
	local tip = ConstValue.tipString[err]
	if not tip then
		local arr = string.split(err,"_")
		tip = ConstValue.tipString[arr[1]] or "未知错误"
	end
	CCLuaLog("DownApp:errorHandler:"..err..tip)

	if err == ConstValue.updateError.eErrorNotEnoughStorageSpace then
		UpdateApp.helper:tipToExitGame("下载安装包出错,请腾出足够存储空间后重试。")
		StatSender:sendBug("z DownApp:eErrorNotEnoughStorageSpace ")
	elseif string.find(err,ConstValue.updateError.eErorNetwork ) then
		local arr = string.split(err,"_")
		local str
		if arr[2] then
			str = "网络出现故障：["..arr[2].."]，请确保在稳定网络环境下进行"
		else
			str = "网络出现故障，请确保在稳定网络环境下进行"
		end
		UpdateApp.helper:tipNetAvailable(str,function() self:_reDown() end)

		self.netErrCount = self.netErrCount + 1
		if self.netErrCount > 3 then
			StatSender:sendBug("z DownApp:eErorNetwork :"..(arr[2] or "").." path:"..self.appFile)
		end
	else
		if err == ConstValue.updateError.eErrorDownRespose then
			-- os.remove(self.zipFile)
		end
		if err == ConstValue.updateError.eErrorRemoteFileLength
			or err == ConstValue.updateError.eErrorFileLengthRespose
			or err == ConstValue.updateError.eErrorDownRespose then
		 	
		 	self.downError = self.downError + 1
		 	if self.downError < 4 then
		 		StatSender:sendBug("z DownApp:ErrorOther "..err.." re try first: "..self.downError)
				scheduler.performWithDelayGlobal(function() self:_reDown() end,0.1)

				CCUserDefault:sharedUserDefault():setStringForKey("DownResErrorOther",err..self.downError.."  re try ok" )
				CCUserDefault:sharedUserDefault():flush()
				return
		 	elseif self.downError < 7 then
				local info = GameCfg:getRemoteVerInfo()
				if info and info.tempAppUrl and info.tempAppUrl ~= self._firstUrl then
					self.appUrl = info.tempUrl
					StatSender:sendBug("z DownApp:ErrorOther "..err.." re try temp:"..self.downError)
					scheduler.performWithDelayGlobal(function() self:_reDown() end,0.1)
					
					CCUserDefault:sharedUserDefault():setStringForKey("DownAppErrorOther",err..self.downError.."  re try ok" )
					CCUserDefault:sharedUserDefault():flush()
					return
				end
			end
		end

		self.scene:setTipText(tip)
        UpdateApp.helper:tipToExitGame(tip)
        StatSender:sendBug("z DownApp:ErrorOther "..err.." path:"..self.appFile)
    end
end

function DownApp:_installApp()
	self.scene:setTipText("准备安装游戏...")
    local sucess = UpdateApp.helper:callJavaFun("installApk", {self.appFile}, "(Ljava/lang/String;)I")
    if sucess == 1 then
        CCDirector:sharedDirector():endToLua()   --退出游戏
    else
    	self.scene:setTipText("安装出错，请重启游戏进行尝试或前往应用商店下载最新版本游戏")
    	StatSender:sendBug("z DownApp:installApp error"..err.." path:"..self.appFile)
    end
end

function DownApp:_reDown()
	self:_startDown(self.appUrl,self.appFile) 
end

return DownApp