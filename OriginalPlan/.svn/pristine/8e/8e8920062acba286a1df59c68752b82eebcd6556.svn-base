local NodeTag = game_require("uiLib.component.richText.tag.NodeTag")

local TextTag = class("TextTag",NodeTag)

function TextTag:ctor(tagInfo)
	self.tagInfo = tagInfo
	self._text = ""
end

function TextTag:_newNode()
	local fType = self.tagInfo.fontType
	local params = {text = self._text,size=self.tagInfo.fontSize
					,color=self:_getColor(),align= ui.TEXT_ALIGN_CENTER}
	local label 
	if fType == RichText.FontType.shadow then
		label = ui.newTTFLabelWithShadow(params)
	elseif fType == RichText.FontType.outline then
		label = ui.newTTFLabelWithOutline(params)  
	else
		label = ui.newTTFLabel(params)
	end
	label:setAnchorPoint(ccp(0,0))
	return label
end

function TextTag:setText(str)
	self._textSize = nil
	self._text = str
end

--遇到行尾的时候 需要拆分一些文本到下一行

function TextTag:segment(width)
	if self.tagInfo.w then  --设置了固定大小 不能拆分
		return nil   
	end
	local str1,str2 = util.splitString(self._text,self.tagInfo.fontSize,width)
	if str1 == "" then
		if not self._isSplited then
			self._isSplited = true
			local TagFactory = game_require("uiLib.component.richText.TagFactory")
			return TagFactory:createTagByType(TagFactory.tagType.span),self
		elseif self._text == "" then
			return nil
		else
			local firstWord,len = util.getCharacterAt(self._text,1)
			str1 = firstWord
			str2 = string.sub(self._text,len+1,self._text:len())
		end
	end

	local tag1 = TextTag.new(self.tagInfo)
	tag1:setText(str1)
	local tag2
	if str2 ~= "" then
		tag2 = TextTag.new(self.tagInfo)
		tag2:setText(str2)
	end
	return tag1,tag2
end

function TextTag:getSize()
	if self.tagInfo.w then
		if not self.tagInfo.h then
			self._textSize = util.getTextSize(self._text,self.tagInfo.fontSize)
			self.tagInfo.h = self._textSize.height
		end
		return CCSize(self.tagInfo.w,self.tagInfo.h)
	end
	return self:_getTextSize()
end

function TextTag:_getTextSize()
	if self._textSize then
		return self._textSize
	end
	self._textSize = util.getTextSize(self._text,self.tagInfo.fontSize)
	return self._textSize
end

function TextTag:setPosition(x,y)
	local node = self:getNode()
	node:setPosition(x+self:_getOffsexX(),y)
end

function TextTag:setPositionX(x)
	local node = self:getNode()
	node:setPositionX(x+self:_getOffsexX())
end

--根据align 和设置的w 实际上文本需要偏移x
function TextTag:_getOffsexX()
	if self.tagInfo.w then --有设置宽度
		if self.tagInfo.align == RichText.RIGHT then
			local size = self:_getTextSize()
			return self.tagInfo.w - size.width
		elseif self.tagInfo.align == RichText.CENTER then
			local size = self:_getTextSize()
			return (self.tagInfo.w - size.width)/2
		end
	end
	return 0
end



----------------------------------------------
function TextTag:show(num)
	if not self._showIndex then
		self._showIndex = 1
		self:getNode():setString("")
	end
	local word = util.getCharacterAt(self._text,self._showIndex)
	if word == "" then
		return true
	else
		self._showIndex = self._showIndex + 1
		local str = self:getNode():getString() .. word
		self:getNode():setString(str)
		return false
	end
end

return TextTag