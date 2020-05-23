--[[--
module：   NotifyCenter
desc：        模块间通信的枢纽
author:  HAN Biao
event：
	Notify 中定义的各种通知类型
example：
	发送通知
	NotifyCenter:dispatchEvent({name=Notify.LEVEL_UP,data=1})

	监听通知：
	function handler(event)
		local data = event.data
	end
	NotifyCenter:addEventListener(Notify.LEVEL_UP,handler)
]]

local NotifyCenterCls = class("NotifyCenterCls")

function NotifyCenterCls:init()
	EventProtocol.extend(self)
end

local NotifyCenter = NotifyCenterCls.new()

return NotifyCenter