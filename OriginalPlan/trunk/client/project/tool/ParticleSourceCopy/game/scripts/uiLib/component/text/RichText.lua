--
-- Author: LiangHongJie
-- Date: 2013-12-13 15:03:22
--

--[[--
class:   RichText
inherit: CCSprite
author:  LiangHongJie
font标签字体颜色支持方式
	1.rfb(155,225,120) 
	2.#ffeeaa 16进制字符的颜色值
	3.green、red、blue 等143个html中英文单词代表的颜色值(具体查看文件:model.utils.ColorWord)
example：
    local text = "我爱你<font color=rgb(255,0,0) fontName=宋体>中 国 </font>,Hello <img src=ui/face.png></img>rld!"
	local richText = RichText.new(200,200,20)
	richText:showBackground()
	richText:addString(text)
	richText:setPosition(ccp(20, 40))
	richText:setAlign(RichText.ALIGN_CENTER) --看需要设置内容对齐方式
注意：
    1.支持<font></font> 和<img></img>
    2.标签要成对出现（有开头标签也要有结束标签）
标签用法：
    1.正确用法：<img src=im.png></img>
    2.错误用法：<img src=im.png/>
    3.换行符："\r\n";"\r";"\n"
]]
local RichText = class("RichText",function()
	return XSprite:create()
end)
RichText.ALIGN_LEFT = 1  --左对齐
RichText.ALIGN_RIGHT = 2  --右对齐
RichText.ALIGN_CENTER =3  --居中对齐
--[[--
	构造函数
	@param width  宽度
	@param height 高度
	@param fontSize 字体大小
	@param color 字体颜色
	@param linesPacing 间距
	@param align   对齐 
		RichText.ALIGN_LEFT   --左对齐
		RichText.ALIGN_RIGHT   --右对齐
		RichText.ALIGN_CENTER   --居中对齐
]]

local Util = require("model.utils.util")
function RichText:ctor(width,height,fontSize,color,linesPacing,align)
	self._size = CCSize(width,height)         --文本的宽高
	self:setContentSize(CCSize(width,height))
	--self:setPosition(ccp(width/2, height/2))
	--self._renderTexture = CCRenderTexture:create(width,height)
	--self._renderTexture:retain()
	self._fontSize = fontSize or 18  --文本的大小
	self._linesPacing = linesPacing or 0
	self._color = color or ccc3(255,255,255)
	self._fontName = GameConst.DEFAULT_FONT
	self:_init()
	self:retain()
	self:setAnchorPoint(ccp(0, 0))
	self._alignType = align or RichText.ALIGN_LEFT
--	self._colorWord = require('model.utils.ColorWord') -- change by changao
end

function RichText:_init()
	-- body
	self._point = ccp(0,self._size.height/2)--ccp(0,h)            --左上角位置
	self._point_x = 0
	self._linePoint_x =0
	self._linePoint_y = (self._size.height-self._fontSize)/2
	self._linePoint = ccp(self._linePoint_x,self._linePoint_y+self._fontSize)--ccp(0,h)            --左上角位置
	self._lineIndex = 0
	self._lineNodes = {}
	self._lineNode = nil
	self._lineSizes = {}
	self._lineSize = {width=0,height=0}
	self:_createLine()
end
function RichText:addString(str,fontName)
	--self._renderTexture:begin()
	if fontName then self._fontName = fontName end
	local htmlStrLiat = Util.parseHtmlStr(str)
	--print
	for index,htmlStrInfo in pairs(htmlStrLiat) do
		self:_htmlStrInfo(htmlStrInfo)
		--self._renderTexture:visit()
	end
	--self._renderTexture:draw()
	--print("<----------------------------------------------------------")
end
function RichText:setString(str,fontName)
	-- body
	self:_clearAllLiner()
	self:addString(str, fontName)
end
function RichText:setAlign( align )
	if not align or not self._lineNodes or
       self._alignType == align then
		return
	end
	if align ==RichText.ALIGN_LEFT or 
       align == RichText.ALIGN_RIGHT or
       align ==RichText.ALIGN_CENTER then
		self._alignType = align
		for index , lineNode in pairs(self._lineNodes) do
			local lineSize = self._lineSizes[index]
			self:_alignLine(lineNode, lineSize)
		end
	end
end

function RichText:_createLine()
	-- body
	local point = self._point
    point.y = point.y - self._fontSize - self._linesPacing
    if self._lineSize.height > self._fontSize then
    	--todo
    	point.y = point.y - (self._lineSize.height+1-self._fontSize) /2
    end
	--createNewLine
	local index = self._lineIndex + 1

	self._lineNode = display.newSprite()
	self._lineNodes[index] = self._lineNode
	self._lineNode:setAnchorPoint(ccp(0, 0))

	self._lineSize = {width=0,height=self._fontSize}
	self._lineSizes[index] = self._lineSize

	self._lineNode:setPosition(0 , point.y)
	self:addChild(self._lineNode)
	--self._renderTexture:addChild(self._lineNode)
	self._linePoint.x=self._linePoint_x
	self._lineIndex = index
	--print("RichText:_createLine()",self._lineSize,self._lineNode,point.y,self._point.y)
end
function RichText:_alignCurLine()
	-- body
	self:_alignLine(self._lineNode, self._lineSize)
end
function RichText:_alignLine(lineNode,lineSize)
	local x = 0
	local width = self._size.width
	if self._alignType == RichText.ALIGN_CENTER then
		x = (width-lineSize.width)/2
	elseif self._alignType == RichText.ALIGN_RIGHT then
		x = (width-lineSize.width)
	else
	end
	lineNode:setPositionX(x)
end

function RichText:_clearAllLiner()
	-- body
	if #self._lineNodes <1 then
		return
	end
	self:removeAllChildrenWithCleanup(true)
	self:_init()
end


function RichText:_lineSizeInfo()

end

function RichText:_htmlStrInfo( htmlStrInfo )
	-- body
	--print("\nRichText:_htmlStrInfo",htmlStrInfo)
	--for k,v in pairs(htmlStrInfo) do
		--print("RichText:_htmlStrInfo",k,v)
	--end
	
	local tType = htmlStrInfo.type
	if not tType or tType == Util.HMTLSTR_FONT then
		--todo
		self:_createLabel( htmlStrInfo )
	else
		--todo
		self:_createImage( htmlStrInfo )
	end
	
end
--[[--
	创建图片
]]
function RichText:_createImage( htmlStrInfo )
	-- body
	
	local filename = htmlStrInfo.src
	if not filename then return end
	local image = XSprite:createWithImage(filename)
	local imageSize = image:getImageSize()
	
	if self._lineSize.width + imageSize.width > self._size.width  then
	    self:_createLine()
	end
	
	self._linePoint.x = self._linePoint_x + self._lineSize.width + ( imageSize.width )/2 
	self._lineSize.width = self._lineSize.width + imageSize.width
	image:setPosition(self._linePoint)
	self._lineNode:addChild(image)
	
	if imageSize.height > self._lineSize.height then
		--self._point.y = self._point.y - (imageSize.height-self._lineSize.height)/2
		self._lineNode:setPosition(self._point)
		--self._lineSize.height = imageSize.height
	end

	self:_alignCurLine()
	
	--local size = image:getImageSize()
	--print("RichText:_createImage:",size.width,size.height)
end
--[[--
	创建本文
]]
function RichText:_createLabel( htmlStrInfo )
	-- body
	local fontSize = self._fontSize
	local fontName = htmlStrInfo.fontName
	local color = self:_getColorByStr(htmlStrInfo.color)
	if not fontName  then fontName = self._fontName end

	if not color then color=self._color end
	local text = htmlStrInfo.value
	local letter , textNum , letterSize, size= Util.splitToLetter(text)
	local texts={}     --一行的字符串
	local textWidths={} --宽度列表
	local index = 1
	local width = self._size.width
	local textWidth = self._lineSize.width
	texts[index] = ""
	textWidths[index] =0
	for k,v in pairs(letter) do
			
		textWidth = textWidth + letterSize[v]*fontSize
		if  v == '\r\n' or v =='\r' or v=='\n' then
				--todo
			index = index + 1
			textWidths[index] =0
			texts[index] = "\r\n"

			index = index + 1
			texts[index]=""
			textWidths[index] =0
			textWidth = 0
		else
			if textWidth > width  then
				index = index + 1
				texts[index] = ""
				textWidths[index] =0
				textWidth = letterSize[v]*fontSize
			end
			texts[index] = texts[index] .. v
			textWidths[index] = textWidths[index] + letterSize[v]
			end
			
		end
	--[[--
	if textWidth + size * fontSize > width then
		if textWidth + fontSize > width then
			textWidth = 0
		end
		texts[index] = ""
		textWidths[index] =0
		for k,v in pairs(letter) do
			textWidth = textWidth + letterSize[v]*fontSize
			if textWidth > width then
				index = index + 1
				texts[index] = ""
				textWidths[index] =0
				textWidth = 0
			end
			texts[index] = texts[index] .. v
			textWidths[index] = textWidths[index] + letterSize[v]
		end
		
	else
		texts[index] = text
		textWidths[index] = size
	end
	]]
	for k,text in pairs(texts) do
		if self._lineSize.width + fontSize > width or text=='\r\n' then
	    	self:_createLine()
		end
		local label = CCLabelTTF:create(text,fontName,fontSize)
		if color then
			label:setColor(color)
		end
		textWidth = textWidths[k] * fontSize
		self._linePoint.x = self._linePoint_x + self._lineSize.width +(textWidth)/2
		label:setPosition(self._linePoint)
		self._lineSize.width = self._lineSize.width + textWidth
		self._lineNode:addChild(label)
		self:_alignCurLine()
	end
end
--[[
	@param string str 格式rgb(255,255,255)
	@return color
]]
function RichText:_getColorByStr(str)
	if not str then	return end
	str = string.gsub(str, "%s+", "")
	str = string.lower(str)
	if string.byte(str) == 35 then -- first char is # then
		if str:len()==7 then
			str=str:sub(2, 7)
		elseif str:len() == 9 then
			str=str:sub(4, 9)
		else
			return ccc3(255,255,255)
		end
		local r = string.format("%d", "0x" .. str:sub(1,2))
		local g = string.format("%d", "0x" .. str:sub(3,4))
		local b = string.format("%d", "0x" .. str:sub(5,6))
		return ccc3(tonumber(r),tonumber(g),tonumber(b))
	elseif str:sub(1, 4)=="rgb("  then
		str = str:sub(5, str:len()-1)
		local rgb = Util.split(str, ",")
		return ccc3(rgb[1],rgb[2],rgb[3])
	elseif self._colorWord[str] then
		self:_getColorByStr(self._colorWord[str])
	end
	return ccc3(255,255,255)
end

--[[--
	显示蓝色占位块，供布局使用
]]
function RichText:showBackground()
	local content = self:getContentSize()
	local colorBg = CCLayerColor:create(GameConst.COLOR_PLACEHOLDER, content.width, content.height)
	self:addChild(colorBg)
end
--[[--
	等到文本内容的大小(宽、高)
	@width , height  
]]
function RichText:getTextContentSize()
	-- body
	local height = 0;
	local width = 0
	local linesPacing = self._linesPacing
	local pac = self._linesPacing
	for k,size in pairs(self._lineSizes) do
		if size.width > width then
			width = size.width
		end
		height = height + size.height  + linesPacing
	end
	return  width ,height 
end

--[[--
	析构函数
]]
function RichText:dispose()
	self:removeFromParentAndCleanup(true)
	--self._renderTexture:release()
	--self._renderTexture = nil
	self._fontSize = nil
	self._point_x = nil
	self._color = nil
	self._fontName = nil
	
	self._lineIndex = nil
	self._lineNodes = nil
	self._lineNode = nil
	self._lineSizes = nil
	self._lineSize = nil
	self:release()
end

return RichText