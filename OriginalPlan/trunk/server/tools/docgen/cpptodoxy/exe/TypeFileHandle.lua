package.cpath = package.cpath..";./?.dll;./?.so;../lib/?.so;../lib/vc_dll/?.dll;../lib/bcc_dll/?.dll;../lib/mingw_dll/?.dll;"
package.path = package.path .. ";?.lua"
require ("io");


-------------------------------------------------------
-- 作用: 打印对像
-- 参数: 对象
-- 返回: 空
function printObject(tab)
    for i,v in pairs(tab) do
        if type(v) == "table"
        then
            print("table",i,"{");
            printTab(v);
            print("}");
        else
            print(i .. " " .. v);
        end
    end
end

-------------------------------------------------------
-- 作用: 分割字符串
-- 参数: 待分割的字符串,分割字符
-- 返回: 子串表.(含有空串)
function stringSplit(str, split_char)
    local sub_str_tab = {};
    while (true) do
        local pos = string.find(str, split_char);
        if (not pos) then
            sub_str_tab[#sub_str_tab + 1] = str;
            break;
        end
        local sub_str = string.sub(str, 1, pos - 1);
        sub_str_tab[#sub_str_tab + 1] = sub_str;
        str = string.sub(str, pos + 1, #str);
    end

    return sub_str_tab;
end

-------------------------------------------------------
-- 作用: 删除两端空格
-- 参数: 源字符串
-- 返回: 删除后字符串
function delStringTowEndSpace(str)
        assert(type(str)=="string")
        return str:match("^%s*(.+)%s*$")
end

-------------------------------------------------------
-- 作用: 解析类似于typedef uint32	TRecordeServerID_t; 格式的字符串并以TRecordeServerID_t:uint32格式存储在表中
-- 参数: 文件名
-- 返回: 类型表 key:别名 value:类型
function getTypesDefine(fileName)
	local srcFile = io.open(fileName, "r"); 
	if srcFile == nil
	then
		return;
	end
	
	local types = {};
	for line in srcFile:lines() do
		startIndex,endIndex = string.find(line, "^[%s]*typedef[%s]+[%w]+[%s]+[%w_]+");
		if startIndex ~= nil
		then
			-- print(startIndex .. " " .. endIndex);
			-- print(string.sub(line, startIndex, endIndex-string.len(line)-1));
			findStr = string.sub(line, startIndex, endIndex-string.len(line)-1);
			replaceStr=string.gsub(findStr, "[%s]+", " ");
			-- print(replaceStr);
			replaceStr=delStringTowEndSpace(replaceStr);
			-- print(replaceStr);
			local spliteStrs = stringSplit(replaceStr, " ");
			-- printObject(spliteStrs);
			if spliteStrs ~= nil and table.getn(spliteStrs) == 3
			then
				types[spliteStrs[3]] = spliteStrs[2];
			end
		end
	end
	
	io.close(srcFile);
	return types;
end

function findString(str, fmt)
	local startIndex,endIndex = string.find(str, fmt);
	if startIndex ~= nil
	then
		return string.sub(str, startIndex, endIndex-string.len(str)-1);
	end

	return "";
end

-------------------------------------------------------
-- 作用: 解析协议结构并去除多余的行并替换成员类型
-- 参数: 文件名, 类型表, 协议ID表
-- 返回: 替换后的文件字符串
-- 类定义
--       class CMChallengeOtherRole : public CRequestPacket
--       {
--             
--       };
--       
--       class CMChallengeOtherRole : public CRequestPacket

function replaceTypesDefine(fileName, types, packids)
	local srcFile = io.open(fileName, "r"); 
	if srcFile == nil
	then
		return;
	end
	
	local classDefineLines = {};
	local continueFlag = true;
	local findMember = false;
	local findPublic = false;
	local findClass = false;
	local findPacketDef = false;
	local findClassEnd = false;
	local findClassBegin = false;
	local classCommentIndex = -1;
	for line in srcFile:lines() do
		continueFlag = true;
		if continueFlag
		then
			local startIndex,endIndex = string.find(line, "^[%s]*class[%s]+[%w_]+[%s]*:[%s]*public[%s]+[%w_]+");
			if startIndex ~= nil
			then
				-- 读到类开头的结构
				-- print(startIndex .. " " .. endIndex);
				-- print(string.sub(line, startIndex, endIndex-string.len(line)-1));
				local findStr = string.sub(line, startIndex, endIndex-string.len(line)-1);
				--print(findStr);
				local matchStr = "";
				for v in string.gmatch(findStr, "[%s]*class[%s]+([%w_]+)")
				do
					matchStr = v;
					break;
				end
				if matchStr ~= ""
				then
					--print(matchStr);
					table.insert(classDefineLines, "/// 未知协议定义");
					classCommentIndex = table.getn(classDefineLines);
					table.insert(classDefineLines, line);
					continueFlag = false;
					findClass = true;
					findPublic = false;
					findMember = false;
					findPacketDef = false;
					findClassBegin = false;
					findClassEnd = false;
				end
			end
		end
		
		-- 没有找到类定义
		if findClass == false
		then
			local packIDStr = findString(line,".+PACKET_[%w_]+");
			if packIDStr == ""
			then
				table.insert(classDefineLines, line);
				classCommentIndex = -1;
			end
			
			continueFlag = false;
		end

		-- 解析类定义下的第一个{
		if continueFlag and findClassBegin == false
		then
			continueFlag = false;
			local startIndex,endIndex = string.find(line, "^[%s]*{[%s]*$");
			if startIndex ~= nil
			then
				continueFlag = true;
				findClassBegin = true;
				table.insert(classDefineLines, line);
			end
		end
		
		-- 解析};
		if continueFlag and findClassEnd == false
		then
			local startIndex,endIndex = string.find(line, "^[%s]*}[%s]*;[%s]*$");
			if startIndex ~= nil
			then
				findMember = false;
				findPublic = false;
				findClass = false;
				findClassBegin = false;
				findPacketDef = false;
				findClassEnd = true;
				continueFlag = false;
				table.insert(classDefineLines, line);
			end
		end
		
		-- 如果已经找到类定义尾则剩余不处理了
		if continueFlag and findClassEnd
		then
			table.insert(classDefineLines, line);
			continueFlag = false;
		end

		if continueFlag and findClass and findPacketDef == false
		then
			local startIndex,endIndex = string.find(line, ".+PACKET_[%w_]+");
			if startIndex ~= nil
			then
				-- 读到类的协议定义
				-- print(startIndex .. " " .. endIndex);
				-- print(string.sub(line, startIndex, endIndex-string.len(line)-1));
				findStr = string.sub(line, startIndex, endIndex-string.len(line)-1);
				
				local matchStr = "";
				for v in string.gmatch(findStr, ".+(PACKET_[%w_]+)")
				do
					matchStr = v;
					break;
				end
				if matchStr ~= "" and classCommentIndex ~= -1 and packids[matchStr] ~= nil
				then
					classDefineLines[classCommentIndex] = packids[matchStr];
					-- table.insert(classDefineLines, line);
				end
				continueFlag = false;
				findPacketDef = true;
			end
		end
		
		if continueFlag
		then
			local startIndex,endIndex = string.find(line, "^[%s]*//[%s]*@member[%s]*$");
			if startIndex ~= nil
			then
				-- 读到成员定义
				-- print(startIndex .. " " .. endIndex);
				-- print(string.sub(line, startIndex, endIndex-string.len(line)-1));
				continueFlag = false;
				findMember = true;
			end
		end

		if continueFlag and findMember
		then
			if findPublic ~= true
			then
				-- 查找public:
				local startIndex,endIndex = string.find(line, "^[%s]*public[%s]*:[%s]*$");
				if startIndex ~= nil
				then
					-- print("member start" .. " " .. line);
					table.insert(classDefineLines, line);
					findPublic = true;
				end
			else
				-- 查找到public:
				local startIndex,endIndex = string.find(line, "^[%s]*public[%s]*:[%s]*$");
				if startIndex ~= nil
				then
					-- print("member end" .. " " .. line);
					findMember = false;
					findPublic = false;
				end
				
				if findMember == true
				then
					-- 解析成员 TGuanQiaTypeID_t	myHeroDataAry[1234]
					local startIndex,endIndex = string.find(line, "^[%s]*[%w_]+[%s]+[%w_%[%]]+[%s]*;");
					if startIndex ~= nil
					then
						-- 读到成员定义
						-- print(startIndex .. " " .. endIndex);
						-- print(string.sub(line, startIndex, endIndex-string.len(line)-1));
						local findStr = string.sub(line, startIndex, endIndex-string.len(line)-1);
						local replaceStr=delStringTowEndSpace(findStr);
						-- print(replaceStr);
						replaceStr=string.gsub(replaceStr, "[%s]+", " ");
						-- print(replaceStr);
						local spliteStrs = stringSplit(replaceStr, " ");
						-- printObject(spliteStrs);
						-- print(types[spliteStrs[1]]);
						if table.getn(spliteStrs) > 0 and types[spliteStrs[1]] ~= nil
						then
							-- print("^[%s]*"..spliteStrs[1]);
							replaceStr=string.gsub(line, spliteStrs[1], types[spliteStrs[1]]);
							-- print(replaceStr);
							table.insert(classDefineLines, replaceStr);
							continueFlag = false;
						else
							table.insert(classDefineLines, line);
						end
					else
						table.insert(classDefineLines, line);
					end
				end
			end
		end
	end
	io.close(srcFile);

	return classDefineLines;
end

-------------------------------------------------------
-- 作用: 解析逻辑结构替换成员的类型
-- 参数: 文件名, 类型表
-- 返回: 替换后的文件字符串
-- 类定义
--       typedef struct _ChangeLineWait
--       {
--		[// @member]
--       [public:]
--		TObjUID_t objUID;							[///< 对象UID]
--       [public:]
--       };

function replaceStructTypesDefine(fileName, types)
	local srcFile = io.open(fileName, "r"); 
	if srcFile == nil
	then
		return;
	end
	
	local classDefineLines = {};
	local continueFlag = true;
	local findMember = false;
	local findPublic = false;
	local findClass = false;
	local findClassEnd = false;
	local findClassBegin = false;
	for line in srcFile:lines() do
		continueFlag = true;
		if continueFlag
		then
			local findStr = findString(line, "^[%s]*typedef[%s]+struct[%s]+[%w_]+[%s]*[^;]*");
			if findStr ~= ""
			then
				-- print(line);

				-- 读到类开头的结构
				local matchStr = "";
				for v in string.gmatch(findStr, "[%s]*typedef[%s]+struct[%s]+([%w_]+)")
				do
					matchStr = v;
					break;
				end
				if matchStr ~= ""
				then
					--print(matchStr);
					table.insert(classDefineLines, line);
					continueFlag = false;
					findClass = true;
					findPublicBegin = false;
					findPublicEnd = false;
					findMember = false;
					findClassBegin = false;
					findClassEnd = false;
				end
			end
		end
		
		-- 没有找到类定义
		if findClass == false
		then
			table.insert(classDefineLines, line);
			continueFlag = false;
		end

		-- 解析类定义下的第一个{
		if continueFlag and findClassBegin == false
		then
			continueFlag = false;
			local findStr = findString(line, "^[%s]*{[%s]*$");
			if findStr ~= ""
			then
				continueFlag = false;
				findClassBegin = true;
				table.insert(classDefineLines, line);
			end
		end
		
		-- 解析};
		if continueFlag and findClassEnd == false
		then
			local findStr = findString(line, "^[%s]*}[%s]*[%w]*[%s]*;[%s]*[/<]*[%s]*.*");
			if findStr ~= ""
			then
				findMember = false;
				findPublicBegin = false;
				findPublicEnd = false;
				findClass = false;
				findClassBegin = false;
				findClassEnd = true;
				table.insert(classDefineLines, line);
				continueFlag = false;
			end
		end
		
		-- 如果已经找到类定义尾则剩余不处理了
		if continueFlag and findClassEnd
		then
			table.insert(classDefineLines, line);
			continueFlag = false;
		end
		
		-- 没有找到@member开头的且从来没有找到过@member开头的
		if continueFlag and findMember == false
		then
			local findStr = findString(line, "^[%s]*//[%s]*@member[%s]*$");
			if findStr ~= ""
			then
				-- 读到成员定义
				continueFlag = false;
				findMember = true;
				findPublicBegin = false;
				findPublicEnd = false;
			end
		end
		
		-- 已经有@member标记, 则找到public:~public:之间的行处理
		if continueFlag and findMember
		then
			if findPublicBegin ~= true
			then
				-- 查找public:
				local findStr = findString(line, "^[%s]*public[%s]*:[%s]*$");
				if findStr ~= ""
				then
					table.insert(classDefineLines, line);
					findPublicBegin = true;
					continueFlag = false;
				end
			else
				-- 查找到public:
				local findStr = findString(line, "^[%s]*public[%s]*:[%s]*$");
				if findStr ~= ""
				then
					findMember = false;
					findPublicEnd = true;
					continueFlag = false;
				end
			end
			
			if findPublicBegin and continueFlag
			then
				-- 解析成员 TGuanQiaTypeID_t	myHeroDataAry[1234]
				local findStr = findString(line, "^[%s]*[%w_]+[%s]+[%w_%[%]]+[%s]*;");
				if findStr ~= ""
				then
					local replaceStr=delStringTowEndSpace(findStr);
					replaceStr=string.gsub(replaceStr, "[%s]+", " ");
					local spliteStrs = stringSplit(replaceStr, " ");
					if table.getn(spliteStrs) > 0 and types[spliteStrs[1]] ~= nil
					then
						replaceStr=string.gsub(line, spliteStrs[1], types[spliteStrs[1]]);
						table.insert(classDefineLines, replaceStr);
						continueFlag = false;
					else
						table.insert(classDefineLines, line);
					end
				else
					table.insert(classDefineLines, line);
				end
			end
		end
		
		-- 没有有@member标记，则不处理public:标记
		if continueFlag and findMember == false and findPublicEnd == false
		then
			-- 解析成员 TGuanQiaTypeID_t	myHeroDataAry[1234]
			local startIndex,endIndex = string.find(line, "^[%s]*[%w_]+[%s]+[%w_%[%]]+[%s]*;");
			if startIndex ~= nil
			then
				-- 读到成员定义
				local findStr = string.sub(line, startIndex, endIndex-string.len(line)-1);
				local replaceStr=delStringTowEndSpace(findStr);
				replaceStr=string.gsub(replaceStr, "[%s]+", " ");
				local spliteStrs = stringSplit(replaceStr, " ");
				if table.getn(spliteStrs) > 0 and types[spliteStrs[1]] ~= nil
				then
					replaceStr=string.gsub(line, spliteStrs[1], types[spliteStrs[1]]);
					table.insert(classDefineLines, replaceStr);
					continueFlag = false;
				else
					table.insert(classDefineLines, line);
				end
			else
				table.insert(classDefineLines, line);
			end
		end
	end
	io.close(srcFile);

	return classDefineLines;
end

-------------------------------------------------------
-- 作用: 解析枚举并将枚举值常量写入注释中
-- 参数: 文件名
-- 返回: 替换后的文件字符串
-- 枚举定义
--       enum XXX
--       {
--		INVALID_SERVER_TYPE[ = 0],			[///< 无效]
--       };
function replaceEnumConstValue(fileName)
	local srcFile = io.open(fileName, "r"); 
	if srcFile == nil
	then
		return;
	end

	local linesDef = {};
	local enumBegin = false;
	local enumEnd = false;
	for line in srcFile:lines() do
		local conLine = line;
		for k in string.gmatch(line, "[%w_]+[%s]*=[%s]*([%d]+)[%s]*,[%s]*///<[%s]*[\128-\255]+")
		do
			conLine = conLine .. " - " .. k;
			break;
		end

		table.insert(linesDef, conLine);
	end
	io.close(srcFile);

	return linesDef;
end

-------------------------------------------------------
-- 作用: 解析协议ID
-- 参数: 文件名,
-- 返回: 协议ID对应的字符串
-- 协议定义 PACKET_WC_TEST = 1,	 ///< 测试协议
function getPackIDDefine(fileName)
	local srcFile = io.open(fileName, "r"); 
	if srcFile == nil
	then
		return;
	end
	
	local packids = {};
	for line in srcFile:lines() do
		for k, v, j in string.gmatch(line, "(PACKET_[%w_]+)[%s]*=[%s]*([%d]+)[%s]*,[/<%s]*([\128-\255]+)")
		do
			packids[k] = "/// " .. j .. " - " .. v;
			break;
		end
	end

	io.close(srcFile);

	return packids;
end

-- local types = getTypesDefine("types.txt");
-- printObject(types);
-- local packids=getPackIDDefine("pack_id.txt");
-- printObject(packids);
-- local classDefs = replaceTypesDefine("protocal.txt", types, packids);
-- printObject(classDefs);


local typesFiles = {"protocal.txt",}; 

function writeToFile(tab, fileName)
	local srcFile = io.open(fileName, "w"); 
	if srcFile == nil
	then
		return;
	end
	
	for i,v in pairs(tab) do
		srcFile:write(v);
		srcFile:write("\n");
	end

	io.close(srcFile);
end

module("TypeFileHandle",package.seeall); 


function handleAllPacketStruct(basePath, files, typeFiles, packIDFile)
	local types = {}
	for k,v in pairs(typeFiles) do
	    local tts = getTypesDefine(basePath .. v);
	    for kt,vt in pairs(tts) do
		types[kt] = vt;
	    end
	end
	local packids=getPackIDDefine(basePath .. packIDFile);
	
	for k, v in ipairs(files) do
		local oldname = basePath .. v;
		local newname = basePath .. v .. ".bak";
		os.rename (oldname, newname)
		local classDefs = replaceTypesDefine(newname, types, packids);
		writeToFile(classDefs, newname);
		os.rename (newname, oldname)
	end
end

function handleAllEnum(basePath, files)
	for k, v in ipairs(files) do
		local oldname = basePath .. v;
		local newname = basePath .. v .. ".bak";
		os.rename (oldname, newname)
		local classDefs = replaceEnumConstValue(newname);
		writeToFile(classDefs, newname);
		os.rename (newname, oldname)
	end
end

function handleAllStruct(basePath, files, typeFiles)
	local types = {}
	for k,v in pairs(typeFiles) do
	    local tts = getTypesDefine(basePath .. v);
	    for kt,vt in pairs(tts) do
		types[kt] = vt;
	    end
	end
	for k, v in ipairs(files) do
		local oldname = basePath .. v;
		local newname = basePath .. v .. ".bak";
		os.rename (oldname, newname)
		local classDefs = replaceStructTypesDefine(newname, types);
		writeToFile(classDefs, newname);
		os.rename (newname, oldname)
	end
end

-- typesFiles = {"pack_id.txt",}; 
-- local basePath="";
-- handleAllStruct(basePath, typesFiles, "types.txt", "pack_id.txt");
-- local types = getTypesDefine("game_util.h");
--replaceStructTypesDefine("struct_def.h", types);

-- enumFiles = {"enum_def.txt"};
-- handleAllEnum(basePath, enumFiles);

-- local structFiles = {"struct_def.txt"};
-- handleAllStruct(basePath, structFiles, "game_util.h");