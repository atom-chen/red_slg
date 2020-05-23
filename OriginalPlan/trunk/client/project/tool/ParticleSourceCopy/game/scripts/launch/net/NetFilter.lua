local NetFilterCls = class("NetFilterCls")

function NetFilterCls:ctor()
	self.whiteList = {}
end



function NetFilterCls:filterMsg(pack)
	local status = pack:getStatus()

	if status ~= 0 then  --消息错误码
		if self.whiteList[msgId] == false then
			local opcode = pack:getOpcode()
			print("飘字提示：  "..opcode.." 消息错误，错误码："..status)
		end
		return false
	else
		return true
	end
end

function NetFilterCls:addWhiteListMsg(msgId)
	self.whiteList[msgId] = true
end

function NetFilterCls:removeWhiteListMsg(msgId)
	self.whiteList[msgId] = false
end

local NetFilter = NetFilterCls.new()

return NetFilter