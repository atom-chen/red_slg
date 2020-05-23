--[[
	class:		WMMonsterElemNode
	desc:
	author:		郑智敏
--]]

local WMElemBase = game_require('view.world.map.mapElem.WMElemBase')
local WMMonsterElemNode = class('WMMonsterElemNode', WMElemBase)

-------------------------------------------

function WMMonsterElemNode:ctor( map )
	-- body
	WMElemBase.ctor(self , map)

	self:_initUI()
	self._map:getblockOriginNode():addChild(self,3)
end

function WMMonsterElemNode:_initUI(  )
	self.pic = display.newXSprite()
	self:addChild(self.pic)

	self.text = ui.newTTFLabelWithOutline({size=19})
	self.text:setAnchorPoint(ccp(0.5,0))
	self.text:setPositionY(50)
	self.text:setPositionX(-50)
	self:addChild(self.text)
end

function WMMonsterElemNode:updateInfo( info  )
	-- body
	self:initInfo( info )
end

function WMMonsterElemNode:initInfo( info )
	-- body
	self:setVisible(true)

	self._info = info
	local name = ""
	local res = nil
	if MonsterCfg:hasMonster(info.data.monsterID) then
    	local cfg = MonsterCfg:getMonster(info.data.monsterID)
        name = cfg.name
        res = cfg.sRes
	end
    name = name or ""

    local textColor = WorldCfg:getColorByFightValue(self._info.data.power)

    if info.data.is_boss == 1 then
    	name = "[精英]" .. name
    	textColor = ccc3(255,133,0)
    end

    self.text:setColor(textColor)
	self.text:setString(string.format('Lv.%d '..name, self._info.data.lev))
	self.text:setContentSize(self.text:getContentSize())
	if res then
		self.pic:setSpriteImage("#yw_h_r"..res..".png")
	else
		self.pic:setSpriteImage("#yw_h_r1.png")
	end

	if info.data.attackTime and (os.time()-info.data.attackTime > 10) then
		info.data.now_populace = info.data.max_populace;
	end
	local hpRate = info.data.now_populace/info.data.max_populace
--	if hpRate <= 0.6 then
--		if hpRate <= 0.3 then
--			self:_showHurtMagic2(true,10006)
--		else
--			self:_showHurtMagic2(true,10006)
--		end
--	else
--		self:_showHurtMagic2(false)
--	end
end

function WMMonsterElemNode:_showHurtMagic(flag,mId,x,y)
	if flag then
		if not self._hurtMagic then
			self._hurtMagic = SimpleMagic.new(mId)
			self._hurtMagic:setMagicType(2)
			self._hurtMagic:setPosition(x,y)
			self:addChild(self._hurtMagic)
		end
	else
		if self._hurtMagic then
			self._hurtMagic = nil
		end
	end
end

function WMMonsterElemNode:_showHurtMagic2(flag,pId)
	if flag then
		if not self._hurtMagic then
			self._hurtMagic = ParticleMgr:CreateParticleSystem(pId)
			local size = self.pic:getImageSize();
			self._hurtMagic:setPosition(0,size.height/2)
			self:addChild(self._hurtMagic)
		end
	else
		if self._hurtMagic then
			self._hurtMagic:removeFromParent()
			self._hurtMagic = nil
		end
	end
end

function WMMonsterElemNode:getBlockPosRange(  )
	return ccp(self._info.startPos.x, self._info.startPos.y), ccp(self._info.endPos.x , self._info.endPos.y)
end

function WMMonsterElemNode:clear(  )
	self:_showHurtMagic(false)
	self:setVisible(false)
	self.text:setString("")
end

function WMMonsterElemNode:dispose(  )
	-- body
	self:_showHurtMagic(false)
	WMElemBase.dispose(self)
end

return WMMonsterElemNode