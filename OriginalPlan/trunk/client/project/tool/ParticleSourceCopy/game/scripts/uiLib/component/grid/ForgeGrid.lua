--[[--
	desc: 打造界面的格子
		加底框图片，显示名字品质颜色，数量/总数量，不可打造时带遮罩
	name: ForgeGrid
	author: linchm
	version: 20131219

	example:

]]

local ForgeGrid = class("ForgeGrid", ItemGrid)

ForgeGrid.TYPE_FORGE_GRID 	= 1
ForgeGrid.TYPE_ITEM_GRID	= 2

ForgeGrid.SOUL_BG = "#grid_soulBg.png"

function ForgeGrid:ctor(w, h)
	ForgeGrid.super.ctor(self, w, h)
	self._bottomSoulBg = display.newSprite()
	self._bottomSoulBg:setAnchorPoint(ccp(0.5,0.5))
	self._bottomSoulBg:setPosition(self._offsetX, self._offsetY - 13)
	self._bottomSoulBg:retain()

	self._colorLayer = nil
end
--[[
	返回数量是否足够
]]
function ForgeGrid:isEough()
	if (not self._num) and (not self._totalNum) then 
		return
	end
	if toint(self._num) < toint(self._totalNum) then
		return false
	end
	return true 
end

--[[--
	设置数量
	@param totalNum int
	@param num 	int
]]
function ForgeGrid:setNum(totalNum, num)
	self._totalNum = totalNum
	self._num = num
	self:_createNumText()
	
	local text = tostring(totalNum)
	if num then
		if toint(num) < toint(totalNum) then
			text = "<font color=rgb(255,0,0)>" ..tostring(num) .. "</font>/" .. text 
		else
			text = tostring(num) .. "/" .. text
		end
	end

	self._numText:setString(text)
	local width, height = self._numText:getTextContentSize()
	self._numText:setPosition(ItemGrid.DEFAULT_WIDTH - width - 10, height + 5)
end

--[[--
	设置打造物品id
	@param itemId num
	@param hasBg boolean 是否显示名字的底框
]]
function ForgeGrid:setForgeItem(itemId, hasBg)
	if hasBg == nil then
	 	hasBg = true
	end

	self:setItem(itemId)
	local itemCfg = ItemCfg.getCfg(itemId)
	local str = tostring(itemCfg.name)

	self:setBottomStr(str, hasBg)

	local color = GameConst.Q_COLORS[(itemCfg.quality or 0)+1]
	self:setBottomStrColor(color)
end

--[[--
	
]]
function ForgeGrid:setSoulBg()
	local imageUrl = ForgeGrid.SOUL_BG
	if string.byte(imageUrl) ~= 35 then   --单个图片
		IconResMgr.prepare(imageUrl)
		display.setDisplaySingleImage(self._bottomSoulBg,imageUrl)
	else   --SpriteFrame
		local frame = display.newSpriteFrame(string.sub(imageUrl,2))
		self._bottomSoulBg:setDisplayFrame(frame)
	end
	self:addChild(self._bottomSoulBg, 0)
end

--[[--
	设置遮罩
]]
function ForgeGrid:setColorMask()
	if self._colorLayer then 
		return
	end
	if not self._bottomSoulBg:getParent() then
		return 
	end

	local size = self._bottomSoulBg:getContentSize()
	self._colorLayer = CCLayerColor:create(ccc4(256, 256, 256, 256), size.width, size.height)
	self._colorLayer:retain()
	self._colorLayer:ignoreAnchorPointForPosition(false)
	self._colorLayer:setAnchorPoint(ccp(0.5,0.5))
	self._colorLayer:setOpacity(100)
	self._colorLayer:setPosition(self._offsetX, self._offsetY - 12)
	self:addChild(self._colorLayer, ItemGrid.Z_EFFECT)
end

--[[--
	是否有遮罩层
	@return bool 
]]
function ForgeGrid:hasColorMask()
	return (self._colorLayer ~= nil)
end

function ForgeGrid:reset()
	ForgeGrid.super.reset(self)

	if self._colorLayer then
		self._colorLayer:removeFromParent()
		self._colorLayer:release()
		self._colorLayer = nil
	end
	if self._numText then
		self._numText:removeFromParent()
		self._numText:release()
		self._numText = nil
	end

	if self._bottomText then
		self._bottomText:removeFromParent()
		self._bottomText:release()
		self._bottomText = nil
	end

	self._bottomSoulBg:setTexture(nil)

end

function ForgeGrid:_createNumText()
	if not self._numText then
		--构建self._numText，定位好位置
		self._numText = RichText.new(82, 20, GameConst.DEFAULT_FONT_SIZE)
		self._numText:setAnchorPoint(ccp(0, 1))
		self._numText:retain()
--		self._numText:setPosition(self._offsetX + ItemGrid.DEFAULT_WIDTH / 2 - 7,self._offsetY - ItemGrid.DEFAULT_HEIGHT / 2 + 5)
		self:addChild(self._numText, ItemGrid.Z_NUMTEXT)
	end
end


--[[--
	析构
]]
function ForgeGrid:dispose()
	self._num = nil
	self._totalNum = nil
 
	self._bottomSoulBg:setTexture(nil)
	self._bottomSoulBg:release()

	if self._numText then
		self._numText:removeFromParent()
		self._numText:release()
		self._numText = nil
	end

	if self._colorLayer then
		self._colorLayer:removeFromParent()
		self._colorLayer:release()
		self._colorLayer = nil
	end

	ForgeGrid.super.dispose(self)
end

return ForgeGrid