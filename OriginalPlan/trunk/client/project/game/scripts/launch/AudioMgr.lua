--[[
	class:		AudioMgr
	desc:		声音管理器
	author:		郑智敏
--]]

local AudioMgr = class('AudioMgr')
--local ConfigMgr = game_require("config.ConfigMgr")
AudioMgr.MUSIC_KEY = "music_volume" 
AudioMgr.EFFECT_KEY = "effect_volume"

function AudioMgr:ctor()
	self.isLoop = false
end

function AudioMgr:init()
	self:loadCfg()
	
	local volume = CCUserDefault:sharedUserDefault():getStringForKey(AudioMgr.MUSIC_KEY)
	volume = tonumber(volume) or 0.5
	self:setMusicVolume(volume)

	volume = CCUserDefault:sharedUserDefault():getStringForKey(AudioMgr.EFFECT_KEY)
	volume = tonumber(volume) or 0.85
	self:setEffectVolume(volume)
end

--[[
	获取音乐播放的时间，参数为音乐id，返回单位为秒
]]
function AudioMgr:getMusicTime(id)
	if nil == self._cfg[tostring(id)] then
		return 0
	end
	return self._cfg[tostring(id)].soundLength or 0.5
end

function AudioMgr:loadCfg()
	self._cfg = ConfigMgr:requestConfig("audio_resource", nil, true)
end

function AudioMgr:getGroundId()
	return self._groudId,self.isLoop
end

function AudioMgr:pauseGround()
	audio.pauseMusic()
end

function AudioMgr:resumeGround()
	audio.resumeMusic()
end

--[[
	playGround--用于将id对应的声音作为背景音乐播放
	--若当前已经有声音作为背景音乐播放,则先关闭该音乐
--]]
function AudioMgr:playGround(id,time)
	if not id  then  -- id相同  直接返回
		return
	end

	-- print('id ..' .. id)
	--[[
	if id ~= self._groudId and true == audio.isMusicPlaying() then
		audio.stopMusic(false)
	end
	--]]

	id = tostring(id)
	if nil == self._cfg[id] then
		print('nil == self._cfg[id] , id = ' .. id)
		return
	end
	if device.isLowApp then
		if id == tostring(AudioConst.FIGHT_ID) then
			id = tostring(AudioConst.BACK_GROUND_ID)
		end
	end
	if id == self._groudId and true == audio.isMusicPlaying() then
		return
	end

	self._groudId = id

	if true ~= self._isOpen then
		print('true ~= self._isOpen')
		return
	end
	
	local filename = self._cfg[id].res
	
	if filename then
		if time == 1 then
			self.isLoop = false
		else
			self.isLoop = true
		end
		CCLuaLog('audio.playMusic( self.isLoop)'..filename)
		audio.playMusic(filename)
	end
		
	if self._timeId then
		scheduler.unscheduleGlobal(self._timeId)
		self._timeId = nil
	end
	if time and time > 0 then  --有播放次数的
		local musicTime = self:getMusicTime(id) * time
		if musicTime > 0 then
			self._timeId = scheduler.performWithDelayGlobal(function() 
											self._timeId = nil   
											self:stopGround()
											end,musicTime)
		end
	end
end

--[[
	--播放游戏音乐特效
]]
function AudioMgr:playEffect(id,time)
	if true ~= self._effectOpen or nil == id then
		return nil
	end
	-- print(debug.traceback())
	-- print("playEffect,,,,,",id)
	-- do
	-- 	return
	-- end
	
	id = tostring(id)
	if nil == self._cfg[id] then
		print('nil == self._cfg[id] , id = ' .. id)
		return nil
	end
	local filename = self._cfg[id].res
	if filename then
		local aId
		if time then
			aId = audio.playSound(filename, true)
			if time > 0 then
				local t = self:getMusicTime(id) * time
				scheduler.performWithDelayGlobal(function() self:stopEffect(aId) end,t)
			end
		else
			aId = audio.playSound(filename, false)
		end
		return aId
	end
	return nil
end

--[[
	handle为playEffect的返回值
--]]
function AudioMgr:stopEffect(handle)
	audio.stopSound(handle)
end

function AudioMgr:stopAllEffect()
	audio.stopAllSounds()
end

--卸载掉某个音乐
function AudioMgr:unloadEffect(id)
	id = tostring(id)
	if self._cfg[id] then
		local filename = self._cfg[id].res
		if filename then
			audio.unloadSound(filename)
		end
	end
end

function AudioMgr:preloadEffect(id)
	id = tostring(id)
	if self._cfg[id] then
		local filename = self._cfg[id].res
		if filename then
			audio.preloadEffect(filename)
		end
	end
end

--批量播放， 并在播放完之后删除资源
--AudioMgr:playEffects(ids)和AudioMgr:playEffect(id) 不能混用
--和AudioMgr:stopEffects() 配对使用
function AudioMgr:playEffects(ids)
	--dump(ids)
	self:stopEffects()
	
	self._audioIds = {}
	self._audioIdIdx = 1
	for i,id in ipairs(ids) do self._audioIds[i] = id end
	
	self:_palyEffects()
end

function AudioMgr:_palyEffects()
	if self._nowHandler then
		self:stopEffect(self._nowHandler)
		self._nowHandler = nil
	end
	
	if self._unloadId then
		self:unloadEffect(self._unLoadId)
		self._unLoadId = nil
	end
	
	if self._audioIdIdx > #self._audioIds then
		self._audioIds = nil
		self._audioIdIdx = nil
		if self._delayCall then
			self._delayCall:dispose()
			self._delayCall = nil
		end
		return
	end
	
	local id = self._audioIds[self._audioIdIdx]
	self._audioIdIdx = self._audioIdIdx + 1
	local t = self:getMusicTime(id)
	self._unLoadId = id
	self._nowHandler = self:playEffect(id)
	--print("function AudioMgr:_palyEffects()", self._unLoadId, id)
	if not self._delayCall then
		self._delayCall = UIDelayCall.new(t, {self, self._palyEffects}, true)
	else
		self._delayCall:setDelayCall(t, {self, self._palyEffects})
		self._delayCall:start()
	end
end

--删除资源
function AudioMgr:stopEffects()
	if self._delayCall then
		self._delayCall:dispose()
		self._delayCall = nil
	end
--	print("function AudioMgr:stopEffects()", self._unLoadId, debug.traceback())
	if self._nowHandler then
		self:stopEffect(self._nowHandler)
		self._nowHandler = nil
	end
	
	if self._unloadId then
		self:unloadEffect(self._unLoadId)
		self._unLoadId = nil
	end
end

--返回音效是否开启
function AudioMgr:isEffectOpen()
	return self._effectOpen
end

--[[
	--检测是否播放音乐
]]
function AudioMgr:isMusicOpen()
	return self._isOpen
end

--[[
	--停止当前背景音乐
]]
function AudioMgr:stopGround()
	self._groudId = nil
	audio.stopMusic(false)
end

--获取 音效音量
function AudioMgr:getEffectVolume()
	local v = CCUserDefault:sharedUserDefault():getStringForKey(AudioMgr.EFFECT_KEY)
	if v == "" then
		return audio.getSoundsVolume()
	else
		return tonumber(v)
	end
end

--获取 背景音量
function AudioMgr:getMusicVolume()
	local v = CCUserDefault:sharedUserDefault():getStringForKey(AudioMgr.MUSIC_KEY)
	if v == "" then
		return audio.getMusicVolume()
	else
		return tonumber(v)
	end
end

--0.0~1.0 --设置音效
function AudioMgr:setEffectVolume(volume)
	if volume <= 0 then
		self._effectOpen = false
	else
		self._effectOpen = true
	end
	audio.setSoundsVolume(volume)
	CCUserDefault:sharedUserDefault():setStringForKey(AudioMgr.EFFECT_KEY, tostring(volume) )
	CCUserDefault:sharedUserDefault():flush()
end

--0.0~1.0  --设置背景音乐
function AudioMgr:setMusicVolume(volume)
	if volume <= 0 then
		self._isOpen = false
		audio.stopMusic(true)
	else
		if not self._isOpen then
			self._isOpen = true
			if self._groudId then
				self:playGround( self._groudId,nil )
			end
		end
	end
	audio.setMusicVolume(volume)
	CCUserDefault:sharedUserDefault():setStringForKey(AudioMgr.MUSIC_KEY, tostring(volume) )
	CCUserDefault:sharedUserDefault():flush()
end

return AudioMgr.new()