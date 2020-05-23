--[[
	class:		ChildEffectExtend
	desc:		用于将子节点一个个显示出来
	author:		郑智敏
]]

local ChildEffectExtend = class('ChildEffectExtend')

function ChildEffectExtend:ctor()
	 
end

function ChildEffectExtend:extend(target, childList)
	if childList == nil then
		print('childList == nil')
	end
	target._effectList = childList
	
	function target:initShow()
		for _,v in ipairs(self._effectList) do
			v:setScale(0)
		end
	end
	
	function target:playEffect(delay, onComplete)
		self._effectPlayIndex = 1
		self:_playNextEffect()
		
		self._completeFunc = onComplete
		self._effectStartDelay = delay
	end
	
	function target:_playNextEffect()
		if nil == self._effectList or nil == self._effectPlayIndex or self._effectPlayIndex > #self._effectList then
			if nil ~= self._completeFunc then
				self._completeFunc()
			end
			return
		end
	
		local childNode = self._effectList[self._effectPlayIndex] 
		local effectCompleteFunc = function()
			self._effectPlayIndex = self._effectPlayIndex + 1
			self:_playNextEffect()
		end
		UIAction.appear(childNode, effectCompleteFunc,self._effectStartDelay)
	end
end

return ChildEffectExtend