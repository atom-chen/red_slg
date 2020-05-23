--game_require("debugger")("127.0.0.1", 10000, "luaidekey")

--require("mobdebug.mobdebug").start()

require("framework.init")
require("framework.shortcodes")

function tostringex(v, len)
    if len == nil then len = 0 end
    local pre = string.rep('\t', len)
    local ret = ""
    ret = ret .. pre .. tostring(v) .. "\t(" .. type(v) .. ")"
    return ret
end

function tracebackex(level)
    level = level + 1
    local ret = ""
    ret = ret .. "stack traceback:\n"
    while true do
       --get stack info
       local info = debug.getinfo(level, "Sln")
       if not info then break end
       if info.what == "C" then                -- C function
        ret = ret .. tostring(level) .. "\tC function\n"
       else           -- Lua function
        ret = ret .. string.format("\t%s:%d in function '%s'\n", info.short_src, info.currentline, info.name or "")
       end
       --get local vars
       local i = 1
       if level == 3 then
           while true do
                local name, value = debug.getlocal(level, i)
                if not name then break end

                if name == "(*temporary)" then

                elseif name == "self" and level == 3 and type(value) == "table"  then
                    ret = ret.."self:".. "\n"
                    for k,v in pairs(value) do
                        local s = "self."..tostring(k)
                        ret = ret .. "\t\t" .. s .. " =\t" .. tostringex(v,3) .. "\n"
                    end
                else
                    ret = ret .. "\t\t" .. name .. " =\t" .. tostringex(value, 3) .. "\n"
                end
                i = i + 1
           end
        end
        level = level + 1
    end
    return ret
end

--CCLuaLoadChunksFromZip("res/framework_precompiled.zip")

if device.platform == "android" then
    REQUIRE_MOUDLE = true
    function game_require( path )
        local filePath = string.gsub(path,"%.","%/")
        filePath = CCFileUtils:sharedFileUtils():fullPathForFilename("scripts/"..filePath..".lua")
        if CCFileUtils:sharedFileUtils():isFileExist(filePath) then
            path = "scripts/"..path
        else
            path = "game."..path
        end
    	  return require(path)
    end
elseif device.platform == "ios" then
	  function game_require( path )
    	  path = "scripts."..path
    	  return require(path)
    end
else
    function game_require( path )
        return require(path)
    end
end
game_require("gameSettings")

xpcall(function()
    GameLaunch = game_require("launch.GameLaunch")
    GameLaunch:startup()
end, __G__TRACKBACK__)

