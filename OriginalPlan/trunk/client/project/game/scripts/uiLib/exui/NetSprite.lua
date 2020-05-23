--
-- Author: wdx
-- Date: 2015-03-28 11:29:48
--
local NetSprite = class("NetSprite",function() return display.newSprite() end)

NetSprite.REQUEST_MAP = {}

function NetSprite:ctor(url,size)
	if size then
		self._imageSize = size
		self:setContentSize(size)
	end
	self:setUrl(url)
	self:retain()
end

function NetSprite:setUrl(url)
	if self.url ~= url then
		self.url = url
		if self.url then
			local request = network.createHTTPRequest(
							function (event)
								if NetSprite.REQUEST_MAP[self] then
							 		self:_onResponse(event)
							 	end
							 end
						 ,url,"GET")
			-- request:retain()
			request:addRequestHeader("Content-Type:application/x-www-form-urlencoded")
			NetSprite.REQUEST_MAP[self] = request
			request:start()
		else

		end
	end
end

function NetSprite:_onResponse(event)
	local request = event.request
	if (event.name == "progress") then
		return
	end
	repeat
	    local ok = (event.name == "completed")
	    if not ok then
	        -- 请求失败，显示错误代码和错误消息
	        CCLuaLog(self.url)
	        CCLuaLog("request:getErrorCode():"..request:getErrorCode().."  "..request:getErrorMessage())
	        break
	    end
	    if NetSprite.REQUEST_MAP[self] ~= request then
	    	break
	    end

	    local code = request:getResponseStatusCode()
	    if code ~= 200 then
	        -- 请求结束，但没有返回 200 响应代码
	        CCLuaLog("getResponseStatusCode:"..code)
	        break
	    end

	    -- 请求成功，显示服务端返回的内容
	    local tx = XUtil:getTextureByNet(request)
	    if tx then
			self:setTexture(tx)
			local size = tx:getContentSizeInPixels()
			self:setTextureRect(CCRect(0,0,size.width,size.height),false,size)
			if self._imageSize then
				local sx = self._imageSize.width/size.width
				local sy = self._imageSize.height/size.height
				self:setScaleX(sx)
				self:setScaleY(sy)
			end
	    end
	until true
end


function NetSprite:dispose()
	NetSprite.REQUEST_MAP[self] = nil
	self:removeFromParent()
	self:release()
end

return NetSprite