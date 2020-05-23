--
-- Author: wdx
-- Date: 2016-03-29 17:38:50
--
local NodeTag = game_require("uiLib.component.richText.tag.NodeTag")
local BlockTag = class("BlockTag",NodeTag)

function BlockTag:ctor(tInfo)
	NodeTag.ctor(self,tInfo)
	self._childList = {}
	self._curWidth = 0
	self._curHeight = tInfo.h or 0
	local childInfoList = tInfo:getChildTagList()

	if childInfoList then
		local TagFactory = game_require("uiLib.component.richText.TagFactory")
		for i,info in ipairs(childInfoList) do
			local tag = TagFactory:createTag(info)
			self:addTag(tag)
		end
		self:_layout()
	end
end

function BlockTag:addTag(tag)
	self._childList[#self._childList+1] = tag

	local node = tag:getNode()
	if node then
		self:getNode():addChild(node)
	end

	local size = tag:getSize()
	self._curWidth = self._curWidth + size.width
	if size.height > self._curHeight then
		self._curHeight = size.height
	end
end

function BlockTag:getSize()
	local w = self.tagInfo.w or self._curWidth
	local h = self.tagInfo.h or self._curHeight
	return CCSize(w,h)
end

--布局
function BlockTag:_layout()
	local startX = 0
	if self.tagInfo.align == RichText.LEFT then
		startX = 0
	elseif self.tagInfo.align == RichText.CENTER then
		local size = self:getSize()
		startX = math.floor( (size.width - self._curWidth)/2)
	elseif self.tagInfo.align == RichText.RIGHT then
		local size = self:getSize()
		startX = math.floor( (size.width -self._curWidth))
	end
	for i,tag in ipairs(self._childList) do
		tag:setPositionX(startX)
		startX = startX + tag:getSize().width
	end
end

function BlockTag:setOpacity(opacity)
	for i,tag in ipairs(self._childList) do
		if tag.setOpacity then
			tag:setOpacity(opacity)
		end
	end
end

function BlockTag:dispose()
	for i,tag in ipairs(self._childList) do
		tag:dispose()
	end
	NodeTag.dispose(self)
end


---------------
function BlockTag:show(num)
	if not self._showIndex then
		self._showIndex = 1
		for i=self._showIndex+1,#self._childList do
			local node = self._childList[i]:getNode()
			if node then
				node:setVisible(false)
			end
		end
	end
	local tag = self._childList[self._showIndex]
	if tag then
		local node = tag:getNode()
		if node then
			node:setVisible(true)
		end
		if tag:show(num) then
			self._showIndex = self._showIndex + 1
		end
		return false
	else
		return true  --显示完了
	end
end

return BlockTag