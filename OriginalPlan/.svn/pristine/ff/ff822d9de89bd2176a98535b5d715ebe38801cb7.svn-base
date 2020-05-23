--[[
class: UIItemGrid
desc: 创建物品格子
author：hrc
event:
    Event.MOUSE_DOWN
    Event.MOUSE_MOVE
    Event.MOUSE_CLICK
    Event.MOUSE_UP
    Event.MOUSE_CANCEL
接口：
    getItemInfo()
    setItem(item, number, showNew)
    setNew(flag)
    addRedPoint(  )
    removeRedPoint(  )
    setSelected(select)
--]]

local UIItemGrid = class("UIItemGrid", UIGrid)

function UIItemGrid:ctor(size, images, priority, swallowTouches,isEnabled)
    local itemImages = nil
    if images then
        itemImages = {}
        for i,v in ipairs(images) do
            if type(v) == "number" then
                itemImages[i] = ResCfg:getRes(v, ".pvr.ccz")
            elseif type(v) == "string" then
                itemImages[i] = v
            else
                itemImages[i] = nil
            end
        end
    end
    UIGrid.ctor(self, size, itemImages, priority, swallowTouches,isEnabled)
    self._defaultItemBorder = "#com_bg_11.png"
    self._defaultItemImage = "#com_bg_10.png"
    self._defaultNewImage = "#bag_img_1.png"
    self._defaultPetNBorder = "#pet_bg_3.png"
    self._defaultPetBorder = "#pet_bg_9.png"
    self._petTeamImage = "#pet_img_ysz.png"
    self._petStarImage = "#pet_img_xx.png"
    self._defaultSelectImage = "#com_select_2.png"

    self._tipsExtend = false
    self._selected = false
    self._needClear = {}

    self._classname = "item"
end

--@desc 获取物品Info
function UIItemGrid:getItemInfo(  )
    return self._itemInfo
end

function UIItemGrid:setItemNull(  )
    -- local img = "#zr_bg_1.png"
    -- self:setImage(img, nil, 2)
    self:setBorder(self._defaultItemBorder)
    self:setNumberText(nil)
    self._itemInfo = nil
end

--[[
@brief 设置格子对应的 item。 可以是
@param item itemId 或者 ItemInfo
@param showNumber number 显示数量，<2不显示数量
@param showNew boolean 显示new图标
--]]
function UIItemGrid:setItem(item, number, showNew)
    if type(item) == "number" then
		if item < 100 then  ---小于100的是资源
			self:setImage(GameConst.CONFIG_ENUM_RES[item], nil, 2)
			self:setBorder(self._defaultItemBorder)
			 self:setNumberText(number)
		else
			self:_updateByItemId(item, number, showNew)
			self._itemInfo = ItemInfo.new(item)
			self._itemInfo:setNum(number)
		end

    else
        number = number or item:getNum()
        self:_updateByItemId(item:getId(), number, showNew)
        self._itemInfo = item
    end
end

function UIItemGrid:_updateByItemId(itemId, number, showNew)
    --self:addQualityMagic(ItemCfg:getQuality(itemId))
    local img = ItemCfg:getIcon(itemId)
    img = img or self._defaultItemImage
    self:setImage(img, nil, 2)
    self:setBorder(self._defaultItemBorder)
    if number and number > 1 then
        self:setNumberText(number)
    else
        self:setNumberText(nil)
    end
    self:setNew(showNew)

    if self._tipsExtend then
        self:setShowTipId(ShowInfoTipExtend.ITEM, itemInfo)
    end
end

--@desc 显示物品信息
-- function UIItemGrid:showTip()
--     if not self._tipsExtend then
--         ShowInfoTipExtend.extend(self)
--         self._tipsExtend = true
--     end
-- end

--@desc 设置物品格子显示new图标
function UIItemGrid:setNew(flag)
    if flag then
        self:_addNew()
    else
        self:_clearNew()
    end
end

function UIItemGrid:isRed(  )
    return self._redPoint
end

function UIItemGrid:setRedPoint( flag )
    if flag then
        self:addRedPoint()
    else
        self:removeRedPoint()
    end
end

--@desc 物品格子添加红点
function UIItemGrid:addRedPoint(  )
    if not self._redPoint then
        self._redPoint = display.newXSprite("#com_new.png")
        self._redPoint:setAnchorPoint(ccp(0,0))
        self:getContainer():addChild(self._redPoint, 134)
        local offset = self:getOffset()
        local size = self._redPoint:getContentSize()
        self._redPoint:setPosition(self._size.width/2, self._size.height/2-size.height+offset)
    end
end

--@desc 物品格子移除红点
function UIItemGrid:removeRedPoint(  )
    if self._redPoint then
        self._redPoint:removeFromParent()
        self._redPoint = nil
    end
end

--[[
    @desc 格子下面添加文本
--]]
function UIItemGrid:setName( name )
    local size = self:getContentSize()
    if not self._itemName then
        self._itemName = UIText.new(size.width, 20, 18, nil,
            UIInfo.color.orange, UIInfo.alignment.center, UIInfo.alignment.center, false,false,true)
        self:addChild(self._itemName)
        self._itemName:setPosition(ccp(0, -20))
        self:_changeContentHeight(self._itemName, true)
    end
    self._itemName:setText(name)
end

function UIItemGrid:_changeContentHeight( node, flag )
    local size = self:getContentSize()
    local nodeSize = node:getContentSize()
    if flag then
        self:setContentSize(CCSize(size.width, size.height + 30))
        self:setPositionY(self:getPositionY() + 30)
    else
        self:setContentSize(CCSize(size.width, size.height - 30))
        self:setPositionY(self:getPositionY() - 30)
    end
end

--[[
    @desc 移除格子下面文本
--]]
function UIItemGrid:removeName(  )
    if self._itemName then
        self:_changeContentHeight(self._itemName)
        self._itemName:removeFromParent()
        self._itemName:dispose()
        self._itemName = nil
    end
end

function UIItemGrid:_addNew(img)
    img = img or self._defaultNewImage
    if not self._newImage then
        self._newImage = UIImage.new(img)
        self._newImage:setAnchorPoint(ccp(0,0))
        self:getContainer():addChild(self._newImage, 133)
        local offset = self:getOffset()
        local siz = self._newImage:getContentSize()
        self._newImage:setPosition(-self._size.width/2, self._size.height/2-siz.height+offset)
    end
end

function UIItemGrid:_clearNew()
    if self._newImage then
        self._newImage:dispose()
        self._newImage = nil
    end
end

--@desc 设置格子选中状态
function UIItemGrid:setSelected( select )
    self._selected = select
    if select then
        self:_addImage("_selectImage", self._defaultSelectImage, UIItemGrid.RightUp)
    else
        self:_removeImage("_selectImage")
    end
    -- self:_updateSelectState()
end

function UIItemGrid:isSelected(  )
    return self._selected
end


UIItemGrid.LeftUp = "leftUp"
UIItemGrid.LeftDown = "leftDown"
UIItemGrid.RightUp = "rightUp"
UIItemGrid.RigthDown = "rightDown"
UIItemGrid.Center = "center"
--@desc 添加图片
function UIItemGrid:_addImage( name, src, position, z )
    if not self[name] then
        self[name] = display.newXSprite(src)
        self[name]:setAnchorPoint(ccp(0,0))
        self:getContainer():addChild(self[name], 134)
        local offset = self:getOffset()
        local size = self[name]:getContentSize()
        local pos
        if position == UIItemGrid.LeftUp then
            pos = ccp(self._size.width / 2, self._size.height / 2 - size.height+offset)
        elseif position == UIItemGrid.RightUp then
            pos = ccp(self._size.width / 2 - size.width + offset, self._size.height / 2 - size.height + offset)
        elseif position == UIItemGrid.LeftDown then
            pos = ccp(self._size.width / 2, offset - size.height)
        elseif postion == UIItemGrid.rightDown then
            pos = ccp(self._size.width / 2 - size.width + offset, offset - size.height)
        else
            pos = ccp(self._size.width / 2, offset)
        end
        self[name]:setPosition(pos)
        self._needClear[name] = true
    end
end

--@desc 移除图片
function UIItemGrid:_removeImage( name )
    if self[name] then
        self[name]:removeFromParent()
        self[name] = nil
        self._needClear[name] = false
    end
end

function UIItemGrid:clearNeedImage(  )
    for name, clear in pairs(self._needClear) do
        if clear then
            self:_removeImage(name)
        end
    end
    self._needClear = {}
end

function UIItemGrid:setEqmStar(star, maxStar)
    print("function UIItemGrid:setEqmStar(star, maxStar)", star, maxStar)
    self:clearEqmStar()
    -- if true then return end
    maxStar = math.floor(maxStar / 2)
    local siz = self._size
    local parent = self:getContainer()
    local width = siz.width-(self:getHOffset())*2
    local step = width/5
    local maxWidth = width/4+1--CCSize(width/4+1, width/4+1)
    self._estars = {}
    local x = -width/2-step/2+(5-maxStar)*step/2
    local zorder = UIGrid._ZTOP
    local y = -siz.height/2+self:getHOffset() --local y = -siz.height/2 - step*(0.5-0.2)
    local fullStar = math.floor(star/2)
    for i=1,fullStar do
        x = self:_addStar("#com_xx_1.png", x, y, maxWidth, step)
    end
    local halfStar = ( star/2 ) % 1
    if halfStar > 0 then
        fullStar = fullStar + 1
        x = self:_addStar("#com_xx_9.png", x, y, maxWidth, step)
    end
    for i=fullStar+1,maxStar do
        x = self:_addStar("#com_xx_2.png", x, y, maxWidth, step)
    end
end

function UIItemGrid:setPetStar( star, maxStar )
    self:clearEqmStar()
    local width = self._size.width-(self:getHOffset())*2
    local step = math.floor( width / maxStar )
    local maxWidth = width/(maxStar - 1) + 1
    self._estars = {}
    local x = -width / 2 - step / 2 + (5 - maxStar) * step / 2
    local y = -self._size.height / 2 + self:getHOffset()
    for i = 1, star do
        x = self:_addStar(self._petStarImage, x, y, maxWidth, step)
    end
end

function UIItemGrid:_addStar( image, x, y, maxWidth, step )
    local zorder = UIGrid._ZTOP
    local parent = self:getContainer()
    local node = UIImage.new(image)
    node:setAnchorPoint(ccp(0.5, 0.5))
    local isiz = node:getContentSize()
    if isiz.width > maxWidth then
        node:setScale(maxWidth/isiz.width)
    end
    x = x + step
    node:setPosition(x, y)
    parent:addChild(node, zorder)
    table.insert(self._estars, node)
    return x
end

function UIItemGrid:clearEqmStar()
    if self._estars then
        for i,node in ipairs(self._estars) do
            node:dispose()
        end
        self._estars = nil
    end
end

function UIItemGrid:setLevelText( text )
    if not text then
        self:clearTopText()
        return
    end
    text = tostring(text)
    self:setTopText(text, UIInfo.alignment.LEFT)
end

------------------------ 宠物 -------------------------------------
--@desc 获取宠物信息
function UIItemGrid:getPetInfo(  )
    return self._petInfo
end

--@desc 设置宠物格子
--@desc cardId 宠物进化id或petInfo
--@desc isTeam boolean 是否已上阵
function UIItemGrid:setPetInfo( cardId, nShow )
    if type(cardId) == "number" then
        self:_updateByCardId(item)
        self._petInfo = PetInfo.new(cardId)
    else
        self._petInfo = cardId
        self:_updateByCardId(self._petInfo:getCardId(), nShow)
    end
    self:setNumberText(self._petInfo:getCardId())
end

function UIItemGrid:setPetNull(  )
    self:setImage(nil, nil, 2)
    self:setBorder(self._defaultPetNBorder)
    self:setNumberText(nil)
    self:setTeam(false)
    self:setLevelText(nil)
    self:clearEqmStar()
    self._petInfo = nil
end

function UIItemGrid:_updateByCardId(cardId, nShow)
    --self:addQualityMagic(ItemCfg:getQuality(itemId))
    local img = PetCfg:getHead(cardId)
    self:setImage(img, nil, 2)
    self:setBorder(self._defaultPetBorder)
    if not nShow then
        if self._petInfo:isTeam() then
            self:setTeam(true, UIItemGrid.RigthDown)
        end
        self:setLevelText(self._petInfo:getLevel())
        self:setPetStar(3, self._petInfo:getMaxStar())
    else
        self:setTeam(false)
        self:setLevelText(nil)
        self:clearEqmStar()
    end
end

--@desc 添加上阵图片
--@pos
function UIItemGrid:setTeam( flag, pos )
    local img = self._petTeamImage
    if flag then
        self:_addImage("_teamImage", self._petTeamImage, UIItemGrid.RigthDown)
    else
        self:_removeImage("_teamImage")
    end
end

function UIItemGrid:clear(  )
    self:_clearNew()
    self._tipsExtend = false
    self._itemInfo = nil
    self._petInfo = nil
    self:clearImage()
    self:setNumberText(nil)
    self:removeRedPoint()
    self:removeName()
    self:clearNeedImage()
    self:clearEqmStar()
end

function UIItemGrid:dispose(  )
    self:clear()
    UIGrid.dispose(self)
end

return UIItemGrid
