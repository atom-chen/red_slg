--[[
class：UINode
inherit：CCNode
desc：根据 UIData， 创建界面
author：changao
date: 2014-06-03
example：
	ResMgr:instance():loadPvr("ui/button.pvr.ccz");
	local uiNode = UINode.new()
	uiNode:setUI("panel") -- 无后缀的 lua ui 文件
	local node = uiNode:getNodeByName("node1")

	uiNode:removeNodeByName("node1")
	uiNode.reset()
]]--

UI_BASE = 0
UI_TEXT = 1
UI_BUTTON = 2
UI_UISCROLLVIEW = 3
UI_GRID = 4
UI_UIEDIT = 5
UI_UISCROLLLIST = 6
UI_NODE = 7
UI_UISCROLLPAGE = 8
UI_TREE = 9
UI_PROGRESS_BAR = 10
UI_FRAME = 11
UI_UISCROLLLISTEX = 12

local UINode = class("UINode", function () return display.newNode() end)
UINode.centerCoordinate = {
	{-display.cx,-display.cy,1,1},
	{0,-display.cy,1,1},
	{display.cx,-display.cy,1,1},
	{-display.cx,0,1,1},
	{0,0,1,1},
	{-display.cx,0,1,1},
	{-display.cx,display.cy,1,1},
	{0,display.cy,1,1},
	{display.cx,display.cy,1,1},
}
UINode.ltCoordinate = {}

for i,co in ipairs(UINode.centerCoordinate) do
	local ltco = {co[1]+display.cx, co[2]+display.cy, co[3], co[4]}
	table.insert(UINode.ltCoordinate, ltco)
end


--init the abbr
local uiAbbr = game_require("uiLib.container.uilayer_abbr")
local uiIndex = {}
for k,v in pairs(uiAbbr) do
	uiIndex[v] = k
end

local ui_style = ConfigMgr:requestConfig("ui_style",nil,true)

local function uirequire( filename )
	if REQUIRE_MOUDLE then
		local filePath = CCFileUtils:sharedFileUtils():fullPathForFilename("uilayer/"..filename..".lua")
        if CCFileUtils:sharedFileUtils():isFileExist(filePath) then
            filename = "uilayer/"..filename
        else
            filename = "uilayer."..filename
        end
		return require(filename)
	else
	    return require("uilayer/" .. filename)
    end
end

local function uirequireZH(filename)
	if REQUIRE_MOUDLE then
		local filePath = CCFileUtils:sharedFileUtils():fullPathForFilename("uilayer/zh_cn/"..filename.."_lang.lua")
        if CCFileUtils:sharedFileUtils():isFileExist(filePath) then
            return require("uilayer/zh_cn/" .. filename .. "_lang")
        else
            return require("uilayer.zh_cn.zh_cn_pack")
        end
	else
		return require("uilayer/zh_cn/" .. filename .. "_lang")
	end
end


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
	self:retain()
	self._priority = priority or 0
	self._swallowTouches = (swallowTouches == nil and true) or swallowTouches
	self._uiList = {}
	self.node = {}
	self._selectButtonGroup = {}
	--self._language = nil;
	self.coordinate = self.centerCoordinate
	--setmetatable(self, {--[[__index=UINode._debugGet, ]]__newindex=UINode._debugSet})
	if DEBUG == 2 then
		setmetatable(self.node, {__index=self._debugNodeGet, __newindex=self._debugNodeSet})
	end
end

function UINode:setLeftBottomCoodinate()
	self.coordinate = self.ltCoordinate
end

function UINode:convertPosition(x,y,pr)
	if not pr then
		pr = 4
	end
	pr = pr + 1
	local co = self.coordinate[pr]
	return uihelper.convertCoodinate({x,y}, co, {0,0,1,1})
end

function UINode:initGeometry(x,y,w,h)
	self._x = x or -480
	self._y = y or -320
	self._w = w or 1136
	self._h = h or 640
end

function UINode:updateGeometry(x,y,w,h)
	local dx = x-self._x
	local dy = y-self._y
	local dw = w-self._w
	local dh = h-self._h

	local c1x = self._x+self._w/2
	local c1y = self._y+self._h/2


	if dw == 0 and dh == 0 then
		if dx == 0 and dy == 0 then return end
		for i,node in ipairs(self._uiList) do
			self:move(node, dx, dy)
		end
		return
	end

	for i,node in ipairs(self._uiList) do
		local cx, cy, lbx, lby, rtx, rty = self:getNodeGeometry(node)
		local ldx, cdx, rdx = math.abs(lbx-self._x), math.abs(cx-c1x), math.abs(rtx-(self._x+self._w))
		local bdy, cdy, tdy = math.abs(lby-self._y), math.abs(cy-c1y), math.abs(rty-(self._y+self._h))

		if ldx <= cdx and ldx <= rdx then
			dx = x-self._x
		elseif cdx <= ldx and cdx <= rdx then
			dx = x+w/2-(self._x+self._w/2)
		elseif rdx <= cdx and rdx <= ldx then
			dx = x+w-(self._x+self._w)
		end

		if bdy <= cdy and bdy <= tdy then
			dy = y-self._y
		elseif cdy <= bdy and cdy <= tdy then
			dy = y+h/2-(self._y+self._h/2)
		elseif tdy <= cdy and tdy <= bdy then
			dy = y+h-(self._y+self._h)
		end
		local nx,ny = node:getPosition()
		--print(string.format("%s, dpos=(%s,%s) pos=(%s,%s) (%s %s %s %s %s %s)", node.__cName, dx, dy, nx, ny, cx, cy, lbx, lby, rtx, rty))
		--print(ldx, cdx, rdx, bdy, cdy, tdy)
		node:setPosition(nx+dx,ny+dy)
	end

	self:initGeometry(x,y,w,h)
end

function UINode:getNodeGeometry(node)
	local anchor = node:getAnchorPoint()
	local scaleX,scaleY = node:getScaleX(), node:getScaleY()
	local siz = node:getContentSize()
	local x,y = node:getPosition()
	local w,h = siz.width*scaleX,siz.height*scaleY
	local x1,y1, x2,y2=x+(0-anchor.x)*w,y+(0-anchor.y)*h, x+(1-anchor.x)*w,y+(1-anchor.y)*h
	local lx,by, rx,ty
	if x1 < x2 then
		lx = x1
		rx = x2
	else
		lx = x2
		rx = x1
	end

	if y1 < y2 then
		by = y1
		ty = y2
	else
		by = y2
		ty = y1
	end
	return x+(0.5-anchor.x)*w,y+(0.5-anchor.y)*h, lx,by, rx,ty
end

function UINode._debugGet(t, k)
	return rawget(t, k)
end

function UINode._debugSet(t, k, v)
	local v = rawget(t, k)
	if v then
		-- print("warning UINode ", k, " is already exists")
	end
	rawset(t, k, v)
end

function UINode._debugNodeGet(t, k)
	local v = rawget(t, k)
	if not v then
		-- print("warning  UINode node ", k, " is nil")
	end
	return v
end

function UINode._debugNodeSet(t, k, v)
	assert(nil, "UINode is readable, shouldnot be changed")
	--rawset(t, k, v)
end

--[[改变优先级
]]
function UINode:setPriority( priorty )
	self._priority = priority
end

function UINode:getPriority(  )
	return self._priority
end

function UINode:setNewPriority(priority)
	local p = self._priority
	if p ~= priority then
		for k,node in pairs(self.node) do
			if node.setTouchPriority then
				node:setTouchPriority(priority)
			end
		end
		self._priority = priority
	end
	return p
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
	--print ("text:", text, " filename:", name, " default:", defaultString, self._language)

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
	self:preProcess(uiData)
	for i=0, uiData.count-1 do
		local elemInfo =  uiData:getElemInfo(i)
		self:createElement( elemInfo )
	end
end

--[[
@brief 根据 uilayer的lua文件名， 创建元素，并将元素添加到 UINode 的子节点中。
@param filename string 不带后缀的lua文件名
--]]
function UINode:setUI(filename)

    local uiTable = uirequire(filename)
	--print("name:", tablePath)

	if not self._language then
		self._language = uirequireZH(filename)
	end
	self:preProcess(uiTable)
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
	[UI_GRID]="UI_GRID",
	[UI_UIEDIT]="UI_UIEDIT",
	[UI_UISCROLL]="UI_UISCROLL",
	[UI_NODE]="UI_NODE",
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

local function getScrollDirection(scrollAlign)
	if (scrollAlign == 0) then
		return kCCScrollViewDirectionHorizontal
	else
		return kCCScrollViewDirectionVertical
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
	-- 	UI_GRID,
	-- 	UI_UIEDIT,
	-- 	UI_UISCROLL,
	-- 	UI_NODE,
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

function UINode:preProcess(uiData)
	if not uiData._progress then
		for i,data in ipairs(uiData) do
			local n = {}
			for k,v in pairs(data) do
				local key = uiIndex[k]
				if key then
					n[key] = v
				else
					n[k] = v
				end
			end
			if n.data then
				local styleId = tonumber(n.data)
				if styleId then
					local styleCfg = ui_style[styleId]
					if styleCfg then
						for k,v in pairs(styleCfg.style) do
							n[k] = v
						end
					end
				end
			end
			uiData[i] = n
		end
		uiData._progress = true
	end
	return uiData
end

function UINode:toWidth(width)
	while width <= 0 do
		width = width + display.width
	end
	return width
end

function UINode:toHeight(height)
	while height <= 0 do
		height = height + display.height
	end
	return height
end

function UINode:createElement(elementInfo, filename)
	--print("createElement name:", elementInfo.cName, " type:", elementInfo.type )
	--[[
	print(elementInfo.cName, string.format("(%d,%d w:%d h:%d)", elementInfo.x, elementInfo.y, elementInfo.width, elementInfo.height),
		"type:", getTUITypeString(elementInfo.type), elementInfo.picName, "textType:", geteTextTypeString(elementInfo.textType),
			elementInfo.text);
	--]]
	local node
	local elePath = elementInfo.picName;
	local useRTF = elementInfo.useRTF
	-- all pictures in frame
	if elePath and elePath ~= "" then
		if string.byte(elePath) ~= 35 then
			elePath = "#" .. elePath
		end
	end
	--print (elePath)

	local idx = #self._uiList + 1

	local pos = ccp(self:convertPosition(elementInfo.x, elementInfo.y, elementInfo.pr)) --tococos2d(elementInfo.x, elementInfo.y, elementInfo.width, elementInfo.height)
	--print("Rect:", pos.x, pos.y, elementInfo.width, elementInfo.height)
	local textAlign = alignConvert(elementInfo.align)
	local size = nil
	if elementInfo.width and elementInfo.height then
		size = CCSize(self:toWidth(elementInfo.width), self:toHeight(elementInfo.height))
	end

	local text = self:_getTextString(elementInfo.text, filename)

	local fontColor = nil
	if elementInfo.fontColor then
		fontColor = ccc3(elementInfo.fontColor%256, (elementInfo.fontColor/256)%256, (elementInfo.fontColor/(256*256))%256)
	end

	--描边和阴影
	local shade = false
	local outline=false
	if type(elementInfo.textShade) == "number" then
		if elementInfo.textShade == 1 then
			shade = true
		elseif elementInfo.textShade >= 2 then
			outline = elementInfo.textShade - 1
		end
	end
	if elementInfo.type == UI_TEXT then

		--[[
		self._uiList[idx] = UIImage.new(elePath, size, elementInfo.isSTensile)
		--setText(text, fontSize, fontName, fontColor, align, valign)
		self._uiList[idx]:setText(text, elementInfo.fontSize, elementInfo.fontName, fontColor, textAlign.horizontalAliment, textAlign.verticalAlignment)
		self._uiList[idx]:setPosition(pos)
		---]]--
	--[[
	--RichText.ALIGN_LEFT = 1
	--RichText.ALIGN_RIGHT = 2
	--RichText.ALIGN_CENTER =3
	--	RichText.ALIGN_TOP  = 1
	--	RichText.ALIGN_BOTTOM = 2

		local richAlign = {RichText.ALIGN_LEFT, RichText.ALIGN_CENTER, RichText.ALIGN_RIGHT}
		local richVAlign = {[0]=RichText.ALIGN_TOP, [1]=RichText.ALIGN_CENTER, [2]=RichText.ALIGN_BOTTOM}
		print('------------text align ', richAlign[elementInfo.align % 3 + 1], richVAlign[math.floor(elementInfo.align/3)])
		local RichText =game_require("uiLib.component.text.RichText")
		self._uiList[idx] = RichText.new(elementInfo.width, elementInfo.height, elementInfo.fontSize or 30, fontColor, 0, richAlign[elementInfo.align % 3 + 1], richVAlign[math.floor(elementInfo.align/3)], elementInfo.textShade)
		print(elementInfo.cName, text)
		self._uiList[idx]:setText(text) -- .. "<img src=" .. elePath .. "></img>"
		self._uiList[idx]:setPosition(pos)
	--]]
		node = UIText.new(size.width, size.height, elementInfo.fontSize or 30, nil, fontColor, textAlign.horizontalAliment, textAlign.verticalAlignment, useRTF, shade, outline)
		node:setText(text)
		node:setPosition(pos)

	end

	if elementInfo.type == UI_BUTTON then
		local buttonDown = nil
		local buttonDisabled = nil
		local buttonSelected = nil
		if elementInfo.button then
			if elementInfo.button.imageDown then
				buttonDown = '#' .. elementInfo.button.imageDown
			end
			if elementInfo.button.imageDisabled then
				buttonDisabled = '#' .. elementInfo.button.imageDisabled
			end
			if elementInfo.button.imageChecked then
				buttonSelected = '#' .. elementInfo.button.imageChecked
			end
		end
		node = UIButton.new({elePath, buttonDown, buttonDisabled, buttonSelected}, self._priority, self._swallowTouches )

		node:setSize(size, elementInfo.isSTensile and elementInfo.isSTensile ~= 0)

		node:setText(text, elementInfo.fontSize, elementInfo.fontName, fontColor, textAlign.horizontalAliment, textAlign.verticalAlignment, useRTF, shade, outline)

		node:setEnlarge(elementInfo.isEnlarge and elementInfo.isEnlarge ~= 0)

		node:setPosition(pos)
		local tag = elementInfo.tag
		--node.tag = tag

		if tag and tag > 0 then
			if not self._selectButtonGroup[tag] then
				self._selectButtonGroup[tag] = UIGroup.new(self._priority)
				--print("self._selectButtonGroup[", tag, "]:add(node)         new")
			end
			self._selectButtonGroup[tag]:add(node)
			node:setGroup(self._selectButtonGroup[tag])
			--print("self._selectButtonGroup[", tag, "]:add(node)         add")
		end

		node:setAudioId(elementInfo.audio)
	end

	if elementInfo.type == UI_UISCROLLVIEW then
		local direction = getScrollDirection(elementInfo.scrollAlign)
		node = ScrollView.new(direction, size.width, size.height, self._priority-1)
		node:setPosition(pos)
	end

	if elementInfo.type == UI_UISCROLLLIST then
		local direction = getScrollDirection(elementInfo.scrollAlign)
		node = ScrollList.new(direction, size.width, size.height, self._priority-1, elementInfo.scrollMargin)
		node:setPosition(pos)
	end

	if elementInfo.type == UI_UISCROLLLISTEX then
		local direction = getScrollDirection(elementInfo.scrollAlign)
		node = ScrollListEx.new(direction, size.width, size.height, self._priority-1, elementInfo.scrollMargin)
		node:setPosition(pos)
	end

	if elementInfo.type == UI_UISCROLLPAGE then
		local direction = getScrollDirection(elementInfo.scrollAlign)
		node = ScrollPageEx.new(direction, size.width, size.height, self._priority-1, elementInfo.scrollMargin)
		node:setPosition(pos)
	end


	if elementInfo.type == UI_GRID then
		node = UIItemGrid.new(size, {elePath}, self._priority, self._swallowTouches)
		local nsiz = node:getContentSize()
		node:setPosition(pos.x+size.width-nsiz.width, pos.y+size.height-nsiz.height)
		node:setAudioId(elementInfo.audio)
	end

	if elementInfo.type == UI_UIEDIT then
        size = size or CCSize(418, 48)
		node = UIEditBox.new(elePath, size, self._priority, self._swallowTouches)
        node:setFont("",25);
	    node:setFontColor(ccc3(0,0,0));
		node:setText(text)
		node:setPosition(pos)
	end

	if elementInfo.type == UI_NODE then
		node = display.newNode();
		node:setContentSize(CCSize(size.width, size.height))
		node:setPosition(pos)
	end

	if elementInfo.type == UI_TREE then
		-- no this component
	end

	if not UI_PROGRESS_BAR then
		UI_PROGRESS_BAR = 10
	end

	if elementInfo.type == UI_PROGRESS_BAR then
		-- function UIProgressBar:ctor(barImage, bgImage, barMaxSize, bgMaxSize, position, maxProgress, priority, swallowTouches)
		local barInfo = elementInfo.progressBar
		node = UIProgressBar.new('#' .. barInfo.barImage, elePath, CCSize(self:toWidth(barInfo.width), self:toHeight(barInfo.height)), size, ccp(barInfo.x, barInfo.y), nil, self._priority, self._swallowTouches)
		node:setText(text, elementInfo.fontSize, elementInfo.fontName, fontColor, textAlign.horizontalAliment, textAlign.verticalAlignment, useRTF, shade, outline)

		node:setPosition(pos)
		node:setAudioId(elementInfo.audio)
	end
	--print('elementInfo.type == UI_FRAME', elementInfo.frameType, elementInfo.width, elementInfo.height)
	if elementInfo.type == UI_FRAME then
		local frameType = elementInfo.frameType
		node = UIFrame.new(frameType, size.width, size.height, elePath)
		node:setText(text, elementInfo.fontSize, elementInfo.fontName, fontColor, textAlign.horizontalAliment, textAlign.verticalAlignment, useRTF, shade, outline)
		node:setPosition(pos)
	end

	if elementInfo.type == UI_BASE or not node then
		local data = elementInfo.data
		if data and data:byte(1) == string.byte('&') then
			local src = data:sub(2)
			node = UIClipImage.new(elePath, src)
		else
			node = UIImage.new(elePath, size, elementInfo.isSTensile)
		end
		node:setText(text, elementInfo.fontSize, elementInfo.fontName, fontColor, textAlign.horizontalAliment, textAlign.verticalAlignment, useRTF, shade, outline)
		node:setPosition(pos)
	end

	if not size then
		size = node:getContentSize()
	end
	if elementInfo.scaleX and elementInfo.scaleX == elementInfo.scaleY then
		node:setScale(elementInfo.scaleX)
		if elementInfo.scaleX < 0 then
			local p = ccp(pos.x-elementInfo.scaleX*size.width, pos.y-elementInfo.scaleY*size.height)
			node:setPosition(p)
		end
	elseif elementInfo.scaleX and elementInfo.scaleY then
		node:setScaleX(elementInfo.scaleX)
		node:setScaleY(elementInfo.scaleY)
		if elementInfo.scaleX < 0 then
			local nx = pos.x-elementInfo.scaleX*size.width
			node:setPositionX(nx)
		end

		if elementInfo.scaleY < 0 then
			local ny = pos.y-elementInfo.scaleY*size.height
			node:setPositionY(ny)
		end
	elseif elementInfo.scaleX then
		node:setScaleX(elementInfo.scaleX)
		if elementInfo.scaleX < 0 then
			local nx = pos.x-elementInfo.scaleX*size.width
			node:setPositionX(nx)
		end
	elseif elementInfo.scaleY then
		node:setScaleY(elementInfo.scaleY)
		if elementInfo.scaleY < 0 then
			local ny = pos.y-elementInfo.scaleY*size.height
			node:setPositionY(ny)
		end
	end

	node.__cName = elementInfo.cName;
	local anchor = self:getAnchor(elementInfo.anchor)
	node:setAnchorPoint(anchor)
	-- print("UINode", elementInfo.cName, elementInfo.anchor, anchor.x, anchor.y)
	self:addChild(node)
	--self.node[elementInfo.cName] = self._uiList[idx]
	self._uiList[idx] = node
	rawset(self.node, elementInfo.cName, node)
end

function UINode:getAnchor(eanchor)
	if not eanchor or eanchor < 0 or eanchor > 8 then
		return ccp(0,0)
	end

	local y = eanchor%3
	local x = math.floor(eanchor/3)
	while x >= 3 do
		x = math.floor(x/3)
	end
	return ccp(x/2,y/2)
end


function UINode:addNodeWithName(node, name, zindex)
	if self:existNode(name) then
		print("function UINode:addNodeWithName(node, name): error node name exists", name)
	end
	local idx = #self._uiList
	self._uiList[idx] = node
	if zindex then
		self:addChild(node, zindex)
	else
		self:addChild(node)
	end
	self._uiList[idx].__cName = name
	rawset(self.node, name, node)
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
	--[[
	for i=1, #self._uiList do
		if self._uiList[i] and (type(name) == type(self._uiList[i].__cName)) and name == self._uiList[i].__cName then
			return self._uiList[i]
		end
	end
	return nil
	--]]
	return self.node[name]
end

function UINode:getNodeByIndex(index)
	return self._uiList[index]
end

function UINode:setGray(flag)
	if true == flag then
		for _,v in pairs(self.node) do
			ShaderMgr:setColor(v)
		end
	else
		for _,v in pairs(self.node) do
			ShaderMgr:removeColor(v)
		end
	end
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
			rawset(self.node, name, nil)
		end
	end

	return cnt
end

function UINode:existNode(name)
	if name == nil then return false end
	--[[
	for i,elem in ipairs(self._uiList)  do
		if self._uiList[i] and (type(name) == type(self._uiList[i].__cName)) and name == self._uiList[i].__cName then
			return true
		end
	end
	return false
	--]]
	return self.node[name]
end

--[[
@brief 通过tag获得该值为该 tag 的所有UIButton
@return UIGroup
--]]
function UINode:getGroupByTag(tag)
	return self._selectButtonGroup[tag]
end

function UINode:setOpacity(opacity)
	for i,node in pairs(self._uiList) do
		if node.setOpacity then
			node:setOpacity(opacity)
		end
	end
end

--[[
@brief 将 UINode 恢复到初始状态。
]]--
function UINode:reset()
	for k,v in pairs(self._selectButtonGroup) do
		v:dispose()
	end
	self._selectButtonGroup = {}
	for i=1, #self._uiList do
		if self._uiList[i] then
			if self._uiList[i].dispose then
				self._uiList[i]:dispose()
			end
			self._uiList[i] = nil
		end
	end
	self._uiList = {}
	self._language = nil;

	-- remove
	for k,v in pairs(self.node) do
		rawset(self.node, k, nil)
	end

end

function UINode:dispose()
	self:removeFromParent()
	self:reset()
	self._uiList = nil
	self._selectButtonGroup = nil
	self:release()
end

return UINode