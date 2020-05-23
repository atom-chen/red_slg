--[[
	class:		GuideExtend
	author:		郑智敏
--]]

local GuideExtend = {}

function GuideExtend.extend(target)
	function target:_removeGuide()
		if self._guide then
			self._guide:dispose()
			self._guide:release()
			self._guide = nil
		end
	end

	function target:_getNewGuide( swallow,priority )
		if self._guide == nil then
			self._guide = GuideArrow.new()
			self._guide:retain()
		else
			self._guide:removeMask()
		end
		self._guide:swallowTouches(swallow,priority)
		return self._guide
	end
end

return GuideExtend