--[[
class：UINode
inherit：CCNode
desc：根据 UIData， 创建界面
author：changao
date: 2014-06-03
example：
	local uiData = UIData:getUIData("test1");
	ResourceMgr:instance():loadPvr("ui/button.plist"); -- setUIData之前。 需要保证相关资源以及加载
	local uiNode = UINode.new()
	uiNode.setUIData(uiData)
	--uiNode.setPosition(ccp(0, 0))
	uiNode.setUI("panel") -- 无后缀的 lua ui 文件
	local node = uiNode:getNodeByName("node1")
	
	uiNode:removeNodeByName("node1")
	uiNode.reset()
]]--

UI_BASE = 0
UI_TEXT = 1
UI_BUTTON = 2
UI_UISCROLLVIEW = 3
UI_DRAWABLE = 4
UI_UIEDIT = 5
UI_UISCROLL = 6
UI_ANIMATION = 7
UI_UISCROLL_BAR = 8
UI_TREE = 9
UI_PROGRESS_BAR = 10

	
local UINode = class("UINode", function () return display.newNode() end)

--[[
@brief 左上角为原点。x 轴向右，y 轴向下的坐标系转行成 opengl 坐标系。
@param x float 
@param y float
@return CCPoint 
--]]
--[[ 优化。 将 坐标转换换到UI编辑器去做 
local function tococos2d(x, y, width, height)
	--return ccp(x + display.width/2, display.height/2 - (y + height))
	return ccp(x, - (y + height))
end
--]]

--[[
@brief 将 uiData 的对齐方式数字转行成 UIInfo 的格式
@param align int
@return {horizontalAliment, verticalAlignment} 
--]]
local function alignConvert(align)
--	local h = {[0]="left", [1]="center", [2]="right"}
--	local v = {[0]="top", [1]="center", [2]="bottom"}
	if not align then return {horizontalAlignment=UIInfo.alignment.CENTER, verticalAlignment=UIInfo.alignment.CENTER} end

	local h = {[0]=UIInfo.alignment.LEFT, [1]=UIInfo.alignment.CENTER, [2]=UIInfo.alignment.RIGHT}
	local v = {[0]=UIInfo.alignment.BOTTOM, [1]=UIInfo.alignment.CENTER, [2]=UIInfo.alignment.TOP}
	--local x = (align % 3) * 0.5
	--local y = 1 - (align / 3.0) * 0.5
	--return ccp(x, y)
	if align < 0 then align = 4 end
	if align >= 9 then align = 4 end
	return {horizontalAliment = h[align % 3], verticalAlignment = v[2-math.floor(align/3)]};
end


function UINode:ctor(priority,swallowTouches)
	self._priority = priority or 0
	self._swallowTouches = swallowTouches or false
	self._uiList = {}
	self._language = nil;
end

--[[改变优先级
]]
function UINode:setPriority( priorty )
	self._priority = priority
end


--[[
@brief 根据 uiData 的的信息，创建元素，并将元素添加到 UINode 的子节点中。
@param uiData UIData 
--]]
function UINode:_getTextString(text, name, defaultString)
	if not text then return defaultString end
	if type(text) == "string" then return text end
	if not name then return defaultString end
	if not self._language then return defaultString end
	print ("text:", text, " filename:", name, " default:", defaultString, self._language)
	
	if type(text) == "number"  then
		if not self._language[name] then return defaultString end
		return self._language[name][text]
	end	
	return defaultString
end

--[[
@brief 根据 uiData 的的信息，创建元素，并将元素添加到 UINode 的子节点中。
@param uiData UIData 
--]]
function UINode:setUIData(uiData)
	print("cccccccccccccccc",uiData.count)
	for i=0, uiData.count-1 do
		local elemInfo =  uiData:getElemInfo(i)
		print( "XXXXXXXXXXXXXXXXXXXXX", elemInfo )
		self:createElement( elemInfo )
	end
end

--[[
@brief 根据 uilayer的lua文件名， 创建元素，并将元素添加到 UINode 的子节点中。
@param filename string 不带后缀的lua文件名 
--]]
function UINode:setUI(filename)
	
	if not self._language then
		local langPath = CCFileUtils:sharedFileUtils():fullPathForFilename("uilayer/zh_cn.lua")
		self._language = require(langPath)
	end
	
	local tablePath = CCFileUtils:sharedFileUtils():fullPathForFilename("uilayer/" .. filename .. ".lua")
	local uiTable = require(tablePath)
		
	print("name:", tablePath)
	
	for i,v in ipairs(uiTable) do
		self:createElement(v, filename)
	end
end

--[[
@brief 获取 uiType 类型
@param textType int
@return string 
]]--
local function getTUITypeString(uiType)
	local t = {
	[UI_BASE]="UI_BASE",
	[UI_TEXT]="UI_TEXT",
	[UI_BUTTON]="UI_BUTTON",
	[UI_UISCROLLVIEW]="UI_UISCROLLVIEW",
	[UI_DRAWABLE]="UI_DRAWABLE",
	[UI_UIEDIT]="UI_UIEDIT",
	[UI_UISCROLL]="UI_UISCROLL",
	[UI_ANIMATION]="UI_ANIMATION",
	[UI_UISCROLL_BAR]="UI_UISCROLL_BAR",
	[UI_TREE]="UI_TREE",
	[UI_PROGRESS_BAR]="UI_PROGRESS_BAR",
	};
	if t[uiType] then 
		return t[uiType]
	else
		return uiType
	end
end

--[[
@brief 获取 textype 类型
@param textType int
@return string 
]]--
local function geteTextTypeString(textType)
	local t = {
	[eTextType_MsFont]="eTextType_MsFont",
	[eTextType_Button]="eTextType_Button",
	[eTextType_Title]="eTextType_Title",
	[eTextType_Propetry]="eTextType_Propetry",
	[eTextType_Num]="eTextType_Num",
	};
	if t[textType] then 
		return t[textType]
	else
		return textType
	end
end

--[[
@brief 根据一个 elementInfo 来创建一个节点，并添加到 UINode 的子节点中
@param elementInfo 
elementInfo 类型信息:
	-- string cName;
	-- int x;
	-- int y;
	-- int width;
	-- int height;
	-- short type;
	-- short tag;
	-- short isEnlarge;		//是否扩大点击范围
	-- short isSTensile;  //是否支持拉伸
	-- short textType;
	-- int align;
	-- string picName;
	-- string text;
	
	-- align%3 : 0:left 1center 2 right
	-- align/3 : 0:top 1center 2 bottom
	
	-- 	enum TUIType
	-- {
	-- 	UI_BASE,
	-- 	UI_TEXT,
	-- 	UI_BUTTON,
	-- 	UI_UISCROLLVIEW,
	-- 	UI_DRAWABLE,
	-- 	UI_UIEDIT,
	-- 	UI_UISCROLL,
	-- 	UI_ANIMATION,
	-- 	UI_UISCROLL_BAR,
	-- 	UI_TREE,
	-- };


	-- enum	eTextType
	-- {
	-- 	eTextType_MsFont,
	-- 	eTextType_Button,
	-- 	eTextType_Title,
	-- 	eTextType_Propetry,

	-- 	eTextType_Num
	-- };
	
--]]

function UINode:createElement(elementInfo, filename)
	print( "createElement:", elementInfo.type )
	--[[
	print(elementInfo.cName, string.format("(%d,%d w:%d h:%d)", elementInfo.x, elementInfo.y, elementInfo.width, elementInfo.height), 
		"type:", getTUITypeString(elementInfo.type), elementInfo.picName, "textType:", geteTextTypeString(elementInfo.textType),
			elementInfo.text);
	--]]
	local elePath = elementInfo.picName;
	print("															fontColor:", elementInfo.fontColor)
	-- all pictures in frame
	if string.byte(elePath) ~= 35 then
		elePath = "#" .. elePath
	end
	print (elePath)
	
	local idx = #self._uiList + 1
	
	local pos = ccp(elementInfo.x, elementInfo.y) --tococos2d(elementInfo.x, elementInfo.y, elementInfo.width, elementInfo.height)
	print("Rect:", pos.x, pos.y, elementInfo.width, elementInfo.height)
	local textAlign = alignConvert(elementInfo.align)
	local size = nil
	if elementInfo.width and elementInfo.height then
		size = CCSize(elementInfo.width, elementInfo.height)
	end
	
	local text = self:_getTextString(elementInfo.text, filename)

	local fontColor = nil
	if elementInfo.fontColor then
		fontColor = ccc3(elementInfo.fontColor%256, (elementInfo.fontColor/256)%256, (elementInfo.fontColor/(256*256))%256)
	end
	
	if elementInfo.type == UI_TEXT then
		----[[

		
		self._uiList[idx] = UIImage.new(elePath, size, elementInfo.isSTensile)
		--setText(text, fontSize, fontName, fontColor, align, valign)
		self._uiList[idx]:setText(text, elementInfo.fontSize, elementInfo.fontName, fontColor, textAlign.horizontalAliment, textAlign.verticalAlignment)
		self._uiList[idx]:setPosition(pos)
		---]]--
	--[[
		local RichText = require("uiLib.component.text.RichText")
		self._uiList[idx] = RichText.new(elementInfo.width, elementInfo.height, 18, ccc3(255,0,0), 0, RichText.ALIGN_CENTER)
		self._uiList[idx]:addString(text ) -- .. "<img src=" .. elePath .. "></img>"
		self._uiList[idx]:setPosition(pos)
		]]--
	end
	
	if elementInfo.type == UI_BUTTON then
		local buttonDown = elePath
		local buttonDisabled = elePath
		if elementInfo.button then
			if elementInfo.button.imageDown then
				buttonDown = '#' .. elementInfo.button.imageDown
			end
			if elementInfo.button.imageDisabled then
				buttonDisabled = '#' .. elementInfo.button.imageDisabled
			end
		end
		
		self._uiList[idx] = UIButton.new({elePath, buttonDown,  buttonDisabled}, self._priority, self._swallowTouches )

		self._uiList[idx]:setSize(size, elementInfo.isSTensile)
		if text and text ~= "" then
			self._uiList[idx]:setText(text, elementInfo.fontSize, elementInfo.fontName, fontColor, textAlign.horizontalAliment, textAlign.verticalAlignment)
		end
		self._uiList[idx]:setEnlarge(elementInfo.isEnlarge)
		
		self._uiList[idx]:setPosition(pos)
	end
	
	if elementInfo.type == UI_UISCROLLVIEW then
		self._uiList[idx] = ScrollList.new(ScrollView.HORIZONTAL, elementInfo.width, elementInfo.height)
		self._uiList[idx]:_setContainerPos(pos)
	end	
	
	if elementInfo.type == UI_DRAWABLE then
		-- no this component
	end
	
	if elementInfo.type == UI_UIEDIT then
		self._uiList[idx] =  ui.newEditBox({image = elePath, size=size})
		self._uiList[idx]:setText(text)
		self._uiList[idx]:setPosition(pos)
	end
	
	if elementInfo.type == UI_UISCROLL then
		
		self._uiList[idx] = ScrollView.new(ScrollView.HORIZONTAL, elementInfo.width, elementInfo.height)
		self._uiList[idx]:_setContainerPos(pos)
	end
	
	if elementInfo.type == UI_ANIMATION then
		-- no this component
	end
	
	if elementInfo.type == UI_UISCROLL_BAR then
		self._uiList[idx] = ScrollView.new(ScrollView.HORIZONTAL, elementInfo.width, elementInfo.height)
		self._uiList[idx]:_setContainerPos(pos)
	end

	if elementInfo.type == UI_TREE then
		-- no this component
	end

	if not UI_PROGRESS_BAR then
		UI_PROGRESS_BAR = 10
	end
	
	if elementInfo.type == UI_PROGRESS_BAR then
		local barInfo = elementInfo.progressBar
		self._uiList[idx] = UIProgressBar.new('#' .. barInfo.barImage, elePath, CCSize(barInfo.width, barInfo.height), size, ccp(barInfo.x, barInfo.y))
		self._uiList[idx]:setText(text, elementInfo.fontSize, elementInfo.fontName, fontColor, textAlign.horizontalAliment, textAlign.verticalAlignment)
		self._uiList[idx]:setPosition(pos)
	end
	
	if elementInfo.type == UI_BASE or not self._uiList[idx] then
		self._uiList[idx] = UIImage.new(elePath, size, elementInfo.isSTensile)
		self._uiList[idx]:setText(text, elementInfo.fontSize, elementInfo.fontName, fontColor, textAlign.horizontalAliment, textAlign.verticalAlignment)	
		self._uiList[idx]:setPosition(pos)
	end
	
	self._uiList[idx].__cName = elementInfo.cName;
	self._uiList[idx]:setAnchorPoint(ccp(0, 0))
	self:addChild(self._uiList[idx])
end

--[[
@brief 通过名字获取节点。
@param name string 节点的名字。
@return CCNode 如果能够找到对应名字的节点，返回节点。否则返回nil。
--]]
function UINode:getNodeByName(name)
	if not name then 
		return nil
	end
	
	for i=1, #self._uiList do
		if self._uiList[i] and (type(name) == type(self._uiList[i].__cName)) and name == self._uiList[i].__cName then
			return self._uiList[i]
		end
	end
	return nil
end

--[[
@brief 通过名字移除节点。
@param name string 节点的名字。
@return int 返回移除节点的个数。
--]]
function UINode:removeNodeByName(name)
	local cnt = 0
	for i,elem in ipairs(self._uiList)  do
		if self._uiList[i] and (type(name) == type(self._uiList[i].__cName)) and name == self._uiList[i].__cName then
			self:removeNode(self._uiList[i])
			self._uiList[i]:dispose()
			table.remove(self._uiList, i)
			cnt = cnt + 1
		end
	end
	
	return cnt
end

--[[
@brief 将 UINode 恢复到初始状态。
]]--
function UINode:reset()
	self:removeAllChildren()
	for i=1, #self._uiList do
		if self._uiList[i] then
			self._uiList[i]:dispose()
			self._uiList[i] = nil
		end
	end
	self._language = nil;
end

function UINode:dispose()
	self:reset()
	self._uiList = nil
end


return UINode




