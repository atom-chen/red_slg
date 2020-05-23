--
-- Author: wdx
-- Date: 2016-03-30 18:04:15
--
local RichTextShow = {}
RichTextShow.one_by_one = 1

function RichTextShow:extend(richText,showType)
	if showType == RichTextShow.one_by_one then
		self:showOneByOne(richText)
	end
end

function RichTextShow:showOneByOne(richText)
	local timerId = nil
	local curLine = 1
	local callback = nil

	function richText:startShow(func)
		callback = func
		curLine = 1
		for i=2,#self._lineList,1 do  --把其他行的移除
			self._lineList[i]:getNode():removeFromParent()
		end
		if not timerId then
			timerId = scheduler.scheduleGlobal(function() self:_showStep() end, 0.1)
		end
	end

	function richText:_showStep()
		local line = self._lineList[curLine]
		if not line then
			self:_stop()
			return
		end
		if line:show() then  --当前行显示完了
			self:_showNextLine()
		end
	end

	function richText:_showNextLine()
		curLine = curLine + 1
		local line = self._lineList[curLine]
		if line then
			if not line:getNode():getParent() then
				self:addChild(line:getNode())
			end
			line:show()
		else
			self:_stop()
		end
	end

	function richText:_stop()
		scheduler.unscheduleGlobal(timerId)
		timerId = nil
		if callback then
			callback()
			callback = nil
		end
	end

	function richText:_clear()
		if timerId then
			scheduler.unscheduleGlobal(timerId)
			timerId = nil

		end
		RichText._clear(richText)
	end
end

return RichTextShow