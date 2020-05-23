function readFileLines(fileName)
	local srcFile = io.open(fileName, "r");
	if srcFile == nil then
		return nil;
	end
	
	local lines = {};
	for line in srcFile:lines() do
		table.insert(lines, line);
	end

	io.close(srcFile);

	return lines;
end

function clearFile(fileName)
	local srcFile = io.open(fileName, "w+");
	if srcFile == nil then
		return nil;
	end
	
	io.close(srcFile);
end

function writeToFile(fileName, lines)
	local srcFile = io.open(fileName, "a+");
	if srcFile == nil then
		return nil;
	end
	
	srcFile:write(lines);

	io.close(srcFile);
end