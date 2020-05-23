local BlockTag = game_require("uiLib.component.richText.tag.BlockTag")

local LineTag = class("LineTag",BlockTag)

function LineTag:ctor(tInfo)
	tInfo.w = tInfo.w or 100  --行一定要有宽度
	tInfo.h = tInfo.h or 0  --默认有0高度
	BlockTag.ctor(self,tInfo)
end

function LineTag:addTag(tag)
	BlockTag.addTag(self,tag)
	self:_layout()
end

--当前行以及用了多少宽度了
function LineTag:getCurWidth()
	return self._curWidth
end

--获取行剩余多少宽度
function LineTag:getSurplusWidth()
	return self.tagInfo.w - self._curWidth
end

function LineTag:getCurHeight()
	return self._curHeight
end

function LineTag:getSize()
	return CCSize(self.tagInfo.w,self.tagInfo.h)
end

function LineTag:getPositionY()
	return self.node:getPositionY()
end

return LineTag