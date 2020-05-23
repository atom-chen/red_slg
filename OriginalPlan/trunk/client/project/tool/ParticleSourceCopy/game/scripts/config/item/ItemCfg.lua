--
-- Author: changao
-- Date: 2014-06-19
--

local ItemCfg = class("ItemCfg")

function ItemCfg:init()
	self._cfg = ConfigMgr:requestConfig("item",nil,true)
end

function ItemCfg:getInstance()
	return self
end

function ItemCfg:getCfg(itemId)
	return self._cfg[itemId]
end


return ItemCfg.new()