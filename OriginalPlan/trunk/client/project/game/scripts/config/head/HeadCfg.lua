--region HeadCfg.lua
--Author : zhangzhen
--Date   : 2014/7/10
--此文件由[BabeLua]插件自动生成

local HeadCfg = class("HeadCfg")

function HeadCfg:init()
	self._cfg = ConfigMgr:requestConfig("head",nil,true)
    self._suffix = ".pvr.ccz"

    self.MAX_ID = 6
end

function HeadCfg:getInstance()
	return self
end

function HeadCfg:getCfgRes(id)
	if nil == self._cfg[id] then
		return nil
	end
	return ResCfg:getRes(self._cfg[id].icon,self._suffix)
end

function HeadCfg:getHeadIcon( id )
	-- body
	print('id ..' .. id)
	return self._cfg[id].icon
end

function HeadCfg:getHeroId(id)
	return self._cfg[id].heroId
end

function HeadCfg:getListOfType(typeId)
	local list = {}
	for k,v in pairs(self._cfg) do
		if v.type == typeId then
			list[#list + 1] = k
		end
	end

	return list
end

return HeadCfg.new()


--endregion
