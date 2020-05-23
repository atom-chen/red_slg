
local NetCenterCls = class("NetCenterCls")

function NetCenterCls:ctor()
    self.netFilter = require("launch.net.NetFilter")

    self._readHandleMap = {}
    self._readHandleMap["int8"] = function(pack,type) return pack:readInt(type) end
    self._readHandleMap["string"] = function(pack,type) return pack:readString() end
    self._readHandleMap["number"] = function(pack,type) return pack:readNumber() end
    self._readHandleMap["int16"] = self._readHandleMap["int8"]
    self._readHandleMap["int32"] = self._readHandleMap["int8"]
    self._readHandleMap["uint16"] = self._readHandleMap["int8"]
    self._readHandleMap["uint32"] = self._readHandleMap["int8"]
    self._readHandleMap["uint8"] = self._readHandleMap["int8"]
    self._readHandleMap["int64"] = function(pack,type) return pack:readInt64() end
    self._readHandleMap["uint64"] = self._readHandleMap["int64"]
    self._readHandleMap["array"] = function(pack,type) return self:_readPacketMsg(pack,type) end

    self._writeHandleMap = {}
    self._writeHandleMap["int8"] = function(pack,type,value) return pack:writeInt(value,type) end
    self._writeHandleMap["string"] = function(pack,type,value) return pack:writeString(value) end
    self._writeHandleMap["number"] = function(pack,type,value) return pack:writeNumber(value) end
    self._writeHandleMap["int16"] = self._writeHandleMap["int8"]
    self._writeHandleMap["int32"] = self._writeHandleMap["int8"]
    self._writeHandleMap["uint16"] = self._writeHandleMap["int8"]
    self._writeHandleMap["uint32"] = self._writeHandleMap["int8"]
    self._writeHandleMap["uint8"] = self._writeHandleMap["int8"]
    self._writeHandleMap["int64"] = function(pack,type,value) return pack:writeInt64(value) end
    self._writeHandleMap["uint64"] = self._writeHandleMap["int64"]
    self._writeHandleMap["array"] = function(pack,type,value) return self:_writePackMsg(pack,type,value) end


    self.msgDisperser = {}  --消息分发器
    EventProtocol.extend(self.msgDisperser)

    self.statusDisperser = {}   --状态分发器
    EventProtocol.extend(self.statusDisperser)

    self.CONNECT_SUCCESS = 1
    self.CONNECT_FAIL = 2
    self.DISCONNECT = 3
end

--[[--
  @param msgId
    消息id

    @param listener
    function or table{obj,obj.callback}
    If the event's event.name matches this string, listener will be invoked.

  @param priority 优先级，默认为0，越小，优先级越高

  @param  coverStatus 是否包含监听 错误码 status   
        coverStatus == true的话   当消息的status~=0 依旧会发出回调  
        默认coverStatus = false
]]
function NetCenterCls:addMsgHandler(msgId,handler,priority,coverStatus)
    --print("add",msgId,handler[1],handler[2])
    self.msgDisperser:addEventListener(msgId,handler,priority)
    if coverStatus then
        self.statusDisperser:addEventListener(msgId,handler,priority)
        self.netFilter:addWhiteListMsg(msgId)
    end
end

function NetCenterCls:removeMsgHandler(msgId,handler)
    print("移除监听：",msgId)
    self.msgDisperser:removeEventListener(msgId,handler,priority)
    self.statusDisperser:removeEventListener(msgId,handler,priority)
    if self.statusDisperser:hasEventListener(msgId) == false then
        self.netFilter:removeWhiteListMsg(msgId)
    end
end


function NetCenterCls:init ()
    self.packetCfg = require("launch.net.PacketCfg")
    self.net = MsgCenter:instance();
    self.net:addMsgScriptHanlder(function(pack)
                                    self:HandleMsg(pack)
                                  end);
    if self._timeHandlerId == nil then
        self._timeHandlerId = scheduler.scheduleGlobal( function()
           self.net:distributeMsg();
          end, 0.05)
    end
end 

function NetCenterCls:connect(serverIp,port)
    self.serverIp = serverIp
    self.port = port
    self.net:disconnect()
    self.net:setServerInfo(serverIp,port);
    self.net:connectToServer();
    print("服务器地址：",serverIp,port)

end

--消息处理方法  注册到c++ 调用
function NetCenterCls:HandleMsg(pack)
  pack = tolua.cast(pack,"Packet")
  local opcode = pack:getOpcode()
  
  print("接受服务器消息：",opcode)
  if opcode == self.CONNECT_SUCCESS then  --连接成功
      self:connetSuccess()
      return
  elseif opcode == self.CONNECT_FAIL then  --连接失败
      self:connectFail()
      return
  elseif opcode == self.DISCONNECT then  --断开连接
      self:disconnect()
      return
  end
  
  local opcodeKey = opcode
  local serializeInfo = self.packetCfg[opcodeKey];
  if serializeInfo ~= nil then
      serializeInfo = serializeInfo["s"]  -- 接受的服务器的读s 
      --local status = pack:getStatus()
      --if self.netFilter:filterMsg(pack) then  --状态码 先过滤
          local msg = self:_readPacketMsg(pack,serializeInfo)
          if msg then
              -- print("解析服务器消息：...."..opcode)
              --[[分发消息]]
              dump(msg)
              self.msgDisperser:dispatchEvent({ name = opcode , msg = msg, status = status})

          end
      -- else
      --     --[[分发状态码]]
      --     self.statusDisperser:dispatchEvent({ name = opcode , status = status})
      -- end
  else
      print("服务器发送opcode: ".. opcode .. " 无配置，解析不了")
  end
end

function NetCenterCls:connetSuccess()

    print("连接成功",self.CONNECT_SUCCESS)
    self.msgDisperser:dispatchEvent({ name = self.CONNECT_SUCCESS })
end

function NetCenterCls:connectFail( )
    print("连接失败",self.CONNECT_FAIL)
    self.msgDisperser:dispatchEvent({ name = self.CONNECT_FAIL })
end

function NetCenterCls:disconnect()
   print("断开连接")
end

--发送消息包
function NetCenterCls:sendMsg(opcode,msg)
    local opcodeKey = opcode;
    local serializeInfo = self.packetCfg[opcodeKey];
    if serializeInfo ~= nil then
      serializeInfo = serializeInfo["c"]  --客户端发送的读 c
      local pack = Packet:new(packet_type_send);
      pack:setOpcode(opcode)
      if type(serializeInfo) ~= "table" or self:_writePackMsg(pack,serializeInfo,msg) then
          print("发送。。。opcode:  "..pack:getOpcode())
          dump(msg)
          self.net:send(pack);
      end
  else
      print("发送 "..opcode .. " 消息   无配置  发送错误")
  end
end

--直接发送
function NetCenterCls:send(opcode,...)
    local opcodeKey = opcode;
    local arg = {...}
    local serializeInfo = self.packetCfg[opcodeKey]
    if serializeInfo ~= nil then
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
        print("发送。。。opcode:  "..pack:getOpcode())
        dump(arg)
        self.net:send(pack);
    else
        print("发送 "..opcode .. " 消息   无配置  发送错误")
    end
end

function NetCenterCls:_readPacketMsg(pack,serializeInfo)
    local msg = {}
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
                        print("接受".. pack:getOpcode() .. " 消息  没定义type:" .. serialize[3])
                        return nil
                    end
                end
                local num = self._readHandleMap["int16"](pack,"int16");
                for j=1,num do
                    arr[j] = readfun(pack,typeT)
                    if arr[j] == nil then
                        return nil
                    end
                end
            elseif readfun ~= nil then
                msg[key] = readfun(pack,typeT)
            else
                typeT = self.packetCfg[typeT]
                if typeT then
                    msg[key] = self:_readPacketMsg(pack,typeT)
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