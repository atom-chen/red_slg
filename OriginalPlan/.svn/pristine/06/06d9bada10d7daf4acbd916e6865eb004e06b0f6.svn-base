
local ParticleMgrCls = class("ParticleMgrCls")

function ParticleMgrCls:ctor(  )
	self:init()
end

function ParticleMgrCls:init(  )
	self.particleList = {}
end

function ParticleMgrCls:hasParticle(id)
	local name = ParticleEftCfg:queryEftCfgById( id )
	if not name then
		return false
	else
		return true
	end
end

function ParticleMgrCls:CreateParticleSystem( id,isCache )
	-- print("创建。。。 粒子",id)
	local list = self.particleList[id]
	local p
	if list and #list>0 then
		p = table.remove(list,#list)
		p:ResetData()
		if not isCache then
			p:autorelease()
		else
			--print("命中。。。 粒子",id,p:retainCount())
		end
	else
		local name = ParticleEftCfg:queryEftCfgById( id )
		print("粒子ID ",id)
		assert(name," --粒子配置没有 ：  粒子id： "..id)
		p =  CParticleMgr:instance():createMyParticle(name)
		if not p then return nil end
		p.id = id
		if isCache then
			p:setUpdateFrequency(3)    --粒子update频率调慢
			p:retain()
		else
			p:setUpdateFrequency(3)
		end
		-- print("创建  粒子",id,p:retainCount())
	end
	return p
end

function ParticleMgrCls:GetCycleTotalTime(pId)
	local p = ParticleMgr:CreateParticleSystem(pId,true)
	if p then
		local t = p:GetCycleTotalTime()
		ParticleMgr:DestroyParticle(p)
		return  t
	end
end

function ParticleMgrCls:DestroyParticle( particle )
	local id = particle.id
	local list = self.particleList[id]
	if list == nil then
		list = {}
		self.particleList[id] = list
	end
	-- print("reset 回来 粒子",id)
	list[#list+1] = particle
end

function ParticleMgrCls:AllReRegisterParticle( )
	for id,list in pairs(self.particleList) do
		--print("--释放 粒子 id： "..id,#list)
		for _,p in ipairs(list) do
			--print("--释放。。。。",p:retainCount(),id)
			p:release()
		end
	end
	self.particleList = {}
	-- CParticleMgr:instance():clearAllTemplateSystem()
end

function ParticleMgrCls:releaseParticleWithout(pMap)
	for id,list in pairs(self.particleList) do
		if not pMap[id] then
			for _,p in ipairs(list) do
				p:release()
			end
			self.particleList[id] = nil
		end
	end
end

function ParticleMgrCls:hasCacheParticle(pId)
	if self.particleList[pId] then
		return true
	else
		return false
	end
end

local ParticleMgr = ParticleMgrCls.new()

return ParticleMgr