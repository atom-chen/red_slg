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

require "lfs"
function findindir (path, wefind, r_table, intofolder)

    for file in lfs.dir(path) do
        if file ~= "." and file ~= ".." then
            local f = path..'\\'..file
            if file == wefind then
                --print("/t "..f)
                table.insert(r_table, f)
            end
            local attr = lfs.attributes (f)
            assert (type(attr) == "table")
            if attr.mode == "directory" and intofolder then
                findindir (f, wefind, r_table, intofolder)
            else
                --for name, value in pairs(attr) do
                --    print (name, value)
                --end
            end
        end
    end
end

local file = "..\\protocol"
local luaFiles = {}
findindir(file, "%.lua$", luaFiles, false)--查找lua文件
i=1
while luaFiles[i]~=nil do
    local index = string.find(luaFiles[i], ".lua")
    if index > 1 then
        --luaFiles[i] = string.sub(luaFiles[i],1,index-1)
    end
    i=i+1
end
return luaFiles

-------------------------------------
-- local currentFolder = [[C:\]]
-- local input_table = {}
-- findindir(currentFolder, "%.txt", input_table, false)--查找txt文件
-- i=1
-- while input_table[i]~=nil do
-- print(input_table[i])
-- i=i+1
-- end
