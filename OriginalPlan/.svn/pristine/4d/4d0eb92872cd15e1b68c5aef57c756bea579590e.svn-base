--
-- Author: wdx
-- Date: 2016-03-23 17:06:13
--

local TagBase = class("TagBase")

function TagBase:ctor(tInfo)
	self.tagInfo = tInfo
end

function TagBase:getNode()
	return nil
end

--是否是要直接换行了
function TagBase:isNewLine()
	return self.tagInfo.newLine
end

function TagBase:setText(str)
end

--切割
function TagBase:segment(width)
	return nil
end

function TagBase:getSize()
	return CCSize(self.tagInfo.w or 0,self.tagInfo.h or 0)
end

function TagBase:setPosition(x,y)
	local node = self:getNode()
	if node then
		node:setPosition(x,y)
	end
end

function TagBase:setPositionX(x)
	local node = self:getNode()
	if node then
		node:setPositionX(x)
	end
end

function TagBase:setPositionY(y)
	local node = self:getNode()
	if node then
		node:setPositionY(y)
	end
end

function TagBase:_getColor()
	if self.tagInfo.fontColor then
		return self.tagInfo.fontColor
	end
	if self.tagInfo.color then
		if UIInfo.color[self.tagInfo.color] then  --预定义的颜色
			self.tagInfo.fontColor = UIInfo.color[self.tagInfo.color]
			return self.tagInfo.fontColor
		end
		local str
 		for rls in string.gmatch(self.tagInfo.color,"(%(.-%))") do
			str = rls
			break
		end
		if str then
			str = string.sub(str,2,str:len()-1)
		else
			str = self.tagInfo.color
		end
		local arr = string.split(str,",")
		self.tagInfo.fontColor = ccc3(arr[1],arr[2],arr[3])
		return self.tagInfo.fontColor
	else
		return self.tagInfo.colorCCC3
	end
end

function TagBase:dispose()
end


-------------一个个显示的时候----------------
function TagBase:show(num)
	return true
end

return TagBase