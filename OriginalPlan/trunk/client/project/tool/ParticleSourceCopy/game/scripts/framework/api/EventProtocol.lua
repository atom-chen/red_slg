
--[[--

Events are the principal way in which you create interactive applications. They are a way of
triggering responses in your program. For example, you can turn any display object into an
interactive object.

]]
local EventProtocol = {}

--[[--

Turn any object into an interactive object.

**Usage:**

    framework.client.api.EventProtocol.extend(object)

]]
function EventProtocol.extend(object)
    object.listeners = {}

    --[[--

    Adds a listener to the object’s list of listeners. When the named event occurs, the listener will be invoked and be supplied with a table representing the event.

    **Usage:**

        -- Create an object that listens to events
        local player = Player.new()
        framework.client.api.EventProtocol.extend(player)

        -- Setup listener
        local function onPlayerDead(event)
            -- event.name   == "PLAYER_DEAD"
            -- event.object == player
        end
        player:addEventListener("PLAYER_DEAD", onPlayerDead)

        -- Sometime later, create an event and dispatch it
        player:dispatchEvent({name = "PLAYER_DEAD"})

    ~~

    @param eventName
    String specifying the name of the event to listen for.

    @param listener
    function or table{obj,obj.callback}
    If the event's event.name matches this string, listener will be invoked.

	@param priority 优先级，默认为0，越小，优先级越高

    @return Nothing.
    ]]
    function object:addEventListener(eventName, listener,priority)
        if object.listeners[eventName] == nil then
            object.listeners[eventName] = {}
			object.listeners[eventName.."P"] = {}  --存放优先级
        end
        --print ("addEventListener-", eventName, #(object.listeners[eventName]))
		--先保存优先级
        priority = tonumber(priority) or 0
		 local listenersPriorityForEvent = object.listeners[eventName.."P"]
		listenersPriorityForEvent[listener] = priority

		local listenersForEvent = object.listeners[eventName]
		local toIndex = #listenersForEvent+1  --监听者要插入的位置
		for i=#listenersForEvent,1,-1 do
			local listen = listenersForEvent[i]
			local pri = listenersPriorityForEvent[listen]
			if priority >= pri then
				toIndex = i
			end
 		end
		table.insert(listenersForEvent,toIndex,listener)
    end

    --[[--

    Dispatches event to object. The event parameter must be a table with a name property which is a
    string identifying the type of event. Event include a object property to the event so that your listener can know which object
    received the event.

    **Syntax:**

        object:dispatchEvent(event)

    <br />

    @param event
    contains event properties

    ]]
    function object:dispatchEvent(event)
        --event.name = event.name
        local eventName = event.name
        --print ("disapatch Event", #object.listeners)
        if object.listeners[eventName] == nil then return end
        event.target = object

        --先复制一份监听者数组，再遍历分发
        local listenersForEvent = object.listeners[eventName]
        local listeners = {}
        for i,v in ipairs(listenersForEvent) do
			listeners[i] = v
        end

        
        for i = #listeners, 1, -1 do
            local ret
            local listener = listeners[i]
            if listener then   --考虑这样的情况：如果在遍历时，已经被优先级更高的回调函数里面移除了
	            if type(listener) == "table" then
	                ret = listener[2](listener[1], event)
	            else
	                ret = listener(event)
	            end
	            if ret == false then break end
            end
        end

        listeners = nil
    end

    --[[--

    Removes the specified listener from the object's list of listeners so that it no longer is
    notified of events corresponding to the specified event.

    **Syntax:**

        object:removeEventListener(eventName, listener)

    ]]
    function object:removeEventListener(eventName, listener)
        --eventName = string.upper(eventName)
        if object.listeners[eventName] == nil then return end
        local listenersForEvent = object.listeners[eventName]
        local listenersPriorityForEvent = object.listeners[eventName.."P"]
        for i = #listenersForEvent, 1, -1 do
        	if type(listener)=="table"  and type(listenersForEvent[i])=="table" then  --如果监听的是个表，则判断1、2两个元素是否相当
				if #listenersForEvent[i]==#listener and listenersForEvent[i][1]==listener[1] and  listenersForEvent[i][2]==listener[2] then
                	listenersPriorityForEvent[listenersForEvent[i]] = nil
                    table.remove(listenersForEvent, i)
                	break
				end
            elseif listenersForEvent[i] == listener then  --如果只是两个函数做比较
                table.remove(listenersForEvent, i)
                listenersPriorityForEvent[listener] = nil
                break
            end
        end
        if #listenersForEvent == 0 then
        	object.listeners[eventName] = nil
        	object.listeners[eventName.."P"] = nil
        end
    end

    --[[--
        if has cur  event  listenter  return true
    ]]
    function object:hasEventListener(eventName, listener)
        if object.listeners[eventName] == nil then return false end
        if listener == nil then return true end
        local listenersForEvent = object.listeners[eventName]
        local listenersPriorityForEvent = object.listeners[eventName.."P"]
        for i = #listenersForEvent, 1, -1 do
            if type(listener)=="table"  and type(listenersForEvent[i])=="table" then  --如果监听的是个表，则判断1、2两个元素是否相当
                if #listenersForEvent[i]==#listener and listenersForEvent[i][1]==listener[1] and  listenersForEvent[i][2]==listener[2] then
                    return true
                end
            elseif listenersForEvent[i] == listener then  --如果只是两个函数做比较
                return true
            end
        end
        return false
    end

    --[[--

    Removes all listeners for specified event from the object's list of listeners.

    **Syntax:**

        object:removeAllEventListenersForEvent(eventName)

    ]]
    function object:removeAllEventListenersForEvent(eventName)
        object.listeners[eventName] = nil
        object.listeners[eventName.."P"] = nil
    end

    --[[--

    Removes all listeners from the object's list of listeners.

    **Syntax:**

        object:removeAllEventListeners()

    ]]
    function object:removeAllEventListeners()
        object.listeners = {}
    end

    return object
end

return EventProtocol
