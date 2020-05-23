local LoopMagicExtend = {}

function LoopMagicExtend.extend(magic)

	function magic:play()
		SimpleMagic.play(self)
		if self.particle then
			self.particle:SetSuspend(false)
		end
		if self.loop > 1 or self.loop == -1 then  --播放多次
			if not self._particleLoopTimer then
				self._particleLoopTimer = scheduler.scheduleGlobal( function()
					if not self.particle then
						scheduler.unscheduleGlobal(self._particleLoopTimer)
						self._particleLoopTimer = nil
						return
					end
					self.particle:ResetData()

				end, self.loopTime+0.1)
			end
		end
	end

	function magic:dispose()
		if self._particleLoopTimer then
			scheduler.unscheduleGlobal(self._particleLoopTimer)
			self._particleLoopTimer = nil
		end
		SimpleMagic.dispose(self)
	end
end

return LoopMagicExtend