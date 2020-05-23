
local first = {}
local other = {}
local first_s = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_"
local second_s = "1234567890"
for i=1,first_s:len() do
	first[first_s:sub(i,i)] = true
	other[first_s:sub(i,i)] = true
end

for i=1,second_s:len() do
	other[second_s:sub(i,i)] = true
end


local function isWord(word)
	if type(word) ~= "string" then
		return false
	end
	
	if word:len() == 0 then
		return false
	end
	
	if not first[word:sub(1,1)] then
		return false
	end
	
	for i=2,word:len() do
		if not other[word:sub(i,i)] then
			return false
		end
	end
	
	return true
end


local tableTostring = function(t)  
	local mark={}  
	local assign={}
	local value_to_string
	local function key_to_string(k, array_count)
		if type(k)=="number" and k <= array_count then
			return nil
		elseif isWord(k) then
			return k
		else
			return type(k)=="number" and "["..k.."]" or "[".. string.format("%q", k) .."]"
		end
	end
	local function insert_table_str(tmp, k, v, array_count)
		local key = key_to_string(k, array_count)
		local val = value_to_string(v)
		local str
		if key then
			str = key
		end
		if val then
			if str then
				str = str .. "=" .. val
			else
				str = val
			end
		end
		if str then
			table.insert(tmp, str)
		end
	end
	
	local function ser_table(tbl)
		local tmp={}
		local count = 0
		for i=1,#tbl do
			if tbl[i] ~= nil then
				insert_table_str(tmp, i, tbl[i], i)
				count = i
			else
				break
			end
		end
		for k,v in pairs(tbl) do
			if type(k) == "number" and k <= count then
			else
				insert_table_str(tmp, k, v, count)
			end
		end  
		return "{"..table.concat(tmp,",").."}"  
	end  
	value_to_string = function (v)
		if type(v)=="table" then  
			return ser_table(v)
		elseif type(v) == "string" then  
			return string.format('%q', v)
		elseif type(v) == "number" or type(v) == "boolean" then  
			return tostring(v)
		end  
	end
    return ser_table(t)
end 


local luaFiles = require("fileHandler")

local packCfg = {}
-- local entryCfg = {}
for i,file in ipairs(luaFiles) do
	print(file)
	if string.find(file,"01_g2l.lua") == nil then
		local f = loadfile(file);
		local protocolCfg = f()
		for key,value in pairs(protocolCfg) do
			if packCfg[key] ~= nil then
				print("\n\n\n\t\t\tError:   "..key.."  msg duplicate definition..."..file.."\n\n")
			else
				packCfg[key] = value
			end
		end
	end
end

  

local path = require("pathSetting")[2]



-- local toCfg = {}
-- for mKey,mValue in pairs(packCfg) do
-- 	for pKey,pValue in pairs(mValue) do
-- 		toCfg[pKey] = pValue
-- 	end
-- end

-- for eKey,eValue in pairs(entryCfg) do
-- 	toCfg[eKey] = eValue
-- end

local str = tableTostring(packCfg)

str = "local packCfg = "..str.."\nreturn packCfg"

local file = io.open(path, "w")
 file:write(str)
file:close()
print("\n\n\n\t\t\tok,done!\n\n\n")







