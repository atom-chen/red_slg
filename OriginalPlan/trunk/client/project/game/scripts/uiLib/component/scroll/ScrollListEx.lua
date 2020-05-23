--[[
    class ScrollListEx
    inherit ScrollList
    author hrc
    data 2016-3-22
    changeData 2016-4-8
    changeDate 2016-4-15
    desc 一开始显示部分内容， 随着拖动添加后面内容
    扩展接口
        setCreateFunc( createFunc, maxNum )
        setShowMaxNum( num )
    重写接口
        setScrollTo( pos, isTween )
        getCellAt( index )
        indexOfCell( cell )
        removeCell( cell, isDispose )
        removeCellAt( index, isDispose )
        setScrollPosByIndex( index, isTween )
]]

local ScrollListEx = class("ScrollListEx", ScrollList)

function ScrollListEx:ctor( dircetion, w, h, priority, margin )
    ScrollList.ctor(self, dircetion, w, h, priority, margin)
    self._nextIndex = 0              --下次
    self._showMaxNum = 10     --列表中显示最大的数量
    self._itemList = {}
    self._itemWidth = 0
    self._itemHeight = 0
    self._currMaxItemIndex = 1
    self:_loadMoreItemEx()
end

--@desc 监听拖动事件
function ScrollListEx:_loadMoreItemEx()
    local scrollEnd = function()
        if self.direction == kCCScrollViewDirectionVertical then
            self:_scrollEndVEx()
        elseif self.direction == kCCScrollViewDirectionHorizontal then
            self:_scrollEndHEx()
        end
    end
    self:registerScriptHandler(scrollEnd, CCScrollView.kScrollViewScroll)
end

--[[
    @param num 列表中显示最大的数量（默认为10）
--]]
function ScrollListEx:setShowMaxNum( num )
    self._showMaxNum = num
end

--[[
    @param createFunc function 创建item的函数，有一个参数index，
            如 function(index)， 返回需要添加到Scroll的item
    @param isShow boolean 是否立刻显示
--]]
function ScrollListEx:setCreateFunc( createFunc, isShow )
    self._createItemFuncByInfo = createFunc
    if isShow then
        self:show()
    end
end

--@desc 显示
function ScrollListEx:show()
    local num = #self.cellArray
    if num < self._showMaxNum then
        while #self.cellArray < self._showMaxNum do
            --补充显示最大数目
            if not self:_addNextCell() then --添加下一个
                --如果下一个添加不成功，就添加上一个
                if not self:_addPreCell() then
                    return
                end
            end
        end
    end
end

function ScrollListEx:removeCell( cell, isDispose )
    local index = self:indexOfCell(cell)
    if index > 0 then
        self:removeCellAt(index, isDispose)
    end
end

--@desc 删除index中的cell,
function ScrollListEx:removeCellAt( index, isDispose )
    local cell, realIndex = self._itemList[index]
    if cell then
        table.remove(self._itemList, index)
        self._currMaxItemIndex = self._currMaxItemIndex - 1
        local i = ScrollList.indexOfCell(self, cell)
        if i > 0 then
            ScrollList.removeCellAt(self, i, false)
            self._nextIndex = self._nextIndex - 1
            --补充显示最大数目
            if not self:_addNextCell() then --添加下一个
                --如果下一个添加不成功，就添加上一个
                self:_addPreCell()
            end
        end

        if isDispose and cell.dispose then
            cell:dispose()
        end
    end
end

function ScrollListEx:getAllCellEx()
    return self._itemList
end

function ScrollListEx:getCellAt( index )
    local cell = self._itemList[index]
    if not cell then
        cell = uihelper.call(self._createItemFuncByInfo ,index)
        if not cell then return end
        self._itemList[index] = cell
        cell:retain()
        if index > self._currMaxItemIndex then
            for i = self._currMaxItemIndex, index do
                local item = self._itemList[i]
                if not item then
                    self._itemList[i] = false
                end
            end
            self._currMaxItemIndex = index
        end
    end
    return cell, index
end

function ScrollListEx:indexOfCell( cell )
    for i, v in pairs(self._itemList) do
        if v == cell then
            return i - self:_getIndexRemoveNum(i)
        end
    end
    return 0
end

function ScrollListEx:setScrollTo( pos, isTween )
    if pos == ScrollView.TOP or pos == ScrollView.LEFT then
        while self._nextIndex - self._showMaxNum > 0 do
            if not self:_addPreCell() then break end
        end
    elseif pos == ScrollView.BOTTOM or pos == ScrollView.RIGHT then
        while true do
            if not self:_addNextCell() then break end
        end
    end
    ScrollList.setScrollTo(self, pos, isTween)
end

--@desc 第一个显示的cell为index
function ScrollListEx:setScrollPosByIndex( index, isTween )
    local cell = self:getCellAt(index)
    if not cell then
        print("Warning ScrollListEx setScrollPosByIndex not index")
        return
    end
    local first = self._nextIndex - self._showMaxNum + 1
    first = first < 1 and 1 or first
    if index < first then   --不在显示范围
        while index < first do
            if not self:_addPreCell() then break end
            first = self._nextIndex - self._showMaxNum + 1
        end
        self:_setScrollToDirection(true, isTween)
    elseif index == first then      --第一个显示对象
        self:_setScrollToDirection(true, isTween)
    else            --不是第一个显示对象
        local nextIndex = index - first + self._nextIndex
        while nextIndex > self._nextIndex do
            if not self:_addNextCell() then break end
        end
        if nextIndex > self._nextIndex + self:_getViewShowNum() then --超过最大显示内容，拉到最底部
            self:_setScrollToDirection(false, isTween)
        elseif index < self._nextIndex then
            first = self._nextIndex - self._showMaxNum
            ScrollList.setScrollPosByIndex(self, index - first)
        end
    end
end

function ScrollListEx:_getViewShowNum(  )
    local size = self:getViewSize()
    local cellSize = self.cellArray[1]:getContentSize()

    local max
    local cell
    if self.direction == kCCScrollViewDirectionVertical then
        max = size.height
        cell = cellSize.height
    elseif self.direction == kCCScrollViewDirectionHorizontal then
        max = size.width
        cell = cellSize.width
    end
    local num = math.ceil(max / cell)
    return num
end

function ScrollListEx:_setScrollToDirection( flag, isTween )
    if flag then
        if self.direction == kCCScrollViewDirectionVertical then
            ScrollList.setScrollTo(self, ScrollView.TOP, isTween)
        elseif self.direction == kCCScrollViewDirectionHorizontal then
            ScrollList.setScrollTo(self, ScrollView.LEFT, isTween)
        end
    else
        if self.direction == kCCScrollViewDirectionVertical then
            ScrollList.setScrollTo(self, ScrollView.BOTTOM, isTween)
        elseif self.direction == kCCScrollViewDirectionHorizontal then
            ScrollList.setScrollTo(self, ScrollView.RIGHT, isTween)
        end
    end
end

--@desc 生成一个cell
function ScrollListEx:_addOneCell( index, pre )
    local cell = self:getCellAt(index)
    if not cell then return false end
    self:addCell(cell, pre)
    if not pre then
        self._nextIndex = self._nextIndex + 1
    end

    if self._itemHeight > 0 then return true end
    local size = cell:getContentSize()
    self._itemHeight = size.height
    self._itemWidth = size.width
    return true
end

--@desc 创建后面内容，并移除超过最大数量的item
function ScrollListEx:_addNextCell(  )
    if not self:_addOneCell(self._nextIndex + 1) then
        return false
    end
    if self._showMaxNum < #self.cellArray then
        ScrollList.removeCellAt(self, 1)
    end
    return true
end

--@desc 创建前面内容，并移除超过最大数量的item
function ScrollListEx:_addPreCell(  )
    local index = self._nextIndex - #self.cellArray
    if index < 1 then return false end
    if not self:_addOneCell(index, 1) then
        return false
    end
    if self._showMaxNum < #self.cellArray then
        ScrollList.removeCellAt(self, #self.cellArray)
        self._nextIndex = self._nextIndex - 1
    end
    return true
end

function ScrollListEx:_scrollEndVEx(  )
    local maxY = self:maxContainerOffset().y
    local minY = self:minContainerOffset().y
    local tempY = maxY
    maxY = maxY > minY and maxY or minY
    minY = maxY == tempY and minY or maxY
    local curY = self:getContentOffset().y
    local addY = math.floor(curY - self._itemHeight)
    local subY = math.floor(curY + self._itemHeight)
    -- print("YYYYYYYYYYYYYYY", maxY, minY, curY, addY, subY)
    if maxY < addY then
        if not self:_addNextCell() then return end
        ScrollList.setScrollTo(self, self.BOTTOM)
    elseif minY > subY then
        if not self:_addPreCell() then return end
        ScrollList.setScrollTo(self, self.TOP)
    end
end

function ScrollListEx:_scrollEndHEx(  )
    local max = self:maxContainerOffset().x
    local min = self:minContainerOffset().x
    local cur = self:getContentOffset().x
    local temp = max
    max = max > min and max or min
    min = max == temp and min or temp
    local add = math.floor(cur - self._itemWidth)
    local sub = math.floor(cur + self._itemWidth)
    -- print("XXXXXXXXXXXXXX", max, min, cur, add, sub)
    if max < add then
        if not self:_addPreCell() then return end
        ScrollList.setScrollTo(self, self.LEFT)
    elseif min > sub then
        if not self:_addNextCell() then return end
        ScrollList.setScrollTo(self, self.RIGHT)
    end
end

function ScrollListEx:clear( isDispose )
    self._nextIndex = 0
    for i, item in pairs(self._itemList) do
        if item.dispose and not item:getParent() then -- 说明没加到显示上的
            item:dispose()
        end
        item:release()
    end
    self._itemList = {}
    self._currMaxItemIndex = 1
    ScrollList.clear(self, true)  --是dispose掉已经显示的
end

function ScrollListEx:dispose(  )
    self._createItemFuncByInfo = nil
    for i, item in pairs(self._itemList) do
        if item.dispose and not item:getParent() then -- 说明没加到显示上的
            item:dispose()
        end
        item:release()
    end
    ScrollList.dispose(self)
end

return ScrollListEx
