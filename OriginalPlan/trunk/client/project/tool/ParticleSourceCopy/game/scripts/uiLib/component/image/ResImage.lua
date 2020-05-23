--[[--
class：     ResImage
inherit: CCSprite
desc：       精灵图片，加上了资源管理功能.不再舞台上时，会清除纹理
author:  HAN Biao
event：

example：
	常用函数:
	ResImage.new(imageUrl)
	ResImage:setDisplayImage(imageUrl)
	ResImage:dispose()
]]

local ResImage = class("ResImage",function(imageUrl)
	local sp = display.newSprite()
	return sp
end)

--[[--
	构造函数
	@param imageUrl String 精灵的图片名字，如果是SpriteFrame，图片名字以#开头，可以为nil，表示空图片
]]
function ResImage:ctor(imageUrl)
	self:retain()
	self._imageUrl = nil
	--注册节点事件
	self:setNodeEventEnabled(true)
	self:setDisplayImage(imageUrl)
end

function ResImage:onEnter()
	if self._imageUrl then
		if string.byte(self._imageUrl) ~= 35 then
			ImageResMgr.prepare(self._imageUrl)
			uihelper.setDisplaySingleImage(self,self._imageUrl)
		else
			uihelper.setDisplaySpriteFrame(self,self._imageUrl)
		end
	end
end

function ResImage:onExit()
	if self._imageUrl then
		local size = self:getContentSize()
		uihelper.setDisplaySingleImage(self,nil)    --清掉纹理
		if string.byte(self._imageUrl) ~= 35 then  --资源的移除管理
			ImageResMgr.remove(self._imageUrl)
		end
		self:setContentSize(size)
	end
end

--[[--
	切换精灵显示成最新的图片
	@param imageUrl String 精灵的图片名字，如果是SpriteFrame，图片名字以#开头，可以为nil，表示设置成空图片
]]
function ResImage:setDisplayImage(imageUrl)
	if self._imageUrl == imageUrl then
		return
	end

	local isRunning = self:isRunning()
	if not isRunning then  --当前不在舞台上
		self._imageUrl = imageUrl
		--[[--
		if self._imageUrl then  --构建一个临时的sprite，获得size
			if string.byte(self._imageUrl) ~= 35 then
				IconResMgr.prepare(self._imageUrl)
			end
			local temp = display.newSprite(self._imageUrl)
			local size = temp:getContentSize()
			self:setContentSize(size)
			if string.byte(self._imageUrl) ~= 35 then
				IconResMgr.remove(self._imageUrl)
			end
		end
		--]]
		return
	else  --当前在舞台上，移除之前的，准备最新的
		self:onExit()
		--if not imageUrl then
		--	self:setContentSize(CCSize(0,0))
		--end
		self._imageUrl = imageUrl
		self:onEnter()
	end
end

function ResImage:dispose()
	--移除事件监听

	--从父节点移除并清理
	self:cleanup()
	self:removeFromParentAndCleanup(true)

	--移除Touch监听

	--移除定时监听

	--移除节点事件监听
	self:setNodeEventEnabled(false)

	--析构自己持有的计数引用
	self:setDisplayImage(nil)
	self:release()

	--基类析构函数
end

return ResImage

