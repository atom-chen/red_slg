local cjson = require("cjson")

CCFileUtils:sharedFileUtils():addSearchPath("res/")

function requestConfig(name)
  	local fileName = "config/"..name
	local filePath = CCFileUtils:sharedFileUtils():fullPathForFilename(fileName)
    local cfgObj = require(filePath)
	return cfgObj
end

function readfile(path)
    local file = io.open(path, "r")
    if file then
        local content = file:read("*a")
        io.close(file)
        return content
    end
    return nil
end

local heroCfg = requestConfig("hero")
local skillCfg = requestConfig("skill")
local resCfg = requestConfig("resource")


local outPut = "<?xml version='1.0' encoding='utf-8'?> \n<AnimationCfg>\n<playerCfg>\n"

-- outPut = outPut.."\n\n\n".."heroName:"..heroName.."\n res:"..res.."\nskill:\n"

local mapCheck = {}

for id,hero in pairs(heroCfg) do
	local res = hero.res

	local heroName = hero.name  --英雄名字

	local jsonName = "anim/"..res..".json"   



	local filePath = CCFileUtils:sharedFileUtils():fullPathForFilename(jsonName)
	local str = readfile(filePath)

	local status, animJson = pcall(cjson.decode, str)  --英雄动画 json配置

	if animJson then

		-- local animJson = json.decode(str,true)  
		-- print("json ",jsonName,status)
		local actionCfg = animJson["actions"]  --动作配置
		
		for name ,action in pairs(actionCfg) do
			print("actionCfg   id: ",id)
			local startFrame = action[1]  --开始帧
			local endFrame = action[2]  --结束帧
			local frame = action[3]   --帧数 
			local def = "<playerDef name='"..heroName.."_"..name.."' filename='"..heroName.."序列图".."' offset='"..startFrame.."' frameRate='"..frame.."'>\n"

			local fp = "<rate value='"..(endFrame - startFrame).." 0 "..(endFrame - startFrame).."'/>\n"
			def = def..fp.."</playerDef>\n"
			
			if mapCheck[heroName.."_"..name] then
			
			else
				mapCheck[heroName.."_"..name] = true
				outPut = outPut..def
			end
		end
	end
	
--[[
		local skillList = hero.skills 
		
		for i,skillId in ipairs(skillList) do
			local sInfo = skillCfg[skillId]  --技能

			local def = ""

			if sInfo and sInfo.action then

				local skillName = sInfo.name
				print("技能名",skillName,skillId)
				local actionName = sInfo.action  --技能的动作名

				local framePlay = sInfo.framePlay  --播放 帧配置

				local action = actionCfg[actionName.."_1"]

				if action == nil then
					print("hero  action  no find ",actionName,heroName)
					-- for id ,ss in pairs(actionCfg) do
					-- 	print("actionCfg   id: ",id)
					-- end
				else
					local startFrame = action[1]  --开始帧
					local endFrame = action[2]  --结束帧
					local frame = action[3]   --帧数 

					def = "<playerDef name='"..heroName.."_"..i..skillName.."' filename='"..heroName.."序列图".."' offset='"..startFrame.."' frameRate='"..frame.."'>\n"

					local fp = ""
					if framePlay then
						for i=1, #framePlay,3 do
							fp = fp.."<rate value='"..framePlay[i].." "..framePlay[i+1].." "..framePlay[i+2].."'/>\n"
						end
					else
						fp = fp.."<rate value='"..(endFrame - startFrame).." 0 "..(endFrame - startFrame).."'/>\n"
					end
					def = def..fp.."</playerDef>\n"
				end

				action = actionCfg[actionName.."_2"]
				if action then
					local startFrame = action[1]  --开始帧
					local endFrame = action[2]  --结束帧
					local frame = action[3]   --帧数 

					def = def .. "<playerDef name='"..heroName.."_"..i..skillName.."(背面)' filename='"..heroName.."序列图".."' offset='"..startFrame.."' frameRate='"..frame.."'>\n"

					local fp = ""
					if framePlay then
						for i=1, #framePlay,3 do
							fp = fp.."<rate value='"..framePlay[i].." "..framePlay[i+1].." "..framePlay[i+2].."'/>\n"
						end
					else
						fp = fp .."<rate value='"..(endFrame - startFrame).." 0 "..(endFrame - startFrame).."'/>\n"
					end
					def = def..fp.."</playerDef>\n"
				end
			else
				print("skill no find:  " ,skillId)
			end

			outPut = outPut..def
		end
	else
		print("没找到 。。。。",jsonName)
	end
	--]]
end


outPut = outPut.."</playerCfg>\n</AnimationCfg>"


local file = io.open("toParticleCfg/animation.xml", "w")
 file:write(outPut)
file:close()
print("\n\n\n\t\t\tok,done!\n\n\n")



