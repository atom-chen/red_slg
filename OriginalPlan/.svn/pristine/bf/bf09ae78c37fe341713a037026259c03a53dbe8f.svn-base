
local WMInfoUilt = game_require('model.world.map.WMInfoUilt')
local WorldMapEffectController = class('WorldMapEffectController')

function WorldMapEffectController:ctor( map )
	-- body
	self._map = map
	self._effectIndex = 0
	self._effectTable = {}
	NotifyCenter:addEventListener(Notify.WORLD_NEED_UPDATE_MAP_ELEM, {self, self._onUpdateMapElem})
	NotifyCenter:addEventListener(Notify.WORLD_NEED_DELETE_MAP_ELEM, {self, self._onDeleteElem})
end

function WorldMapEffectController:_removeEffect( index )
	-- body
	self._effectTable[index] = nil
end

function WorldMapEffectController:_hasEffect(pos)
	for i,effect in pairs(self._effectTable) do
		if effect.posX == pos.x and effect.posY == pos.y then
			return true
		end
	end
	return false
end

function WorldMapEffectController:_onUpdateMapElem( event )
	-- body
	print('_onUpdateMapElem')
	local msg = event.msg
	local addPosList = {}
	for _,v in ipairs(msg.armyList) do
		local pos = WMInfoUilt:changeworldPosToPos( v.worldPos )
		local armyInfo = WorldMapModel:getElemInfoAt( WorldMapProxy.ARMY, pos )
		if false == armyInfo.hasElem or armyInfo.data.worldPlayerInfo.roleId ~= v.worldPlayerInfo.roleId or
			armyInfo.index ~= v.index then
			addPosList[#addPosList + 1] = pos
		end
	end
	for _,v in ipairs(msg.baseList) do
		local pos = WMInfoUilt:changeworldPosToPos( v.worldPos )
		local baseInfo = WorldMapModel:getElemInfoAt( WorldMapProxy.BASE, pos )
		if false == baseInfo.hasElem or baseInfo.data.worldPlayerInfo.roleId ~= v.worldPlayerInfo.roleId  then
			addPosList[#addPosList + 1] = pos
		end
	end
	for _,pos in ipairs(addPosList) do
		if not self:_hasEffect(pos) then
			local index = self._effectIndex
			local effect = SimpleMagic.new( 113,1,function() self:_removeEffect(index) end,true)
			print('pos.x .. ' , pos.x ,'..pos.y ..' , pos.y)
			effect.posX = pos.x
			effect.posY = pos.y
			local mapNodePos = self._map:getMapPosAtMidOfBlockRange(pos, pos)
			local originNodePosX,originNodePosY = self._map:getblockOriginNode():getPosition()
			effect:setPosition(ccp(mapNodePos.x - originNodePosX, mapNodePos.y - originNodePosY ))
			self._map:getblockOriginNode():addChild(effect, 8)
			self._effectTable[self._effectIndex] = effect
			self._effectIndex = self._effectIndex + 1
		end
	end
end

function WorldMapEffectController:_onDeleteElem( event )
	-- body
	local msg = event.msg
	local addPosList = {}
	for _,v in ipairs(msg.deleteArmyPosList) do
		addPosList[#addPosList + 1] = WMInfoUilt:changeworldPosToPos( v.worldPos )
	end
	for _,v in ipairs(msg.deleteBasePosList) do
		addPosList[#addPosList + 1] = WMInfoUilt:changeworldPosToPos( v.worldPos )
	end
	for _,pos in ipairs(addPosList) do
		if not self:_hasEffect(pos) then
			local index = self._effectIndex
			local effect = SimpleMagic.new( 113,1,function() self:_removeEffect(index) end,true)
			print('pos.x .. ' , pos.x , '..pos.y ..' , pos.y)
			effect.posX = pos.x
			effect.posY = pos.y
			local mapNodePos = self._map:getMapPosAtMidOfBlockRange(pos, pos)
			local originNodePosX,originNodePosY = self._map:getblockOriginNode():getPosition()
			effect:setPosition(ccp(mapNodePos.x - originNodePosX, mapNodePos.y - originNodePosY ))
			self._map:getblockOriginNode():addChild(effect, 8)
			self._effectTable[self._effectIndex] = effect
			self._effectIndex = self._effectIndex + 1
		end
	end
end

function WorldMapEffectController:dispose(  )
	-- body
	-- print("WorldMapEffectController  dispose")
	NotifyCenter:removeEventListener(Notify.WORLD_NEED_UPDATE_MAP_ELEM, {self, self._onUpdateMapElem})
	NotifyCenter:removeEventListener(Notify.WORLD_NEED_DELETE_MAP_ELEM, {self, self._onDeleteElem})
	for _,v in pairs(self._effectTable) do
		v:dispose()
	end
end

return WorldMapEffectController