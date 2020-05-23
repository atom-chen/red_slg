--
XTileExtend = class("XSpriteExtend", CCNodeExtend)
XTileExtend.__index = XTileExtend

function XTileExtend.extend(target)
    local t = tolua.getpeer(target)
    if not t then
        t = {}
        tolua.setpeer(target, t)
    end
    setmetatable(t, XTileExtend)

    target._tileList = {}
    target:setAnchorPoint(ccp(0.5,0.5))
    return target
end

--[[--
	切换一个精灵对象显示成另外一个单独图片的纹理
	@param imageUrl String 如果为nil，则是清除sprite的纹理
	@param size CCSize   大小   nil 的话取 当前大小
    #
]]
function XTileExtend:setSpriteImage(imageUrl,size)
	if not imageUrl then
		self:clearImage()
		return
	end
	if self._curImageUrl == imageUrl and (not size or size == self:getContentSize()) then
		return
	end
	self._curImageUrl = imageUrl

	if not size then
		size = self:getContentSize()
	else
		self:setContentSize(size)   --整个大小
	end

	local tile = self:_getTile(1,imageUrl)
    local imageSize = tile:getContentSize()  --单个图片大小

    local totalW = size.width
    local totalH = size.height
    local imageW = imageSize.width - 1
    if 0 == imageW  then
        imageW = 1
    end
    local imageH = imageSize.height - 1

    local wNum = math.ceil(totalW/imageW )
    local remainW = totalW%imageW   --宽度最后还差多少像素

    if remainW == 1 then
        wNum = wNum - 1
        remainW = 0
    end

    -- while true do
    --     totalW = size.width + (wNum - 1)
    --     local num = math.ceil(totalW/imageW )
    --     if num == wNum then
    --         remainW = totalW%imageW   --宽度最后还差多少像素
    --         break
    --     end
    -- end



    local hNum = math.ceil(totalH/imageH)
    local remainH = totalH%imageH --高度最后还差多少像素

    if remainH == 1 then
        hNum = hNum - 1
        remainH = 0
    end
    -- while true do
    --     totalH = size.height + (hNum - 1)
    --     local num = math.ceil(totalH/imageH )
    --     if num == hNum then
    --         remainH = totalH%imageH --高度最后还差多少像素
    --         break
    --     end
    -- end

    for i=1,hNum do
    	for j=1,wNum do
    		local index = (i-1)*wNum + j
            -- print('index ..' .. index .. ' wNum .. '..wNum)
    		local tile = self:_getTile(index,imageUrl)
    		tile:setPosition(self:_getTilePos(j,i,imageW,imageH,totalH))
    		local clipRect = nil
    		if i == hNum and remainH > 0 then  --最后一行
    			clipRect = CCRect(0,0,imageSize.width,remainH)
    		end
    		if j == wNum and remainW > 0 then
    			if not clipRect then
    				clipRect = CCRect(0,0,remainW,imageSize.height)
    			else
    				clipRect.size.width = remainW
    			end
    		end
    		if clipRect then
    			tile:setClipRect(clipRect)
    		end
    	end
    end
    local lastIndex = (hNum-1)*wNum + wNum
    for i=#self._tileList, lastIndex+1,-1 do
        -- print("asdfasdf",i,#self._tileList,lastIndex,wNum,totalW,imageW )
    	local tile = self._tileList[i]
    	tile:removeFromParent()
    	table.remove(self._tileList,i)
    end
end

function XTileExtend:setImageSize(size)
	if self._curImageUrl then
		self:setSpriteImage(self._curImageUrl,size)
	else
		self:setContentSize(size)
	end
end

function XTileExtend:clearImage()
	for i,tile in ipairs(self._tileList) do
		tile:clearImage()
	end
	self._curImageUrl = nil
end

function XTileExtend:_getTile(index,imageUrl)
	local tile = self._tileList[index]
	if tile == nil then
		tile = display.newXSprite(imageUrl)
        print('index ..' .. index)
		self._tileList[index] = tile
		self:addChild(tile)
		tile:setAnchorPoint(ccp(0,1))  --从左上往右下排
	else
		tile:setSpriteImage(imageUrl)
	end
	return tile
end

function XTileExtend:_getTilePos(w,h,tileW,tileH,totalH)
	return (w-1)*(tileW),totalH - (h-1)*(tileH)
end
