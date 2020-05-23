local StopFrameMaigc = class("StopFrameMaigc",Magic)

function StopFrameMaigc:start()
	Magic.start(self)

	self._stopFrameTime = self.fTime * self.info.stopFrame[1]
	self._stopTime = self.fTime *self.info.stopFrame[2]
end

function StopFrameMaigc:run(dt)
	if self._stopFrameTime then
		if self.curTime > self._stopFrameTime then
			self._stopTime = self._stopTime - dt
			if self._stopTime <= 0 then
				self._stopFrameTime = nil
			end
			return
		end
	end
	Magic.run(self,dt)
end


return StopFrameMaigc