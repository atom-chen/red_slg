local Event = {}


--网络层发出的网络消息事件
Event.NET_ERROR = "neterror"

--组件跑出给使用者处理对应逻辑用的点击事件
Event.MOUSE_DOWN = "mousedown"
Event.MOUSE_CANCEL = "mousecancel"
Event.MOUSE_UP = "mouseup"
Event.MOUSE_CLICK = "mouseclick"

Event.TIME_COUNTDOWN = "timecountdown"

Event.TAB_CHANGE = "tabchange"

Event.MOUSE_BUBBLE = "mousebubble"   --bubble类按钮特有

--进度条事件
Event.PROGRESS_END = "progressend" --滚动结束
Event.PROGRESS_MAX = "prgoressmax" --滚动到最大进度

return Event