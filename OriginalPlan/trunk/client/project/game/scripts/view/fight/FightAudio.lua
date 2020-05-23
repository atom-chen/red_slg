local FightAudio = {}

function FightAudio:init()
	self.audioList = {}
	self.totalNum = 0
	self._curFramNum = 0
end

function FightAudio:playEffect(id)
	self._curFramNum = self._curFramNum + 1
	if self._curFramNum > 5 then
		return
	end
	if self.totalNum > 15 then
		return
	end
	local aList = self.audioList[id]
	if aList then
		if #aList >= 3 then
			return false
		end
	else
		aList = {}
		self.audioList[id] = aList
	end
	if AudioMgr:playEffect(id) then
		self.totalNum = self.totalNum + 1
		local time = AudioMgr:getMusicTime(id)*1000
		aList[#aList+1] = FightEngine:getCurTime() + time

		-- FightCache:retainAudio(id)
		return true
	end
	return false
end

function FightAudio:run(dt)
	self._curFramNum = 0
	local curTime = FightEngine:getCurTime()
	for _,aList in pairs(self.audioList) do
		repeat
			if aList[1] and aList[1] <= curTime then
				self.totalNum = self.totalNum - 1
				table.remove(aList,1)
			else
				break
			end
		until false
	end
end

function FightAudio:clear()
	self._curFramNum = 0
	self.totalNum = 0
	self.audioList = {}
end

return FightAudio