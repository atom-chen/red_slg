
--[[--
 wdx
滚动 页面
inherit: ScrollView
@param   direction  滚动方向   
@param   w ，h  整个面板的  长宽  也即 可见区域的大小

event:  

exp:  local s = ScrollPage.new(ScrollView.VERTICAL,100,200)
		s:addPage(node);  --添加内容
		s:addPageAt(node2,0);  --添加内容
		s:removePage(node);
		s:removePageAt(0);
		
		
		s:pageAtIndex(index);  获取到某一页的page
		s:indexOfPage(page)   获取到page在哪一页

		s:setTouchEnabled(false)

		s:scrollToNextPage()
		s:scrollToPrePage()


ps：滚动面板的容器
注意：  每个page的大小 会默认为 ScrollView的大小

]]

local ScrollPageEx = class("ScrollPage",function(direction,w,h)
	return ScrollPage:create(CCSize(w,h),direction)
end)


--[[--
@param  direction  设置滚动方向  
@param   w ，h  整个面板的  长宽  也即 可见区域的大小
@param   margin 2个页面的 间隔
]]
function ScrollPageEx:ctor(direction,w,h,priority,margin)
	--self.container = display.newNode() 
	--self.container:setContentSize(CCSize(0,0))
	--self:setContainer(self.container);   --设置container
	self:setViewSize(CCSize(w,h))
	priority = priority or 0
	self:setTouchPriority(priority)  --优先级
	-- margin = margin or 0
	-- self:setMargin(margin)
end

function ScrollPageEx:scrollToNextPage()
	local index = self:getCurIndex()
	local max = self:getPageCount()
	if index < max-1 then
		self:bounceToPage(index+1,true)
	end
end

function ScrollPageEx:scrollToPrePage()
	local index = self:getCurIndex()
	if index > 0 then
		self:bounceToPage(index-1,true)
	end
end

function ScrollPageEx:pageAtIndex(index)
		self:bounceToPage(index,true)
end

return ScrollPageEx