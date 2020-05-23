--
-- Author: wdx
-- Date: 2016-03-23 14:31:28
--
local RichText = class("RichText",function() return display.newNode() end)
local TagFactory = game_require("uiLib.component.richText.TagFactory")

RichText.LEFT = UIInfo.alignment.LEFT
RichText.RIGHT = UIInfo.alignment.RIGHT
RichText.CENTER = UIInfo.alignment.CENTER
RichText.TOP = UIInfo.alignment.TOP
RichText.BOTTOM = UIInfo.alignment.BOTTOM

RichText.FontType = {
	shadow = "shadow",  --阴影
	outline = "outline",  --描边
	none = "none"
}

function RichText:ctor(width,height)
	--整个richText最基本的标签信息
	self._baseTagInfo = TagFactory:createTagInfo(TagFactory.tagType.font)
	self._baseTagInfo.align = RichText.LEFT
	self._baseTagInfo.alignV = RichText.TOP

	self._text = ""
	self._width = width or 100
	self._height = height or 100
	self:setContentSize(CCSize(self._width,self._height))

	self._lineList = {}
	self:retain()
end

function RichText:setSize(width,height)
	self._width = width
	self._height = height
	self:setContentSize(CCSize(self._width,self._height))
	self:_updateText()
end

function RichText:getTextContentSize()
	if #self._lineList == 0 then
		return 0,0
	end
	local w = (#self._lineList > 1 and self._width) or self._lineList[1]:getCurWidth()
	local h = self._lineList[1]:getPositionY() - self._lineList[#self._lineList]:getPositionY()
	h = h + self._lineList[1]:getCurHeight()
	return w,h
end

function RichText:setString(str)
	RichText.setText(self,str)
end

function RichText:setText(str)
	self:_clear()
	if not str then
		self._text = ""
		return
	end
	self._text = str
	self:_buildText(str)
end

--设置各种属性 传一个table 可选参数：
-- {fontSize=21,color=ccc3(255,0,0),fontType=RichText.FontType.shadow,align=RichText.RIGHT}
function RichText:setParams(params)
	for k,v in pairs(params) do
		self._baseTagInfo[k] = v
	end
	if self._baseTagInfo.color then
		self._baseTagInfo.colorCCC3 = self._baseTagInfo.color
		self._baseTagInfo.color = nil
	end
	self:_updateText()
end

function RichText:getParams(key)
	return self._baseTagInfo[key]
end

function RichText:setFontSize(fSize)
	self._baseTagInfo.fontSize = fSize
	self:_updateText()
end

function RichText:setColor(color)
	self._baseTagInfo.colorCCC3 = color
	self:_updateText()
end

--RichText.FontType   --阴影  --描边
function RichText:setFontType(fType)
	self._baseTagInfo.fontType = fType
	self:_updateText()
end

function RichText:setAlign(align)
--	print(debug.traceback())
	self._baseTagInfo.align = align
	self:_updateText()
end

function RichText:setAlignV(alignV)
	self._baseTagInfo.alignV = alignV
	self:_updateText()
end

--设置行间距
function RichText:setLineSpace(space)
	self._baseTagInfo.lineSpace = space
	self:_updateText()
end

function RichText:setTextOneByOne(str,endCallback)
	local RichTextShow = game_require("uiLib.component.richText.RichTextShow")
	RichTextShow:extend(self,RichTextShow.one_by_one)
	self:setText(str)
	self:startShow(endCallback)
end

function RichText:_updateText()
	if self._text ~= "" then
		self:setText(self._text)
	end
end

function RichText:_buildText(str)
	local tagInfoList = TagFactory:parseString(str,self._baseTagInfo)
	local curLine = self:_newLine()
--	dump(tagInfoList)
	if #tagInfoList > 0 then
		local index = 1
		local tagInfo = tagInfoList[index]
		local tag = TagFactory:createTag(tagInfo)
		while tag do
			local nextTag = true
			if tag:isNewLine() then
				curLine = self:_newLine()
			end
			local size = tag:getSize()
			local lineWidth = curLine:getSurplusWidth()  --行剩余宽度
			if size.width > lineWidth then  --当前行不够宽度加入了
				local nextLine = self:_newLine()
				local tag1,tag2 = tag:segment(lineWidth)  --看看是不是可以切割
				if tag1 then
					curLine:addTag(tag1)  --分割第一个加入当前行
					if tag2 then
						tag = tag2  --剩余的第二部分
						nextTag = false
					end
				else
					nextLine:addTag(tag) --只能加入新的一行
				end
				curLine = nextLine
			else
				curLine:addTag(tag)
			end

			if nextTag then
				index = index + 1
				tagInfo = tagInfoList[index]
				if tagInfo then
					tag = TagFactory:createTag(tagInfo)
				else
					break
				end
			end
		end
	end
	self:_layout()
end

function RichText:_addTag(tag)
	self:addChild(tag:getNode())
end

function RichText:_newLine()
	local lineInfo = TagFactory:createTagInfo(TagFactory.tagType.line)
	lineInfo.w = self._width
	lineInfo.h = 0  --行的高度在这个时候还不能确定
	lineInfo.align = self._baseTagInfo.align
	lineInfo.alignV = self._baseTagInfo.alignV
	local line = TagFactory:createTag(lineInfo)
	self._lineList[#self._lineList+1] = line
	self:_addTag(line)
	return line
end

function RichText:_layout()
	local alginV = self._baseTagInfo.alignV
	local lineSpace = self._baseTagInfo.lineSpace or 0
	if alginV == RichText.TOP then
		local startY = self._height
		for i,line in ipairs(self._lineList) do
			startY = startY - line:getCurHeight() - lineSpace
			line:setPositionY(startY)
		end
	elseif alginV == RichText.BOTTOM then
		local startY = 0
		for i = #self._lineList,1,-1 do
			line = self._lineList[i]
			line:setPositionY(startY)
			startY = startY + line:getCurHeight() + lineSpace
		end
	elseif alginV == RichText.CENTER then
		local totalHeight = 0
		for i,line in ipairs(self._lineList) do
			totalHeight = totalHeight + line:getCurHeight() + lineSpace
		end
		if totalHeight > 0 then
			totalHeight = totalHeight - lineSpace
		end
		local startY = (self._height + totalHeight)/2
		for i,line in ipairs(self._lineList) do
			startY = startY - line:getCurHeight() - lineSpace
			line:setPositionY(startY)
		end
	end
end

function RichText:setOpacity(opacity)
	if not self._lineList then
		return
	end

	for i,line in ipairs(self._lineList) do
		if line.setOpacity then
			line:setOpacity(opacity)
		end
	end
end


function RichText:_clear()
	for i,line in ipairs(self._lineList) do
		line:dispose()
	end
	self._lineList = {}
end


function RichText:dispose()
	self:_clear()
	self:removeFromParent()
	self:release()
end

return RichText