--[[
    class:      ScrollListVExtend
    author:     hrc
]]
local ScrollListVExtend = {}

function ScrollListVExtend.extend(target, columnNum )
    if not target._vExtend then
        target._vExtend = UIVGrid.new(target:getViewSize().width, columnNum, ccp(0, 0), nil, false)
        target:addCell(target._vExtend)
    end

    function target:addCell(cell)
        target._vExtend:addCell(cell)
    end

    function target:getCellWidth(  )
        return target._vExtend:getCellWidth()
    end

    function target:setCenter(  )
        target._vExtend:setCenter()
    end

    function target:removeCell( cell )
        target._vExtend:removeCell(cell)
    end

    function target:clearCell( isDispose )
        target._vExtend:clearCell(isDispose)
    end

    function target:clear( isDispose )
        if self._vExtend then
            self._vExtend:clearCell(isDispose)
            self._vExtend = nil
        end
        ScrollList.clear(target, true)
    end
end

return ScrollListVExtend
