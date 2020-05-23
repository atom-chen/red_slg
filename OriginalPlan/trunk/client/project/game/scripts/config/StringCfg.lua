--region StringCfg.lua
--Author : zhangzhen
--Date   : 2015/3/3
local StringCfg = class("StringCfg")

function StringCfg:init()
	self._cfg = ConfigMgr:requestConfig("string_cfg",nil,true)
end

function StringCfg:getInstance()
	return self
end

function StringCfg:getCfg(id)
	return self._cfg[id]
end

function StringCfg:getTipByParam(id, params)
    local strCfg = self._cfg[id]
    local content = ""
    if strCfg and params then
      content = strCfg.content
      content = util.strFormat(content,params)
    end

    return content
end

return StringCfg.new()


--endregion
