--[[
	class:		WMMineElemNode
	desc:
	author:		郑智敏
--]]

local WMElemBase = game_require('view.world.map.mapElem.WMElemBase')
local WMMineElemNode = class('WMMineElemNode', WMElemBase)

------------------------------------

function WMMineElemNode:ctor( map )
	-- body
	WMElemBase.ctor(self , map)

	self:_initUI()
	print("aaaaaaaaaaaaa add main")
	self._map:getblockOriginNode(  ):addChild(self,1)
end

function WMMineElemNode:_initUI(  )
	self.pic = display.newXSprite()
	self:addChild(self.pic)
end

function WMMineElemNode:setMineLvShow( flag )
	-- body
	if flag then
		local lvText = self:_getLvText()
		if not lvText:getParent() then
			self:addChild(lvText)
		end
		local str = 'Lv.' .. self._info.data.level
		if self._lvStr ~= str then
			local color = WorldCfg:getColorByLevel(self._info.data.level)
			lvText:setColor(color)
			self._lvStr = str
			lvText:setString(str)
		end
	else
		if self._lvText then
			self._lvText:removeFromParent()
		end
	end
end

function WMMineElemNode:_getLvText()
	if not self._lvText then
		self._lvText = ui.newTTFLabelWithOutline({size=20,text=""})
		self._lvText:setContentSize(CCSize(50,10))
		self._lvText:setAnchorPoint(ccp(0.5,0))
		self._lvText:setPositionY(20)
		self._lvText:retain()
	end
	return self._lvText
end

function WMMineElemNode:updateInfo( info  )
	-- body
	self:initInfo( info )
end

function WMMineElemNode:initInfo( info )
	self:setVisible(true)


	self._info = info
	if info.data.type == 1 then
		self.pic:setSpriteImage('#crystal.png')
	elseif info.data.type == 2 then
		self.pic:setSpriteImage('#iron.png')
	else
		self.pic:setSpriteImage('#uranium.png')
	end
	self.pic:setImageSize(ccsize(256,128))

		local jointFlag = WorldMapProxy:getElemInfoController(WorldMapProxy.MINE):isJoint(self._info.startPos)
		if false == jointFlag then
			self._isJointShow = false
			self:_clearJointFlag()
		else
			self:_setJointFlag()
		end
end

function WMMineElemNode:_clearJointFlag(  )
	-- body
	if self._jointPic then
		self._jointPic:removeFromParent()
		self._jointPic = nil
	end
end

function WMMineElemNode:_setJointFlag(  )
	if self._isJointShow then
		return
	end
	self._isJointShow = true
	if self._jointPic == nil then
		self._jointPic = display.newXSprite('#yw_bg_10.png')
		self._jointPic:setImageSize(ccsize(256,128))
		self:addChild(self._jointPic,2)

		local fadeOut = CCFadeOut:create(0.5)
		local fadeIn = CCFadeIn:create(0.5)
		local fadeInAndOut = CCSequence:createWithTwoActions(fadeIn, fadeOut)
		local repeatAction = CCRepeat:create(fadeInAndOut, 3)

		transition.execute(self._jointPic, repeatAction, {onComplete=
			function() self:_clearJointFlag()  end
			})
		--self._jointPic:runAction(repeatAction)
	end
end

function WMMineElemNode:getBlockPosRange(  )
	-- body
	return ccp(self._info.startPos.x, self._info.startPos.y), ccp(self._info.endPos.x , self._info.endPos.y)
end

function WMMineElemNode:clear(  )
	-- body
	self._isJointShow = false
	self:_clearJointFlag()
	self:setVisible(false)
end

function WMMineElemNode:dispose()
	if self._lvText then
		self._lvText:release()
	end
	WMElemBase.dispose(self)
end

return WMMineElemNode