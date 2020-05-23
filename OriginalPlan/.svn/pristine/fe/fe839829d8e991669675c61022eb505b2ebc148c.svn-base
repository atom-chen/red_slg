table.tostring = function(t)  
   local mark={}  
   local assign={}  
   local function ser_table(tbl,parent)  
       mark[tbl]=parent  
       local tmp={}  
       for k,v in pairs(tbl) do  
            local key= type(k)=="number" and "["..k.."]" or "[".. string.format("%q", k) .."]"  
            if type(v)=="table" then  
                 local dotkey= parent.. key  
                 if mark[v] then  
                    table.insert(assign,dotkey.."='"..mark[v] .."'")  
                 else  
                    table.insert(tmp, key.."="..ser_table(v,dotkey))  
                 end  
            elseif type(v) == "string" then  
                table.insert(tmp, key.."=".. string.format('%q', v))  
            elseif type(v) == "number" or type(v) == "boolean" then  
                table.insert(tmp, key.."=".. tostring(v))  
            end  
        end  
       return "{"..table.concat(tmp,",").."}"  
    end  
    return ser_table(t,"ret")..table.concat(assign," ")  
end  


table.tostring_2 = function(t)  
   local mark={}  
   local assign={}  
   local function ser_table(tbl,parent)  
       mark[tbl]=parent  
       local tmp={}  
       local pass = {}
       for k,v in ipairs(tbl) do  
            pass[k] = true
            local key= type(k)=="number" and "["..k.."]" or "[".. string.format("%q", k) .."]"  
            if type(v)=="table" then  
                 local dotkey= parent.. key  
                 if mark[v] then  
                    table.insert(assign,"'"..mark[v] .."'")  
                 else  
                    table.insert(tmp, ser_table(v,dotkey))  
                 end  
            elseif type(v) == "string" then  
                table.insert(tmp, string.format('%q', v))  
            elseif type(v) == "number" or type(v) == "boolean" then  
                table.insert(tmp, tostring(v))  
            end  
        end
        for k,v in pairs(tbl) do  
            if pass[k] ~= true then
                local key= type(k)=="number" and "["..k.."]" or "[".. string.format("%q", k) .."]"  
                if type(v)=="table" then  
                     local dotkey= parent.. key  
                     if mark[v] then  
                        table.insert(assign,dotkey.."='"..mark[v] .."'")  
                     else  
                        table.insert(tmp, key.."="..ser_table(v,dotkey))  
                     end  
                elseif type(v) == "string" then  
                    table.insert(tmp, key.."=".. string.format('%q', v))  
                elseif type(v) == "number" or type(v) == "boolean" then  
                    table.insert(tmp, key.."=".. tostring(v))  
                end
            end
        end
       return "{"..table.concat(tmp,",").."}"  
    end  
    return ser_table(t,"ret")..table.concat(assign," ")  
end

function addRequirePath(p)
	local path = package.path
	print(package.path)
	package.path = path .. ";" .. p
end

function init()
	addRequirePath("../../../project/game/res/config/?.lua")
end

init()
item_config = require("item")
item_com_config = require("item_com")
hero_quality_config = require("hero_quality")

function getCanComItems()
	local allItems = {}
	for id,_ in pairs(item_config) do
		local items = {}
		for itemId, cfg in pairs(item_com_config) do
			for i,v in ipairs(cfg.num_4) do
				if v[1] == id then
					table.insert(items, itemId)
					break
				end
			end
		end
		allItems[id] = items
	end
	return allItems
end


function getCanEquipHeroesByQuality(quality)
	local cfg = hero_quality_config[quality]
	local items = {}
	for id,_ in pairs(item_config) do
		local heroes = {}
		for heroId, v in pairs(cfg) do
			for i=1,6 do
				if v["eqm_" .. i] == id then
					table.insert(heroes, heroId)
					break
				end
			end
		end
		items[id] = heroes
	end
	return items
end

-- quality itemId heroes
function getCanEquipHeroes()
	local qualityHeroes = {}
	for quality = 1, 10 do
		qualityHeroes[quality] = getCanEquipHeroesByQuality(quality)
	end
	return qualityHeroes
end


function convert(tablename, filename)
	local f = assert(io.open(filename, 'w'))
	local str = table.tostring(tablename)
	f:write("return ")
	f:write(str)
	f:close()
end




function main()
	
	convert(getCanComItems(), "../../../project/game/res/config/itemToCom.lua")
	
	convert(getCanEquipHeroes(), "../../../project/game/res/config/itemToHero.lua")
end

main()
