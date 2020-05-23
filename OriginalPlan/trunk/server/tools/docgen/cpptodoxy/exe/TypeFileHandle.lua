package.cpath = package.cpath..";./?.dll;./?.so;../lib/?.so;../lib/vc_dll/?.dll;../lib/bcc_dll/?.dll;../lib/mingw_dll/?.dll;"
package.path = package.path .. ";?.lua"
require ("io");


-------------------------------------------------------
-- ����: ��ӡ����
-- ����: ����
-- ����: ��
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
-- ����: �ָ��ַ���
-- ����: ���ָ���ַ���,�ָ��ַ�
-- ����: �Ӵ���.(���пմ�)
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
-- ����: ɾ�����˿ո�
-- ����: Դ�ַ���
-- ����: ɾ�����ַ���
function delStringTowEndSpace(str)
        assert(type(str)=="string")
        return str:match("^%s*(.+)%s*$")
end

-------------------------------------------------------
-- ����: ����������typedef uint32	TRecordeServerID_t; ��ʽ���ַ�������TRecordeServerID_t:uint32��ʽ�洢�ڱ���
-- ����: �ļ���
-- ����: ���ͱ� key:���� value:����
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
-- ����: ����Э��ṹ��ȥ��������в��滻��Ա����
-- ����: �ļ���, ���ͱ�, Э��ID��
-- ����: �滻����ļ��ַ���
-- �ඨ��
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
				-- �����࿪ͷ�Ľṹ
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
					table.insert(classDefineLines, "/// δ֪Э�鶨��");
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
		
		-- û���ҵ��ඨ��
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

		-- �����ඨ���µĵ�һ��{
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
		
		-- ����};
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
		
		-- ����Ѿ��ҵ��ඨ��β��ʣ�಻������
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
				-- �������Э�鶨��
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
				-- ������Ա����
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
				-- ����public:
				local startIndex,endIndex = string.find(line, "^[%s]*public[%s]*:[%s]*$");
				if startIndex ~= nil
				then
					-- print("member start" .. " " .. line);
					table.insert(classDefineLines, line);
					findPublic = true;
				end
			else
				-- ���ҵ�public:
				local startIndex,endIndex = string.find(line, "^[%s]*public[%s]*:[%s]*$");
				if startIndex ~= nil
				then
					-- print("member end" .. " " .. line);
					findMember = false;
					findPublic = false;
				end
				
				if findMember == true
				then
					-- ������Ա TGuanQiaTypeID_t	myHeroDataAry[1234]
					local startIndex,endIndex = string.find(line, "^[%s]*[%w_]+[%s]+[%w_%[%]]+[%s]*;");
					if startIndex ~= nil
					then
						-- ������Ա����
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
-- ����: �����߼��ṹ�滻��Ա������
-- ����: �ļ���, ���ͱ�
-- ����: �滻����ļ��ַ���
-- �ඨ��
--       typedef struct _ChangeLineWait
--       {
--		[// @member]
--       [public:]
--		TObjUID_t objUID;							[///< ����UID]
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

				-- �����࿪ͷ�Ľṹ
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
		
		-- û���ҵ��ඨ��
		if findClass == false
		then
			table.insert(classDefineLines, line);
			continueFlag = false;
		end

		-- �����ඨ���µĵ�һ��{
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
		
		-- ����};
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
		
		-- ����Ѿ��ҵ��ඨ��β��ʣ�಻������
		if continueFlag and findClassEnd
		then
			table.insert(classDefineLines, line);
			continueFlag = false;
		end
		
		-- û���ҵ�@member��ͷ���Ҵ���û���ҵ���@member��ͷ��
		if continueFlag and findMember == false
		then
			local findStr = findString(line, "^[%s]*//[%s]*@member[%s]*$");
			if findStr ~= ""
			then
				-- ������Ա����
				continueFlag = false;
				findMember = true;
				findPublicBegin = false;
				findPublicEnd = false;
			end
		end
		
		-- �Ѿ���@member���, ���ҵ�public:~public:֮����д���
		if continueFlag and findMember
		then
			if findPublicBegin ~= true
			then
				-- ����public:
				local findStr = findString(line, "^[%s]*public[%s]*:[%s]*$");
				if findStr ~= ""
				then
					table.insert(classDefineLines, line);
					findPublicBegin = true;
					continueFlag = false;
				end
			else
				-- ���ҵ�public:
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
				-- ������Ա TGuanQiaTypeID_t	myHeroDataAry[1234]
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
		
		-- û����@member��ǣ��򲻴���public:���
		if continueFlag and findMember == false and findPublicEnd == false
		then
			-- ������Ա TGuanQiaTypeID_t	myHeroDataAry[1234]
			local startIndex,endIndex = string.find(line, "^[%s]*[%w_]+[%s]+[%w_%[%]]+[%s]*;");
			if startIndex ~= nil
			then
				-- ������Ա����
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
-- ����: ����ö�ٲ���ö��ֵ����д��ע����
-- ����: �ļ���
-- ����: �滻����ļ��ַ���
-- ö�ٶ���
--       enum XXX
--       {
--		INVALID_SERVER_TYPE[ = 0],			[///< ��Ч]
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
-- ����: ����Э��ID
-- ����: �ļ���,
-- ����: Э��ID��Ӧ���ַ���
-- Э�鶨�� PACKET_WC_TEST = 1,	 ///< ����Э��
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