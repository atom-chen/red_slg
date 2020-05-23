--[[--
wdx
滚动面板
inherit: TouchBase
@param   direction  滚动方向   ScrollView.VERTICAL 垂直滚动	  或者 ScrollView.HORIZONTAL 横向滚动
@param   w ，h  整个面板的  长宽  也即 可见区域的大小

]]

local ScrollView = class("ScrollView",function()
	return CCScrollView:create()
end)

ScrollView.VERTICAL = kCCScrollViewDirectionVertical
ScrollView.HORIZONTAL = kCCScrollViewDirectionHorizontal
--垂直滚动 kCCScrollViewDirectionVertical
--水平 kCCScrollViewDirectionHorizontal

ScrollView.TOP = "top"
ScrollView.BOTTOM = "bottom"  --
ScrollView.LEFT = "left"
ScrollView.RIGHT = "right"  --底部

--[[--
@param  direction  设置滚动方向   kCCScrollViewDirectionVertical  或者 kCCScrollViewDirectionHorizontal
@param   w ，h  整个面板的  长宽  也即 可见区域的大小
]]
function ScrollView:ctor(direction,w,h,priority)
	self:setDirection(direction)  --设置方向
	self.direction = direction
	self.container = display.newNode()
	--self.container:setContentSize(CCSize(0,0))
	self:setContainer(self.container);   --设置container
	self:setViewSize(CCSize(w,h))
	self:setContentSize(CCSize(w,h))

	priority = priority or 0
	self:setTouchPriority(priority)  --优先级
end

--[[--
设置滚动到哪个地方
pos 参数:
ScrollView.TOP = "top"
ScrollView.BOTTOM = "bottom"  --
ScrollView.LEFT = "left"
ScrollView.RIGHT = "right"  --底部
3、CCPoint

isTween:
ture 缓动
false 直接设置
]]
function ScrollView:setScrollTo( pos,isTween)
	if nil == isTween then
		isTween = false
	end
	if pos == ScrollView.TOP or pos == ScrollView.RIGHT then
		pos = self:minContainerOffset()
		--print('self:minContainerOffset ..' .. pos.x .. ' ' .. pos.y)
		if self.direction == kCCScrollViewDirectionVertical then
			pos.x = 0

		elseif self.direction == kCCScrollViewDirectionHorizontal then
			local viewSize = self:getViewSize()
			local size = self:getContentSize()
			if viewSize.width > size.width then
				pos.x = 0
			end
			pos.y = 0
		end
	elseif pos == ScrollView.BOTTOM or pos == ScrollView.LEFT then
		pos = self:maxContainerOffset()
		--print('self:maxContainerOffset ..'.. pos.x .. ' ' ..  pos.y)
		if self.direction == kCCScrollViewDirectionVertical then
			local viewSize = self:getViewSize()
			local size = self:getContentSize()
			if viewSize.height > size.height then
				pos = self:minContainerOffset()
			end
			pos.x = 0
		elseif self.direction == kCCScrollViewDirectionHorizontal then
			pos.y = 0
		end
	else
		if self.direction == kCCScrollViewDirectionVertical then
			local viewSize = self:getViewSize()
			local size = self:getContentSize()
			if viewSize.height > size.height then
				pos = self:minContainerOffset()
			elseif pos.y > 0 then
				pos.y = 0
			end
			pos.x = 0
		elseif self.direction == kCCScrollViewDirectionHorizontal then
			pos.y = 0
		end
	end
	print("位置。。。222222    。",pos.x,pos.y)
	self:setContentOffset(pos,isTween)
end

function ScrollView:checkOutSize()
	local viewSize = self:getViewSize()
	local size = self:getContentSize()
	local pos = self:getContentOffset()
	if self.direction == kCCScrollViewDirectionVertical then
		if viewSize.height > size.height  then
			pos = self:minContainerOffset()
			pos.x = 0
		elseif viewSize.height - size.height > pos.y then
			pos.y = viewSize.height - size.height
		end
	elseif self.direction == kCCScrollViewDirectionHorizontal then
		if viewSize.width > size.width then
			pos.x = 0
		end
	end
	self:setContentOffset(pos,false)
end

function ScrollView:isScrollToDdge(  )
        local maxY = self:minContainerOffset().y
        local curY = self:getContentOffset().y
        local beginY = (maxY-curY)

        if beginY == 0 then
        	return true
        end
        return false
end

return ScrollView
