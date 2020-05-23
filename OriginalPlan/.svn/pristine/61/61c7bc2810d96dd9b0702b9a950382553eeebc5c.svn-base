
local ok, socket = pcall(function()
    return require("socket")
end)

if ok then
    math.randomseed(socket.gettime() * 1000)
else
    math.randomseed(os.time())
end
-- math.random()
-- math.random()
-- math.random()
-- math.random()

if type(DEBUG) ~= "number" then DEBUG = 1 end
local CURRENT_MODULE_NAME = ...

cc = cc or {}
cc.PACKAGE_NAME = string.sub(CURRENT_MODULE_NAME, 1, -6)


cc.VERSION = "2.2.0"
cc.FRAMEWORK_NAME = "quick-cocos2d-x client"

require(cc.PACKAGE_NAME .. ".debug")
require(cc.PACKAGE_NAME .. ".functions")
require(cc.PACKAGE_NAME .. ".cocos2dx")

echoInfo("")
echoInfo("# DEBUG                        = "..DEBUG)
echoInfo("#")

device     = require(cc.PACKAGE_NAME .. ".device")
transition = require(cc.PACKAGE_NAME .. ".transition")
display    = require(cc.PACKAGE_NAME .. ".display")
audio      = require(cc.PACKAGE_NAME .. ".audio")
network    = require(cc.PACKAGE_NAME .. ".network")
ui         = require(cc.PACKAGE_NAME .. ".ui")
crypto     = require(cc.PACKAGE_NAME .. ".crypto")
-- json       = require(cc.PACKAGE_NAME .. ".json") --不用json这东西

EventProtocol = require(cc.PACKAGE_NAME ..".api.EventProtocol")
scheduler = require(cc.PACKAGE_NAME ..".scheduler")

if device.platform == "android" then
    require(cc.PACKAGE_NAME .. ".platform.android")
elseif device.platform == "ios" then
    require(cc.PACKAGE_NAME .. ".platform.ios")
end

if not NO_SHORTCODES then
    require(cc.PACKAGE_NAME .. ".shortcodes")
end

__G__TRACKBACK__ = function(errorMessage)
      CCLuaLog("----------------------------------------")
      CCLuaLog("                                        ")
      local errorStr = tostring(errorMessage)
      local bug = debug.traceback("", 2)
      -- local bug = tracebackex(2)
      CCLuaLog("LUA ERROR: " .. errorStr .. "\n")
      CCLuaLog(bug)
      CCLuaLog("                                        ")
      CCLuaLog("----------------------------------------")

     --提交错误信息
      if StatSender then
          if StatSender.lastError ~= errorStr then
              StatSender.lastError = errorStr
              StatSender:sendBug( errorStr .. "  \n  " ..bug)
          end
      end
 end