--[[--
class：     Button
inherit: TouchBase
desc：       通用图片按钮类
author:  HAN Biao
event：
	Event.MOUSE_DOWN:鼠标按下时，发出此事件
	Event.MOUSE_UP：   鼠标松开时，发出此事件
	Event.MOUSE_CANCEL:按下时，移动等，发出此事件
example：
	local mybtn = Button.new("blb0u.png","blb0d.png","blb0n.png")
	mybtn:setPosition(ccp(400,50))
	mybtn:setDisabled(true)
	mybtn:setMouseWhenDisabled(true)

	self:addChild(mybtn)
	mybtn:addEventListener(Event.MOUSE_UP, function()
		echo("mouse up")
	end)
]]

local Button = class("Button",TouchBase)

--按钮的鼠标状态
Button.STATE_UP = 1
Button.STATE_DOWN = 2
Button.STATE_MOVE = 3

--[[--
	构造函数
	@param imageUp String       按钮正常状态下的图片名字，如果是SpriteFrame，图片名字以#开头
	@param imageDown String     按钮按下状态下的图片名字，如果是SpriteFrame，图片名字以#开头,没有的时候，取imageUp的值
	@param imageDisabled String 按钮禁用状态下的图片名字，如果是SpriteFrame，图片名字以#开头,没有的时候，取imageUp的值
]]
function Button:ctor(imageUp,imageDown,imageDisabled)
	--基类构造函数
	Button.super.ctor(self)
	--构造本类
	EventProtocol.extend(self)

	self._disabled = false         --是否禁用,默认为false
	self._mouseWhenDisabled = false --当按钮禁用时，是否继续触发鼠标事件
	self._hitRect = nil            --响应区域，如无，则为按钮图片的矩形范围
	self._state = Button.STATE_UP  --按钮当前的鼠标状态
	self._toggleSelect = false     --是否开启按钮的选中
	self._selected = false         --是否选中
	self._currentImage = nil       --当前显示的图片在_images中的索引

	self:changeTouchEnabled(true)     --CCLayer启用触摸
	self:setButtonImages(imageUp,imageDown,imageDisabled)
end

--[[--
	按钮重置状态后，可通过此方法重新设置成新的图片按钮
	@param imageUp String       按钮正常状态下的图片名字，如果是SpriteFrame，图片名字以#开头
	@param imageDown String     按钮按下状态下的图片名字，如果是SpriteFrame，图片名字以#开头,没有的时候，取imageUp的值
	@param imageDisabled String 按钮禁用状态下的图片名字，如果是SpriteFrame，图片名字以#开头,没有的时候，取imageUp的值
]]
function Button:setButtonImages(imageUp,imageDown,imageDisabled)
	self:reset()
	if not imageUp then
		return
	end
	self._images = {imageUp,imageDown,imageDisabled}
	self._imageSprites = {}
	self:_updateImage()
end

--[[--
	是否是重置后的初始状态
]]
function Button:isReset()
	return (self._images == nil)
end

--[[--
	重置函数,重置之后,相当于一个新new出的空的按钮
]]
function Button:reset()
	if self._images then
		self._disabled = false
		self._mouseWhenDisabled = false
		self._state = Button.STATE_UP
		self._toggleSelect = false
		self._selected = false
		self._offsetX = nil
		self._offsetY = nil
		self._currentImage = nil
		self._hitRect = nil

		for i = 1,4 do
			local imageUrl = self._images[i]
			if imageUrl then
				if string.byte(imageUrl) ~= 35 then  --如果是单个图片
					ImageResMgr:remove(imageUrl)
				end
			end
			local sp = self._imageSprites[i]
			if sp then
				if sp:getParent() then
					self:removeChild(sp)
				end
				sp:release()
			end
		end
		self._images = nil
		self._imageSprites = nil
	end
end

--[[--
	获得按钮正常状态下的宽高
	@return CCSize 按钮图片的size
]]
function Button:getButtonSize()
	local image = self:_getImage(1)
	return image:getImgSize()
end

--[[--
	设置点击响应区域
	@param rect CCRect 按钮的点击触发区域
]]
function Button:setHitRect(rect)
	self._hitRect = rect
end

--[[--
	设置是否禁用
	@param isDisabled Boolean 禁用状态
]]
function Button:setDisabled(isDisabled)
	local bool = tobool(isDisabled)
	if(self._disabled == bool) then
		return
	end
	self._disabled = bool
	self:_updateImage()
end

--[[--
	返回当前按钮是否禁用
	@return Boolean 禁用状态
]]
function Button:getDisabled()
	return self._disabled
end

--[[--
	设置鼠标禁用时，是否需要继续接受事件
	@param Boolean 是：继续接收，否：不接收
]]
function Button:setMouseWhenDisabled(bool)
	self._mouseWhenDisabled = tobool(bool)
end

--[[--
	返回鼠标禁用时，是否需要继续接受事件
	@return Boolean
]]
function Button:getMouseWhenDisabled()
	return self._mouseWhenDisabled
end

--[[--
	开启选中状态
	@param imageSelect String 选中状态下的图片,为nil时，选中时取imageUp的值
]]
function Button:toggleSelect(imageSelect)
	self._toggleSelect = true
	self._images[4] = imageSelect
end

--[[--
	设置当前选中状态
	@param isSelect Boolean 选中状态
]]
function Button:setSelected(isSelect)
	local bool = tobool(isSelect)
	if self._selected == bool then
		return
	end
	self._selected = bool
	self:_updateImage()
end

--[[--
	返回当前按钮是否是选中状态
	@return Boolean 选中状态
]]
function Button:getSelected()
	return self._selected
end



--根据当前按钮的鼠标状态、禁用状态、选中状态，设置相应的显示图片
function Button:_updateImage()
	local index = 1
	if self._disabled then
		index = 3
	elseif self._state == Button.STATE_DOWN then
		if self._toggleSelect and self._selected then
			index = 4
		else
			index = 2
		end
	elseif self._toggleSelect and self._selected then
		index = 4
	else
		index = 1
	end

	if self._currentImage == index then
		return
	end
	--移除之前的图片
	local curImage
	if self._currentImage then
		curImage = self:_getImage(self._currentImage)
	end
	local image = self:_getImage(index)
	if image ~= curImage then
		if curImage then curImage:removeFromParentAndCleanup(true) end
		self:addChild(image)
	end
	self._currentImage = index
end

function Button:_getImage(index)
	local imageUrl = self._images[index]
	if not imageUrl then --对应的照片没有传进来,取正常状态下的图片来显示
		index = 1
		imageUrl = self._images[index]
	end
	local image = self._imageSprites[index]
	if not image then
		if string.byte(imageUrl) ~= 35 then  --如果是单个图片
			ImageResMgr:prepare(imageUrl)
		end
		image = XSprite:createWithImage(imageUrl)
		image:retain()
		if not self._offsetX then
			local size = image:getImgSize()
			self:setContentSize(size)
			self._offsetX = size.width/2
			self._offsetY = size.height/2
		end
		image:setPosition(self._offsetX,self._offsetY)
		self._imageSprites[index] = image
	end
	return image
end

--鼠标按下时
function Button:_onTouchBegan(event,x,y)
	local pos = self:convertToNodeSpace(ccp(x,y))
	local rect = self._hitRect
	if (not rect) and self._images then
		local image = self:_getImage(self._currentImage)
		local ox,oy = image:getPosition()
		local size = image:getImgSize()
		rect = {origin={x=ox, y=oy}, size=size} 
	end
	if rect and rect:containsPoint(pos) then
		self:_onTouchDown(x,y)
		self._state = Button.STATE_DOWN
		local image = self:_getImage(self._currentImage)
		self:_updateImage()
		--抛出事件
		if self._disabled and (not self._mouseWhenDisabled) then
			return true
		end
		self:dispatchEvent({name = Event.MOUSE_DOWN})
		return true
	end
end

--鼠标移动时
function Button:_onTouchMoved(event,x,y)
	self:_onTouchMove(x,y)

	self._state = Button.STATE_MOVE
	self:_updateImage()
end

--鼠标正常弹起时
function Button:_onTouchEnded(event,x,y)
	self._state = Button.STATE_UP
	if self._toggleSelect and not self._isMoved then
		if self._selected then
			self._selected = false
		else
			self._selected = true
		end
	end

	self:_updateImage()
	if self._disabled and (not self._mouseWhenDisabled) then  --如果禁用按钮，同时设置不继续发出事件
		return
	end
	
	local isValid = self:_isTouchValid()
	if isValid then
	  AudioMgr:playEffect(GameConst.EFFECT_CLICK)
    self:dispatchEvent({name = Event.MOUSE_UP})
  else
    self:dispatchEvent({name = Event.MOUSE_CANCEL})
	end
	self:_onTouchUp()
end

--鼠标取消时
function Button:_onTouchCanceled(event,x,y)
	self._state = Button.STATE_UP
	self:_updateImage()
	self:dispatchEvent({name = Event.MOUSE_CANCEL})
	self:_onTouchUp()
end

--鼠标事件，统一接收函数，再根据类型，交由对应函数处理
function Button:_onTouch(event,x,y)
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
  	析构函数：移除事件监听、cleanup定时以及动作、点击监听，析构时调用
]]
function Button:dispose()
	--移除事件监听
	self:removeAllEventListeners()

	--从父节点移除并清理
	self:cleanup()
	self:removeFromParentAndCleanup(true)


	--移除Touch监听
	self:removeTouchEventListener()

	--移除定时监听

	--移除节点事件监听

	--析构自己持有的计数引用
	self._hitRect = nil
	self._beforeMovePoint = nil

	if self._images then
		for i = 1,4 do
			local imageUrl = self._images[i]
			if imageUrl then
				if string.byte(imageUrl) ~= 35 then  --如果是单个图片
					ImageResMgr:remove(imageUrl)
				end
			end
			local sp = self._imageSprites[i]
			if sp then
				if sp:getParent() then
					self:removeChild(sp)
				end
				sp:release()
			end
		end
		self._images = nil
		self._imageSprites = nil
	end

	--基类析构函数
	Button.super.dispose(self)
end

return Button