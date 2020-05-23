--
-- Author: Your Name
-- Date: 2014-03-31 17:08:58
--

local luaFiles = require("fileHandler")

local packCfg = {}
local entryCfg = {}

for i,file in ipairs(luaFiles) do
	local f = loadfile(file);
	print(file)
	local protocolCfg = f()
	if string.find(file,"00_entry.lua") then
		entryCfg = protocolCfg
	else
		local moudelName = nil
		for key,value in pairs(protocolCfg) do
			if moudelName == nil then
				moudelName = "proto_"..math.floor(key/1000)
				packCfg[moudelName] = {}
			end
			if packCfg[moudelName][key] ~= null then
				print("\n\n\n\t\t\tError:   "..key.."  msg duplicate definition..."..file.."\n\n")
			else
				packCfg[moudelName][key]  = value
			end
		end
	end
end


local path = require("pathSetting")[1]
local hrlPath = require("pathSetting")[3]

-- local PackCfg = require("protocol")

-- local packCfg,entryCfg = PackCfg[1],PackCfg[2]

local packFunName = "pack"
local unpackFunName = "unpack"

local erlangNameMap = {}

function getErlangName(name)
	if erlangNameMap[name] == nil then
		erlangNameMap[name] = 0
	end
	return name.."_"..erlangNameMap[name]
end

function newErlangName(name)
	if erlangNameMap[name] == nil then
		erlangNameMap[name] = 0
	end
	erlangNameMap[name] = erlangNameMap[name] +1
	return getErlangName(name)
end

--进行打包 一个普通类型
function getPackLineString(binName,newBinName,typeT,param)
	local binStr = ""

	local tStr = ""
	if binName then
		tStr = "<<"..binName.."/binary,"
	else
		tStr = "<<"
	end
	if typeT == "uint32" then
		tStr = tStr..param..":32>>,\n\t"
		binStr = binStr..newBinName.." = "..tStr
	elseif typeT == "uint16" then
		tStr = tStr..param..":16>>,\n\t"
		binStr = binStr..newBinName.." = "..tStr
	elseif typeT == "uint8" then
		tStr = tStr..param..":8>>,\n\t"
		binStr = binStr..newBinName.." = "..tStr
    elseif typeT == "int64" then
        tStr = tStr..param..":64/signed>>,\n\t"
        binStr = binStr..newBinName.." = "..tStr
	elseif typeT == "int32" then
		tStr = tStr..param..":32/signed>>,\n\t"
		binStr = binStr..newBinName.." = "..tStr
	elseif typeT == "int16" then
		tStr = tStr..param..":16/signed>>,\n\t"
		binStr = binStr..newBinName.." = "..tStr
	elseif typeT == "int8" then
		tStr = tStr..param..":8/signed>>,\n\t"
		binStr = binStr..newBinName.." = "..tStr
	elseif typeT == "string" then
		tStr = tStr.."(byte_size("..param..")):16,"..param.."/binary>>,\n\t"
		binStr = binStr..newBinName.." = "..tStr
	elseif typeT == "erlang_List_length" then
		tStr = tStr.."(length("..param..")):16"..">>,\n\t"
		binStr = binStr..newBinName.." = "..tStr
	else
        print("ERROR TYPE:" .. typeT)
	end
	return binStr
end

--进行打包 一个数组的
function getPackListString(binName,entryName)
	local entryInfo = entryCfg[entryName]

	local fName = newErlangName("Fun")
	local EName = newErlangName("_Elem")
	local fStr = "\n"..fName.." = fun("..EName..") -> \n\t"

	local tStr , retName
	if entryInfo ~= nil then
		tStr , retName = getPackChunkString(binName,EName,entryInfo)
	else
		tStr = getPackLineString(nil,binName.."_1",entryName,EName)
		retName = binName.."_1"
	end

	fStr = fStr..tStr
	fStr = fStr..retName.."\n\t"

	fStr = fStr.."end,\n\n\t"

	return fStr,fName
end

--一个大块 的 进行打包
function getPackChunkString(binName,EName,cfg)
	local fStr = ""

	local binIndex = 0
	local getBinName = function()
		if binIndex == 0 then
			return nil 
		end
		return binName.."_"..binIndex
	end
	local newBinName = function()
		binIndex = binIndex+1
		return getBinName()
	end

	if type(cfg) ~= "table" or #cfg == 0 then
		return "","<<>>"
	end

	local arrStr = "{"
	local binStr =  ""--newBinName().." = <<>>,\n\t"

	for pIndex,pValue in ipairs(cfg) do
		local name = newErlangName("_E_"..pValue[1])
		local typeT = pValue[2]
		arrStr = arrStr ..name ..","
		if typeT == "array" then
			local entryName = pValue[3]
			local tStr =  getPackLineString(getBinName(),newBinName(),"erlang_List_length",name)
				--"<<"..getBinName().."/binary,(byte_size("..name..")):16>>,\n\t"
			binStr = binStr ..tStr

			local listStr,funName = getPackListString(getBinName(),entryName)
			binStr = binStr .. listStr

			local tStr = "(list_to_binary(["..funName.."("..newErlangName("_Elem")..")||"..getErlangName("_Elem").."<-"..name.."]))/binary"

			tStr = "<<"..getBinName().."/binary,"..tStr..">>,\n\t"
			binStr = binStr .. newBinName().." = "..tStr

		elseif entryCfg[typeT] then
			if getBinName() == nil then
				newBinName()
				local listStr,funName = getPackListString(getBinName(),typeT)
				binStr = binStr .. listStr
				binStr = binStr .. newBinName().." = "..funName.."("..name.."),\n\t"
			else
				local listStr,funName = getPackListString(getBinName(),typeT)
				binStr = binStr .. listStr
				local tStr = "<<"..getBinName().."/binary,("..funName.."("..name.."))/binary>>,\n\t"
				binStr = binStr .. newBinName().." = "..tStr
			end
			
		else
			binStr = binStr..getPackLineString(getBinName(),newBinName(),typeT,name)
		end
	end 

	arrStr = string.sub(arrStr,1,-2)

	arrStr = arrStr.."} = ".. EName..",\n\t"

	fStr = fStr..arrStr..binStr

	return fStr,getBinName()
end


--解析 一个普通类型
function getUnpackLineString(binName,newBinName,typeT,param)
	local fStr = ""
	local tStr = ""
	if typeT == "int32" then
		tStr = tStr.."lib_proto:read_int32("..binName.."),\n\t"
		fStr = fStr .. "{"..param..","..newBinName.."} = "..tStr
    elseif typeT == "int64" then
        tStr = tStr.."lib_proto:read_int64("..binName.."),\n\t"
        fStr = fStr .. "{"..param..","..newBinName.."} = "..tStr
    elseif typeT == "int16" then
		tStr = tStr.."lib_proto:read_int16("..binName.."),\n\t"
		fStr = fStr .. "{"..param..","..newBinName.."} = "..tStr
	elseif typeT == "int8" then
		tStr = tStr.."lib_proto:read_int8("..binName.."),\n\t"
		fStr = fStr .. "{"..param..","..newBinName.."} = "..tStr
	elseif typeT == "string" then
		tStr = tStr.."lib_proto:read_string("..binName.."),\n\t"
		fStr = fStr .. "{"..param..","..newBinName.."} = "..tStr
	elseif typeT == "uint32" then
		tStr = tStr.."lib_proto:read_uint32("..binName.."),\n\t"
		fStr = fStr .. "{"..param..","..newBinName.."} = "..tStr
	elseif typeT == "uint16" then
		tStr = tStr.."lib_proto:read_uint16("..binName.."),\n\t"
		fStr = fStr .. "{"..param..","..newBinName.."} = "..tStr
	elseif typeT == "uint8" then
		tStr = tStr.."lib_proto:read_uint8("..binName.."),\n\t"
		fStr = fStr .. "{"..param..","..newBinName.."} = "..tStr
	end
	return fStr
end


--解析 一个数组的
function getUnpackListString(binName,entryName)
	local entryInfo = entryCfg[entryName]

	local fName = newErlangName("Fun")
	local fStr = "\n"..fName.." = fun("..binName.."_1"..") -> \n\t"

	local tStr , retName, lastBinName
	if entryInfo ~= nil then
		tStr , retName, lastBinName = getUnpackChunkString(binName,entryInfo)
		retName = "{"..retName.."}"
	else
		local rect = newErlangName("_Ret")
		tStr = getUnpackLineString(binName.."_1",binName.."_2",entryName,rect)
		retName = rect
		lastBinName = binName.."_2"
	end

	fStr = fStr..tStr
	fStr = fStr.."{"..retName..","..lastBinName.."}\n\t"

	fStr = fStr.."end,\n\n\t"

	return fStr,fName
end


--解析 一个大块
function getUnpackChunkString(binName,cfg)

	local fStr = ""

	local binIndex = 0
	local getBinName = function()
		return binName.."_"..binIndex
	end
	local newBinName = function()
		binIndex = binIndex+1
		return getBinName()
	end

	if type(cfg) ~= "table" or #cfg == 0 then
		return "",""
	end

	--fStr = fStr .. newBinName() .. " = "..binName..",\n\t"

	newBinName()

	local arrStr = ""
	
	for pIndex,pValue in ipairs(cfg) do
		local name = newErlangName("_E_"..pValue[1])
		local typeT = pValue[2]
		
		local tStr = ""
		if typeT == "array" then
			local entryName = pValue[3]

			local listStr,funName = getUnpackListString(getBinName(),entryName)
			fStr = fStr .. listStr
-- 	{P1_role_list, Bin1} =lib_proto:read_array(Bin, FUN_1),
			local tStr = "lib_proto:read_array("..getBinName()..","..funName.."),\n\t"

			tStr = "{"..name..",".. newBinName().."} = " .. tStr
			fStr = fStr ..tStr

		elseif entryCfg[typeT] then

			local listStr,funName = getUnpackListString(getBinName(),typeT)

			fStr = fStr .. listStr

			local tStr = funName.."("..getBinName().."),\n\t"
			tStr = "{"..name..",".. newBinName().."} = " .. tStr

			fStr = fStr ..tStr
			
		else
			fStr = fStr .. getUnpackLineString(getBinName(),newBinName(),typeT,name)
		end 
		arrStr = arrStr..name..","
	end 

	arrStr = string.sub(arrStr,1,-2)

	return fStr,arrStr,getBinName()

end 





--遍历
for mKey,mValue in pairs(packCfg) do

	local mStr = "-module ("..mKey..").\n".."-export (["..packFunName.."/2,"..unpackFunName.."/2]).\n"
	
	local packStr = ""
	local unpackStr = ""
    local hrlStr = ""
    -- 对key排序
    local key_table = {}
    for k,_ in pairs(mValue) do
        table.insert(key_table, k)
    end
    table.sort(key_table)

	-- for pKey,pValue in pairs(mValue) do
    for _, pKey in pairs(key_table) do
        local pValue = mValue[pKey]
		
        print("key:                        .......................",pKey)
        local macro = ""
        local zh_macro = ""
		local clientMsg = pValue["c"]   --客户端的请求
        if pValue["m"] ~= nil then
            macro = "PROTO_" .. math.floor(pKey/1000) .. "_" .. string.upper(pValue["m"])
        end

        if pValue["zh_m"] ~= nil then
            zh_macro = "%% " .. pValue["zh_m"]
        end

		erlangNameMap = {}
		
        if macro == "" then
            unpackStr = unpackStr .. unpackFunName.."("..pKey..",_Bin_1) ->\n\t"
        else
            unpackStr = unpackStr .. unpackFunName.."(?"..macro..",_Bin_1) ->\n\t"
        end

		local chunkStr,recName = getUnpackChunkString("_Bin",clientMsg)
		unpackStr = unpackStr .. chunkStr
		unpackStr = unpackStr.."{ok,{"..recName.."}};\n"

		local serverMsg = pValue["s"]   --服务器发送的响应
		erlangNameMap = {}
        if macro == "" then
	    	packStr = packStr .. packFunName.."("..pKey..",_P) ->\n\t"
        else
            hrlStr = hrlStr .. "-define(".. macro .. ", " .. pKey .. "). " .. zh_macro .. "\n"
	    	packStr = packStr .. packFunName.."(?"..macro..",_P) ->\n\t"
        end

		local chunkStr,recName =  getPackChunkString("_Bin","_P",serverMsg)
		packStr = packStr .. chunkStr
		packStr = packStr .. "{ok,"..recName.."};\n"

	end



	packStr = packStr.."pack(_OpCode, _Data) ->\n\t?DEBUG(\"未知协议打包:~p ~p\", [_OpCode, _Data]),\n\t{error, unknown_opcode}.\n\n"
	
    unpackStr = unpackStr.."unpack(_OpCode, _Bin) ->\n\t?DEBUG(\"未知协议解包: ~p ~p\", [_OpCode, _Bin]),\n\t{error, unknown_opcode}."


    mStr = mStr .. "\n-include(\"common.hrl\").\n"
    if hrlStr ~= "" then
        mStr = mStr.."\n-include(\"" .. mKey ..".hrl\").\n\n" .. packStr..unpackStr
    else
        mStr = mStr..packStr..unpackStr
    end

    local file = io.open(path..mKey..".erl", "w")
    file:write(mStr)
    file:close()
    if hrlStr ~= "" then
        local file = io.open(hrlPath..mKey..".hrl", "w")
        file:write(hrlStr)
        file:close()
    end
end
print("\n\n\n\t\t\tok,done!\n\n\n")




