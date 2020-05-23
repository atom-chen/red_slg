--[[-- 
wdx
滚动面板
inherit: TouchBase
@param   direction  滚动方向   ScrollView.VERTICAL 垂直滚动	  或者 ScrollView.HORIZONTAL 横向滚动
@param   w ，h  整个面板的  长宽  也即 可见区域的大小

event： Event.SCROLL_END 停止滚动时候  发出

exp:  local s = ScrollView.new(ScrollView.VERTICAL,100,200)
		s.container:addChild(btn);  --添加内容
		s.refresh(w,h);  --之后需要刷新
		
		s.showScrollBar(false)   是否显示滚动条
		s.setScrollPos(pos)  pos  可以是字符串 “top” 表示滚动到顶部（横向滚动的时候表示最左边）  “bottom”表示滚动到底部（横向滚动的时候表示最右边） 也可以是一个table {x=10,y=100} 表示滚动到 某个位置(10,100)

ps: 滚动面板的容器 的锚点左边是  在左上角（0,1）   里面的东西也都是从上到下的  以左上角为锚点（0,1） 进行布局 

]] 

local ScrollView = class("ScrollView",TouchBase)

ScrollView.VERTICAL = 1; --垂直滚动	
ScrollView.HORIZONTAL = 2;  --横向滚动

ScrollView.TOP = "top"  --顶部
ScrollView.BOTTOM = "bottom"  --底部

ScrollView.isScrolling = false;  --是否拖动了

--[[-- 
@param  direction  设置滚动方向   ScrollView.VERTICAL  或者 ScrollView.HORIZONTAL
@param   w ，h  整个面板的  长宽  也即 可见区域的大小
]]
function ScrollView:ctor(direction,w,h)
	assert(direction == ScrollView.VERTICAL or direction == ScrollView.HORIZONTAL,
           "ScrollView:ctor() - invalid direction")
    ScrollView.super.ctor(self);
	self.direction = direction;  --滚动方向
	
	EventProtocol.extend(self)
	
	local rect = CCRect(0, 0, w,h)
	local clip = display.newClippingRegionNode(rect);
	clip:setAnchorPoint(ccp(0,0));
	clip:setPosition(ccp(0,0));
	self:addChild(clip);
	
	self.vWidth = w;
	self.vHeight = h;
	
	self:setContentSize(CCSize(w,h));
	
	self.container = display.newNode();
	--self.container:ignoreAnchorPointForPosition(false)
	self.container:setAnchorPoint(ccp(0,0));
	self.container:setPosition(ccp(0,h));
	self.container:setContentSize(CCSize(0,0));
	clip:addChild(self.container);
	
	self.containerSize = CCSize(0,0);
	
	self:initScrollBar();
	
	self:changeTouchEnabled(true);
	
	self._acceptTouchEvent = false  --内容是否 需要滚动   内容超过边界艹需要滚动
--	self:addTouchEventListener(function(event,x,y) return self:_onTouch(event,x,y) end
--			,false,INT_MIN,false);
	
	self._touchRet = CCRectMake(0, 0, self.vWidth, self.vHeight)   --触摸区域

	self:showScrollBar(false)
end

--[[-- 
初始化  滚动条
]]
function ScrollView:initScrollBar()
	if(self.direction == ScrollView.VERTICAL) then
		self.scrollBar = display.newScale9Sprite("#win_scrollv.png");
		self.scrollBar:setCapInsets(CCRect(0,6,self.scrollBar:getContentSize().width,self.scrollBar:getContentSize().height-12))
		self.scrollBar:setAnchorPoint(ccp(0,1));
		self.scrollBar:setPosition(ccp(self.vWidth-self.scrollBar:getContentSize().width,self.vHeight));
		self:addChild(self.scrollBar);
		self.scrollBar:retain();
		self.scrollBar:setVisible(false);
	elseif(self.direction == ScrollView.HORIZONTAL) then
		self.scrollBar = display.newScale9Sprite("#win_scrollh.png");
		--print("barWidth",self.scrollBar:getContentSize().width);
		self.scrollBar:setCapInsets(CCRect(6,0,self.scrollBar:getContentSize().width-12,self.scrollBar:getContentSize().height))
		self.scrollBar:setAnchorPoint(ccp(0,1));
		self.scrollBar:setPosition(ccp(0,self.scrollBar:getContentSize().height));
		self:addChild(self.scrollBar);
		self.scrollBar:retain();
		self.scrollBar:setVisible(false);
	end
end

--[[--
设置是否显示 滚动条
@param   true  显示   false 不显示

]]
function ScrollView:showScrollBar(flag)
	if(flag)then
		if(not self.scrollBar:getParent())then
			self:addChild(self.scrollBar);
		end
	else
		self.scrollBar:removeFromParent();
	end
end

--[[--
desc:会根据  内容的 宽高 更新滚动条的  大小
@param  w  h  重新设置 滚动内容container的 宽高   refresh(100,200)

]]
function ScrollView:refresh(w,h)
	transition.stopTarget(self.container);
	if(w and h) then
		self.containerSize = CCSize(w,h);
	else
		local rect = self:getContainerRect(self.container);
		self.containerSize = CCSize(rect:getMaxX(),-rect:getMinY());
		--print("ppppppppp",-rect:getMinY())
	end
	
	if(self.direction == ScrollView.VERTICAL) then
	    if(self.containerSize.height <= self.vHeight) then
	    	self.scrollBar:setVisible(false);
--	    	self:changeTouchEnabled(false);
			self._acceptTouchEvent = false;
	    else
	    	self._acceptTouchEvent = true;
--	    	self:changeTouchEnabled(true);
	    	self.scrollBar:setVisible(true);
	    	local barHeight = self.vHeight*self.vHeight/self.containerSize.height;
	    	if(barHeight < 12)then
	    		barHeight = 12;
	    	end
	    	self.scrollBar:setContentSize(CCSize(self.scrollBar:getContentSize().width,barHeight))
	    	local x,y = self.container:getPosition();
	    	self:updateBarPos(x,y);
	    end
	elseif(self.direction == ScrollView.HORIZONTAL) then
		if(self.containerSize.width <= self.vWidth) then
	    	self.scrollBar:setVisible(false);
--	    	self:changeTouchEnabled(false);
			self._acceptTouchEvent = false;
	    else
	    	self._acceptTouchEvent = true;
--	    	self:changeTouchEnabled(true);
	    	self.scrollBar:setVisible(true);
	    	local barWidth = self.vWidth*self.vWidth/self.containerSize.width;
	    	if(barWidth < 12)then
	    		barWidth = 12;
	    	end
	    	self.scrollBar:setContentSize(CCSize(barWidth,self.scrollBar:getContentSize().height))
	    	local x,y = self.container:getPosition();
	    	self:updateBarPos(x,y);
	    end
	end
	self:_checkTweenBack();
	--self:setScrollTo({x='-100',y='-100'});
end

--[[--
	设置把内容滚动到什么位置
	@parma  pos  可以是字符串 “top”  ScrollView.TOP 表示滚动到顶部（横向滚动的时候表示最左边）  
						“bottom”   ScrollView.BOTTOM表示滚动到底部（横向滚动的时候表示最右边）
				也可以是一个table {x=10,y=100} 表示滚动到 某个位置(10,100)
]]
function ScrollView:setScrollPos(pos)
	if(type(pos) == "string")then
		if(pos == ScrollView.TOP)then  
			local x,y = self.container:getPosition();
			if(self.direction == ScrollView.VERTICAL)then
				y = self.vHeight;
			elseif(self.direction == ScrollView.HORIZONTAL)then
				x = 0;
			end
			self:_setContainerPos(x,y);
		elseif(pos == ScrollView.BOTTOM)then
			local x,y = self.container:getPosition();
			if(self.direction == ScrollView.VERTICAL)then
				if(self.containerSize.height  < self.vHeight)then
					y = self.vHeight;
				else
					y = self.containerSize.height;
				end
			elseif(self.direction == ScrollView.HORIZONTAL)then
				x = self.containerSize.width - self.vWidth;
				x = -x;
				if(x > 0)then
					x = 0;
				end
			end
			self:_setContainerPos(x,y);
		end
	else
		local x,y = (pos.x or 0),(pos.y or 0)
		self:_setContainerPos(x,y+self.vHeight);
		self:_checkTweenBack(true);
	end
end

--设置 触摸区域的大小  @CCRectMake
function ScrollView:setTouchRet(rect)
	self._touchRet = rect --CCRectMake(0, 0, self.vWidth, self.vHeight)   --触摸区域
end

--[[--
	获取 滚动容器  的size
	@return CCSize
]]
function ScrollView:getScrollContainerSize()
	return self.containerSize
end

--[[--
	获取 滚动容器  的位置
	@return CCSize
]]
function ScrollView:getScrollContainerPosition()
	return self.container:getPosition()
end

--[[-- 
更新滚动条的 位置
]]
function ScrollView:updateBarPos(x,y)   --全部不显示滚动条了
--	if(self.direction == ScrollView.VERTICAL) then
--		local barY = self.vHeight*(y-self.vHeight)/self.containerSize.height;
--		barY = self.vHeight - barY;
--		if(barY < self.scrollBar:getContentSize().height) then barY = self.scrollBar:getContentSize().height end
--		if(barY > self.vHeight) then barY = self.vHeight end
--		self.scrollBar:setPositionY(barY);
--		--print(barY,y,"222");
--	elseif(self.direction == ScrollView.HORIZONTAL) then
--		local barX = -self.vWidth*x/self.containerSize.width;
--		--print(barX,x,"111");
--		if(barX < 0) then barX = 0 end
--		if(barX > self.vWidth - self.scrollBar:getContentSize().width) then barX = self.vWidth - self.scrollBar:getContentSize().width end
--		
--		self.scrollBar:setPositionX(barX);
--	end
end

--[[-- 
直接设置容器位置 
]]
function ScrollView:_setContainerPos(x,y)
	self.container:setPosition(ccp(x,y));
	self:updateBarPos(x,y)
	self:dispatchEvent({name = Event.MOUSE_SCROLL_MOVE,x=x,y=y})
end

--[[-- 
获取一个node节点的真实矩形边界  
]]
function ScrollView:getContainerRect(container,isOffset)
	
	local maxRect = container:boundingBox();
	local offsetX = 0;
	local offsetY = 0
	local posX,posY = container:getPosition();
	if(isOffset)then  --子孩子需要位移
		local anchor = container:getAnchorPoint();   
		offsetX = posX - anchor.x*maxRect.size.width;
		offsetY = posY - anchor.y*maxRect.size.height;
	else
		maxRect.origin.x = maxRect.origin.x - posX  --自己  不需要
		maxRect.origin.y = maxRect.origin.y - posY
		--print("坐标",maxRect:getMinY(),maxRect:getMaxX())
	end
	
	local children = container:getChildren();
	if children then
		--print(offsetX,offsetY,"444444",children:count()-1)
		for i=0,children:count()-1 do 
			local child = children:objectAtIndex(i);
			child = tolua.cast(child,"CCNode")
			local rect = self:getContainerRect(child,true);
			--print(rect:getMinX(),rect:getMaxX(),"5555")
			local minX = rect:getMinX() + offsetX;
			minX = math.min(maxRect:getMinX(),minX);
			local minY = rect:getMinY() + offsetY;
			minY =  math.min(maxRect:getMinY(),minY)
			local maxX = rect:getMaxX() + offsetX;
			maxX = math.max(maxRect:getMaxX(),maxX)
			local maxY = rect:getMaxY() + offsetY;
			maxY = math.max(maxRect:getMaxY(),maxY)
			maxRect:setRect(minX,minY,maxX-minX,maxY-minY)
		end
	end
	--print("aaad111111aaaaa",maxRect:getMinY(),maxRect:getMaxY())
	return maxRect;
end

--触摸事件
function ScrollView:_onTouch(event, x, y)
	if event == "began" then
        return self:_onTouchBegan(x, y)
    elseif event == "moved" then
        self:_onTouchMoved(x, y)
    elseif event == "ended" then
        self:_onTouchEnded(x, y)
    else -- cancelled
        self:_onTouchCancelled(x, y)
    end
end

--down
function ScrollView:_onTouchBegan(x, y)
	if self._acceptTouchEvent == false then
		return false;
	end
	ScrollView.isScrolling = false;
	local point = self:convertToNodeSpace(ccp(x,y));
    local rect = self._touchRet;
   	if(rect:containsPoint(point))then
--   		self._isMouseDown = true;
   		self._mouseDownPoint = ccp(x,y);
   		self._mouseMovePoint = self._mouseDownPoint;
   		self._containerX,self._containerY = self.container:getPosition();
   		transition.stopTarget(self.container);
   		return true;
   	else   --没点到
   		return false;
   	end
end

--move
function ScrollView:_onTouchMoved(x, y)
	local dy = y - self._mouseMovePoint.y
	local dx = x - self._mouseMovePoint.x
	
	
	self._mouseMovePoint = ccp(x,y);
	
	if(not self:isInGestureAngle(dx,dy))then   --在 手势设定的范围内  才有效
		return false;
	end
	
	if(self.direction == ScrollView.VERTICAL)then
		dx = 0
	elseif(self.direction == ScrollView.HORIZONTAL)then
		dy = 0
	end
	
	local curX,curY = self.container:getPosition();
	local targetX,targetY = curX+dx,curY+dy;
	local canMove,canMoveX,canMoveY = self:_canMoveTo(targetX,targetY)
	if(canMove)then
		ScrollView.isScrolling = true;
		self:_setContainerPos(targetX,targetY);
		return true;
	else
		ScrollView.isScrolling = true;
		self:_setContainerPos(canMoveX,canMoveY);
		return false;
	end
end

--up
function ScrollView:_onTouchEnded(x, y)
	ScrollView.isScrolling = false;
	if(self._mouseDownPoint ~= self._mouseMovePoint)then
		self:_checkTweenBack();
	end
end

--cancel
function ScrollView:_onTouchCancelled(x, y)
	ScrollView.isScrolling = false;
    self:_checkTweenBack();
    --self:dispatchEvent({name = Event.SCROLL_END})
end

--[[-- 
是否可以拖动到 p位置 
]]
function ScrollView:_canMoveTo(x,y)
	if(self.forbidOut)then  --禁止滚动出界
		local isOut,tx,ty = self:isScrollOut(x,y)
		if(isOut)then
			return false,tx,ty
		end
	end
	return true
	
--	if(self.direction == ScrollView.VERTICAL) then
--		local maxY = 0;
--		local minY = self:getContentSize().height - self.containerSize.height;
--	elseif(self.direction == ScrollView.HORIZONTAL) then
--		
--	end
--	return true;
end

--[[-- 
检测是否滚动出界
]]
function ScrollView:isScrollOut(x,y)
	if(self.direction == ScrollView.VERTICAL) then
		local maxY = self.containerSize.height;
		local minY = self.vHeight;
		--print(minY,maxY,y);
		if(minY > maxY)then
			maxY = minY;
		end
		if(y > maxY)then
			return true,x,maxY
		elseif(y < minY)then
			return true,x,minY
		end
	elseif(self.direction == ScrollView.HORIZONTAL) then
		local maxX = 0;
		local minX = self.vWidth - self.containerSize.width;
		--print(minX,x)
		if(minX > 0)then
			minX = 0;
		end
		if(x > maxX)then
			return true,maxX,y;
		elseif(x < minX)then
			return true,minX,y;
		end
	end
	return false,x,y
end

--[[-- 
检测是否  越级   然后缓动回来
]]
function ScrollView:_checkTweenBack(noTween)
	local x,y = self.container:getPosition();
	local isOut,targetX,targetY = self:isScrollOut(x,y);
	if(isOut)then
		--print("越界了：：：：",x,y);
		if noTween then
			self:_setContainerPos(targetX,targetY);
		else
			self:_tweenTo(targetX,targetY);
		end
	end
	self:dispatchEvent({name = Event.MOUSE_SCROLL_END})
end
 
--[[-- 
缓动回来
]]
function ScrollView:_tweenTo(x,y)
--	print("位置啊啊啊----tweento----------",y);
	self:updateBarPos(x,y);
	transition.stopTarget(self.container);
	transition.moveTo(self.container,{time = 0.3, x = x, y = y,easing="EXPONENTIALOUT",onComplete=function()
									self:updateBarPos(x,y);
								end})
	--print("位置啊啊啊----tweento----------",self.container:getPositionY(),y);
end

--[[--
	设置是否可以拖动出边界  再弹回来
	true  禁止滚动出边界
	false  （默认）  可以滚动出边界
]]
function ScrollView:forbidScrollOut(forbid)
	self.forbidOut = forbid;
end


--[[--
	设置滚动手势的方向作用角度    默认不用调用
]]
function ScrollView:setGestureAngle(angle)
	self.gestureAngle = angle
end

--是否在 手势作用范围内
function ScrollView:isInGestureAngle(x,y)
	if(not self.gestureAngle)then
		return true
	else
		local r = 180*math.atan2(y,x)/math.pi;
		local angle = self.gestureAngle;
		
--		print("角度",r,angle,y,x,math.atan2(y,x))
		if(self.direction == ScrollView.VERTICAL) then
			if( (r > 90-angle and r < 90+angle) or  (r > -90-angle and r < angle-90) )then --垂直范围内移动
				return true
			else
				return false
			end
		elseif(self.direction == ScrollView.HORIZONTAL) then
			if( (r > -angle and r < angle) or  r > 180-angle or r < angle-180  )then --水平范围内滚动
				return true
			else   --不在水平范围内
				return false
			end
		end
	end
end

--[[--
	移除容器所有孩子 
]]
function ScrollView:clear()
	self.container:removeAllChildren();
	self:refresh(0,0)
end

function ScrollView:showBg()
	local content = self:getContentSize()
	local colorBg = CCLayerColor:create(GameConst.COLOR_PLACEHOLDER, content.width, content.height)
	self:addChild(colorBg)
end

--[[-- 
销毁
]]
function ScrollView:dispose()
	--移除事件监听
	self:removeTouchEventListener()
	--从父节点移除并清理
	self:removeFromParentAndCleanup(true)

	--移除Touch监听

	--移除定时监听

	--移除节点事件监听

	--析构自己持有的计数引用
	self.container = nil
	self.scrollBar:release();
	self.scrollBar = nil;
	ScrollView.super.dispose(self);
end

return ScrollView;