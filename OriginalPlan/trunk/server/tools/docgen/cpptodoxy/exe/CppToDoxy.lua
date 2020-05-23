package.cpath = package.cpath..";./?.dll;./?.so;../lib/?.so;../lib/vc_dll/?.dll;../lib/bcc_dll/?.dll;../lib/mingw_dll/?.dll;"
package.path = package.path .. ";?.lua"

-- 可以嵌标记, 开始标记可以没有结束标记, 以另外一个开始标记做为结束标记, 默认是 @BEGSNODOC 标记
local BeginNoDocFlag = "@BEGNODOC";	-- 开始块非文档标记
local BeginDocFlag = "@BEGDOC";		-- 开始块文档标记
local BeginSNoDocFlag = "@BEGSNODOC";	-- 单行开始非文档标记
local BeginSDocFlag = "@BEGSDOC";	-- 单行开始文档标记
local EndDocFlag = "@ENDDOC";		-- 结束标记

-- 状态标记对应的状态
local DocStateTable = {};
DocStateTable[BeginNoDocFlag] = 1;
DocStateTable[BeginDocFlag] = 2;
DocStateTable[BeginSNoDocFlag] = 3;
DocStateTable[BeginSDocFlag] = 4;

local UnDocFlag = "@NODOC";			-- 非文档标记与 @BEGSNODOC 使用
local DocFlag = "@DOC";				-- 文档标记与 @BEGSDOC 使用

function printTab(tab)
    for i,v in pairs(tab) do
        if type(v) == "table"
        then
            print("table",i,"{");
            printTab(v);
            print("}");
        else
            print(v);
        end
    end
end

-- printTab(DocStateTable);

------ 堆栈操作
function stackPush(stack, val)
	table.insert(stack, val);
end
function stackTop(stack)
	if table.maxn(stack) > 0
	then
		return stack[table.maxn(stack)];
	end

	return nil;
end
function stackPop(stack)
	if table.maxn(stack) > 0
	then
		table.remove(stack, table.maxn(stack));
	end
end
function stackEmpty(stack)
	return table.maxn(stack) <= 0;
end
------ 堆栈操作

-- 得到当前标记状态
function getState(states)
--	if stackEmpty(states)
--	then
--		return DocStateTable[BeginNoDocFlag];
--	end

	return stackTop(states);
end

function filterCppLine(srcFileName, destFileName, startState)
	-- 打开文件
	local srcFile = io.open(srcFileName, "r"); 
	if srcFile == nil
	then
		return;
	end

	local destFile = io.open(destFileName, "a+");
	
	local statesStack = {};
	stackPush(statesStack, DocStateTable[startState]);
	
--	print(getState(statesStack));
	
	local tempState = getState(statesStack);
	-- 过滤有非文档标记的行
	for line in srcFile:lines() do
		continueFlag = false;

		-- 压入对应状态
		if string.find(line, BeginNoDocFlag) ~= nil
		then
			stackPush(statesStack, DocStateTable[BeginNoDocFlag]);
			continueFlag = true;
		elseif string.find(line, BeginDocFlag) ~= nil
		then
			stackPush(statesStack, DocStateTable[BeginDocFlag]);
			continueFlag = true;
		elseif string.find(line, BeginSDocFlag) ~= nil
		then
			stackPush(statesStack, DocStateTable[BeginSDocFlag]);
			continueFlag = true;
		elseif string.find(line, BeginSNoDocFlag) ~= nil
		then
			stackPush(statesStack, DocStateTable[BeginSNoDocFlag]);
			continueFlag = true;
		elseif string.find(line, EndDocFlag) ~= nil
		then
			-- 从状态栈中弹出一个状态
			stackPop(statesStack);
--			print(getState(statesStack));
			continueFlag = true;
		end
		
		if continueFlag == false
		then
			-- 得到当前状态
			state = getState(statesStack);
			if tempState ~= state
			then
				tempState = state;
--				print(tempState);
			end

--			print(state);
			-- 根据当前状态处理当前行
			if state == DocStateTable[BeginNoDocFlag]
			then
				-- 块非文档状态, 任意行忽略
				continueFlag = true;
			elseif state == DocStateTable[BeginDocFlag]
			then
				-- 块文档状态, 任意行文档化
			elseif state == DocStateTable[BeginSDocFlag]
			then
				-- 单行文档状态
				if string.find(line, DocFlag) == nil
				then
					-- 如果无文档标记则直接忽略这一行
					continueFlag = true;
				else
					-- 将文档化标记去掉
					line = string.gsub(line, DocFlag, "") 
--					print(line);
				end
			elseif state == DocStateTable[BeginSNoDocFlag]
			then
				-- 单行非文档状态
				if string.find(line, UnDocFlag) ~= nil
				then
					-- 如果有非文档标记则直接忽略这一行
--					print(line);
					continueFlag = true;
				end
			else
				-- 状态错误
				continueFlag = true;
			end
			
			if continueFlag == false
			then
				-- 写入到目标文件中
				destFile:write(line);
				destFile:write("\n");
--				print(line);
			end
		end
	end

	io.close(srcFile);
	io.close(destFile);
end

function appendToFile(str, fileName)
    local file = io.open(fileName,"a+");
    file:write(str);
    file:write("\n");
    file:close();
end

local basePath="../cppfile/";
-- 处理CPP文件
function handleSectionFile(srcFiles, destFileName, sectionHStr, sectionTStr)
	appendToFile(sectionHStr, destFileName);

	for key, value in ipairs(srcFiles) do
		local pa = basePath .. value;
		filterCppLine(pa, destFileName, BeginSNoDocFlag);
	end

	appendToFile(sectionTStr, destFileName);
end

function handleCppFiles(filterFiles, destFileName)
	-- 创建文件
	local destFile = io.open(destFileName, "w+");
	io.close(destFile);
	
	-- 遍历处理所有段的文件
	for key, value in ipairs(filterFiles) do
		handleSectionFile(value[2], destFileName, value[1], value[3]);
	end
end

-- local destFile = io.open("test.h.bak", "w+");
-- io.close(destFile);
-- filterCppLine("test.h", "test.h.bak", BeginSNoDocFlag);


local filterCppFilesConfig  = require("FilterCppFiles");
local typeFileHandle = require("TypeFileHandle");

TypeFileHandle.handleAllPacketStruct(basePath, CppFileterFiles.packetFiles, {"game_util.h", "game_base_util.h"}, "packet_id_def.h");
TypeFileHandle.handleAllStruct(basePath, CppFileterFiles.structFiles, {"game_util.h", "game_base_util.h"});
TypeFileHandle.handleAllEnum(basePath, CppFileterFiles.definesFiles);

local destFileName = "packet.h";
handleCppFiles(CppFileterFiles.FileterFiles, destFileName);
