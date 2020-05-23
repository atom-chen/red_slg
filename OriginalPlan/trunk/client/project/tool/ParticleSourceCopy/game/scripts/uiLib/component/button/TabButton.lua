--[[--
class: TabButton
inherit: CCLayer
desc:	标签按钮
author:	hong
event:	
	
example:
	tabButton = TabButton.new(TabButton.TYPE_MAX, {"全部", "附件", "信息"})
	
	tabButton:showBackground()		--显示蓝色占位块，供布局使用
	tabButton:trigger(index)		--手动切换标签
	
	tabButton:addEventListener(Event.TAB_CHANGE,{self, self._change})
	function Panel:_change(event)	--回调方法例子
		echo("index:" .. event.index)
	end
]]

local TabButton = class("TabButton", function()
		return display.newLayer(false)
	end)

TabButton.TYPE_MAX = 1 	--大标签
TabButton.TYPE_MIN = 2 	--小标签

TabButton.WIDTH = 480	--组件整体宽度
TabButton.HEIGHT = 58	--组件整体高度

TabButton.TYPE_WIDTH = {156, 98}	--按钮宽度
TabButton.TYPE_HEIGHT = {46, 46}	--按钮高度

TabButton.IMAGELINE = "#line2.png"
--[[--
	构造函数
	@param tabType Number 标签类型
	@param tabs table 标签文字列表
	@param length Number 标签长度
]]
function TabButton:ctor(tabType, tabs, length)
	self:retain()
	EventProtocol.extend(self)

	self._type = tabType or 1
	self._index = 1
	self._length = length or TabButton.WIDTH
	
	self._labelList = {}	--标签文字对象列表
	self._buttonList = {}	--标签按钮对象列表

	local width = TabButton.TYPE_WIDTH[self._type]
	local height = TabButton.TYPE_HEIGHT[self._type]
	self._labelPoint = ccp(width / 2, height / 2)

	local line = display.newScale9Sprite(TabButton.IMAGELINE)	--底线图片
	line:setCapInsets(CCRect(0, 0, 6, 6))
	line:setContentSize(CCSize(self._length, 6))
	line:setAnchorPoint(ccp(0, 0))

	self._layer = display.newLayer()
	self._layer:retain()
	self._layer:addChild(line)
	self:addChild(self._layer)

	self:setList(tabs)
	self:setAnchorPoint(ccp(0, 0))
	self:ignoreAnchorPointForPosition(false)
	self._layer:setTouchEnabled(true)
	self._layer:addTouchEventListener(handler(self, self._onTouch))
end

function TabButton:setList(tabs)
	if not tabs then
		return
	end

	local label = nil
	local button = nil
	local width = TabButton.TYPE_WIDTH[self._type]
	local marginLeft = 3

	-- tab 居中
	if self._type == TabButton.TYPE_MIN then
		local width = TabButton.TYPE_WIDTH[self._type]
		marginLeft = (self._length - width * #tabs) /2
	end
	
	for k,v in pairs(tabs) do 
		if not self._buttonList[k] then --没有时再创建
			button = self:_getButton(k)
			button:retain()
			self._buttonList[k] = button
			self._layer:addChild(button)
		elseif not self._buttonList[k]:getParent() then --已经有按钮，重新添加到节点
			self._layer:addChild(self._buttonList[k])
		end

		self._buttonList[k]:setPosition((k-1) * width  + marginLeft, 0)

		if type(v) == "string" and string.sub(v, -4, -1) == ".png" then -- png的图片文字
        	self:_setSpriteLabel(k, v)
        elseif type(v) == "string" then
        	self:_setStringLabel(k, v)
        else --node节点
    		self:_setObjectLabel(k, v)
        end
	end

	--移除多余按钮
	for i=#tabs+1, #self._buttonList do
		self._layer:removeChild(self._buttonList[i])
	end
end

function TabButton:_setSpriteLabel(k,v)
	if not self._labelList[k] then
        label = display.newSprite(v)
        label:setPosition(self._labelPoint)
        label:retain()
		self._labelList[k] = label
		self._buttonList[k]:addChild(label)
    else
        display.setDisplaySpriteFrame(self._labelList[k], v) --已经存在，则修改
    end
end

function TabButton:_setStringLabel(k,v)
	if not self._labelList[k] then
		label = ui.newTTFLabel({
			text = v,
			size = 24,
			align = ui.TEXT_ALIGN_CENTER,
		})   
		label:setPosition(self._labelPoint)
		label:retain()
		self._labelList[k] = label
		self._buttonList[k]:addChild(label)
	else 	
		self._labelList[k]:setString(v)
	end
end

function TabButton:_setObjectLabel(k,v)
	if not self._labelList[k] then
		label = v
    	label:setPosition(self._labelPoint)
    	label:retain()
		self._labelList[k] = label
		self._buttonList[k]:addChild(label)
	end
end

--[[--
	清除纹理
]]
function TabButton:reset()
	for k,v in ipairs(self._labelList) do
		display.setDisplaySpriteFrame(v)
	end
end

--[[--
	根据下标获取按钮
	@param index Number 下标
]]
function TabButton:_getButton(index, marginLeft)
	local button = nil
	local filename = nil
	
	if self._index == index then
		filename = self:_getButtonFileName(true)
	else 
		filename = self:_getButtonFileName(false)
	end
	
	button = display.newSprite(filename)
	button:setAnchorPoint(ccp(0,0))

	return button
end

--[[--
	根据按钮状态获取按钮资源名字
	@param isSelect string 按钮状态
]]
function TabButton:_getButtonFileName(isSelect)
	if isSelect then
		status = "s"
	else 
		status = "u"
	end
	local filename = "#btn_tab" .. self._type .. status .. ".png"
	return filename
end

--[[--
	按钮触击判断
	@param event string 事件
	@param x Number x坐标
	@param y Number y坐标
]]
function TabButton:_onTouch(event, x, y)
	local nodePoint =  self._layer:convertToNodeSpace(ccp(x, y))

	for k,v in pairs(self._buttonList) do 
    	if v:getBoundingBox():containsPoint(nodePoint) then
    		if self._index ~= k and v:getParent() then 	--不同位置才触发
				self:trigger(k)
			end
    	end
	end
end

--[[--
	改变触摸优先级
	@param priority Number
]]
function TabButton:changeTouchPriority(priority)
	local old = self._layer:getTouchPriority()
	if old == priority then
		return
	end
	self._layer:setTouchPriority(priority)
	if self._layer:isTouchEnabled() then --如果开启了触摸，则重新监听
		self._layer:removeTouchEventListener()
		self._layer:addTouchEventListener(handler(self,self._onTouch),false,priority, true)
	end
end

--[[--
	显示蓝色占位块，供布局使用
]]
function TabButton:showBackground()
	local colorBg = CCLayerColor:create(GameConst.COLOR_PLACEHOLDER, self._length, TabButton.HEIGHT)
	self._layer:addChild(colorBg)
end

--[[--
	手动调用标签
]]
function TabButton:trigger(index)
	self._index = index

	local filename = nil
	local frame = nil
	for k,v in pairs(self._buttonList) do 
		if self._index == k then
			filename = self:_getButtonFileName(true)
		else
			filename = self:_getButtonFileName(false)
		end
		
		frame = display.newSpriteFrame(string.sub(filename,2))
    	v:setDisplayFrame(frame)
	end
	
	AudioMgr.playEffect(GameConst.EFFECT_CLICK)
	self:dispatchEvent({name = Event.TAB_CHANGE, index = index})
end

--[[--
	确保是某下标标签（不是再调用）
]]
function TabButton:changeToIndex(index)
	if self._index ~= index then
		self:trigger(index)
	end
end

function TabButton:dispose()

	--从父节点移除并清理
	self:removeFromParentAndCleanup(true)

	--移除Touch监听
	self._layer:removeTouchEventListener()

	self._layer:removeAllChildren()

	for i=1,#self._buttonList do
		self._buttonList[i]:release()
		self._labelList[i]:release()
	end

	self._layer:release()
	self._layer = nil

	self._type = nil
	self._index = nil
	
	self._labelList = nil
	self._buttonList = nil

	self:release()
end

return TabButton