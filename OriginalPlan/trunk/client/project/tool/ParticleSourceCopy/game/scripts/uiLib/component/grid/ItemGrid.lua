--[[--
class：  ItemGrid
inherit:BaseGrid
desc：物品、将魂的格子类
author:  HAN Biao

example:
	local item = ItemGrid.new()
	item:setItem(21)
	--item:setSelected(true)
	--item:setLocked(true)
	item:setEmpty(2)
	item:setBottomStr("Lv.111")
	item:setNum(100)
	item:setTip(true)
	item:setPosition(display.cx,display.cy)
	self:addChild(item)

	公开方法：
	ItemGrid:setItem(itemType)
	ItemGrid:setSoul(soulType)
	ItemGrid:setGem(gemType)
	ItemGrid:setBottomStr(str)

	ItemGrid:setQuality(q)
	ItemGrid:setLocked(isLocked,type)
	ItemGrid:setEmpty(where,equipType)
	ItemGrid:setSelected(isSelected)
]]

local ItemGrid = class("ItemGrid",BaseGrid)

--格子孩子的层次
ItemGrid.Z_EFFECT = 4
ItemGrid.Z_NUMTEXT = 5
ItemGrid.Z_SELECTEDFRAME = 6
ItemGrid.Z_BOTTOMBG = 7
ItemGrid.Z_TIP = 8
ItemGrid.Z_RIGHT = 9

--不同品质的物品的底部背景
ItemGrid.BGS={"#grid_bg1.png","#grid_bg2.png","#grid_bg3.png","#grid_bg4.png","#grid_bg5.png","#grid_bg6.png"}
--不同品质的物品的外框
ItemGrid.FRAMES={"#grid_frame1.png","#grid_frame2.png","#grid_frame3.png","#grid_frame4.png","#grid_frame5.png","#grid_frame6.png"}

ItemGrid.EMPTY_SOUL = "#grid_soulEmpty.png"
ItemGrid.EMPTY_SOUL2 = "#grid_soulEmpty2.png"
ItemGrid.EMPTY_EQUIPS = {"#grid_equip1.png","#grid_equip2.png","#grid_equip3.png","#grid_equip4.png","#grid_equip5.png","#grid_equip6.png"}
ItemGrid.UNKOWN_IMAGE = "#grid_unkonwn.png"
ItemGrid.SOULLOCK_IMAGE = "#grid_soulLock.png"

ItemGrid.SELECTED_IMAGE = "#grid_selected.png"
ItemGrid.SELECTED_HUNT_IMAGE = "#grid_hunt_selected.png"
ItemGrid.LOCKED_IMAGE = "#grid_locked.png"
ItemGrid.GEM_IMAGE = "#grid_gem.png"
ItemGrid.TIP_IMAGE = "#grid_tip.png"
ItemGrid.BOTTOM_BG = "#grid_labelbg.png"

function ItemGrid:ctor(width,height)
	ItemGrid.super.ctor(self,width,height)

	--可能有的属性，先列出
	self._isSelected = false
	self._isLocked = false
	self._isTip = false
	self._isSpecial = false    --是否是专属状态

	self._tipIcon = nil        --提示图标
	self._selectedFrame = nil  --选中框
	self._numText = nil        --显示数量的文本
	self._bottomText = nil
	self._bottomBg = nil
	self._rightText = nil      --右侧显示的文本
	self._effect = nil         --特效动画
end

function ItemGrid:_createTipIcon()
	if not self._tipIcon then
		--构建self._tipIcon 定位好位置
		self._tipIcon = display.newSprite(ItemGrid.TIP_IMAGE)
		self._tipIcon:retain()
		self._tipIcon:setPosition(self._offsetX+ItemGrid.DEFAULT_HEIGHT/2-20,self._offsetY+ItemGrid.DEFAULT_HEIGHT/2-20)
	end
end

function ItemGrid:_createNumText()
	if not self._numText then
		--构建self._numText，定位好位置
		self._numText = CCLabelTTF:create("1000",GameConst.DEFAULT_FONT, GameConst.DEFAULT_FONT_SIZE,CCSize(53,26), ui.TEXT_ALIGN_RIGHT, ui.TEXT_VALIGN_BOTTOM)
		self._numText:setAnchorPoint(ccp(1,0))
		self._numText:retain()
		self._numText:setPosition(self._offsetX+ItemGrid.DEFAULT_WIDTH/2-4,self._offsetY-ItemGrid.DEFAULT_HEIGHT/2+5)
	end
end
--[[--
	创建时判断是否显示底部图片
]]
function ItemGrid:_createBottom( hasBg )
	if not self._bottomText then
		--构建self._bottomText 以及self._bottomBg,定位好位置
		self._bottomBg = display.newSprite()
		self._bottomBg:retain()
		self._bottomBg:setPosition(self._offsetX,self._offsetY-ItemGrid.DEFAULT_HEIGHT/2-18)
		if hasBg then
			display.setDisplaySpriteFrame(self._bottomBg, ItemGrid.BOTTOM_BG)
		end
		self._bottomText = CCLabelTTF:create("",GameConst.DEFAULT_FONT,GameConst.DEFAULT_FONT_SIZE_MINI)
		self._bottomText:retain()
		local size = self._bottomBg:getContentSize()
		self._bottomText:setPosition(size.width/2,size.height/2)
		self._bottomBg:addChild(self._bottomText)
	end
end

--[[--
	调整底部文字与格子之间的间距，可以偏移一个数值
	@param offsetY Number 在原来的基础上偏移的竖直距离
]]
function ItemGrid:adjustBottomSpace(offsetY)
	if not self._bottomText then  return end
	local y = self._bottomBg:getPositionY()
	self._bottomBg:setPositionY(y+offsetY)
end

--[[--
	设置BottomStr字体颜色
	@param：color ccc3
]]
function ItemGrid:setBottomStrColor(color)
	if not self._bottomText then
		return
	end
	self._bottomText:setColor(color)
end

function ItemGrid:_createRight()
	if not self._rightText then
		--构建self._rightText，定位好位置
		self._rightText = CCLabelTTF:create("",GameConst.DEFAULT_FONT, GameConst.DEFAULT_FONT_SIZE,CCSize(150,26), ui.TEXT_ALIGN_LEFT, ui.TEXT_VALIGN_CENTER)
		self._rightText:setAnchorPoint(ccp(0,0.5))
		self._rightText:retain()
		self._rightText:setPosition(self._offsetX+ItemGrid.DEFAULT_WIDTH/2+15,self._offsetY)
	end
end

function ItemGrid:_createSelectedFrame(image)
	if not self._selectedFrame then
		--构建self._selectedFrame ,默认居中显示
		local selectImage = image or ItemGrid.SELECTED_IMAGE
		self._selectedFrame = display.newSprite(selectImage)
		self._selectedFrame:setPosition(self._offsetX,self._offsetY)
		self._selectedFrame:retain()
	end
end

--[[--
	设置格子显示某种游戏资源，参见GameConst.RES配置
	@param resName String 资源的名字：元宝ccy,铜币gcy,体力vit,经验exp,经验书expBook
]]
function ItemGrid:setRes(resName)
	local cfg = GameConst.RES[resName]
	if not cfg then return end
	self:setQuality(cfg.quality)
	self:setIcon(cfg.iconSrc)
end

--[[--
	设置显示物品
	@param itemType Number 物品类型
	@param rightNum Number 显示在右侧的名字+数量中的数量,nil则为不显示
]]
function ItemGrid:setItem(itemType,rightNum)
	--读配置，读取品质、图标信息
	local itemCfg = ItemCfg.getCfg(itemType)
	if not itemCfg then
		self:setEmpty(1)
		return
	end
	self:setQuality(itemCfg.quality)
--	local iconUrl = "item/100035.png"
	local iconUrl = "item/"..itemCfg.iconSrc..".png"
	self:setIcon(iconUrl)

	if rightNum then  --如果需要在右侧显示名字x数量
		local str = itemCfg.name.."x"..rightNum
		local color = GameConst.Q_COLORS[(itemCfg.quality or 0)+1]
		self:setRightStr(str,color)
	end
end


--[[--
	设置显示将魂
	@param soulType Number 将魂类型
	@param rightNum Number 显示在右侧的名字+数量中的数量,nil则为不显示
	@param q Number 神将的品质
]]
function ItemGrid:setSoul(soulType,rightNum,q)
	--读配置，读取品质、图标信息
	local partner = PartnerCfg.getPartner(soulType)
	if partner == nil then
		echo("no partner of type:" .. tostring(soulType))
		return
	end
	self:setQuality(q or partner.quality)
--	local iconUrl = "head/100035.png"
	local iconUrl = "head/"..partner.head..".png"
	self:setIcon(iconUrl)

	if rightNum then  --如果需要在右侧显示名字x数量
		local str = partner.name.."x"..rightNum
		local color = GameConst.Q_COLORS[(partner.quality or 0)+1]
		self:setRightStr(str,color)
	end
end

--[[--
	设置显示灵石
	@param gemType Number 灵石类型
	@param rightNum Number 显示在右侧的名字+数量中的数量,nil则为不显示
]]
function ItemGrid:setGem(gemType,rightNum)
	--读配置，读取品质、图标信息
	local gem = GemCfg.getCfg(gemType)
	if gem == nil then
		echo("no gem of type:" .. tostring(gemType))
		return
	end

	self:setQuality(gem.quality)
--	local iconUrl = "head/100035.png"
	local iconUrl = "item/"..gem.icon..".png"
	self:setIcon(iconUrl)

	if rightNum then  --如果需要在右侧显示名字x数量
		local str = gem.name.."x"..rightNum
		local color = GameConst.Q_COLORS[(gem.quality or 0)+1]
		self:setRightStr(str,color)
	end
end

--[[--
	设置显示 玩家头像
	@param info table 玩家信息
	info = {gender=1,prof=1,quality=3}
	grid:setPlayer(info);

	info 为nil的话表示 读 自己玩家头像
]]
function ItemGrid:setPlayer(info)
	info = info or RoleModel.myInfo;
	local quality = info.quality or 3;
	local url = RoleCfg.getHead(info.gender);
	self:setQuality(quality)
	self:setIcon(url);
end

--[[--
	设置星宿
]]
function ItemGrid:setHunt(htype)
	local hunt = HuntCfg.getHunt(htype)
	local quality = HuntCfg.getQuality(htype)
	local level = HuntCfg.getLevel(htype)
	local iconUrl = "hunt/" .. hunt.iconSrc .. ".png"
	self:setIcon(iconUrl)
	self:setHuntQuality(quality)
end

--[[--
	设置星宿品质
]]
function ItemGrid:setHuntQuality(q)
	q = q or 1
	local bgUrl = ItemGrid.BGS[q]
	local huntBgUrl = string.sub(bgUrl, 1, 6) .. "hunt_" .. string.sub(bgUrl, 7)
	self:setBg(huntBgUrl)
	local frameUrl = ItemGrid.FRAMES[q]
	local huntFrameUrl = string.sub(frameUrl, 1, 6) .. "hunt_" .. string.sub(frameUrl, 7)
	self:setFrame(huntFrameUrl)
end

--[[--
	设置星宿锁住
	@param isLocked Boolean 是否锁住
]]
function ItemGrid:setHuntLocked(isLocked)
	isLocked = tobool(isLocked)
	if self._isLocked == isLocked then
		return
	end
	self._isLocked = isLocked
	if self._isLocked then    --如果锁住状态
		local lockUrl = ItemGrid.LOCKED_IMAGE
		local huntLockUrl = string.sub(lockUrl, 1, 5) .. "hunt_" .. string.sub(lockUrl, 6)
		self:setBg(huntLockUrl)
		self:setIcon(nil)
		self:setFrame(nil)
	end
end

--[[--
	设置星宿等级
]]
function ItemGrid:setHuntLevel(level)
	self:setNum(level and "Lv." .. level)
	-- 调整位置
	if self._numText then
		self._numText:setAnchorPoint(ccp(0.5,0))
		self._numText:setPosition(self._offsetX - 3, 1)
	end
end

--[[--
	设置格子显示的品质,可以决定显示的背景、外框
	@param q Number 0开始
]]
function ItemGrid:setQuality(q)
	q = q or 0
	local bgUrl = ItemGrid.BGS[q+1]
	self:setBg(bgUrl)
	local frameUrl = ItemGrid.FRAMES[q+1]
	self:setFrame(frameUrl)
end

function ItemGrid:onEnter()
	if self._isSpecial and self._effect then
		self._effect:playForever()
	end
end

function ItemGrid:onExit()
	if self._isSpecial and self._effect then
		self._effect:stop()
	end
end

--[[--
	设置物品的效果
	@param isSpecial Boolean 是否显示效果
	@param effectUrl 资源名称
]]
function ItemGrid:setSpecialEffect(isSpecial, effectUrl)
	isSpecial = tobool(isSpecial)
	if self._isSpecial == isSpecial then
		return
	end
	self._isSpecial = isSpecial
	effectUrl = effectUrl or "EffectZS"
	if self._isSpecial then  --如果是专属状态
		if not self._effect then
			self._effect = Effect.new(effectUrl)
			self._effect:retain()
			self._effect:setPosition(self._offsetX,self._offsetY)
		end
		if not self._effect:getParent() then
			self:addChild(self._effect,ItemGrid.Z_EFFECT)
		end
		if self:isRunning() then
			self._effect:playForever()
		end
		self:setNodeEventEnabled(true)
	else
		if self._effect then
			self._effect:release()
			self._effect:dispose()
			self._effect = nil
		end
		self:setNodeEventEnabled(false)
	end
end

--[[--
	播放特效
]]
function ItemGrid:playEffectOnce(effectUrl)

	if not self._onceEffect then
		self._onceEffect = Effect.new(effectUrl)
		self._onceEffect:retain()
		self._onceEffect:setPosition(self._offsetX, self._offsetY)
		self._onceEffect:addEventListener(Event.ANIM_END, {self, self._onEffectEnd})
	end

	if not self._onceEffect:getParent() then
		self:addChild(self._onceEffect,ItemGrid.Z_EFFECT)
	end

	if self:isRunning() then
		self._onceEffect:play()
	end
	
end

function ItemGrid:_onEffectEnd(event)
	if self._onceEffect then
		self._onceEffect:dispose()
		self._onceEffect:release()
		self._onceEffect = nil
	end
	self:dispatchEvent({name = Event.GRIDEFFECT_END})
end

--[[--
	设置是否锁住
	@param isLocked Boolean 是否锁住
	@param type Number nil:默认锁住,1:主界面锁住
]]
function ItemGrid:setLocked(isLocked,type)
	isLocked = tobool(isLocked)
	if self._isLocked == isLocked then
		return
	end
	self._isLocked = isLocked
	if self._isLocked then    --如果锁住状态
		if type then
			self:setBg(ItemGrid.SOULLOCK_IMAGE)
		else
			self:setBg(ItemGrid.LOCKED_IMAGE)
		end
		self:setIcon(nil)
		self:setFrame(nil)
		--self:setSelected(false)
	else

	end
end

--[[--
	格子是否是锁住的
]]
function ItemGrid:isLocked()
	return self._isLocked
end

--[[--
	设置空的类型
	@param where Number nil:展示界面装备空,1:背包中空 ,2：将魂中空（显示问号）  3:展示界面灵石空 4:主界面神将空  5:展示界面神将空
	@param equipType Number where为nil时此参数有效，1-6依次为：武器、头盔、胸甲、手部、裤子、战靴
]]
function ItemGrid:setEmpty(where,equipType)
	if not where then
		equipType = equipType or 1
		self:setBg(ItemGrid.EMPTY_EQUIPS[equipType])
		self:setIcon(nil)
		self:setFrame(nil)
	elseif where == 1 then  --背包中空,显示的白色品质的框
		self:setIcon(nil)
		self:setQuality(0)
	elseif where == 2 then  --将魂空，显示一个问号
		self:setBg(ItemGrid.UNKOWN_IMAGE)
		self:setIcon(nil)
		self:setFrame(nil)
	elseif where == 3 then  --展示界面灵石空
		self:setBg(ItemGrid.GEM_IMAGE)
		self:setIcon(nil)
		self:setFrame(nil)
	elseif where == 4 then
		self:setBg(ItemGrid.EMPTY_SOUL)
		self:setIcon(nil)
		self:setFrame(nil)
	elseif where == 5 then
		self:setBg(ItemGrid.EMPTY_SOUL2)
		self:setIcon(nil)
		self:setFrame(nil)
	end
end


--[[--
	设置是否选中
	@param isSelected Boolean
]]
function ItemGrid:setSelected(isSelected, selectImage)
	isSelected = tobool(isSelected)
	if self._isSelected == isSelected then
		return
	end
	self._isSelected = isSelected
	if isSelected then  --如果是选中效果，创建、显示出来
		self:_createSelectedFrame(selectImage)
		if not self._selectedFrame:getParent() then
			self:addChild(self._selectedFrame,ItemGrid.Z_SELECTEDFRAME)
		end
	else  --如果非选中，非选中效果，要隐藏
		if self._selectedFrame and self._selectedFrame:getParent() then
			self:removeChild(self._selectedFrame)
		end
		return
	end
end

function ItemGrid:isSelected()
	return self._isSelected
end

--[[--
	设置格子上显示的数量
	@param num Number
]]
function ItemGrid:setNum(num)
	if (not num) or (num==1) then
		if self._numText and self._numText:getParent() then
			self:removeChild(self._numText)
		end
		return
	end
	self:_createNumText()
	if not self._numText:getParent() then
		self:addChild(self._numText,ItemGrid.Z_NUMTEXT)
	end
	self._numText:setString(tostring(num))
end

--[[--
	设置等级
]]
function ItemGrid:setLevel(level)
	level = toint(level)
	if self._numText and self._numText:getParent() then
		self:removeChild(self._numText)
	end
	local str = "Lv." .. level
	self:_createNumText()
	if not self._numText:getParent() then
		self:addChild(self._numText,ItemGrid.Z_NUMTEXT)
	end
	self._numText:setString(str)
end

function ItemGrid:getNum()
	if self._numText then
		local num = self._numText:getString()
		return tonumber(num)
	end
end

--[[--
	设置底部上的文字
	@param str String 设为nil，则不显示底部文本
	@param hasBg boolean 是否显示文本底框
	@param color 设置颜色
]]
function ItemGrid:setBottomStr(str, hasBg,color)
	if hasBg == nil then
	 	hasBg = true
	end

	if not str then
		if self._bottomBg and self._bottomBg:getParent() then
			self:removeChild(self._bottomBg)
		end
		if self._bottomText then
			self._bottomText:setColor(display.COLOR_WHITE)
		end
		return
	end
	str = tostring(str)
	self:_createBottom(hasBg)
	if not self._bottomBg:getParent() then
		self:addChild(self._bottomBg,ItemGrid.Z_BOTTOMBG)
	end
	self._bottomText:setString(str)
	if color then
		self._bottomText:setColor(color)
	end
end

--[[--
	设置右侧显示的文字
	@param str String 设为nil，则不显示右侧文本
]]
function ItemGrid:setRightStr(str,color)
	if not str then
		if self._rightText and self._rightText:getParent() then
			self:removeChild(self._rightText)
		end
		return
	end
	str = tostring(str)
	self:_createRight()
	if not self._rightText:getParent() then
		self:addChild(self._rightText,ItemGrid.Z_RIGHT)
	end
	if color then
		self._rightText:setColor(color)
	end
	self._rightText:setString(str)

end

--[[--
	设置是否显示提示图标
	@param isTip Boolean
]]
function ItemGrid:setTip(isTip)
	isTip = tobool(isTip)
	if self._isTip == isTip then
		return
	end
	self._isTip = isTip
	if isTip then
		self:_createTipIcon()
		if not self._tipIcon:getParent() then
			self:addChild(self._tipIcon,ItemGrid.Z_TIP)
		end
	else
		if self._tipIcon and self._tipIcon:getParent() then
			self:removeChild(self._tipIcon)
		end
	end
end

--[[--
	格子的重置方法,重置之后就跟新创建的格子一样
--]]
function ItemGrid:reset()
	self._isLocked = false
	self:setSelected(false)
	self:setSpecialEffect(false)
	self:setNum(nil)
	self:setBottomStr(nil)
	self:setRightStr(nil)
	self:setTip(nil)
	ItemGrid.super.reset(self)
end

function ItemGrid:dispose()
	--移除事件、触摸、从父节点移除等，在基类dispose函数中已经实现，
	--这里不再需要，最后调用基类dispose函数即可

	--析构本身持有:数量文本、底部文本、底部文本背景、选中框
	if self._tipIcon then
		self._tipIcon:release()
		self._tipIcon = nil
	end

	if self._selectedFrame then
		self._selectedFrame:release()
		self._selectedFrame = nil
	end

	if self._effect then  --自定义的，因为要有dispose
		self._effect:release()
		self._effect:dispose()
		self._effect = nil
	end

	if self._bottomBg then
		self._bottomBg:release()
		self._bottomBg = nil

		self._bottomText:release()
		self._bottomText = nil
	end

	if self._numText then
		self._numText:release()
		self._numText = nil
	end

	if self._onceEffect then
		self._onceEffect:dispose()
		self._onceEffect:release()
		self._onceEffect = nil
	end

	--析构父类
	ItemGrid.super.dispose(self)
end
return ItemGrid