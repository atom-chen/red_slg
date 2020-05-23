local UIDragedProgressBarExtend = {}

function UIDragedProgressBarExtend.extend(progress, url)
	progress:setEnable(true)
	local img = display.newXSprite(url)
	if url == "#institute_btn_jd.png" then
		img:setAnchorPoint(ccp(0.1,0.5))
	end
	progress._bgImage:addChild(img, 30)
	local function fixProgress(self)
		local parent = self._barImage
		local siz = parent:getContentSize()
		local cur = self:getCurProgress()
		--print("fixProgress:", cur, siz.width)
		if cur == 0 then
			img:setPosition(0+self._position.x, siz.height/2+self._position.y)
		else
			img:setPosition(siz.width+self._position.x, siz.height/2+self._position.y)
		end
		
	end
	fixProgress(progress)
	progress.fixProgress = fixProgress
	
	function progress:getEventName()
		return "__progress_change"
	end
	
	function progress:_moveTo(x, last)
		local pos = self._bgImage:convertToNodeSpace(ccp(x,0))--:getParent()
		local origin = self._position
		local maxW = self._barMaxSize.width
		--local curp = self:getCurProgress()
		local maxp = self:getMaxProgress()
	--	local step = maxW/maxp 
		local cx = pos.x - origin.x
	---	print("function progress:_moveTo(x)", x, cx)
		local p = 0
		if cx <= 0 then
			p = 0
		elseif cx > maxW then
			p = maxp
		else
			p = cx/maxW*maxp
		end
		self:setProgress(p)
		self:fixProgress()
--		self._extendLastProgress
		if last or math.abs(p-math.floor(p+0.5)) < 0.1 then
			p = math.floor(p+0.5)
			print("current progress", p, self._extendLastProgress)
			if p ~= self._extendLastProgress then
				self._extendLastProgress = p
				self:dispatchEvent({name=self:getEventName(), progress=p})
			end
		end
	end
	
	
	--[[
	function progress:fixProgress()
		local parent = self._barImage
		local siz = parent:getContentSize()
		img:setPosition(siz.width+self._position.x, siz.height/2+self._position.y)
	end
	--]]
	function progress:onTouchDown(x,y)
	--	print("function progress:onTouchDown(x,y)", x, y)
		self:_moveTo(x)
		return true
	end
	
	function progress:onTouchMove( x,y )
		self:_moveTo(x)
	end
	
	function progress:onTouchEnd(x,y)
--		print("function progress:onTouchEnd( x,y )", x, y)
		self:_moveTo(x, true)
	--	self:fixProgress()
	end
	
--[[
	function progress:onTouchMoveOut(x,y)
		
	end

	function progress:onTouchUp( x,y )
		
	end
	function progress:onTouchCanceled( x,y )
		print("function progress:onTouchCanceled( x,y )", x, y)
		self:_moveTo(x, true)
	end
--]]	



end

return UIDragedProgressBarExtend