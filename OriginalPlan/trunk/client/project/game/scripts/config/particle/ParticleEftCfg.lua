

local ParticleEftCfg = class("ParticleEftCfg")

function ParticleEftCfg:ctor( ... )
end

function ParticleEftCfg:init(  )
	self._particleCfg = ConfigMgr:requestConfig("eft",nil,true)
end

function ParticleEftCfg:queryEftCfgById( _id )

	local cfg = self._particleCfg[_id]
	if cfg then
		return cfg.path
	end

	return nil
end

local _particleEftCfg = ParticleEftCfg.new()

return _particleEftCfg