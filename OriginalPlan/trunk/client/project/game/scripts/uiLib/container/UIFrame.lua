--[[--
class：     UIFrame
inherit: 	CCNode
desc：      背景边框
author:  changao
date: 2014-06-30
--]]

local UIFrame = class("UIFrame", function (type, width, height) return display.newNode() end)
local UIFrameTmp = {}
--[[--
@FrameCfg 
@brief Frame的配置
@测试用。 正式使用待迁移
@ left-bottom-corner com_bk_1.png v-com_bk_2.png h-com_bk_5.png left-top-corner-com_bk_3.png 
--]]
local FrameCfg = 
{
[0]={left={image="#com_bk_2.png"}, right={image="#com_bk_2.png", rotate=180}, top={image="#com_bk_4.png", corner={[1]={image="#com_bk_3.png"}, [2]={image="#com_bk_3.png", rotate=180}}}, bottom={image="#com_bk_5.png"}, leftBottomCorner={image="#com_bk_1.png"}, rightBottomCorner={image="#com_bk_1.png", rotate=180}},
[1]={left={image="#com_bk_2.png"}, right={image="#com_bk_2.png", rotateY=180}, top={image="#com_bk_5.png", rotateX=180}, bottom={image="#com_bk_5.png"}, 
	leftBottomCorner={image="#com_bk_1.png"}, rightBottomCorner={image="#com_bk_1.png", rotateY=180}, leftTopCorner={image="#com_bk_1.png", rotateX=180}, rightTopCorner={image="#com_bk_1.png", rotate=180}},
[10]={left={image="#one.png"}, right={image="#one.png"}, top={image="#long.png", corner={[1]={image="#corner.png"}, [2]={image="#corner.png"}}}, bottom={image="#long.png"}},
};

local frame2Index = {
['#arena_jilu1.png'] = {corner='#com_jiao1.png', x=-2},
['#com_frame_2.png'] = {corner='#com_jiao1.png', x=1},
['#com_zidiban.png'] = {corner='#com_jiao1.png', x=1},
['#renwu_diban.png'] = {corner='#com_jiao1.png', x=-1},
['#com_renwu_diban.png'] = {corner='#com_jiao1.png', x=-1},
['#yb_diban.png'] = {corner='#com_jiao1.png', x=-1},
['#yb_diban.png'] = {corner='#com_jiao1.png', x=-1},

['#boss_di.png'] = {corner='#hero_diban2.png', x=-2},
['#boss_di2.png'] = {corner='#hero_diban2.png', x=-3},
['#com_frame_3.png'] = {corner='#hero_diban2.png', x=-3},
['#hero_diban.png'] = {corner='#hero_diban2.png', x=-3},
}


function UIFrame:ctor(ttype, width, height, picName)
--	print('function UIFrame:ctor(ttype, width, height)')
	self:init()
	
	self._src = picName
	self._container = display.newNode()
	self:addChild(self._container)
	
	if width and height then
		self._size = CCSize(width, height)
	end
	
	self:initFrame(ttype, width, height)
	
	self:setContentSize(self._size)
	self:retain()
	--setClipRect()
end

function UIFrame:getContentSize()
	return self._size
end

function UIFrame.setCenter(node, x, y)
	local anchor = node:getAnchorPoint()
	local size = node:getContentSize()
	local w = size.width * (anchor.x - 0.5)
	local h = size.height * (anchor.y - 0.5)
	--print("_layoutSetCenter(", x + w, y + h, ")  anchor(", anchor.x, anchor.y, ")  w:", size.width, " h:", size.height)
	node:setPosition(ccp(x + w, y + h))
end

function UIFrame:init()
	if UIFrameTmp.setAliasTexParameters then
		return
	end
--	print('function UIFrame:init() begin')
	--XUtil:setAliasTexParameters("ui/jag/jag.pvr.ccz")
--	print('function UIFrame:init() end')
	UIFrameTmp.setAliasTexParameters = true
end

function UIFrame:initFrame(ttype, width, height)
--	print('function UIFrame:initFrame(ttype)', ttype)
	self._type = ttype
	local callfunc = self['initFrame' .. ttype]
	
	callfunc(self, width, height)
end

function UIFrame:initFrame0()
end

function UIFrame:uninitFrame1()
	for i,node in ipairs(self._frame1Nodes) do
		if node.dispose then
			node:dispose()
		else
			node:removeFromParent()
		end
	end
	self._frame1Nodes = {}
end

function UIFrame:initFrame1()
--	print('function UIFrame:initFrame1()')
	local minWidth = 176
	local minHeight = 176
	local squareUnit = 52
	--52,72,52 square
	assert(minWidth < self._size.width)
	assert(minHeight < self._size.height)
	local tiles = {'#com_dj1.png', '#com_bian2.png', '#com_dj2.png',
				'#com_bian1.png', '#com_zhong.png', '#com_bian3.png',
				'#com_dj3.png', '#com_bian4.png', '#com_dj4.png',}
	
	local top = MiddleTile.new(CCSize(self._size.width, squareUnit), tiles[1], tiles[2], tiles[3])
	local bottom = MiddleTile.new(CCSize(self._size.width, squareUnit), tiles[7], tiles[8], tiles[9])
	local left = display.newXTileSprite(tiles[4], CCSize(squareUnit, self._size.height-squareUnit-squareUnit))
	local right = display.newXTileSprite(tiles[6], CCSize(squareUnit, self._size.height-squareUnit-squareUnit))
	local center = display.newXTileSprite(tiles[5], CCSize(self._size.width-squareUnit-squareUnit+2, self._size.height-squareUnit-squareUnit+2))
	local nodes = {top,bottom,left,right,center}
	self._frame1Nodes = nodes
	for i,node in ipairs(nodes) do
		self._container:addChild(node)
		node:setAnchorPoint(ccp(0,0))
	end
	
	top:setPosition(ccp(0,self._size.height-squareUnit))
	bottom:setPosition(ccp(0,0))
	left:setPosition(ccp(0,squareUnit))
	right:setPosition(ccp(self._size.width-squareUnit,squareUnit))
	center:setPosition(ccp(squareUnit-1,squareUnit-1))
end

function UIFrame:uninitFrame2()
	for i,node in ipairs(self._frame2Nodes) do
		if node.dispose then
			node:dispose()
		else
			node:removeFromParent()
		end
	end
	self._frame2Nodes = {}
end

function UIFrame:setImageSize(siz)
--	print("function UIFrame:setImageSize(siz)", siz.width, siz.height, self._type)
	if self._size:equals(siz) then
		return
	end
	
	if self._type == 1 then
		self:uninitFrame1()
		self._size = siz
		self:initFrame1()
	else
		self._size = siz
	end
	self:setContentSize(siz)
end

function UIFrame:initFrame2(width, height)
	local cfg = frame2Index[self._src]
	
	local imgLeft = UIImage.new(self._src)
	local imgRight = UIImage.new(self._src)
	local siz = imgLeft:getContentSize()

--[[-- unuse the corner
	if cfg then
		local corner = cfg.corner or '#com_jiao1.png'
		local imgRight1 = UIImage.new(corner)
		local siz1 = imgRight1:getContentSize()
		imgRight:addChild(imgRight1)
		imgRight1:setScaleX(-1)
		imgRight1:setPosition(ccp(siz1.width+(frame2Index[self._src].x or 0),siz.height-siz1.height))
	end
--]]

	local nodes = {imgLeft, imgRight, imgRight1}
	self._frame2Nodes = nodes
	
	self._container:addChild(imgLeft)
	self._container:addChild(imgRight)
		
	imgRight:setScaleX(-1)
	imgRight:setPosition(ccp(siz.width*2-1, 0))
	
	if width and height then
		self._container:setScaleX(width/siz.width)
		self._container:setScaleY(height/siz.height)
		self._size = CCSize(width*2, siz.height)
	else
		self._size = CCSize(siz.width*2, siz.height)
	end
	
end

function UIFrame:uninitFrame3()
--[[
	for i,node in ipairs(self._frame3Nodes) do
		if node.dispose then
			node:dispose()
		else
			node:removeFromParent()
		end
	end
	self._frame3Nodes = {}
--]]
	self:uninitFrame2()
end

function UIFrame:initFrame3(width, height)
	self:initFrame2(width, height)
--[[
	local cover = '#hero_diban2.png'
	local imgRight1 = UIImage.new(cover)
	local imgLeft = UIImage.new(self._src)
	local imgRight = UIImage.new(self._src)
	local siz = imgLeft:getContentSize()
	local siz1 = imgRight1:getContentSize()
	
	
	imgRight:addChild(imgRight1)
	imgRight1:setScaleX(-1)
	imgRight1:setPosition(ccp(siz1.width,siz.height-siz1.height))
	
	local nodes = {imgLeft, imgRight1, imgRight}
	self._frame3Nodes = nodes
	
	self._container:addChild(imgLeft)
	self._container:addChild(imgRight)
		
	imgRight:setScaleX(-1)
	imgRight:setPosition(ccp(siz.width*2, 0))
	self._size = CCSize(siz.width*2, siz.height)
	--]]
end

function UIFrame:initFrame4(width, height)
	local chainSrc = "#com_biaoti1.png"
	local titleSrc = "#com_biaotikuang.png"
	local chain1,chain2 = display.newXSprite(chainSrc), display.newXSprite(chainSrc)
	local title = display.newXSprite(titleSrc)
	local nodes = {chain1, chain2, title}
	local anchors = {ccp(1,0), ccp(1,0), ccp(0.5, 0)}
	local offset = {ccp(0,11), ccp(width, 11), ccp(width/2, 0)}
	chain1:setScaleX(-1)
	for i,node in ipairs(nodes) do
		self._container:addChild(node)
		node:setAnchorPoint(anchors[i])
		node:setPosition(offset[i])
	end
end
--[=====[
function UIFrame:initFrame0()
	local frame = FrameCfg[0]
	self._border = {}
	
	self._borderInfo = {}

	for k,v in pairs(frame) do
		--print("k=", k, " v=", v, "image", frame[k].image)
		self._border[k] = display.newXSprite()
		self._container:addChild(self._border[k])
		
		self._border[k]:setSpriteImage(frame[k].image)
		self._border[k]:setAnchorPoint(ccp(0, 0))
		if frame[k].rotate then
			self._border[k]:setRotationY(frame[k].rotate)
		end
		self._borderInfo[k] = {}
		self._borderInfo[k].size = self._border[k]:getContentSize()
		self._border[k].corner = {}
		self._borderInfo[k].cornerSize = {}

		if v.corner then
			if v.corner[1] then
				self._border[k].corner[1] = display.newXSprite(v.corner[1].image)
				self._container:addChild(self._border[k].corner[1])
				self._border[k].corner[1]:setAnchorPoint(ccp(0, 0))
				if v.corner[1].rotate then
					self._border[k].corner[1]:setRotationY(v.corner[1].rotate)
				end
				self._borderInfo[k].cornerSize[1] = self._border[k].corner[1]:getContentSize()
			end

			if v.corner[2] then
				self._border[k].corner[2] = display.newXSprite(v.corner[2].image)
				self._container:addChild(self._border[k].corner[2])
				self._border[k].corner[2]:setAnchorPoint(ccp(0, 0))
				if v.corner[2].rotate then
					self._border[k].corner[2]:setRotationY(v.corner[2].rotate)
				end
				self._borderInfo[k].cornerSize[2] = self._border[k].corner[2]:getContentSize()
			end
		end

	end

	self._container:setContentSize(self._size)
	self._container:setAnchorPoint(ccp(0, 0))

	self._border.leftBottomCorner:setPosition(0, 0)
	self._border.rightBottomCorner:setPosition(self._size.width, 0)
	
	local leftBottomCornerWidth, leftBottomCornerHeight = self._borderInfo.leftBottomCorner.size.width, self._borderInfo.leftBottomCorner.size.height
	local rightBottomCornerWidth, rightBottomCornerHeight = self._borderInfo.rightBottomCorner.size.width, self._borderInfo.rightBottomCorner.size.height

	local vTopPad = 9
	local vTopPadHeight = 45
	
	local x,y,w,h,px,py
	
	-- left
	w = self._borderInfo.left.size.width
	h = self._size.height - vTopPadHeight
	
	h = h - leftBottomCornerHeight - self._borderInfo.top.size.height
	
	x = 0
	y = (self._borderInfo.left.size.height - h)/2

	self._border.left:setClipRect(CCRect(x, y, w, h))
	
	px = 0
	py = leftBottomCornerHeight

	self._border.left:setPosition(px, py)
	
	
	-- right
	w = self._borderInfo.right.size.width
	h = self._size.height - vTopPadHeight
	
	h = h - rightBottomCornerHeight - self._borderInfo.top.size.height
	
	x = 0
	y = (self._borderInfo.right.size.height - h)/2
	
	self._border.right:setClipRect(CCRect(x, y, w, h))
	
	px = self._size.width
	py = leftBottomCornerHeight

	self._border.right:setPosition(px, py)
	
	
	
	-- top
	w = self._size.width + vTopPad + vTopPad
	h = self._borderInfo.top.size.height
	
	w = w - self._borderInfo.top.cornerSize[1].width - self._borderInfo.top.cornerSize[2].width
	
	x = (self._borderInfo.top.size.width - w)/2
	y = 0
	
	self._border.top:setClipRect(CCRect(x, y, w, h))
	
	px = 0
	py = self._size.height - h
	
	self._border.top.corner[1]:setPosition(px - vTopPad, py - vTopPadHeight)

	self._border.top.corner[2]:setPosition(self._size.width + vTopPad, py - vTopPadHeight)
	
	px = self._borderInfo.top.cornerSize[1].width - vTopPad
	self._border.top:setPosition(px, py)
	
	
	
	-- bottom
	w = self._size.width - leftBottomCornerWidth - rightBottomCornerWidth
	h = self._borderInfo.bottom.size.height
	
	x = (self._borderInfo.bottom.size.width - w)/2
	y = 0
	
	self._border.bottom:setClipRect(CCRect(x, y, w, h))

	px = leftBottomCornerWidth
	py = 0

	self._border.bottom:setPosition(px, py)
end

function UIFrame:initFrame1()
	local frame = FrameCfg[1]
	self._border = {}
	
	self._borderInfo = {}

	for k,v in pairs(frame) do
		--print("k=", k, " v=", v, "image", frame[k].image)
		self._border[k] = display.newXSprite()
		self._container:addChild(self._border[k])
		
		self._border[k]:setSpriteImage(frame[k].image)
		self._border[k]:setAnchorPoint(ccp(0, 0))
		if frame[k].rotateX then
			self._border[k]:setRotationX(frame[k].rotateX)
		end
		
		if frame[k].rotateY then
			self._border[k]:setRotationY(frame[k].rotateY)
		end
		
		if frame[k].rotate then
			self._border[k]:setRotation(frame[k].rotate)
		end
		
		self._borderInfo[k] = {}
		self._borderInfo[k].size = self._border[k]:getContentSize()
	end

	self._container:setContentSize(self._size)
	self._container:setAnchorPoint(ccp(0, 0))

	self._border.leftBottomCorner:setPosition(0, 0)
	self._border.rightBottomCorner:setPosition(self._size.width, 0)
	self._border.leftTopCorner:setPosition(0, self._size.height)
	self._border.rightTopCorner:setPosition(self._size.width, self._size.height)
	
	local leftBottomCornerWidth, leftBottomCornerHeight = self._borderInfo.leftBottomCorner.size.width, self._borderInfo.leftBottomCorner.size.height
	local rightBottomCornerWidth, rightBottomCornerHeight = self._borderInfo.rightBottomCorner.size.width, self._borderInfo.rightBottomCorner.size.height
	local leftTopCornerWidth, leftTopCornerHeight = self._borderInfo.leftTopCorner.size.width, self._borderInfo.leftTopCorner.size.height
	local rightTopCornerWidth, rightTopCornerHeight = self._borderInfo.rightTopCorner.size.width, self._borderInfo.rightTopCorner.size.height
	
	
	local x,y,w,h,px,py
	
	-- left
	w = self._borderInfo.left.size.width
	h = self._size.height
	
	h = h - leftBottomCornerHeight - leftTopCornerHeight
	
	x = 0
	y = (self._borderInfo.left.size.height - h)/2

	self._border.left:setClipRect(CCRect(x, y, w, h))
	
	px = 0
	py = leftBottomCornerHeight

	self._border.left:setPosition(px, py)
	
	
	-- right
	w = self._borderInfo.right.size.width
	h = self._size.height
	
	h = h - rightBottomCornerHeight - rightTopCornerHeight
	
	x = 0
	y = (self._borderInfo.right.size.height - h)/2
	
	self._border.right:setClipRect(CCRect(x, y, w, h))
	
	px = self._size.width
	py = rightBottomCornerHeight

	self._border.right:setPosition(px, py)
	
	
	
	-- top
	w = self._size.width
	h = self._borderInfo.top.size.height
	
	w = w - leftTopCornerWidth - rightTopCornerWidth
	
	x = (self._borderInfo.top.size.width - w)/2
	y = 0
	
	self._border.top:setClipRect(CCRect(x, y, w, h))
	
	
	px = leftTopCornerWidth
	py = self._size.height
	
	self._border.top:setPosition(px, py)
	
	
	
	-- bottom
	w = self._size.width - leftBottomCornerWidth - rightBottomCornerWidth
	h = self._borderInfo.bottom.size.height
	
	x = (self._borderInfo.bottom.size.width - w)/2
	y = 0
	
	self._border.bottom:setClipRect(CCRect(x, y, w, h))

	px = leftBottomCornerWidth
	py = 0

	self._border.bottom:setPosition(px, py)
end

function UIFrame:initFrame10()
	local frame = FrameCfg[10]
	self._border = {left = display.newXSprite(), right = display.newXSprite(), 
		top = display.newXSprite(), bottom = display.newXSprite()};
	
	self._borderInfo = {left={}, right={}, top={}, bottom={}}
	
	self._container:addChild(self._border.left)
	self._container:addChild(self._border.right)
	self._container:addChild(self._border.top)
	self._container:addChild(self._border.bottom)

	for k,v in pairs(frame) do
		--print("k=", k, " v=", v, "image", frame[k].image)
		self._border[k]:setSpriteImage(frame[k].image)
		self._borderInfo[k].size = self._border[k]:getContentSize()
		self._border[k].corner = {}
		self._borderInfo[k].cornerSize = {}
		if v.corner then

			if v.corner[1] then
				self._border[k].corner[1] = display.newXSprite(v.corner[1].image)
				self._container:addChild(self._border[k].corner[1])
				
				self._borderInfo[k].cornerSize[1] = self._border[k].corner[1]:getContentSize()
				
			end
			if v.corner[2] then
				self._border[k].corner[2] = display.newXSprite(v.corner[2].image)
				self._container:addChild(self._border[k].corner[2])
				
				self._borderInfo[k].cornerSize[2] = self._border[k].corner[2]:getContentSize()
			end
		end
	end
	
	self._size = CCSize(width, height)
	self._container:setContentSize(self._size)
	
	local x,y,w,h,px,py
	
	-- left
	w = self._borderInfo.left.size.width
	h = self._size.height
	
	if (self._borderInfo.left.cornerSize[1]) then h = h - self._borderInfo.left.cornerSize[1].height end
	if (self._borderInfo.left.cornerSize[2]) then h = h - self._borderInfo.left.cornerSize[2].height end
	
	x = 0
	y = (self._borderInfo.left.size.height - h)/2

	self._border.left:setClipRect(CCRect(x, y, w, h))
	
	px = w/2
	py = self._size.height
	if self._border.left.corner[1] then
		self.setCenter(self._border.left.corner[1], w - self._borderInfo.left.cornerSize[1].width/2, self._size.height - self._borderInfo.left.cornerSize[1].height/2)
		py = py - self._borderInfo.left.cornerSize[1].height
	end
	if self._border.left.corner[2] then
		self.setCenter(self._border.left.corner[2], w - self._borderInfo.left.cornerSize[1].width/2, self._borderInfo.left.cornerSize[2].height/2)
	end
	self.setCenter(self._border.left, px, py - h/2)
	
	
	
	-- right
	w = self._borderInfo.right.size.width
	h = self._size.height
	
	if (self._borderInfo.right.cornerSize[1]) then h = h - self._borderInfo.right.cornerSize[1].height end
	if (self._borderInfo.right.cornerSize[2]) then h = h - self._borderInfo.right.cornerSize[2].height end
	
	x = 0
	y = (self._borderInfo.right.size.height - h)/2
	
	self._border.right:setClipRect(CCRect(x, y, w, h))
	
	px = self._size.width - w/2
	py = self._size.height
	if self._border.right.corner[1] then
		self.setCenter(self._border.right.corner[1], self._size.width - w + self._borderInfo.right.cornerSize[1].width/2, self._size.height - self._borderInfo.right.cornerSize[1].height/2)
		py = py - self._borderInfo.right.cornerSize[1].height
	end
	if self._border.right.corner[2] then
		self.setCenter(self._border.right.corner[2], self._size.width - w + self._borderInfo.right.cornerSize[2].width/2, self._borderInfo.right.cornerSize[2].height/2)
	end
	self.setCenter(self._border.right, px, py - h/2)
	
	
	
	-- top
	w = self._size.width
	h = self._borderInfo.top.size.height
	
	--self._borderInfo.top.clipRect = {origin={x = 0, y = 0}, size = CCSize(self._borderInfo[k].size.width, self._borderInfo[k].size.height)}
	if (self._borderInfo.top.cornerSize[1]) then w = w - self._borderInfo.top.cornerSize[1].width end
	if (self._borderInfo.top.cornerSize[2]) then w = w - self._borderInfo.top.cornerSize[2].width end
	
	x = (self._borderInfo.top.size.width - w)/2
	y = 0
	
	self._border.top:setClipRect(CCRect(x, y, w, h))
	
	px = self._size.width
	py = self._size.height - h / 2
	if self._border.top.corner[1] then
		self.setCenter(self._border.top.corner[1], self._borderInfo.top.cornerSize[1].width/2, self._size.height - h + self._borderInfo.top.cornerSize[1].height/2)
	end
	if self._border.top.corner[2] then
		self.setCenter(self._border.top.corner[2], self._size.width - self._borderInfo.top.cornerSize[2].width/2, self._size.height - h + self._borderInfo.top.cornerSize[2].height/2)
		px = px - self._borderInfo.top.cornerSize[2].width
	end
	self.setCenter(self._border.top, px - w/2, py)
	
	
	
	-- bottom
	w = self._size.width
	h = self._borderInfo.bottom.size.height
	
	if (self._borderInfo.bottom.cornerSize[1]) then w = w - self._borderInfo.bottom.cornerSize[1].width end
	if (self._borderInfo.bottom.cornerSize[2]) then w = w - self._borderInfo.bottom.cornerSize[2].width end
	
	x = (self._borderInfo.bottom.size.width - w)/2
	y = 0
	
	self._border.bottom:setClipRect(CCRect(x, y, w, h))

	px = self._size.width
	py = h / 2
	if self._border.bottom.corner[1] then
		self.setCenter(self._border.bottom.corner[1], self._borderInfo.bottom.cornerSize[1].width/2, h - self._borderInfo.bottom.cornerSize[1].height/2)
	end
	if self._border.bottom.corner[2] then
		self.setCenter(self._border.bottom.corner[2], self._size.width - self._borderInfo.bottom.cornerSize[2].width/2, h - self._borderInfo.bottom.cornerSize[2].height/2)
		px = px - self._borderInfo.bottom.cornerSize[2].width
	end
	self.setCenter(self._border.bottom, px - w/2, py)
end
--]=====]

function UIFrame:setText(text, fontSize, fontName, fontColor, align, valign, useRTF, shadow)
--(text, fontSize, fontName, fontColor, useRTF, shadow)
	local textParent = self
	if not self._textInfo then
		self._textInfo = {fontSize=fontSize, fontName=fontName, fontColor=fontColor, align=align, valign=valign, useRTF=useRTF, shadow=shadow}
	else
		UIInfo.setTextInfo(self._textInfo, text, fontSize, fontName, fontColor, align, valign, useRTF, shadow, outline)
	end
	
	if not text or text == "" then
		if not self._text then return end
		self._text:removeFromParent()
		self._text:dispose()
		self._text = nil
		return
	end
	
	if not self._text then
		local textnode = UIAttachText.new(self._size.width, self._size.height, self._textInfo.fontSize, self._textInfo.fontName, self._textInfo.fontColor, self._textInfo.useRTF, self._textInfo.shadow)
		
		textParent:addChild(textnode)
		self._text = textnode
		
		if self._text:isRichText() then
			self._text:setAlignment(self._textInfo.align, self._textInfo.valign)
		end
		
		self._text:setText(text)
	else
		self._text:setText(text, self._textInfo.fontSize, self._textInfo.fontName, self._textInfo.fontColor)
	end
	
	-- align
	if not self._text:isRichText() then
		self._text:setAlignInParent(textParent, self:getContentSize(), self._textInfo.align, self._textInfo.valign)
	end
end

--[[
@brief 获取文字内容
@return string 返回的文字
]]--
function UIFrame:getText()
	if not self._text then
		return nil
	end
	
	return self._text:getText()
end

--[[
@brief 获取文字节点
@return string 返回的文字
]]--
function UIFrame:getTextNode()
	return self._text
end

function UIFrame:clear()

end

function UIFrame:dispose()
	self:removeFromParent()
	if self._text then
		self._text:dispose()
		self._text = nil
	end
	self._textInfo = nil
	
	if self._type and self['uninitFrame' .. self._type] then
		self['uninitFrame' .. self._type](self)
	end
	
	self._size = nil
	self._border = nil
	self._borderInfo = nil
	
	self:release()
end

 
return UIFrame