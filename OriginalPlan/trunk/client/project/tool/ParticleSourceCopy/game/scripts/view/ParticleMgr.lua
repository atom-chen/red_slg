
local ParticleMgrCls = class("ParticleMgrCls")

function ParticleMgrCls:ctor( ... )
end

function ParticleMgrCls:init(  )
	
end

function ParticleMgrCls:CreateParticleSystem( _id )
	local name = ParticleEftCfg:queryEftCfgById( _id )
	if name then
	 	return CParticleMgr:instance():createMyParticle(name);
	end
	return nil
end

local ParticleMgr = ParticleMgrCls.new()
return ParticleMgr