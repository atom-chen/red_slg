--
-- Author: LiangHongJie
-- Date: 2014-01-21 17:36:27
--
local AudioMgrCls= class("AudioMgrCls")
local AudioMgr = AudioMgrCls.new()


function AudioMgrCls:init()
  self._isOpen = true
  self._musicCfgName = "music/cof/gamemusic.json"
  self._cfg = {}
  self._groudId = 0
  self._cacheName = "musicset.set"
  self:loadCfg()
end

function AudioMgrCls:loadCfg()
	local filePath = CCFileUtils:sharedFileUtils():fullPathForFilename(self._musicCfgName)
	local str = util.readfile(filePath)
	self._cfg = json.decode(str,true)
	local str = luacall.cacheRead(AudioMgr._cacheName)
	if str and str == "close" then
		self._isOpen = false
	end
end
--[[
	播放游戏背景音乐
]]
function AudioMgrCls:playGround( id )
	if not id then	return end
	if self._groudId ~= id or not audio.isMusicPlaying() then
		self._groudId = id
		if not self._isOpen then	return end
		id = tostring(id)
		local name = self._cfg.ground[id]
		if name then
			local filename =  "music/ground/".. name
			audio.playMusic(filename, true)
		end
	end
end
function AudioMgrCls:getGroundId()
	return self._groudId
end
--[[
	播放游戏音乐特效
]]
function AudioMgrCls:playEffect( id )
	if not self._isOpen or not id then	return	end
	id = tostring(id)
	local name = self._cfg.effect[id]
	if name then
		local filename =  "music/sound/".. name
		audio.playSound(filename, false)
	end
end

function AudioMgrCls:isOpen()
	return self._isOpen
end
function AudioMgrCls:stopGround()
	audio.stopMusic(true)
end
function AudioMgrCls:stopAll()
	self._isOpen = false
	audio.stopMusic(true)
end

function AudioMgrCls:setStatus( isOpen )
	if type(isOpen) ~= "boolean" then
		self._isOpen = true
	else
		self._isOpen = isOpen
	end
	self:saveSetting()
	if self._isOpen and not audio.isMusicPlaying() and self._groudId then
		self:playGround( self._groudId )
	else
		self:stopAll()
	end
end

--[[
 	保存设置
]]
function AudioMgrCls:saveSetting()
	local str = "open"
	if not self._isOpen then
		str = "close"
	end
	luacall.cacheWrite(self._cacheName,str)
end

function AudioMgrCls:fightEffect( fileName )
	if not self._isOpen then	return	end
	audio.playSound("music/sound/"..fileName, false)
end
return AudioMgr