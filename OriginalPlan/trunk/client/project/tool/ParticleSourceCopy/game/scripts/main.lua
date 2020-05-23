--require("debugger")("127.0.0.1", 10000, "luaidekey")

function __G__TRACKBACK__(errorMessage)
    CCLuaLog("----------------------------------------")
    CCLuaLog("                                        ")
    CCLuaLog("LUA ERROR: " .. tostring(errorMessage) .. "\n")
    CCLuaLog(debug.traceback("", 2))
    CCLuaLog("                                        ")
    CCLuaLog("----------------------------------------")

--    --提交日志信息给中央服
--    if STAT_URL then
--        local stat = {}
--        stat.statType = 10004
--        stat.log = errorMessage
--        StatSender.sendStat(stat,STAT_URL)
--    end
end

--CCLuaLoadChunksFromZip("res/framework_precompiled.zip")




xpcall(function()
    local GameLaunch = require("launch.GameLaunch")
    GameLaunch:startup()
end, __G__TRACKBACK__)