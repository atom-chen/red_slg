
--[[--
 wdx
滚动 页面
inherit: ScrollView
@param   direction  滚动方向   ScrollView.VERTICAL 垂直滚动	  或者 ScrollView.HORIZONTAL 横向滚动
@param   w ，h  整个面板的  长宽  也即 可见区域的大小

event:  

exp:  local s = ScrollPage.new(ScrollView.VERTICAL,100,200)
		s:addPage(node);  --添加内容
		s:addPageAt(node2,0);  --添加内容
		s:removePage(node);
		s:removePageAt(0);
		
		s:setScrollPosByIndex(1); 滚动到某个Page的位置上
		
		s:pageAtIndex(index);  获取到某一页的page
		s:indexOfPage(page)   获取到page在哪一页
		s:showPriortPage()  显示上一页
		s:showNextPage()  显示下一页
ps：滚动面板的容器 的锚点左边是  在左上角（0,1）   里面的东西也都是从上到下的  以左上角为锚点（0,1） 进行布局 
	
注意：  每个page也是以 左上角为锚点（0,1） 进行布局    并且每个page的大小 会默认为 ScrollView的大小

]]

local ScrollPage = class("ScrollPage",ScrollView)


--[[--
@param  direction  设置滚动方向   ScrollView.VERTICAL  或者 ScrollView.HORIZONTAL
@param   w ，h  整个面板的  长宽  也即 可见区域的大小
@param   margin 2个页面的 间隔
]]
function ScrollPage:ctor(direction,w,h,margin)
	ScrollPage.super.ctor(self,direction,w,h)
	
	self.margin = margin or 0;
	
	self.pageArray = {};
	
	self.curPageIndex = 0;  --当前显示第几页
	
	self.containerSize = CCSize(self.vWidth,self.vHeight);
	
	self:showScrollBar(false);
	
	self._acceptTouchEvent = true;
end

--[[--
	覆盖父类的refresh方法   并且不需要主动调用了
]]
function ScrollPage:refresh(w,h)
	self.containerSize = CCSize(self.vWidth,self.vHeight);
end


--[[--
	设置 滚动到指定的 index那一页上
]]
function ScrollPage:setScrollPosByIndex(index)
	self.curPageIndex = index;
	self:_refreshPage();
end

--[[--
	@param (table) arr 
	 还没优化
]]
function ScrollPage:addPageArray(arr)
	for i=1,#arr,1 do
		local page = arr[i];
		self:addPage(page)
	end
end

--[[--
	获取当前在那个页面 index
]]
function ScrollPage:getCurPageIndex()
	return self.curPageIndex;
end

--[[--
	获取当前在那个页面
]]
function ScrollPage:getCurPage()
	return self:pageAtIndex(self.curPageIndex);
end

--[[--
	添加page
	@param (CCNode)  page  
]]
function ScrollPage:addPage(page)
	assert(page ~= nil,"ScrollPage:addPage() ---------- page == nil")
	local index = #self.pageArray+1;
	self:addPageAt(page,index);
end

--[[--
	添加page到指定序列
	@param (CCNode)  page  
	@param (int)  index  
]]
function ScrollPage:addPageAt(page,index)
	assert(page ~= nil,"ScrollList:addPageAt() ---------- page == nil")
	--page:setAnchorPoint(ccp(0,1));
	
	
	local findIndex = self:indexOfPage(page); 
	if(findIndex >= 1)then --有可能已经在容器里面了
		table.remove(self.pageArray,findIndex)
		if self.curPageIndex >= findIndex then
			self.curPageIndex = self.curPageIndex - 1
		end
	else
		page:retain()
	end
	if(index > #self.pageArray)then
		index = #self.pageArray+1
	end
	table.insert(self.pageArray,index,page)
	
	if self.curPageIndex >= index then
		self.curPageIndex = self.curPageIndex + 1
	end 
	self:_refreshPage();
end

--[[--
	根据移除page
	@param (CCNode)  page  
]]
function ScrollPage:removePage(page,isDispose)
	local index = self:indexOfPage(page);
	if(index >=1)then
		self:removePageAt(index,isDispose);
	end
end

--[[--
	根据index 移除page
]]
function ScrollPage:removePageAt(index,isDispose)
	local page = self:pageAtIndex(index);
	if(page == nil)then
		return
	end
	table.remove(self.pageArray,index)
	if self.curPageIndex >= index then
		self.curPageIndex = self.curPageIndex - 1
	end
	if(page:getParent())then
		page:removeFromParent();
		self:_refreshPage();
	end
	if(isDispose and page.dispose)then
		page:dispose();
	end
	page:release()
	--print("移除page：",index);
end

--[[--
	刷新页面
]]
function ScrollPage:_refreshPage()
	--print("显示当前页数：",self.curPageIndex);
	local curPage = self:pageAtIndex(self.curPageIndex);
	if(curPage == nil)then
		self.curPageIndex = #self.pageArray;
		curPage = self:pageAtIndex(self.curPageIndex);
	end
	if(curPage == nil)then
		return
	end
	self.container:setPosition(ccp(0,self.vHeight));  --总容器恢复到原位
	
	local lastPage = self:pageAtIndex(self.curPageIndex-1);
	local nextPage = self:pageAtIndex(self.curPageIndex+1);
	local newPageList = {lastPage,curPage,nextPage} --3 个页面准备
	
	--上次的上个页面
	local oldPageList = {self.container:getChildByTag(1) ,self.container:getChildByTag(2), self.container:getChildByTag(3)  };
	
	if(newPageList[1] == oldPageList[1] and newPageList[2] == oldPageList[2]  and newPageList[3] == oldPageList[3] )then
		return   --已经是好的了
	end
	
	local oldCurPage = oldPageList[2]
	
	
	for i,page in pairs(oldPageList) do
		if page and table.indexOf(newPageList,page) == -1 then  --不在新的页面数组里面的
			page:removeFromParent();  -- 移除
		end
	end
	
	for i,page in pairs(newPageList) do
		if page then
			if page:getParent() == nil then  --添加到 界面
				self.container:addChild(page);
			end
			page:setTag(tonumber(i));
		end
		
	end
	--print("有页数")
	if(self.direction == ScrollView.VERTICAL)then
		if(lastPage)then
			lastPage:setPositionY(self.vHeight + self.margin)
		end
		if(nextPage)then
			nextPage:setPositionY(-self.vHeight - self.margin)
		end
		curPage:setPositionY(0)
	elseif(self.direction == ScrollView.HORIZONTAL)then
		if(lastPage)then
			lastPage:setPositionX(-self.vWidth - self.margin)
		end
		if(nextPage)then
			nextPage:setPositionX(self.vWidth + self.margin)
		end
		curPage:setPositionX(0)
	end
	
	self:dispatchEvent({name = Event.SCROLL_PAGE_REFRESH})
	
	
	--page 内部假如有提供  setPageFocus  方法  切换页面的时候   就调用这个方法
	if curPage ~= oldCurPage then
		if oldCurPage ~= nil and oldCurPage.setPageFocus then
			oldCurPage:setPageFocus(false)   --不是当前显示页面   取消焦点
		end
		if curPage.setPageFocus then
			curPage:setPageFocus(true)  --当前显示页面   设置为焦点
		end
	end
end

--down
function ScrollPage:_onTouchBegan(x, y)
	if(self.isMoving)then
		return false
	end
	return ScrollPage.super._onTouchBegan(self,x,y);
end

--[[--
	检测是否  越级   然后判断是不是切换  到其他页面了
]]
function ScrollPage:_checkTweenBack()
	local x,y = self.container:getPosition();
	local isTweenBack = true;
	self.isMoving = false
	if(self.direction == ScrollView.VERTICAL)then
		if(y - self.vHeight > 50)then  --显示下一页
			if(self.curPageIndex < #self.pageArray)then
				self:showNextPage();
				isTweenBack = false;
			end
		elseif(y - self.vHeight < -50 )then --显示上一页
			if(self.curPageIndex > 1)then
				self:showPriortPage();
				isTweenBack = false;
			end
		end
	elseif(self.direction == ScrollView.HORIZONTAL)then
		if(x > 50)then  --显示左一页
			if(self.curPageIndex > 1)then
				self:showPriortPage();
				isTweenBack = false;
			end
		elseif(x < -50 )then --显示右一页
			if(self.curPageIndex < #self.pageArray)then
				self:showNextPage();
				isTweenBack = false;
			end
		end
	end
	
	if(isTweenBack)then
		self.super._checkTweenBack(self);
	end
end

--[[--
	显示上一页
]]
function ScrollPage:showPriortPage()
	if(self.curPageIndex > 1 and not self.isMoving)then
		local x,y = self.container:getPosition();
		--print("当前页数1：",self.curPageIndex);
		if(self.direction == ScrollView.VERTICAL)then
			y = 0 - self.margin
		elseif(self.direction == ScrollView.HORIZONTAL)then
			x = self.vWidth + self.margin
		end
		self.isMoving = true;
		transition.moveTo(self.container,{time = 0.3, x=x, y = y
						,easing="EXPONENTIALOUT",onComplete=function()
								self.isMoving = false;
								self.curPageIndex = self.curPageIndex-1;
								self:_refreshPage()
								self:dispatchEvent({name = Event.MOUSE_SCROLL_END,index=self.curPageIndex})
							end})
	end
end

--[[--
	显示下一页
]]
function ScrollPage:showNextPage()
	if(self.curPageIndex < #self.pageArray and not self.isMoving)then
		local x,y = self.container:getPosition();
		--print("当前页数2：",self.curPageIndex);
		if(self.direction == ScrollView.VERTICAL)then
			y = 2*self.vHeight + 2*self.margin
		elseif(self.direction == ScrollView.HORIZONTAL)then
			x = -self.vWidth - self.margin
		end
		self.isMoving = true;
		transition.moveTo(self.container,{time = 0.3, x=x, y = y
						,easing="EXPONENTIALOUT",onComplete=function()
								self.isMoving = false;
								self.curPageIndex = self.curPageIndex+1;
								self:_refreshPage()
								self:dispatchEvent({name = Event.MOUSE_SCROLL_END,index=self.curPageIndex})
							end})
	end
end

--[[--
	@return (table)  返回所有 page   
]]
function ScrollPage:getAllPage()
	return self.pageArray
end

--[[--
	根据 page 获取页面 序列index
	@param (CCNode)  page  
]]
function ScrollPage:indexOfPage(page)
	for i, value in ipairs(self.pageArray) do
	   if value == page then
	      return i
	    end
	end
	return 0
end

--[[--
	根据index 获取page
]]
function ScrollPage:pageAtIndex(index)
	if(index == nil or index < 1 or index > #self.pageArray)then
		return nil
	end
	local page = self.pageArray[index];
	if(page)then
		return tolua.cast(page,"CCNode") 
	else
		return nil;
	end
end

--[[--
	销毁
]]
function ScrollPage:dispose()
	for i=1,#self.pageArray,1 do
		local page = self:pageAtIndex(i);
		page:release();
		if page.dispose then
			page:dispose();
		end
	end
	self.pageArray = nil;
	ScrollPage.super.dispose(self);
end

return ScrollPage;