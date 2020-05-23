require "Class"

BaseRequest = class("BaseRequest")	    -- 请求协议
BaseResponse = class("BaseResponse")	    -- 响应协议

function BaseResponse:ctor()
    self.retCode = 0;
end

BaseStruct = class("BaseStruct", SetMeta)	    -- 结构体

-- 序列化协议头
function SerialPacketHeader(stream, packId, flag)
    stream:writeUInt16(0);
    stream:writeUInt16(packId);
	stream:writeUInt8(flag);
end

function SerialResPacketHeader(stream, packId, flag, retCode)
    stream:writeUInt16(0);
    stream:writeUInt16(packId);
	stream:writeUInt8(flag);
	stream:writeUInt16(retCode);
end

-- 序列化协议总长度
function SerialPacketHeaderLen(stream, len, pos)
    stream:writeUInt16ByPos(len, pos);
end

_G.Protocol = {};