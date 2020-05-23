--[[--
class：     BaseGrid
inherit: TouchBase
desc：       通用格子类
author:  HAN Biao
event：
	Event.MOUSE_DOWN:鼠标按下时，发出此事件
	Event.MOUSE_UP：   鼠标松开时，发出此事件
	Event.MOUSE_CANCEL:按下时，移动等，发出此事件
example：
	CCLayer中包含CCSprite，因此个格子类对齐点，为图标的中心点

	local grid = BaseGrid.new()
	local hitRect = CCRect(-41,-41,82,82)
	grid:setHitRect(hitRect)
	grid:setBg("#grid_bg1.png")
	grid:setIcon("item/10103.png")
	grid:setFrame("#grid_frame1.png")

	grid:setPosition(300,500)
	grid:changeTouchEnabled(true)
	self:addChild(grid)

	grid:addEventListener(Event.MOUSE_UP, function()
		echo("mouse up")
	end)
]]

local BaseGrid = class("BaseGrid",TouchBase)

--格子、背景默认的宽、高都是82*82
BaseGrid.DEFAULT_WIDTH = 82
BaseGrid.DEFAULT_HEIGHT = 82

--背景、图标、外框的zOrder
BaseGrid.Z_BG = 1
BaseGrid.Z_ICON = 2
BaseGrid.Z_FRAME = 3

function BaseGrid:ctor(width,height)
	--基类构造函数
	BaseGrid.super.ctor(self)
	--事件扩展
	EventProtocol.extend(self)

	--格子偏移
	self._width = width or BaseGrid.DEFAULT_WIDTH
	self._height = height or BaseGrid.DEFAULT_HEIGHT
	self:setContentSize(CCSize(self._width,self._height))
	self._offsetX = self._width/2
	self._offsetY = self._height/2

	self._hitRect = nil
	self._isMoved = false

	--背景、图标、外框
	self._bgUrl = nil
	self._bg = display.newSprite()
	self._bg:retain()
	self._bg:setPosition(self._offsetX,self._offsetY)
	self:addChild(self._bg,BaseGrid.Z_BG)

	self._iconUrl = nil
	self._icon = display.newSprite()
	self._icon:retain()
	self._icon:setPosition(self._offsetX,self._offsetY)
	self:addChild(self._icon,BaseGrid.Z_ICON)

	self._frameUlr = nil
	self._frame = display.newSprite()
	self._frame:retain()
	self._frame:setPosition(self._offsetX,self._offsetY)
	self:addChild(self._frame,BaseGrid.Z_FRAME)

	self:setContentSize(CCSize(BaseGrid.DEFAULT_WIDTH, BaseGrid.DEFAULT_WIDTH))

	--处理触摸时移动的变量
	self._beforeMovePoint = nil
	self._mhtDistance = 0
end

--[[--
	设置点击触发区域
]]
function BaseGrid:setHitRect(hitRect)
	self._hitRect = hitRect
end


--鼠标按下时
function BaseGrid:_onTouchBegan(event,x,y)
	local pos = self:convertToNodeSpace(ccp(x,y))
	local rect = self._hitRect
	if not rect then
		local sp = nil
		if self._bg:getParent() then
			sp = self._bg
		elseif self._icon:getParent() then
			sp = self._icon
		else
			sp = nil
		end
		if sp then
			rect = sp:boundingBox()
			--self._hitRect = rect
			--print(pos.x,pos.y,sp.x,sp.y,rect.x,rect.y,rect.width,rect.height)
		end
	end

	if rect and rect:containsPoint(pos) then
		self._isMoved = false
		self._beforeMovePoint = self:convertToWorldSpace(ccp(x,y))
		self._mhtDistance = 0

		self:dispatchEvent({name = Event.MOUSE_DOWN})
		return true
	end
end

--鼠标移动时
function BaseGrid:_onTouchMoved(event,x,y)
	self._isMoved = true

	local nowPoint = self:convertToWorldSpace(ccp(x,y))
	local mhtDistance = Util.mhtInstance(nowPoint,self._beforeMovePoint)
	if(mhtDistance>self._mhtDistance)then
		self._mhtDistance = mhtDistance
	end
end

--鼠标正常弹起时
function BaseGrid:_onTouchEnded(event,x,y)
	if self._isMoved then    --如果按下按钮后，有移动
		if self._mhtDistance < GameConst.MHT_DISTANCE then
			AudioMgr.playEffect(GameConst.EFFECT_CLICK) 
			self:dispatchEvent({name = Event.MOUSE_UP})
		else
			self:dispatchEvent({name = Event.MOUSE_CANCEL})
		end
		return
	end
	AudioMgr.playEffect(GameConst.EFFECT_CLICK)
	self:dispatchEvent({name = Event.MOUSE_UP})
end

--鼠标取消时
function BaseGrid:_onTouchCanceled(event,x,y)
	self:dispatchEvent({name = Event.MOUSE_CANCEL})
end

function BaseGrid:_onTouch(event,x,y)
	local ret
	if event == "began" then
		ret = self:_onTouchBegan(event,x,y)
	elseif event == "moved" then
		self:_onTouchMoved(event,x,y)
	elseif event == "ended" then
		self:_onTouchEnded(event,x,y)
	elseif event == "canceled" then
		self:_onTouchCanceled(event,x,y)
	end
	return ret
end

--[[--
	设置某个孩子成新的图片或者SpriteFrame
]]
function BaseGrid:_setCompImage(comp,compUrlName,imageUrl,zOrder)
	if self[compUrlName] == imageUrl then
		return
	end

	if self[compUrlName] then
		 if string.byte(self[compUrlName]) ~= 35 then  --如果是单个图片
			IconResMgr.remove(self[compUrlName])
		 end
	end
	self[compUrlName] = imageUrl

	if imageUrl then
		if not comp:getParent() then
			self:addChild(comp,zOrder)
		end
	else     --如果imageUrl是nil，则说明不显示图片,清除纹理，同时不显示
		comp:setTexture(nil)
		if comp:getParent() then
			self:removeChild(comp)
		end
		return
	end

	if string.byte(imageUrl) ~= 35 then   --单个图片
		IconResMgr.prepare(imageUrl)
		display.setDisplaySingleImage(comp,imageUrl)
	else   --SpriteFrame
		local frame = display.newSpriteFrame(string.sub(imageUrl,2))
		comp:setDisplayFrame(frame)
	end
end

--[[--
	设置背景图片
	@param bgUrl String bgUrl为nil，则为不显示背景
]]
function BaseGrid:setBg(bgUrl)
	self:_setCompImage(self._bg,"_bgUrl",bgUrl,BaseGrid.Z_BG)
end

--[[--
	设置图标图片
	@param iconUrl String iconUrl为nil，则为不显示图标
]]
function BaseGrid:setIcon(iconUrl)
	self:_setCompImage(self._icon,"_iconUrl",iconUrl,BaseGrid.Z_ICON)
end

--[[--
	获取图标图片对象，设置动画什么的
]]
function BaseGrid:getIcon()
	return self._icon
end

--[[--
	设置外框图片
	@param frameUrl String 外框为nil，则为不显示外框
]]
function BaseGrid:setFrame(frameUrl)
	self:_setCompImage(self._frame,"_frameUrl",frameUrl,BaseGrid.Z_FRAME)
end

--[[--
	设置图标图片   缩放
	@param number
]]
function BaseGrid:setIconScale(scale)
	self._icon:setScale(scale);
end

--[[--
	设置icon 偏移位置
]]
function BaseGrid:setIconOffset(x,y)
	self._icon:setPosition(self._offsetX+x,self._offsetY+y)
end

--[[--
	格子的重置方法,重置之后就跟新创建的格子一样
--]]
function BaseGrid:reset()
	self:setBg(nil)
	self:setIcon(nil)
	self:setFrame(nil)
end

function BaseGrid:dispose()
	--移除事件监听
	self:removeAllEventListeners()

	--从父节点移除并清理
	self:cleanup()
	self:removeFromParentAndCleanup(true)

	--析构自己持有的计数引用
	self._hitRect = nil
	self._beforeMovePoint = nil

	self:setBg(nil)
	self._bg:release()
	self._bg = nil

	self:setIcon(nil)
	self._icon:release()
	self._icon = nil

	self:setFrame(nil)
	self._frame:release()
	self._frame = nil

	--析构基类
	BaseGrid.super.dispose(self)
end

return BaseGrid