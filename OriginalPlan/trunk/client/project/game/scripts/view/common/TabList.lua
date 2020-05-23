--
-- Author: wdx
-- Date: 2016-05-12 16:54:45
--
local TabList = class("TabList")

function TabList:ctor(container,priority,fontSize)
	self.container = container
	self._priority = priority
	self._btnList = {}
	self._selectIndex = -1
	self.fonSize = fontSize or 26
end

function TabList:addBtnList(btnNameList,callback)
	self.callback = callback
	local size = self.container:getContentSize()
	local btnWidth = (size.width - 46)/#btnNameList + 46

	for i,name in ipairs(btnNameList) do
		local btn = self:_newBtn(i,name,btnWidth)
		self.container:addChild(btn)
		btn:setZOrder(#btnNameList-i)
		self._btnList[i] = btn
	end

	--选中按钮
	self._selectBtn = UIButton.new({"#com_btn_1.png"}, self._priority, true )
	self._selectBtn:setTextPadding({left=-btnWidth/10-2,bottom=2})
	local size = self._selectBtn:getContentSize()
	size.width = btnWidth 
	self._selectBtn:setSize(size, true)
	self._selectBtn:setEnlarge(false)
	self._selectBtn:setZOrder(#btnNameList+5)
	self.container:addChild(self._selectBtn)
	self:setSelect(1,true)
end

function TabList:_onBtn(event)
	local btn = event.target
	local index = btn._btnIndex
	self:setSelect(index)
end

function TabList:setSelect(index,noCallback)
	local btn = self._btnList[index]
	if btn then
		local curBtn = self._btnList[self._selectIndex]
		if curBtn and not curBtn:getParent() then
			self.container:addChild(curBtn)
		end
		btn:removeFromParent()
		self._selectIndex = index
		local x,y = btn:getPosition()
		self._selectBtn:setPosition(x,y)
		self._selectBtn:setText(btn:getText(), self.fonSize, nil, UIInfo.color.blue)

		if not noCallback then
			uihelper.call(self.callback,index)
		end
	end
end

function TabList:_newBtn(i,name,width)
	local btn = UIButton.new({"#com_btn_2.png"}, self._priority, true )
	btn:setTextPadding({bottom=8})
	local size = btn:getContentSize()
	size.width = width
	btn:setSize(size, true)
	btn:setText(name, self.fonSize, nil, UIInfo.color.blue)
	btn:setEnlarge(false)
	btn:addEventListener(Event.MOUSE_CLICK, {self,self._onBtn})
	btn._btnIndex = i
	btn:setPositionX( (i-1)*(width-46) )
	return btn
end

function TabList:dispose()
	for i,btn in iparis(self._btnList) do
		btn:dispose()
	end
	self._btnList = nil
	if self._selectBtn then
		self._selectBtn:dispose()
		self._selectBtn = nil
	end
end

return TabList