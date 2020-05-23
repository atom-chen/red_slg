--[[
authro: changao
date: 2014/06/19
class:ItemInfo item����Ϣ�� ������Ŀ��cfg
--]]

local ItemInfo = class("ItemInfo")

ItemInfo.PROB	= 1110	-- ����
ItemInfo.EXPAND	= 1111	-- ����Ʒ ��ҩˮ��
ItemInfo.EQUIP	= 1121	-- װ��

function ItemInfo:ctor(itemId)
	self.num = 0
	self.itemId = itemId
	self.cfg = self:getCfg(self.itemId)
end

function ItemInfo:subNumber(num)
	self.num = self.num + num
	if self.num < 0 then
		self.num = 0
	end
	return self.num
end

function ItemInfo:compCreate(type)
	local fun = function(a, b)
		local atype = a.cfg.type
		local btype = b.cfg.type
		if atype == type then
			return true
		end
		
		if btype == type then
			return false
		end
		
		if atype == btype then
			return a.itemId < b.itemId
		else
			return atype < btype
		end
	end
	return fun
end

function ItemInfo:getQuality()
	return self._quality
end

function ItemInfo:setQuality(quality)
	self._quality = quality
end

return ItemInfo