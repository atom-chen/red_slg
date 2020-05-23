function ReadFileLines(fileName)
	local srcFile = io.open(fileName, "r");
	if srcFile == nil then
		return {};
	end

	local lines = {};
	for line in srcFile:lines() do
		table.insert(lines, line);
	end

	io.close(srcFile);

	return lines;
end

function ClearFile(fileName)
	local srcFile = io.open(fileName, "w+");
	if srcFile == nil then
		return nil;
	end

	io.close(srcFile);
end

function WriteToFileAppend(fileName, lines, postfix)
	local srcFile = io.open(fileName, "a+");
	if srcFile == nil then
		return false;
	end
	if postfix ~= nil then
		srcFile:write(lines..postfix);
	else
		srcFile:write(lines);
	end
	io.close(srcFile);
	return true;
end

function WriteToFileAppendL(fileName, lines, postfix)
	local srcFile = io.open(fileName, "a+");
	if srcFile == nil then
		return false;
	end

	for _, l in ipairs(lines) do
		if postfix ~= nil then 
			srcFile:write(l..postfix);
		else
			srcFile:write(l);
		end
	end

	io.close(srcFile);
	return true;
end

function WriteToFile(fileName, lines)
	local srcFile = io.open(fileName, "w");
	if srcFile == nil then
		return false;
	end

	srcFile:write(lines);
	io.close(srcFile);
	return true;
end

function ReadFromFile(fileName)
	local srcFile = io.open(fileName, "r");
	if srcFile == nil then
		return nil;
	end

	local fileData = srcFile:read("*a");
	io.close(srcFile);
	return fileData;
end

function Mkdir(path)
	os.execute("if not exist "..path.." ( mkdir "..path.." )");
end

function DelDirFiles(path, ext)
	os.execute("if exist "..path.." ( del /Q "..path.." *."..ext..")");
end