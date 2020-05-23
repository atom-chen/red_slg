
local NetCenterCls = class("NetCenterCls")

function NetCenterCls:ctor()
    self.netFilter = game_require("launch.net.NetFilter")
    self.PRIORITY_MODEL  = -1
    self._readHandleMap = {}
	self._readHandleMap["string"] = function(pack,type) return pack:readString() end
	self._readHandleMap["number"] = function(pack,type) return pack:readNumber() end
    self._readHandleMap["int8"] = function(pack,type) return pack:readInt("int8") end
	self._readHandleMap["uint8"] = function(pack,type) return pack:readInt("uint8") end
    self._readHandleMap["int16"] = function(pack,type) return pack:readInt("int16") end
    self._readHandleMap["int32"] = function(pack,type) return pack:readInt("int32") end
    self._readHandleMap["uint16"] = function(pack,type) return pack:readInt("uint16") end
    self._readHandleMap["uint32"] = function(pack,type) return pack:readInt("uint32") end
    self._readHandleMap["int64"] = function(pack,type) return pack:readInt64() end
    self._readHandleMap["uint64"] = self._readHandleMap["int64"]
    self._readHandleMap["array"] = function(pack,type) return self:_readPacketMsg(pack,type) end

	self._readHandleMap["String"] = self._readHandleMap["string"]
	self._readHandleMap["Int8"] = self._readHandleMap["int8"]
	self._readHandleMap["UInt8"] = self._readHandleMap["uint8"]
    self._readHandleMap["Int16"] = self._readHandleMap["int16"]
    self._readHandleMap["Int32"] = self._readHandleMap["int32"]
    self._readHandleMap["UInt16"] = self._readHandleMap["uint16"]
    self._readHandleMap["UInt32"] = self._readHandleMap["uint32"]
    self._readHandleMap["Int64"] = self._readHandleMap["int64"]
    self._readHandleMap["UInt64"] = self._readHandleMap["uint64"]

    self._writeHandleMap = {}
	self._writeHandleMap["string"] = function(pack,type,value) return pack:writeString(value) end
	self._writeHandleMap["number"] = function(pack,type,value) return pack:writeNumber(value) end
    self._writeHandleMap["int8"] = function(pack,type,value) return pack:writeInt(value,"int8") end
	self._writeHandleMap["uint8"] = function(pack,type,value) return pack:writeInt(value,"uint8") end
    self._writeHandleMap["int16"] = function(pack,type,value) return pack:writeInt(value,"int16") end
    self._writeHandleMap["int32"] = function(pack,type,value) return pack:writeInt(value,"int32") end
    self._writeHandleMap["uint16"] = function(pack,type,value) return pack:writeInt(value,"uint16") end
    self._writeHandleMap["uint32"] = function(pack,type,value) return pack:writeInt(value,"uint32") end
    self._writeHandleMap["int64"] = function(pack,type,value) return pack:writeInt64(value) end
    self._writeHandleMap["uint64"] = self._writeHandleMap["int64"]
    self._writeHandleMap["array"] = function(pack,type,value) return self:_writePackMsg(pack,type,value) end

	self._writeHandleMap["String"] = self._writeHandleMap["string"]
	self._writeHandleMap["Int8"] = self._writeHandleMap["int8"]
	self._writeHandleMap["UInt8"] = self._writeHandleMap["uint8"]
    self._writeHandleMap["Int16"] = self._writeHandleMap["int16"]
    self._writeHandleMap["Int32"] = self._writeHandleMap["int32"]
    self._writeHandleMap["UInt16"] = self._writeHandleMap["uint16"]
    self._writeHandleMap["UInt32"] = self._writeHandleMap["uint32"]
    self._writeHandleMap["Int64"] = self._writeHandleMap["int64"]
    self._writeHandleMap["UInt64"] = self._writeHandleMap["uint64"]

    self.NO_CONNECT = -1
    self.CONNECTING = 0
    self.CONNECT_SUCCESS = 1
    self.CONNECT_FAIL = 2
    self.DISCONNECT = 3

    self:reset()
end

function NetCenterCls:reset()
    self.msgDisperser = {}  --消息分发器
    self._msgList = {}
    EventProtocol.extend(self.msgDisperser)

    self._reconnectEnable = false
    self.ignoreList = {}  --忽略 错误码的
    self._ignoreErrorCode = {}
    self:addMsgHandler(MsgType.ENTER_GAME_RET,function( ... )
        self:setReconnectEnable(true)   --进入游戏后 才可以断线重连
    end,-2)

    self:addMsgHandler(MsgType.NET_BE_BREAK,{self,self._netBeBreak} , -2)
end

function NetCenterCls:addMsgHandlerList(target,msgList,priority)
    for msg,handle in pairs(msgList) do
        self:addMsgHandler(msg,{target,handle},priority)
    end
end

function NetCenterCls:removeMsgHandlerList(target,msgList)
    for msg,handle in pairs(msgList) do
        self:removeMsgHandler(msg,{target,handle},priority)
    end
end

--[[--
  @param msgId
    消息id

    @param listener
    function or table{obj,obj.callback}
    If the event's event.name matches this string, listener will be invoked.

  @param priority 优先级，默认为0，越小，优先级越高

]]
function NetCenterCls:addMsgHandler(msgId,handler,priority)
    self.msgDisperser:addEventListener(msgId,handler,priority)
end

function NetCenterCls:removeMsgHandler(msgId,handler)
    --print("移除监听：",msgId)
    self.msgDisperser:removeEventListener(msgId,handler,priority)
end

function NetCenterCls:ignoreError(msgId,flag)
    self.ignoreList[msgId] = flag
end

function NetCenterCls:ignoreErrorCode(errorCode, flag)
	self._ignoreErrorCode[errorCode] = flag
end


function NetCenterCls:init ()
    self.packetCfg = game_require("launch.net.PacketCfg")
    self.msgMD5 = game_require("launch.net.MsgMD5")
    self.msgMD5:init(self.packetCfg)

    self.net = MsgCenter:instance();
    self.net:addMsgScriptHanlder(function(pack)
                                    self:HandleMsg(pack)
                                  end);
    if self._timeHandlerId == nil then
        self._timeHandlerId = scheduler.scheduleGlobal( function()
            if #self._msgList == 0 then --没消息处理了
                self.net:distributeMsg()
            else  --先处理好包
                self:_dispatchMsg()
            end
        end, 0.01)
    end

    self.status = self.NO_CONNECT
end

function NetCenterCls:isConnected()
    if self.status == self.CONNECT_SUCCESS then
        return true
    end
end

function NetCenterCls:connect(serverIp,port)
    -- serverIp = SERVER_IP
    if self.serverIp == serverIp and self.port == port and self.status == self.CONNECT_SUCCESS then
        return true  --已经连接成功
    end
    self.status = self.CONNECTING
    self.serverIp = serverIp
    self.port = port
    self.net:disconnect()
    self.net:setServerInfo(self.serverIp,self.port)
    self.net:connectToServer()
    CCLuaLog(string.format("--服务器地址：%s,%d",self.serverIp,self.port))
    return false
end

--消息处理方法  注册到c++ 调用
function NetCenterCls:HandleMsg(pack)
  pack = tolua.cast(pack,"Packet")
  local opcode = pack:getOpcode()
 --  if DEBUG == 2 then
	-- local opstring = MsgType.debug[opcode]
	-- CCLuaLog(string.format("--服务器消息：%s(%s)", opcode, opstring or ""))
 --  else
	-- CCLuaLog("--服务器消息："..opcode)
 --  end
  if opcode == self.CONNECT_SUCCESS then  --连接成功
      self:connetSuccess()
      return
  elseif opcode == self.CONNECT_FAIL then  --连接失败
      self:connectFail()
      return
  elseif opcode == self.DISCONNECT then  --断开连接
      local stamp = pack:getStamp()
      self:disconnect(stamp)
      return
  end

  local opcodeKey = opcode
  local serializeInfo = self.packetCfg[opcodeKey];
  print("opcodeKey = :",opcodeKey)
  if serializeInfo ~= nil then
      serializeInfo = serializeInfo["s"]  -- 接受的服务器的读s
      --local status = pack:getStatus()
      --if self.netFilter:filterMsg(pack) then  --状态码 先过滤
          local msg = self:_readPacketMsg(pack,serializeInfo)
          if DEBUG == 2 then
              pack:readEnd()  --读取结束
          end
          msg.__opcode = opcode
          self._msgList[#self._msgList + 1] = msg
        -- else
        --     --[[分发状态码]]
        --     self.statusDisperser:dispatchEvent({ name = opcode , status = status})
        -- end
    else
        print("-- error:--服务器发送opcode: ".. opcode .. " 无配置，解析不了")
    end
end

function NetCenterCls:_dispatchMsg()
    for i=1,2 do
        if #self._msgList > 0 then
            local msg = table.remove(self._msgList,1)
            --[[分发消息]]
            --if 4042 == opcode then
            --end
            local opcode = msg.__opcode
			if DEBUG == 2 then
				local opstring = MsgType.debug[opcode]
				print(string.format("--接受服务器消息：.... %s ( %s )", opcode, opstring or ""))
			else
				print("--接受服务器消息：.... "..opcode)
			end
            dump(msg)
            if msg.result and msg.result ~= 0 and errorTip and not self.ignoreList[opcode] then
                if not self._ignoreErrorCode[msg.result] then
                    errorTip(msg.result)
                end
            end
            self.msgDisperser:dispatchEvent({ name = opcode , msg = msg})
            self.msgDisperser:dispatchEvent({ name = MsgType.ALL , msg = msg})
        end
    end
end

function NetCenterCls:connetSuccess()
    self.status = self.CONNECT_SUCCESS
    print("--连接成功",self.CONNECT_SUCCESS)

    LoadingControl:stopAll()  --去掉所有加载中

    self.msgDisperser:dispatchEvent({ name = self.CONNECT_SUCCESS })

    if not self._liveTimer then
        self._liveTimer = scheduler.scheduleGlobal(function() self:sendLiveMsg() end, 2*60)
    end
end

function NetCenterCls:sendLiveMsg()
    if self._reconnectEnable and self.status == self.CONNECT_SUCCESS then
        NetCenter:send(MsgType.LIVE_PACK)
    end
end

-- btnInfo = {}
--   btnInfo.text -- 按钮文本
--   btnInfo.obj   --回调对象
--     btnInfo fun = info.callfun   --回调方法
--     btnInfo param = info.param   --回调参数

function NetCenterCls:connectFail( )
    self.status = self.CONNECT_FAIL
    -- print("连接失败",self.CONNECT_FAIL)
    if not self.msgDisperser:hasEventListener(self.CONNECT_FAIL) then
        self:tipReConnect()
    end
    -- print("这里  失败了。。。")
    self.msgDisperser:dispatchEvent({ name = self.CONNECT_FAIL })
end

function NetCenterCls:disconnect(stamp)
    self.status = self.DISCONNECT
    if stamp == 0 then
        local packLength = self.net:getSendPacketLength()
        print("length....",packLength)
        if packLength > 0 then  --还有包没发出去
            stamp = 1
        end
    end
    if stamp == 1 then
        if not self.msgDisperser:hasEventListener(self.DISCONNECT) then
            self:tipReConnect()
        end
    end
    self.msgDisperser:dispatchEvent({ name = self.DISCONNECT })
end

function NetCenterCls:tipReConnect()
    if self.status == self.CONNECTING or self.status == self.CONNECT_SUCCESS or self.status == self.NO_CONNECT then
        return
    end
    if self._reconnectEnable then
        local btnList = { {text="重试",obj=self,callfun=self._onReConnect}}
        openErrorPanel("网络连接失败。",btnList)
    else   --无法重连
        local btnList = { {text="确定",obj=self,callfun=toExitGame}}
        openErrorPanel("网络错误，请重新启动游戏",btnList)
    end
end

--重连
function NetCenterCls:_onReConnect()
    if self.status ~= self.CONNECT_SUCCESS then
        local pack = self:_getReLoginPack()
        if pack then
            self.net:addReConnectPack(pack)--重连包
            self.net:reConnect()
            self.status = self.CONNECTING

            LoadingControl:show("ReConnect",true)
        end
    end
end

--设置是否进行 重连
function NetCenterCls:setReconnectEnable( flag )
    self._reconnectEnable = flag
end

--获取重连登录包
function NetCenterCls:_getReLoginPack()
    if not self._reconnectEnable then
        return nil
    end
    local pack = Packet:new(packet_type_send)
    local opcodeKey = MsgType.LOGIN_GAME_SERVER_MSG

    local os = 0
    if device.platform == "android" then
        os= 1
    elseif device.platform == "ios" then
        if GameCfg:getBoolean("iosLegal") then  --正版
            os = 3
        else
            os = 2
        end
    end

    local arg = {PLATFORM_ID,GAME_ACCOUNT,GAME_MD5,os,"",1,""}  --平台 账号  md5
    pack:setOpcode(opcodeKey)
    local serializeInfo = self.packetCfg[opcodeKey]
    serializeInfo = serializeInfo["c"] ----客户端发送的读 c
    -- dump(serializeInfo)
    if type(serializeInfo) == "table" then
        for i,serialize in ipairs(serializeInfo) do
            if self:_writeChunckMsg(pack,i,serialize,arg) == false then
            end
        end
    end
    pack:encode(0)
    return pack
end

--被服务器断开了
function NetCenterCls:_netBeBreak(pack)
    local msg = pack.msg
    local msgTips = {[1]="该账号在其他地方登录",[2]="服务器维护中，请稍后重试",[3]="服务器人数达到上限",
                    [4]="战斗数据错误",[5]="禁止登录",[6]="失去连接",[7]="账号验证失败",[9]="游戏版本更新，请重新启动游戏"
                    ,[10] = "服务器维护中",[11]="网络错误，请重新启动游戏"}
    if msg.type == 11 then
        self:disconnect()
        return
    end
    local tip = msgTips[msg.type]
    if tip then
        if msg.type == 10 then
            local str
            local gameClose = gamePlatform:getRemoteValue("gameClose")
            if GAME_SERVER_ID then
                if gameClose then  --游戏服务器关闭
                    if type(gameClose) == "table" then
                        if table.indexOf(gameClose,tonumber(GAME_SERVER_ID)) > 0 then
                            str = gameClose[1]
                        end
                    else
                        str = gameClose
                    end
                end
            elseif gameClose and type(gameClose) == "string" then
                str = gameClose
            end
            if str then
                tip = str
            else
                local time = msg.extra
                if time then
                    tip = tip.."，预计"..util.formatDayEx(time).."后开放，请稍后登录"
                end
            end
        end
        local btnList = { {text="确定",obj=self,callfun=toExitGame}}
        openErrorPanel(tip,btnList)
    end
end

--发送消息包
function NetCenterCls:sendMsg(opcode,msg)
    if self.status ~= self.CONNECT_SUCCESS then
        self:tipReConnect()
    end
    local opcodeKey = opcode;
    local serializeInfo = self.packetCfg[opcodeKey];
    if serializeInfo ~= nil then
        serializeInfo = serializeInfo["c"]  --客户端发送的读 c
        self.msgMD5:md5Msg(opcode,msg,serializeInfo)
        local pack = Packet:new(packet_type_send);
        pack:setOpcode(opcode)
        if type(serializeInfo) ~= "table" or self:_writePackMsg(pack,serializeInfo,msg) then
			if DEBUG == 2 then
				local opstring = MsgType.debug[pack:getOpcode()]
				print(string.format("--发送。。。opcode: %s(%s)", pack:getOpcode(), opstring or ""))
			else
				print("发送。。。opcode:  "..pack:getOpcode())
			end
            dump(msg)
            --dump(msg)
            self.net:send(pack);
        end
    else
		if DEBUG == 2 then
			local opstring = MsgType.debug[opcode]
			print(string.format("--error:发送。。。opcode: %s(%s) 消息   无配置  发送错误", opcode, opstring or ""))
		else
			print("--error:发送 "..opcode .. " 消息   无配置  发送错误")
		end

    end
end

--直接发送
function NetCenterCls:send(opcode,...)
    if self.status ~= self.CONNECT_SUCCESS then
        self:tipReConnect()
    end
    local opcodeKey = opcode
    local arg = {...}
    local serializeInfo = self.packetCfg[opcodeKey]
    if serializeInfo ~= nil then
        self.msgMD5:md5List(opcode,arg)
        serializeInfo = serializeInfo["c"] ----客户端发送的读 c
        local pack = Packet:new(packet_type_send)
        pack:setOpcode(opcode)
        if type(serializeInfo) == "table" then
            for i,serialize in ipairs(serializeInfo) do
                if self:_writeChunckMsg(pack,i,serialize,arg) == false then
                    return
                end
            end
        end
    	if DEBUG == 2 then
			local opstring = MsgType.debug[pack:getOpcode()]
			CCLuaLog(string.format("--发送。。。opcode:  %s(%s)", pack:getOpcode(), opstring or ""))
		else
			print("--发送。。。opcode:  "..pack:getOpcode())
		end
        self.net:send(pack);
        dump(arg)
    else
        print("error:发送 "..opcode .. " 消息   无配置  发送错误")
    end
end

function NetCenterCls:_readPacketMsg(pack,serializeInfo,msg)
    msg = msg or {}
    if type(serializeInfo) == "table" then
        for i,serialize in ipairs(serializeInfo) do
            local key = serialize[1]
            local typeT = serialize[2]
            local readfun = self._readHandleMap[typeT]
            if typeT == "array" then
                local arr = {}
                msg[key] = arr
                typeT = serialize[3]
                readfun = self._readHandleMap[typeT]
                if readfun == nil then
                    readfun = self._readHandleMap["array"];
                    typeT = self.packetCfg[typeT]
                    if typeT == nil then
                        --print("接受".. pack:getOpcode() .. " 消息  没定义type:" .. serialize[3])
                        return nil
                    end
                end
                local num = self._readHandleMap["int16"](pack,"int16");
                --print("接受".. pack:getOpcode() .. "   数组长度多少："..num)
                for j=1,num do
                    arr[j] = readfun(pack,typeT)
                    if arr[j] == nil then
                        return nil
                    end
                end
            elseif readfun ~= nil then
                msg[key] = readfun(pack,typeT)
                if typeT == "string" then
                    msg[key] = string.gsub(msg[key],"\t","    ")
                end
            else
                typeT = self.packetCfg[typeT]
                if typeT then
                    local isExtend = serialize[3]
                    if isExtend then
                        self:_readPacketMsg(pack,typeT,msg)
                    else
                        msg[key] = self:_readPacketMsg(pack,typeT)
                    end
                else
                    print("接受".. pack:getOpcode() .. " 消息第"..i.." key： ".. key .." 出错,type:" ,typeT)
                    return nil
                end
            end
        end
      end
   return msg
end

function NetCenterCls:_writePackMsg(pack,serializeInfo,msg)
    if type(serializeInfo) == "table" then
        for i,serialize in ipairs(serializeInfo) do
            local key = serialize[1]
            if self:_writeChunckMsg(pack,key,serialize,msg) == false then
                return false
            end
        end
        return true
    end
    return false
end

function NetCenterCls:_writeChunckMsg(pack,key,serialize,msg)
    local typeT = serialize[2]
    local value = msg[key]
    local wirtefun = self._writeHandleMap[typeT];
    if value ~= nil then
        if typeT == "array" then
            typeT = serialize[3]
            wirtefun = self._writeHandleMap[typeT]
            if wirtefun == nil then
                wirtefun = self._writeHandleMap["array"];
                typeT = self.packetCfg[typeT]
                if typeT == nil then
                    print("发送".. pack:getOpcode() .. " 消息  没定义type:" .. serialize[3])
                    return false
                end
            end
            local num = #value
            self._writeHandleMap["int16"](pack,"int16",num);
            for j=1,num do
                if wirtefun(pack,typeT,value[j]) == false then
                    return false
                end
            end
        elseif wirtefun ~= nil then
            wirtefun(pack,typeT,value)
        else
            typeT = self.packetCfg[typeT]
            if typeT then
                self:_writePackMsg(pack,typeT,value)
            else
                print("发送 ".. pack:getOpcode() .. "消息第 "..i.." 个 ".. serialize[1] .." 无序列化,类型type:" .. typeT)
                return false
            end
        end
    else
        print("发送 ".. pack:getOpcode() .. " 消息 键："..key .." 没值 nil")
        return false
    end
end

NetCenter = NetCenterCls.new()

return NetCenter