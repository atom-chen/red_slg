local DownRes = {}

local ConstValue = UpdateApp.Update_Const
function DownRes:init(update)
	self.tempPath,self.zipPath = UpdateApp.helper:getTempPath()
	self.update = update

	self.scene = UpdateApp.scene

	self.downError = 0

	self.scene:setTipText("准备更新资源...")
	if self.tempPath then
		UpdateApp.helper:emptyFile(self.tempPath )
		return true
	else
		return false
	end 
end

function DownRes:startDown(url,callback)
	local arr = string.split(url, "/")
	local fileName = arr[#arr]
	self.zipFile = self.zipPath..fileName
	self.resUrl = url
	self.endCallback = callback

	self.netErrCount = 0

	if not self._firstUrl then
		self._firstUrl = url
	end

	self.isError = false

	self.scene:addProgress()

	self.update:registerScriptHandler(function(event, value) self:downHandler(event,value) end)
	self.update:update(url, self.zipFile, self.tempPath, true)
end

function DownRes:downHandler(event, value)
    if event == ConstValue.updateEvent.eUpdateSucess then
        self:moveDir(self.tempPath,UpdateApp.storePath)

        local lastErr = CCUserDefault:sharedUserDefault():getStringForKey("DownResErrorOther")
    	if lastErr and lastErr ~= "" then
    		CCUserDefault:sharedUserDefault():setStringForKey("DownResErrorOther","")
			CCUserDefault:sharedUserDefault():flush()
			StatSender:sendBug("z DownRes:ErrorOther fix ok: "..lastErr)
		end
    elseif event == ConstValue.updateEvent.eUpdateError then
    	local errCode = value:getCString()
    	self:errorHandler(errCode)

    elseif event == ConstValue.updateEvent.eUpdateProgress then
	    local _array = value
	    local child0 = _array:objectAtIndex(0);
	    local percent = tolua.cast(child0,"CCInteger")
	    local child1 = _array:objectAtIndex(1);
	    local totalToDownload = tolua.cast(child1,"CCDouble"):getValue()
	    local child2 = _array:objectAtIndex(2);
	    local nowDownloaded =  tolua.cast(child2,"CCDouble"):getValue()

	    if nowDownloaded >= totalToDownload then
	    	return
	    end
	    totalToDownload = math.max(totalToDownload,1)

	    self.scene:setProgress(nowDownloaded/totalToDownload)

	    local down_detail = "已下载"
	    down_detail = down_detail..tostring(math.ceil(nowDownloaded/1024)).."KB/"..tostring(math.ceil(totalToDownload/1024)).."KB"
	    self.scene:setTipText(down_detail)

    elseif event == ConstValue.updateEvent.eUncompressProgress then
        local _array = value
	    local child0 = _array:objectAtIndex(0);
	    local percent = tolua.cast(child0,"CCInteger")
	    local child1 = _array:objectAtIndex(1);
	    local totalToDownload = tolua.cast(child1,"CCDouble")
	    local child2 = _array:objectAtIndex(2);
	    local nowDownloaded =  tolua.cast(child2,"CCDouble")

	    self.scene:setProgress(percent:getValue()/100)
	    self.scene:setTipText("已解压"..tostring(percent:getValue()).."%")

    elseif event == ConstValue.updateEvent.eUpdateState then
    	value = value:getCString()
        local tip = ConstValue.tipString[value] or value
        self.scene:setTipText(tip)

        if value == ConstValue.updateState.kDownStart then
        	-- self.scene:setProgress(0)
        elseif value == ConstValue.updateState.kDownDone then
        	self.scene:setProgress(1)
        elseif value == ConstValue.updateState.kUncompressStart then
        	self.scene:setProgress(0)
        elseif value == ConstValue.updateState.kUncompressDone then
        	self.scene:setProgress(1)
        else

        end
    end
end

function DownRes:errorHandler(err)
	local tip = ConstValue.tipString[err]
	if not tip then
		local arr = string.split(err,"_")
		tip = ConstValue.tipString[arr[1]] or "未知错误"
	end
	CCLuaLog("DownRes:errorHandler:"..err..tip)
	if err == ConstValue.updateError.eErrorNotEnoughStorageSpace then
		UpdateApp.helper:nativeMessageBox( "提示",tip,"重试","退出",
											function() self:_reDown() end,
											function() 
												os.remove(self.zipFile) 
												UpdateApp:exit()
											end
											)
		StatSender:sendBug("z DownRes:eErrorNotEnoughStorageSpace ")
		-- UpdateApp.helper:tipStoreSpaceLack(tip)
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
			StatSender:sendBug("z DownRes:eErorNetwork :"..(arr[2] or "").." path:"..self.zipFile)
		end
	else
		if err == ConstValue.updateError.eErrorUncompressZipError or 
			err == ConstValue.updateError.eErrorUncompress  then
			os.remove(self.zipFile)
		end
		if err == ConstValue.updateError.eErrorUncompressFileNoFound
			or err == ConstValue.updateError.eErrorRemoteFileLength
			or err == ConstValue.updateError.eErrorFileLengthRespose
			or err == ConstValue.updateError.eErrorDownRespose then
		 	
		 	self.downError = self.downError + 1
		 	if self.downError < 7 then
		 		StatSender:sendBug("z DownRes:ErrorOther "..err.." re try first: "..self.downError)
				scheduler.performWithDelayGlobal(function() self:_reDown() end,0.1)

				CCUserDefault:sharedUserDefault():setStringForKey("DownResErrorOther",err..self.downError.."  re try ok" )
				CCUserDefault:sharedUserDefault():flush()
				return
		 	elseif self.downError < 7 then
				local info = GameCfg:getRemoteVerInfo()
				if info and info.tempUrl and info.tempUrl ~= self._firstUrl then
					self.resUrl = info.tempUrl
					StatSender:sendBug("z DownRes:ErrorOther "..err.." re try temp:"..self.downError)
					scheduler.performWithDelayGlobal(function() self:_reDown() end,0.1)
					
					CCUserDefault:sharedUserDefault():setStringForKey("DownResErrorOther",err..self.downError.."  re try ok" )
					CCUserDefault:sharedUserDefault():flush()
					return
				end
			end
		end

		self.scene:setTipText(tip)
        UpdateApp.helper:tipToExitGame(tip)
        StatSender:sendBug("z DownRes:ErrorOther "..err.." path:"..self.zipFile)
        CCUserDefault:sharedUserDefault():setStringForKey("DownResErrorOther",err )
		CCUserDefault:sharedUserDefault():flush()
    end
end

function DownRes:_reDown()
	CCLuaLog("reDown:"..self.resUrl)
	self:startDown(self.resUrl,self.endCallback) 
end

function DownRes:moveDir(srcPath,desPath)
	self.scene:setTipText("准备处理资源文件...")
	self.scene:setProgress(0)

	self.desPath = desPath

	self.fileList = {}
	if self:_getMoveFileList(srcPath,desPath,true) then
		self:_startMoveFile()
	else
		UpdateApp.helper:ensureOrExitGame("整理资源失败，请腾出足够存储空间后重试。","重试",function() self:moveDir(srcPath,desPath) end)
		StatSender:sendBug("z DownRes:_startMoveFile src"..srcPath.." des path:"..desPath)
	end
end

function DownRes:_getMoveFileList(srcPath,desPath,insertHead)
	if UpdateApp.helper:mkdir(desPath) then
		for file in lfs.dir(srcPath)  do
			if file ~= "." and file ~= ".." then
				local src_dir = srcPath.."/"..file
				local attr = lfs.attributes(src_dir)
				local des_dir = desPath.."/"..file
				if attr.mode == "directory" then
					if not self:_getMoveFileList(src_dir,des_dir) then
						return false
					end
				else
					local moveFile = {src=src_dir,des=des_dir}
					if insertHead then
						table.insert(self.fileList,1,moveFile)
					else
						table.insert(self.fileList,moveFile)
					end
				end
			end
		end
		return true
	else
		return false
	end
end

function DownRes:_startMoveFile()
	self.scene:setTipText("处理资源文件(不产生流量)...")

	self._maxFileMove = #self.fileList
	self.errCount = 0
	if not self._moveFileTimer then
		self._moveFileTimer = scheduler.scheduleGlobal(function() self:_moveNextFile() end, 0.001)
	end
	-- scheduler.performWithDelayGlobal(listener, time)
end

function DownRes:_moveNextFile()
	local moveFile = self.fileList[#self.fileList]
	if not moveFile then
		scheduler.unscheduleGlobal(self._moveFileTimer)
		self._moveFileTimer = nil
		self:_moveFileEnd()
		return
	end
	local curErr = ""
	repeat
		local fileContent = UpdateApp.helper:readFile(moveFile.src)
	    if fileContent == nil then
	    	curErr = "read error"
	    	StatSender:sendBug("z DownRes:_moveNextFile "..curErr.." src path:"..moveFile.src)
	    	break
	    else
	    	local flag,err = UpdateApp.helper:writeFile(moveFile.des, fileContent)
	    	if not flag then
	    		curErr = err or ""
	    		StatSender:sendBug("z DownRes:_moveNextFile "..curErr.." des path:"..moveFile.des)
	    		break
	    	end
	    end
	    table.remove(self.fileList,#self.fileList)
	    local r = (self._maxFileMove - #self.fileList)/self._maxFileMove
	    self.scene:setProgress( r )
	    self.scene:setTipText("处理资源文件"..math.ceil(100*r).."%(不产生流量)")
	    return
	until true

	self.errCount = self.errCount + 1
	if self.errCount >= 3 then
		-- curErr
		scheduler.unscheduleGlobal(self._moveFileTimer)
		self._moveFileTimer = nil
		UpdateApp.helper:ensureOrExitGame("整理资源失败，请腾出足够存储空间后重试。","重试",function() self:_restartMoveFile() end)
	end
end

function DownRes:_restartMoveFile()
	if not self._moveFileTimer then
		self._moveFileTimer = scheduler.scheduleGlobal(function() self:_moveNextFile() end, 0.001)
	end
end

function DownRes:_moveFileEnd()
	self.scene:removeProgress()
	UpdateApp.scene:setTipText("资源整理完成")
	self.update:unregisterScriptHandler()
	os.remove(self.zipFile)
	UpdateApp.helper:emptyFile(self.tempPath )
	scheduler.performWithDelayGlobal(function() self.endCallback() end, 0.001)
end

return DownRes