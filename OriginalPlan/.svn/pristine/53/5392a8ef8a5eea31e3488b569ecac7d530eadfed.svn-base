package.path = package.path .. ";?.lua;script/?.lua;script/code/?.lua;script/code/lib/?.lua;"
package.path = package.path .. ";script/code/logic/?.lua;script/code/server/?.lua;script/code/record/?.lua"


allReloadRequireName = {};

function reloadRequire(name)
	if allReloadRequireName[name]
	then
		return;
	end

	package.loaded[name] = nil;
	require(name);
	allReloadRequireName[name] = true;

	if log 
	then
		log:info("reload require " .. name .. " file");
	end
end

reloadRequire("LibHeader");
reloadRequire("CodeHeader");

