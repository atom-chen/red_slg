package.cpath = package.cpath .. ";./?.dll;./?.so;../lib/?.so;./clibs/?.dll;"
package.path = package.path .. "lualibs/?.lua;"
package.path = package.path .. ";?.lua;script/?.lua;script/data/?.lua;script/code/?.lua;script/code/gm/?.lua;script/code/lib/?.lua;"
package.path = package.path .. ";script/code/role/?.lua;script/code/server/?.lua;script/code/config/?.lua;script/code/net/?.lua;"

cjson = require "cjson"
cjson.encode_sparse_array(true,1,1);

allReloadRequireName = {};

-------------------------------------------------------
-- @class function
-- @name reloadRequire
-- @description 重新加载脚本文件
-- @param string:name
-- @return nil:
-- @usage
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
reloadRequire("ProtocolBase");
reloadRequire("ProtocolSerial");
require("DataHeader");
require("CodeHeader");

GameConfig = {};
