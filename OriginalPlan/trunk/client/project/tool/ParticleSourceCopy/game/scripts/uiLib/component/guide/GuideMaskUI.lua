--[[--
	引导用的遮罩层

	触发引导时示例：
	self._guideUI = GuideMaskUI.new()
	self._guideUI:addComp(self._buildings[2],nil,nil,"t")
	self._guideUI:show()

	销毁示例：
	if self._guideUI then
		self._guideUI:removeComp(self._buildings[2])
		self._guideUI:hide()
		self._guideUI:dispose()
		self._guideUI = nil
	end
]]

local GuideMaskUI = class("GuideMaskUI",function()
	return CCLayerColor:create(launchCfg.maskColor)
end)

function GuideMaskUI:ctor()
	self:retain()
	self:setTouchEnabled(true)
	self:registerScriptTouchHandler(handler(self,self._onTouch),false,Mask.NEWBIE,true)

	self._arrow = GuideArrow.new()
	self._arrow:setZOrder(1)
	self._arrow:retain()
	self._arrowHeight = self._arrow:getContentSize().height
	self:addChild(self._arrow)
end

--[[--
	遮罩层上，添加一个显示组件，如要指示的按钮等
]]
function GuideMaskUI:addComp(comp,offsetX,offsetY,arrowDir,arrowOffsetX,arrowOffsetY)
	--保存原始位置和事件优先级
	comp.orignX = comp:getPositionX()
	comp.orignY = comp:getPositionY()
	comp.orignParent = comp:getParent()
	if comp.getTouchPriority then
		comp.orignPriority = comp:getTouchPriority()
	end

	--坐标系转换成本全局坐标系
	local globalPt = comp:getParent():convertToWorldSpace(ccp(comp.orignX,comp.orignY))
	comp:removeFromParent()

	if offsetX then
		globalPt.x = globalPt.x+offsetX
	end

	if offsetY then
		globalPt.y = globalPt.y+offsetY
	end

	comp:setPosition(globalPt)
	if comp.changeTouchPriority then
		comp:changeTouchPriority(Mask.NEWBIE_ON.max-1)
	end
	-- self:addChild(comp) -- 先改优先级再添加，不然修改无效
	scheduler.performWithDelayGlobal(function() self:addChild(comp) end,0.001) -- 延迟添加，避免修改优先级无效的问题
	
	if arrowDir == "no" then  --不需要加箭头
		return
	elseif arrowDir == "removeArrow" then
		if self._arrow:getParent() then
			self._arrow:removeFromParent()
		end
		return
	end
	
	--自动定位箭头,根据组件的大小、锚点信息等
	local size
	if comp.contentSize then
		size = comp.contentSize
	else
		size = comp:getContentSize()
	end

	local anchorPoint = nil
	if comp:isIgnoreAnchorPointForPosition() then
		anchorPoint = ccp(0, 0)
	else
		anchorPoint = comp:getAnchorPoint()
	end

	local centerX = (0.5-anchorPoint.x)*size.width+globalPt.x
	local centerY = (0.5-anchorPoint.y)*size.height+globalPt.y
	echo(centerX,centerY,size.width,size.height)
	local arrowX = centerX
	local arrowY = 0
	
	arrowDir = arrowDir or "b"

	if arrowDir == "b" then  --如果是指向下的
		arrowY = centerY+size.height/2+ self._arrowHeight/2+10
	else
		arrowY = centerY-size.height/2- self._arrowHeight/2-10
	end

	if arrowOffsetX then
		arrowX = arrowX+arrowOffsetX
	end

	if arrowOffsetY then
		arrowY = arrowY+arrowOffsetY
	end
	
	
	self._arrow:setDir(arrowDir,arrowX,arrowY)
end

--[[--
	遮罩层上，移除一个显示组件，如要指示的按钮等
]]
function GuideMaskUI:removeComp(comp)
	comp:removeFromParent()
	comp:setPosition(comp.orignX,comp.orignY)
	if comp.changeTouchPriority then
		comp:changeTouchPriority(comp.orignPriority)
	end
	
	-- comp.orignParent:addChild(comp)
	scheduler.performWithDelayGlobal(function()
		if comp and comp.orignParent then
			comp.orignParent:addChild(comp) 
			comp.orignParent = nil
		end
	end,0.001) -- 延迟添加，避免修改优先级无效的问题
end

--[[--
	还原原来位置，用于按钮切换的情况（引导后不会立刻放回而是切换）
]]
function GuideMaskUI:resetOrignPoint(comp)
	comp:removeFromParent()
	comp:setPosition(comp.orignX,comp.orignY)
	
	if comp.changeTouchPriority then
		comp:changeTouchPriority(comp.orignPriority)
	end
end

--[[--
	显示出来
]]
function GuideMaskUI:show()
	if not self:getParent() then
		ViewMgr.notifyRoot:addChild(self)
	end
end

--[[--
	隐藏起来
]]
function GuideMaskUI:hide()
	if self:getParent() then
		ViewMgr.notifyRoot:removeChild(self)
	end
end


--空实现，屏蔽优先级更低的点击事件触发
function GuideMaskUI:_onTouch(event,x,y)
	return true
end

function GuideMaskUI:dispose()
	self._arrow:release()
	self._arrow:dispose()
	self._arrow = nil
	self:cleanup()
	self:removeFromParentAndCleanup(true)
	self:unregisterScriptTouchHandler()
	self:release()
end

return GuideMaskUI