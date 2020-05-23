local VerCheck = {}

local VER_FILE = "resinfo.txt"

function VerCheck:init(update,callback)
    self.callback = callback
    self.update = update
    self.localVerInfo = self:getLocalVerInfo(UpdateApp.storePath)
    GameCfg:setLocalVerInfo(self.localVerInfo)
	self.remoteVerInfo = self:_getRemoteResInfo(self.localVerInfo.update_url)
end

function VerCheck:resRemoteInfo(info)
    if type(info) == "table" then
        self.remoteVerInfo = info
        local ch = gamePlatform:getChannelId()
        if self.remoteVerInfo[ch] then
            for k,v in pairs(self.remoteVerInfo[ch]) do
                self.remoteVerInfo[k] = v
            end
        end
        GameCfg:setRemoteVerInfo(self.remoteVerInfo)
        if self.callback then
            self.callback(true,info)
        end
    else
        if self.callback then
            self.callback(false,info)
        end
    end
end

function VerCheck:checkVer()

    if not self.remoteVerInfo.version or not self.localVerInfo.version then
        return "error"
    end
    if self.localVerInfo.version == "0.0.0" then
        return "resUpdate"
    end
    local diff,newApk = UpdateApp.helper:compareVer(self.remoteVerInfo.version,self.localVerInfo.version)
    if not diff then
        return "error"
    end
    if diff > 0 then
        if newApk then
            return "newApp"
        end
        return "resUpdate"
    end
    return "ok"
end

function VerCheck:getRemoteVerDate()
    if self.remoteVerInfo then
        local arr = string.splitEx(self.remoteVerInfo.version,"%.")
        return arr[#arr]
    else
        return "1"
    end
end

function VerCheck:getLocalVerInfo(storePath)
    local verInfo = nil
    if storePath then
        local verInfoPath = storePath.."/"..VER_FILE
        local verInfo = UpdateApp.helper:getTableFromFile(verInfoPath)
        if verInfo then
            return verInfo
        end
    end
    local version = GameCfg:getValue("version")
    local update_url = GameCfg:getValue("update_url")
    local subpackurl = GameCfg:getValue("subpackurl")
    return {version=version,update_url=update_url,subpackurl=subpackurl}
end

function VerCheck:_getRemoteResInfo(url)
    local request = network.createHTTPRequest(function (event)
        if (event.name == "progress") then
            -- CCLuaLog(string.format("progress %f,%f",event.dlnow,event.dltotal ))
            return
        end
        local req = event.request
        if event.name == "completed" then
            if req:getResponseStatusCode() == 200 then
                local resInfoTxt = req:getResponseString()
                local remoteInfo = nil
                if resInfoTxt ~= "" then
                    local func = loadstring(resInfoTxt)
                    if type(func) == "function" then
                        remoteInfo = func()
                    end
                end
                self:resRemoteInfo(remoteInfo)
            else
                self:resRemoteInfo(req:getResponseString())
            end
        else
            self:resRemoteInfo(event.name)
        end
    end,url,"GET")
    request:addRequestHeader("Content-Type:application/x-www-form-urlencoded")
    request:start()
end

function VerCheck:_getRemoteResInfoEx(url)
    local resInfoTxt = self.update:getUpdateInfo(url)
    if resInfoTxt == "" then
        return nil
    end
    local func = loadstring(resInfoTxt)
    if type(func) == "function" then
        return func()
    else
        return nil
    end
end

function VerCheck:getNewAppUrl()
    if device.platform == "android" or device.platform == "windows" then
        return self.remoteVerInfo.apkurl
    end
    return nil
end

function VerCheck:getResUpdateUrl()
    if self.localVerInfo.version == "0.0.0" then
        return self.localVerInfo.subpackurl
    end
    local package = self.remoteVerInfo.package
    if package then
        local curVer = self.localVerInfo.version
        local nextVer,nextDiff
        for ver,url in pairs(package) do
            local diff,isNew = UpdateApp.helper:compareVer(ver,curVer)
            if not isNew and diff > 0 then
                if not nextDiff or diff < nextDiff then
                    nextVer = ver
                    nextDiff = diff
                end
            end
        end
        return nextVer and package[nextVer]
    end
    return nil
end

function VerCheck:getVerStr()
    local str = ""
    if self.localVerInfo then
        str = self.localVerInfo.version or "error"
    end
    if self.remoteVerInfo then
        str = str ..","..(self.remoteVerInfo.version or "error")
    end
    return str
end

return VerCheck
