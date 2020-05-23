--
-- Author: wdx
-- Date: 2015-01-26 19:54:09
--
--更新 相关 工具类
local UpdateHelper = {}

require"lfs"

GameJavaCallCalss = "com/game/lib/LuaCallClass"


function UpdateHelper:callJavaFun(funcName, params, sig)
    local flag,ret = luaj.callStaticMethod(GameJavaCallCalss, funcName, params, sig) 
    return ret
end


--全局方法 弹框
function UpdateHelper:nativeMessageBox( title,text,btn1,btn2,func1,func2 )
    btn1 = btn1 or "确定"
    if device.platform == "android" then
        local params = {title or "", text or "", btn1, btn2 or "",function(event)
                if event == "ok" then
                    if func1 then
                        func1()
                    end
                else
                    if func2 then
                       func2()
                    end
                end
            end
        }
        self:callJavaFun("showAlertDialog", params)
    else
        local btnList = {btn1}
        if btn2 then
            btnList[2] = btn2
        end
        device.showAlert(title or "",text or "",btnList,function(event)
                if event.buttonIndex  == 1 then
                    if func1 then
                        func1()
                    end
                elseif event.buttonIndex  == 2 then
                    if func2 then
                        func2()
                    end
                end
            end)
    end
end

function UpdateHelper:tipToExitGame(text)
    self:nativeMessageBox( "提示",text,"确定",nil,function() UpdateApp:exit() end )
end

function UpdateHelper:ensureOrExitGame(text,okbtn,func)
    self:nativeMessageBox( "提示",text,okbtn or "确定","退出",func,function() UpdateApp:exit() end )
end

function UpdateHelper:tipNetAvailable(tip,func)
    local function retryFun()
        if self:isNetAvailable() then
            CCLuaLog("UpdateApp.helper:isNetAvailable()  :  true")
            func()
        else
            self:tipNetAvailable(tip,func)
        end
    end
    self:nativeMessageBox( "提示",tip,"重试","退出",
                    retryFun, function() UpdateApp:exit() end)
end

function UpdateHelper:isWifi()
    if device.platform == "android" then
        return self:callJavaFun("isWifi",{},"()Z")
    elseif device.platform == "windows" then
        return false
    else
        return network.isLocalWiFiAvailable()
    end
end

function UpdateHelper:isNetAvailable()
    if device.platform == "android" then
        return self:callJavaFun("isNetAvailable",{},"()Z")
    else
        return network.isInternetConnectionAvailable()
    end
end

function UpdateHelper:getdeviceId()
	if device.platform == "android" then
		return CallJava:getdeviceId()
	end
	return 0
end

function UpdateHelper:writeFile(path, content, mode)
    mode = mode or "w+b"
    local file,err = io.open(path, mode)
    if file then
        local flag,err = file:write(content)
        io.close(file)
        return flag,err
    else
        return false,err
    end
end
 
function UpdateHelper:readFile(path)
    return CCFileUtils:sharedFileUtils():getFileData(path)
end
 
function UpdateHelper:exists(path)
    return CCFileUtils:sharedFileUtils():isFileExist(path)
end
 
function UpdateHelper:mkdir(path)
    if not self:exists(path) then
        return lfs.mkdir(path)
    end
    return true
end

function UpdateHelper:emptyFile(path,flag)
    if self:exists(path) then
        local function _rmdir(path,flag)
            for file in lfs.dir(path)  do
                if file ~= "." and file ~= ".." then
                    local curFile = path.."/"..file
                    local attr = lfs.attributes(curFile)
                    if attr.mode == "directory" then
                        _rmdir(curFile,true)
                    else
                        os.remove(curFile)
                    end
                end
            end
            if flag then
                lfs.rmdir(path)
            end
        end
        _rmdir(path,flag)
    end
end

function UpdateHelper:rmdir(path)
    self:emptyFile(path,true)
end

function UpdateHelper:getTableFromFile(path)
    if self:exists(path) then
        local str = self:readFile(path)
        if str and str ~= "" then
            local func = loadstring(str)
            if type(func) == "function" then
                local tb = func()
                if type(tb) == "table" then
                    return tb
                end
            end
        end
    end
    return nil
end

function UpdateHelper:getStorePath()
    local path = CCUserDefault:sharedUserDefault():getStringForKey("storePath")
    if path ~= "" and CCFileUtils:sharedFileUtils():isFileExist(path) then
        return path
    end
    path = nil
    local platformID = CMJYXConfig:GetInst():getStringForKey("platform")
    local gameName = CMJYXConfig:GetInst():getStringForKey("gameName")

    local gamePlatform = require("update.PlatformSDK")
    local chID = gamePlatform:getChannelId()

    local fileName = gameName..platformID
    if chID and chID ~= "" then
        fileName = fileName.."_"..chID
    end

    if device.platform == "android" then
        path = self:callJavaFun("getGameResPath",{fileName},"(Ljava/lang/String;)Ljava/lang/String;")
        if path == "error" then
            return nil
        end
        path = path.."/"
    elseif device.platform == "ios" then
        path = CCFileUtils:sharedFileUtils():getWritablePath()..fileName
        if not self:mkdir(path) then
            return nil
        end
        path = path.."/game/"
        if not self:mkdir(path) then
            return nil
        end
    elseif device.platform == "windows" then
        path = "C:redClient/game/"..fileName
        if not self:mkdir(path) then
            return nil
        end
    end 
    CCUserDefault:sharedUserDefault():setStringForKey("storePath",path)
    CCUserDefault:sharedUserDefault():flush()
    return path
end

function UpdateHelper:getTempPath()
    local platformID = CMJYXConfig:GetInst():getStringForKey("platform")
    local gameName = CMJYXConfig:GetInst():getStringForKey("gameName")
    local gamePlatform = require("update.PlatformSDK")
    local chID = gamePlatform:getChannelId()

    local fileName = gameName..platformID
    if chID and chID ~= "" then
        fileName = fileName.."_"..chID
    end
    local path
    if device.platform == "android" then
        path =  self:callJavaFun("getGameTempPath",{fileName},"(Ljava/lang/String;)Ljava/lang/String;")
        if path == "error" then
            return nil
        end
        local tempPath = path.."/temp/"
        if not self:mkdir(tempPath) then
            return nil
        end
        local zipPath = path.."/zip/"
        if not self:mkdir(zipPath) then
            return nil
        end
        return tempPath,zipPath
        
    elseif device.platform == "ios" then
        local path = CCFileUtils:sharedFileUtils():getWritablePath()..fileName
        if not self:mkdir(path) then
            return nil
        end
        local tempPath = path.."/temp/"
        if not self:mkdir(tempPath) then
            return nil
        end
        local zipPath = path.."/zip/"
        if not self:mkdir(zipPath) then
            return nil
        end
        return tempPath,zipPath
    elseif device.platform == "windows" then
        local tempPath = "C:redClient/"..fileName.."/temp/"
        if not self:mkdir(tempPath) then
            return nil
        end
        local zipPath = "C:redClient/"..fileName.."/zip/"
        if not self:mkdir(zipPath) then
            return nil
        end
        return tempPath,zipPath
    end 
end

function UpdateHelper:compareVer(ver1,ver2)
    local vArr1 =  string.splitEx(ver1,"%.")
    local vArr2 =  string.splitEx(ver2,"%.")
    CCLuaLog("ver："..ver1..","..ver2)
    if #vArr1 ~= 3 or #vArr2 ~= 3 then
        return nil
    end

    if vArr1[1] ~= vArr2[1] then
        return tonumber(vArr1[1]) - tonumber(vArr2[1]),true
    elseif vArr1[2] ~= vArr2[2] then
        return tonumber(vArr1[2]) - tonumber(vArr2[2]),true
    else
        return tonumber(vArr1[3]) - tonumber(vArr2[3]),false
    end
end

function UpdateHelper:initSysInfo()
    device.phone_model = ""
    device.phone_sys_ver = ""

    if device.platform == "android" then
        local javaClassName = GameJavaCallCalss
        local javaMethodName = "getSysInfo"
        local javaParams = {}
        local javaMethodSig = "()Ljava/lang/String;"
        local flag,androidInfoStr = luaj.callStaticMethod(javaClassName, javaMethodName, javaParams, javaMethodSig)
        if flag then
            local androidInfo = string.split(androidInfoStr,"&no&")  --安卓信息
            device.phone_model = androidInfo[1]
            device.phone_sys_ver = androidInfo[2]
        end
    end
end

return UpdateHelper