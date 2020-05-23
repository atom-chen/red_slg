table.tostring = function(t)  
   local mark={}  
   local assign={}  
   local function ser_table(tbl,parent)  
       mark[tbl]=parent  
       local tmp={}  
       for k,v in pairs(tbl) do  
            local key= type(k)=="number" and "["..k.."]" or (k:match("%w+") and k or "[".. string.format("%q", k) .."]")
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


function convert(tablename, filename)
	local f = assert(io.open(filename, 'w'))
	local str = table.tostring(tablename)
	f:write("return ")
	f:write(str)
	f:close()
end

function string.rfind(s, pattern)
	local index = s:find(pattern)
	local old
	while(index) do
		old = index
		index = s:find(pattern, old+1)
	end
	return old
end

function convert_file(filename, ...)
	local news = {...}
	local dir = filename:sub(1, filename:rfind('/') or filename:rfind('\\'))
	local new1 = dir .. news[1]
	print(string.format("dir:%s\nfilename:%s\n", dir, filename))
	
	local f,err = loadfile(filename)
	if err then print("error:", err) end
	local tab = f()
	local newtab = {}
	for id,suit in pairs(tab) do
		if suit.itemList then
			for i,itemId in ipairs(suit.itemList) do
				newtab[itemId] = id
			end
		end
	end
	
	convert(newtab, new1)
end


function main()

	--convert(getCanComItems(), "../../../project/game/res/config/itemToCom.lua")
	convert_file(arg[1], arg[2])
end

main()
