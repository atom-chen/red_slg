
OwnerBuffer = class("OwnerBuffer", BaseStruct)
function OwnerBuffer:ctor()
	self.buffTypeID = nil       -------- 
	self.buffType = nil       -------- 
	self.casterObjUID = nil       -------- 
	self.casterObjGUID = nil       -------- 
	self.casterType = nil       -------- 
	self.otherID = nil       -------- 
	self.startTime = nil       -------- 
	self.totoalTime = nil       -------- 
	self.lastTime = nil       -------- 
	self.timeElapsed = nil       -------- 
	self.times = nil       -------- 
	self.level = nil       -------- 
	self.params = {}        -------- 
end

function OwnerBuffer:Read(stream)
	self.buffTypeID = stream:readUInt16()		-------- 
	self.buffType = stream:readInt32()		-------- 
	self.casterObjUID = stream:readUInt32()		-------- 
	self.casterObjGUID = stream:readUInt64()		-------- 
	self.casterType = stream:readInt32()		-------- 
	self.otherID = stream:readUInt16()		-------- 
	self.startTime = stream:readUInt32()		-------- 
	self.totoalTime = stream:readInt64()		-------- 
	self.lastTime = stream:readInt64()		-------- 
	self.timeElapsed = stream:readInt64()		-------- 
	self.times = stream:readUInt8()		-------- 
	self.level = stream:readUInt8()		-------- 
	local _params_0_t = {}		-------- 
	local _params_0_len = stream:readUInt8()
	for _0=1,_params_0_len,1 do
	  table.insert(_params_0_t, stream:readInt32())
	end
	self.params = _params_0_t
end

function OwnerBuffer:Write(stream)
	stream:writeUInt16(self.buffTypeID) 
	stream:writeInt32(self.buffType) 
	stream:writeUInt32(self.casterObjUID) 
	stream:writeUInt64(self.casterObjGUID) 
	stream:writeInt32(self.casterType) 
	stream:writeUInt16(self.otherID) 
	stream:writeUInt32(self.startTime) 
	stream:writeInt64(self.totoalTime) 
	stream:writeInt64(self.lastTime) 
	stream:writeInt64(self.timeElapsed) 
	stream:writeUInt8(self.times) 
	stream:writeUInt8(self.level) 
	local _params_0_t = self.params 
	stream:writeUInt8(#_params_0_t)
	for _,_params_1_t in pairs(_params_0_t) do
	  stream:writeInt32(_params_1_t)
	end
end
AxisPos = class("AxisPos", BaseStruct)
function AxisPos:ctor()
	self.x = nil       -------- 横坐标
	self.y = nil       -------- 纵坐标
end

function AxisPos:Read(stream)
	self.x = stream:readInt16()		-------- 横坐标
	self.y = stream:readInt16()		-------- 纵坐标
end

function AxisPos:Write(stream)
	stream:writeInt16(self.x) 
	stream:writeInt16(self.y) 
end
MissionParam = class("MissionParam", BaseStruct)
function MissionParam:ctor()
	self.nMaxParam = nil       -------- 最大的条件个数
	self.nParam = nil       -------- 当前已经得到的数目
end

function MissionParam:Read(stream)
	self.nMaxParam = stream:readInt32()		-------- 最大的条件个数
	self.nParam = stream:readInt32()		-------- 当前已经得到的数目
end

function MissionParam:Write(stream)
	stream:writeInt32(self.nMaxParam) 
	stream:writeInt32(self.nParam) 
end
_ChangeMapSaveData = class("_ChangeMapSaveData", BaseStruct)
function _ChangeMapSaveData:ctor()
	self.petObjUID = nil       -------- 
	--! OwnerBuffer
	self.petBuffAry = {}        -------- 
end

function _ChangeMapSaveData:Read(stream)
	self.petObjUID = stream:readUInt32()		-------- 
	local _petBuffAry_0_t = {}		-------- 
	local _petBuffAry_0_len = stream:readUInt8()
	for _0=1,_petBuffAry_0_len,1 do
	  local _petBuffAry_2_o = {}
	  OwnerBuffer.Read(_petBuffAry_2_o, stream)
	  table.insert(_petBuffAry_0_t, _petBuffAry_2_o)
	end
	self.petBuffAry = _petBuffAry_0_t
end

function _ChangeMapSaveData:Write(stream)
	stream:writeUInt32(self.petObjUID) 
	local _petBuffAry_0_t = self.petBuffAry 
	stream:writeUInt8(#_petBuffAry_0_t)
	for _,_petBuffAry_1_t in pairs(_petBuffAry_0_t) do
	  OwnerBuffer.Write(_petBuffAry_1_t, stream)
	end
end
SceneData = class("SceneData", BaseStruct)
function SceneData:ctor()
	self.mapServerID = nil       -------- 
	self.sceneID = nil       -------- 
	self.sceneType = nil       -------- 
	self.maxRoleNum = nil       -------- 
	self.curRoleNum = nil       -------- 
	self.openTime = nil       -------- 
	self.lastTime = nil       -------- 
	self.objUID = nil       -------- 
end

function SceneData:Read(stream)
	self.mapServerID = stream:readUInt16()		-------- 
	self.sceneID = stream:readUInt64()		-------- 
	self.sceneType = stream:readInt32()		-------- 
	self.maxRoleNum = stream:readInt32()		-------- 
	self.curRoleNum = stream:readUInt32()		-------- 
	self.openTime = stream:readUInt32()		-------- 
	self.lastTime = stream:readInt32()		-------- 
	self.objUID = stream:readUInt32()		-------- 
end

function SceneData:Write(stream)
	stream:writeUInt16(self.mapServerID) 
	stream:writeUInt64(self.sceneID) 
	stream:writeInt32(self.sceneType) 
	stream:writeInt32(self.maxRoleNum) 
	stream:writeUInt32(self.curRoleNum) 
	stream:writeUInt32(self.openTime) 
	stream:writeInt32(self.lastTime) 
	stream:writeUInt32(self.objUID) 
end
HoleGemInfo = class("HoleGemInfo", BaseStruct)
function HoleGemInfo:ctor()
	self.pos = nil       -------- 位置
	self.id = nil       -------- 道具ID
end

function HoleGemInfo:Read(stream)
	self.pos = stream:readUInt8()		-------- 位置
	self.id = stream:readUInt16()		-------- 道具ID
end

function HoleGemInfo:Write(stream)
	stream:writeUInt8(self.pos) 
	stream:writeUInt16(self.id) 
end
ExtendAttr = class("ExtendAttr", BaseStruct)
function ExtendAttr:ctor()
	self.attrType = nil       -------- 属性类型
	self.valueType = nil       -------- 值类型
	self.attrValue = nil       -------- 属性值
end

function ExtendAttr:Read(stream)
	self.attrType = stream:readInt8()		-------- 属性类型
	self.valueType = stream:readUInt8()		-------- 值类型
	self.attrValue = stream:readInt32()		-------- 属性值
end

function ExtendAttr:Write(stream)
	stream:writeInt8(self.attrType) 
	stream:writeUInt8(self.valueType) 
	stream:writeInt32(self.attrValue) 
end
GiftBeanReader = class("GiftBeanReader", BaseStruct)
function GiftBeanReader:ctor()
	self.count = nil       -------- 
	self.giftId = nil       -------- 
	self.iconFlag = nil       -------- 
	self.icon = nil       -------- 
end

function GiftBeanReader:Read(stream)
	self.count = stream:readInt32()		-------- 
	self.giftId = stream:readInt32()		-------- 
	self.iconFlag = stream:readUInt8()		-------- 
	self.icon = stream:readString()		-------- 
end

function GiftBeanReader:Write(stream)
	stream:writeInt32(self.count) 
	stream:writeInt32(self.giftId) 
	stream:writeUInt8(self.iconFlag) 
	stream:writeString(self.icon) 
end
PackMissionParams = class("PackMissionParams", BaseStruct)
function PackMissionParams:ctor()
	self.missionID = nil       -------- 任务ID
	--! MissionParam
	self.missionParam = {}        -------- 任务参数
end

function PackMissionParams:Read(stream)
	self.missionID = stream:readUInt16()		-------- 任务ID
	local _missionParam_0_t = {}		-------- 任务参数
	local _missionParam_0_len = stream:readUInt8()
	for _0=1,_missionParam_0_len,1 do
	  local _missionParam_2_o = {}
	  MissionParam.Read(_missionParam_2_o, stream)
	  table.insert(_missionParam_0_t, _missionParam_2_o)
	end
	self.missionParam = _missionParam_0_t
end

function PackMissionParams:Write(stream)
	stream:writeUInt16(self.missionID) 
	local _missionParam_0_t = self.missionParam 
	stream:writeUInt8(#_missionParam_0_t)
	for _,_missionParam_1_t in pairs(_missionParam_0_t) do
	  MissionParam.Write(_missionParam_1_t, stream)
	end
end
ZoneServer = class("ZoneServer", BaseStruct)
function ZoneServer:ctor()
	self.serverId = nil       -------- 区ID
	self.serverName = nil       -------- 区名字
	self.status = nil       -------- 区状态 @ref EZoneServerState
	self.flag = nil       -------- 区标记 @ref EZoneServerFlag
end

function ZoneServer:Read(stream)
	self.serverId = stream:readUInt16()		-------- 区ID
	self.serverName = stream:readString()		-------- 区名字
	self.status = stream:readUInt8()		-------- 区状态 @ref EZoneServerState
	self.flag = stream:readUInt8()		-------- 区标记 @ref EZoneServerFlag
end

function ZoneServer:Write(stream)
	stream:writeUInt16(self.serverId) 
	stream:writeString(self.serverName) 
	stream:writeUInt8(self.status) 
	stream:writeUInt8(self.flag) 
end
ChangeLineTempData = class("ChangeLineTempData", BaseStruct)
function ChangeLineTempData:ctor()
	--! _ChangeMapSaveData
	self.saveData = nil       -------- 
	--! OwnerBuffer
	self.buffAry = {}        -------- 
	--! AxisPos
	self.pos = nil       -------- 
	self.mapID = nil       -------- 
	self.pkType = nil       -------- 
	self.camp = nil       -------- 
end

function ChangeLineTempData:Read(stream)
	self.saveData = {}		-------- 
	_ChangeMapSaveData.Read(self.saveData, stream)
	local _buffAry_0_t = {}		-------- 
	local _buffAry_0_len = stream:readUInt8()
	for _0=1,_buffAry_0_len,1 do
	  local _buffAry_2_o = {}
	  OwnerBuffer.Read(_buffAry_2_o, stream)
	  table.insert(_buffAry_0_t, _buffAry_2_o)
	end
	self.buffAry = _buffAry_0_t
	self.pos = {}		-------- 
	AxisPos.Read(self.pos, stream)
	self.mapID = stream:readUInt16()		-------- 
	self.pkType = stream:readUInt8()		-------- 
	self.camp = stream:readInt32()		-------- 
end

function ChangeLineTempData:Write(stream)
	_ChangeMapSaveData.Write(self.saveData, stream)
	local _buffAry_0_t = self.buffAry 
	stream:writeUInt8(#_buffAry_0_t)
	for _,_buffAry_1_t in pairs(_buffAry_0_t) do
	  OwnerBuffer.Write(_buffAry_1_t, stream)
	end
	AxisPos.Write(self.pos, stream)
	stream:writeUInt16(self.mapID) 
	stream:writeUInt8(self.pkType) 
	stream:writeInt32(self.camp) 
end
PackMission = class("PackMission", BaseStruct)
function PackMission:ctor()
	self.missionID = nil       -------- 任务ID
	self.missionStatus = nil       -------- 任务状态 参考见: @ref EMissionStatus
	--! MissionParam
	self.params = {}        -------- 任务参数
end

function PackMission:Read(stream)
	self.missionID = stream:readUInt16()		-------- 任务ID
	self.missionStatus = stream:readUInt8()		-------- 任务状态 参考见: @ref EMissionStatus
	local _params_0_t = {}		-------- 任务参数
	local _params_0_len = stream:readUInt8()
	for _0=1,_params_0_len,1 do
	  local _params_2_o = {}
	  MissionParam.Read(_params_2_o, stream)
	  table.insert(_params_0_t, _params_2_o)
	end
	self.params = _params_0_t
end

function PackMission:Write(stream)
	stream:writeUInt16(self.missionID) 
	stream:writeUInt8(self.missionStatus) 
	local _params_0_t = self.params 
	stream:writeUInt8(#_params_0_t)
	for _,_params_1_t in pairs(_params_0_t) do
	  MissionParam.Write(_params_1_t, stream)
	end
end
LoginServerData = class("LoginServerData", BaseStruct)
function LoginServerData:ctor()
	self.serverID = nil       -------- 服务器ID
	self.serverIP = nil       -------- 服务器IP @TODO 废弃掉不用
	self.serverPort = nil       -------- 服务器端口 @TODO 废弃掉不用
end

function LoginServerData:Read(stream)
	self.serverID = stream:readUInt16()		-------- 服务器ID
	self.serverIP = stream:readSString()		-------- 服务器IP @TODO 废弃掉不用
	self.serverPort = stream:readUInt16()		-------- 服务器端口 @TODO 废弃掉不用
end

function LoginServerData:Write(stream)
	stream:writeUInt16(self.serverID) 
	stream:writeSString(self.serverIP) 
	stream:writeUInt16(self.serverPort) 
end
M2WRoleDataUpdate = class("M2WRoleDataUpdate", BaseStruct)
function M2WRoleDataUpdate:ctor()
	self.level = nil       -------- 
	self.mapServerID = nil       -------- 
	self.sceneID = nil       -------- 
	--! AxisPos
	self.pos = nil       -------- 
end

function M2WRoleDataUpdate:Read(stream)
	self.level = stream:readUInt8()		-------- 
	self.mapServerID = stream:readUInt16()		-------- 
	self.sceneID = stream:readUInt64()		-------- 
	self.pos = {}		-------- 
	AxisPos.Read(self.pos, stream)
end

function M2WRoleDataUpdate:Write(stream)
	stream:writeUInt8(self.level) 
	stream:writeUInt16(self.mapServerID) 
	stream:writeUInt64(self.sceneID) 
	AxisPos.Write(self.pos, stream)
end
LoginServerLog = class("LoginServerLog", BaseStruct)
function LoginServerLog:ctor()
	self.serverId = nil       -------- 区ID
	self.last_visit_time = nil       -------- 上次登陆时间
end

function LoginServerLog:Read(stream)
	self.serverId = stream:readUInt16()		-------- 区ID
	self.last_visit_time = stream:readUInt32()		-------- 上次登陆时间
end

function LoginServerLog:Write(stream)
	stream:writeUInt16(self.serverId) 
	stream:writeUInt32(self.last_visit_time) 
end
AttackorImpact = class("AttackorImpact", BaseStruct)
function AttackorImpact:ctor()
	self.objUID = nil       -------- 
	self.attrType = nil       -------- 
	self.hp = nil       -------- 
	self.impactType = nil       -------- 
end

function AttackorImpact:Read(stream)
	self.objUID = stream:readUInt32()		-------- 
	self.attrType = stream:readInt8()		-------- 
	self.hp = stream:readInt32()		-------- 
	self.impactType = stream:readUInt8()		-------- 
end

function AttackorImpact:Write(stream)
	stream:writeUInt32(self.objUID) 
	stream:writeInt8(self.attrType) 
	stream:writeInt32(self.hp) 
	stream:writeUInt8(self.impactType) 
end
PackSimpleBuff = class("PackSimpleBuff", BaseStruct)
function PackSimpleBuff:ctor()
	self.objUID = nil       -------- 对象UID
	self.bufferTypeID = nil       -------- Buffer类型ID
end

function PackSimpleBuff:Read(stream)
	self.objUID = stream:readUInt32()		-------- 对象UID
	self.bufferTypeID = stream:readUInt16()		-------- Buffer类型ID
end

function PackSimpleBuff:Write(stream)
	stream:writeUInt32(self.objUID) 
	stream:writeUInt16(self.bufferTypeID) 
end
PackBuffer = class("PackBuffer", BaseStruct)
function PackBuffer:ctor()
	self.objUID = nil       -------- 对象UID
	self.bufferTypeID = nil       -------- Buffer类型ID
	self.level = nil       -------- Buff等级
	self.timeElapsed = nil       -------- 已经持续的时间
	self.param = nil       -------- 参数(血/蓝球表示当前总容量)
end

function PackBuffer:Read(stream)
	self.objUID = stream:readUInt32()		-------- 对象UID
	self.bufferTypeID = stream:readUInt16()		-------- Buffer类型ID
	self.level = stream:readUInt8()		-------- Buff等级
	self.timeElapsed = stream:readUInt32()		-------- 已经持续的时间
	self.param = stream:readUInt32()		-------- 参数(血/蓝球表示当前总容量)
end

function PackBuffer:Write(stream)
	stream:writeUInt32(self.objUID) 
	stream:writeUInt16(self.bufferTypeID) 
	stream:writeUInt8(self.level) 
	stream:writeUInt32(self.timeElapsed) 
	stream:writeUInt32(self.param) 
end
MoveItem = class("MoveItem", BaseStruct)
function MoveItem:ctor()
	self.srcType = nil       -------- 源背包类型 @ref EPackType
	self.objUID = nil       -------- 对象UID
	self.destType = nil       -------- 目标背包类型 @ref EPackType
	self.destIndex = nil       -------- 目标位置索引
end

function MoveItem:Read(stream)
	self.srcType = stream:readUInt8()		-------- 源背包类型 @ref EPackType
	self.objUID = stream:readUInt32()		-------- 对象UID
	self.destType = stream:readUInt8()		-------- 目标背包类型 @ref EPackType
	self.destIndex = stream:readUInt8()		-------- 目标位置索引
end

function MoveItem:Write(stream)
	stream:writeUInt8(self.srcType) 
	stream:writeUInt32(self.objUID) 
	stream:writeUInt8(self.destType) 
	stream:writeUInt8(self.destIndex) 
end
UpdateItem = class("UpdateItem", BaseStruct)
function UpdateItem:ctor()
	self.objUID = nil       -------- 对象UID
	self.index = nil       -------- 索引位置
	self.itemNum = nil       -------- 道具数目
end

function UpdateItem:Read(stream)
	self.objUID = stream:readUInt32()		-------- 对象UID
	self.index = stream:readUInt8()		-------- 索引位置
	self.itemNum = stream:readInt16()		-------- 道具数目
end

function UpdateItem:Write(stream)
	stream:writeUInt32(self.objUID) 
	stream:writeUInt8(self.index) 
	stream:writeInt16(self.itemNum) 
end
MailBeanReader = class("MailBeanReader", BaseStruct)
function MailBeanReader:ctor()
	self.contentFlag = nil       -------- 
	self.content = nil       -------- 
	self.endTime = nil       -------- 
	self.golds = nil       -------- 
	self.id = nil       -------- 
	self.jewels = nil       -------- 
	self.senderFlag = nil       -------- 
	self.sender = nil       -------- 
	self.titleFlag = nil       -------- 
	self.title = nil       -------- 
	self.attach = nil       -------- 
	self.read = nil       -------- 
	self.createTime = nil       -------- 
end

function MailBeanReader:Read(stream)
	self.contentFlag = stream:readUInt8()		-------- 
	self.content = stream:readString()		-------- 
	self.endTime = stream:readInt32()		-------- 
	self.golds = stream:readInt32()		-------- 
	self.id = stream:readInt32()		-------- 
	self.jewels = stream:readInt32()		-------- 
	self.senderFlag = stream:readUInt8()		-------- 
	self.sender = stream:readString()		-------- 
	self.titleFlag = stream:readUInt8()		-------- 
	self.title = stream:readString()		-------- 
	self.attach = stream:readUInt8()		-------- 
	self.read = stream:readUInt8()		-------- 
	self.createTime = stream:readInt32()		-------- 
end

function MailBeanReader:Write(stream)
	stream:writeUInt8(self.contentFlag) 
	stream:writeString(self.content) 
	stream:writeInt32(self.endTime) 
	stream:writeInt32(self.golds) 
	stream:writeInt32(self.id) 
	stream:writeInt32(self.jewels) 
	stream:writeUInt8(self.senderFlag) 
	stream:writeString(self.sender) 
	stream:writeUInt8(self.titleFlag) 
	stream:writeString(self.title) 
	stream:writeUInt8(self.attach) 
	stream:writeUInt8(self.read) 
	stream:writeInt32(self.createTime) 
end
CannonBeanReader = class("CannonBeanReader", BaseStruct)
function CannonBeanReader:ctor()
	self.id = nil       -------- 
	self.bc = nil       -------- 
end

function CannonBeanReader:Read(stream)
	self.id = stream:readUInt8()		-------- 
	self.bc = stream:readUInt8()		-------- 
end

function CannonBeanReader:Write(stream)
	stream:writeUInt8(self.id) 
	stream:writeUInt8(self.bc) 
end
PackItem = class("PackItem", BaseStruct)
function PackItem:ctor()
	self.objUID = nil       -------- 对象唯一ID
	self.itemTypeID = nil       -------- 类型ID
	self.index = nil       -------- 位置索引
	self.count = nil       -------- 数目
	self.quality = nil       -------- 品质
	self.bind = nil       -------- 绑定
	self.remainTime = nil       -------- 剩余时间
	self.stre = nil       -------- 强化等级
	--! ExtendAttr
	self.appendAttrAry = {}        -------- 附加属性
	--! HoleGemInfo
	self.holeGemAry = {}        -------- 镶嵌的宝石信息
end

function PackItem:Read(stream)
	self.objUID = stream:readUInt32()		-------- 对象唯一ID
	self.itemTypeID = stream:readUInt16()		-------- 类型ID
	self.index = stream:readUInt8()		-------- 位置索引
	self.count = stream:readInt16()		-------- 数目
	self.quality = stream:readUInt8()		-------- 品质
	self.bind = stream:readUInt8()		-------- 绑定
	self.remainTime = stream:readUInt32()		-------- 剩余时间
	self.stre = stream:readUInt8()		-------- 强化等级
	local _appendAttrAry_0_t = {}		-------- 附加属性
	local _appendAttrAry_0_len = stream:readUInt8()
	for _0=1,_appendAttrAry_0_len,1 do
	  local _appendAttrAry_2_o = {}
	  ExtendAttr.Read(_appendAttrAry_2_o, stream)
	  table.insert(_appendAttrAry_0_t, _appendAttrAry_2_o)
	end
	self.appendAttrAry = _appendAttrAry_0_t
	local _holeGemAry_0_t = {}		-------- 镶嵌的宝石信息
	local _holeGemAry_0_len = stream:readUInt8()
	for _0=1,_holeGemAry_0_len,1 do
	  local _holeGemAry_2_o = {}
	  HoleGemInfo.Read(_holeGemAry_2_o, stream)
	  table.insert(_holeGemAry_0_t, _holeGemAry_2_o)
	end
	self.holeGemAry = _holeGemAry_0_t
end

function PackItem:Write(stream)
	stream:writeUInt32(self.objUID) 
	stream:writeUInt16(self.itemTypeID) 
	stream:writeUInt8(self.index) 
	stream:writeInt16(self.count) 
	stream:writeUInt8(self.quality) 
	stream:writeUInt8(self.bind) 
	stream:writeUInt32(self.remainTime) 
	stream:writeUInt8(self.stre) 
	local _appendAttrAry_0_t = self.appendAttrAry 
	stream:writeUInt8(#_appendAttrAry_0_t)
	for _,_appendAttrAry_1_t in pairs(_appendAttrAry_0_t) do
	  ExtendAttr.Write(_appendAttrAry_1_t, stream)
	end
	local _holeGemAry_0_t = self.holeGemAry 
	stream:writeUInt8(#_holeGemAry_0_t)
	for _,_holeGemAry_1_t in pairs(_holeGemAry_0_t) do
	  HoleGemInfo.Write(_holeGemAry_1_t, stream)
	end
end
W2MUserDataUpdate = class("W2MUserDataUpdate", BaseStruct)
function W2MUserDataUpdate:ctor()
	self.gmPower = nil       -------- 
end

function W2MUserDataUpdate:Read(stream)
	self.gmPower = stream:readUInt8()		-------- 
end

function W2MUserDataUpdate:Write(stream)
	stream:writeUInt8(self.gmPower) 
end
PlayerInfoBeanReader = class("PlayerInfoBeanReader", BaseStruct)
function PlayerInfoBeanReader:ctor()
	self.charms = nil       -------- 
	self.constellationFlag = nil       -------- 
	self.constellation = nil       -------- 
	self.dataId = nil       -------- 
	self.golds = nil       -------- 
	self.jewels = nil       -------- 
	self.level = nil       -------- 
	self.locationFlag = nil       -------- 
	self.location = nil       -------- 
	self.city = nil       -------- 
	self.mobileNumFlag = nil       -------- 
	self.mobileNum = nil       -------- 
	self.nickNameFlag = nil       -------- 
	self.nickName = nil       -------- 
	self.selfIconUrlFlag = nil       -------- 
	self.selfIconUrl = nil       -------- 
	self.signatureFlag = nil       -------- 
	self.signature = nil       -------- 
	self.systemIcon = nil       -------- 
	self.titleFlag = nil       -------- 
	self.title = nil       -------- 
	self.male = nil       -------- 
	self.online = nil       -------- 
	self.vipLevel = nil       -------- 
	self.giftsFlag = nil       -------- 
	--! GiftBeanReader
	self.gifts = {}        -------- 
end

function PlayerInfoBeanReader:Read(stream)
	self.charms = stream:readInt32()		-------- 
	self.constellationFlag = stream:readUInt8()		-------- 
	self.constellation = stream:readString()		-------- 
	self.dataId = stream:readUInt32()		-------- 
	self.golds = stream:readInt32()		-------- 
	self.jewels = stream:readInt32()		-------- 
	self.level = stream:readInt32()		-------- 
	self.locationFlag = stream:readUInt8()		-------- 
	self.location = stream:readString()		-------- 
	self.city = stream:readString()		-------- 
	self.mobileNumFlag = stream:readUInt8()		-------- 
	self.mobileNum = stream:readString()		-------- 
	self.nickNameFlag = stream:readUInt8()		-------- 
	self.nickName = stream:readString()		-------- 
	self.selfIconUrlFlag = stream:readUInt8()		-------- 
	self.selfIconUrl = stream:readString()		-------- 
	self.signatureFlag = stream:readUInt8()		-------- 
	self.signature = stream:readString()		-------- 
	self.systemIcon = stream:readInt32()		-------- 
	self.titleFlag = stream:readUInt8()		-------- 
	self.title = stream:readString()		-------- 
	self.male = stream:readUInt8()		-------- 
	self.online = stream:readUInt8()		-------- 
	self.vipLevel = stream:readInt32()		-------- 
	self.giftsFlag = stream:readUInt8()		-------- 
	local _gifts_0_t = {}		-------- 
	local _gifts_0_len = stream:readUInt16()
	for _0=1,_gifts_0_len,1 do
	  local _gifts_2_o = {}
	  GiftBeanReader.Read(_gifts_2_o, stream)
	  table.insert(_gifts_0_t, _gifts_2_o)
	end
	self.gifts = _gifts_0_t
end

function PlayerInfoBeanReader:Write(stream)
	stream:writeInt32(self.charms) 
	stream:writeUInt8(self.constellationFlag) 
	stream:writeString(self.constellation) 
	stream:writeUInt32(self.dataId) 
	stream:writeInt32(self.golds) 
	stream:writeInt32(self.jewels) 
	stream:writeInt32(self.level) 
	stream:writeUInt8(self.locationFlag) 
	stream:writeString(self.location) 
	stream:writeString(self.city) 
	stream:writeUInt8(self.mobileNumFlag) 
	stream:writeString(self.mobileNum) 
	stream:writeUInt8(self.nickNameFlag) 
	stream:writeString(self.nickName) 
	stream:writeUInt8(self.selfIconUrlFlag) 
	stream:writeString(self.selfIconUrl) 
	stream:writeUInt8(self.signatureFlag) 
	stream:writeString(self.signature) 
	stream:writeInt32(self.systemIcon) 
	stream:writeUInt8(self.titleFlag) 
	stream:writeString(self.title) 
	stream:writeUInt8(self.male) 
	stream:writeUInt8(self.online) 
	stream:writeInt32(self.vipLevel) 
	stream:writeUInt8(self.giftsFlag) 
	local _gifts_0_t = self.gifts 
	stream:writeUInt16(#_gifts_0_t)
	for _,_gifts_1_t in pairs(_gifts_0_t) do
	  GiftBeanReader.Write(_gifts_1_t, stream)
	end
end
RoleHeart = class("RoleHeart", BaseStruct)
function RoleHeart:ctor()
	self.roleUID = nil       -------- 
	self.accountID = nil       -------- 
	self.onlineFlag = nil       -------- 
end

function RoleHeart:Read(stream)
	self.roleUID = stream:readUInt64()		-------- 
	self.accountID = stream:readUInt64()		-------- 
	self.onlineFlag = stream:readInt8()		-------- 
end

function RoleHeart:Write(stream)
	stream:writeUInt64(self.roleUID) 
	stream:writeUInt64(self.accountID) 
	stream:writeInt8(self.onlineFlag) 
end
MapServerUpdate = class("MapServerUpdate", BaseStruct)
function MapServerUpdate:ctor()
	self.serverID = nil       -------- 服务器ID
	self.maxRoleNum = nil       -------- 最大角色数
	self.roleNums = nil       -------- 角色数目
	--! SceneData
	self.scenes = {}        -------- 场景列表
end

function MapServerUpdate:Read(stream)
	self.serverID = stream:readUInt16()		-------- 服务器ID
	self.maxRoleNum = stream:readInt32()		-------- 最大角色数
	self.roleNums = stream:readInt32()		-------- 角色数目
	local _scenes_0_t = {}		-------- 场景列表
	local _scenes_0_len = stream:readUInt8()
	for _0=1,_scenes_0_len,1 do
	  local _scenes_2_o = {}
	  SceneData.Read(_scenes_2_o, stream)
	  table.insert(_scenes_0_t, _scenes_2_o)
	end
	self.scenes = _scenes_0_t
end

function MapServerUpdate:Write(stream)
	stream:writeUInt16(self.serverID) 
	stream:writeInt32(self.maxRoleNum) 
	stream:writeInt32(self.roleNums) 
	local _scenes_0_t = self.scenes 
	stream:writeUInt8(#_scenes_0_t)
	for _,_scenes_1_t in pairs(_scenes_0_t) do
	  SceneData.Write(_scenes_1_t, stream)
	end
end
CWorldUserData = class("CWorldUserData", BaseStruct)
function CWorldUserData:ctor()
	self.offOverDay = nil       -------- 
	self.level = nil       -------- 
	self.sex = nil       -------- 
	self.job = nil       -------- 
	self.accountID = nil       -------- 
	self.roleUID = nil       -------- 
	self.roleName = nil       -------- 
	self.logoutTime = nil       -------- 
	self.newUser = nil       -------- 
	self.sceneID = nil       -------- 
end

function CWorldUserData:Read(stream)
	self.offOverDay = stream:readInt8()		-------- 
	self.level = stream:readUInt8()		-------- 
	self.sex = stream:readUInt8()		-------- 
	self.job = stream:readUInt8()		-------- 
	self.accountID = stream:readUInt64()		-------- 
	self.roleUID = stream:readUInt64()		-------- 
	self.roleName = stream:readString()		-------- 
	self.logoutTime = stream:readUInt32()		-------- 
	self.newUser = stream:readInt8()		-------- 
	self.sceneID = stream:readUInt64()		-------- 
end

function CWorldUserData:Write(stream)
	stream:writeInt8(self.offOverDay) 
	stream:writeUInt8(self.level) 
	stream:writeUInt8(self.sex) 
	stream:writeUInt8(self.job) 
	stream:writeUInt64(self.accountID) 
	stream:writeUInt64(self.roleUID) 
	stream:writeString(self.roleName) 
	stream:writeUInt32(self.logoutTime) 
	stream:writeInt8(self.newUser) 
	stream:writeUInt64(self.sceneID) 
end
RoleDetail = class("RoleDetail", BaseStruct)
function RoleDetail:ctor()
	self.objUID = nil       -------- 对象UID
	self.roleUID = nil       -------- 角色UID
	self.protypeID = nil       -------- 原型ID
	self.name = nil       -------- 姓名
	self.level = nil       -------- 等级
	self.sex = nil       -------- 性别 @ref ESexType
	self.maxExp = nil       -------- 经验最大值
	self.exp = nil       -------- 经验
	self.gold = nil       -------- 金钱
	self.rmb = nil       -------- 元宝
	self.mapID = nil       -------- 地图ID
	self.xPos = nil       -------- X位置
	self.yPos = nil       -------- Y位置
	self.dir = nil       -------- 方向 @ref EDir2
	self.moveSpeed = nil       -------- 移动速度
	self.maxHp = nil       -------- 最大血量
	self.curHp = nil       -------- 当前血量
	self.maxEnergy = nil       -------- 最大能量
	self.curEnergy = nil       -------- 当前体力值
	self.power = nil       -------- 力量
	self.agility = nil       -------- 敏捷
	self.wisdom = nil       -------- 智力
	self.physical = nil       -------- 体力
	self.attack = nil       -------- 普通攻击
	self.skillAttack = nil       -------- 技能攻击
	self.damage = nil       -------- 额外伤害
	self.crit = nil       -------- 暴击
	self.defense = nil       -------- 防御
	self.damageReduce = nil       -------- 伤害减免
	self.dodge = nil       -------- 闪避
end

function RoleDetail:Read(stream)
	self.objUID = stream:readUInt32()		-------- 对象UID
	self.roleUID = stream:readUInt64()		-------- 角色UID
	self.protypeID = stream:readUInt8()		-------- 原型ID
	self.name = stream:readString()		-------- 姓名
	self.level = stream:readUInt8()		-------- 等级
	self.sex = stream:readUInt8()		-------- 性别 @ref ESexType
	self.maxExp = stream:readInt32()		-------- 经验最大值
	self.exp = stream:readInt32()		-------- 经验
	self.gold = stream:readInt32()		-------- 金钱
	self.rmb = stream:readInt32()		-------- 元宝
	self.mapID = stream:readUInt16()		-------- 地图ID
	self.xPos = stream:readInt16()		-------- X位置
	self.yPos = stream:readInt16()		-------- Y位置
	self.dir = stream:readUInt8()		-------- 方向 @ref EDir2
	self.moveSpeed = stream:readInt16()		-------- 移动速度
	self.maxHp = stream:readInt32()		-------- 最大血量
	self.curHp = stream:readInt32()		-------- 当前血量
	self.maxEnergy = stream:readInt32()		-------- 最大能量
	self.curEnergy = stream:readInt32()		-------- 当前体力值
	self.power = stream:readInt32()		-------- 力量
	self.agility = stream:readInt32()		-------- 敏捷
	self.wisdom = stream:readInt32()		-------- 智力
	self.physical = stream:readInt32()		-------- 体力
	self.attack = stream:readInt32()		-------- 普通攻击
	self.skillAttack = stream:readInt32()		-------- 技能攻击
	self.damage = stream:readInt32()		-------- 额外伤害
	self.crit = stream:readInt32()		-------- 暴击
	self.defense = stream:readInt32()		-------- 防御
	self.damageReduce = stream:readInt32()		-------- 伤害减免
	self.dodge = stream:readInt32()		-------- 闪避
end

function RoleDetail:Write(stream)
	stream:writeUInt32(self.objUID) 
	stream:writeUInt64(self.roleUID) 
	stream:writeUInt8(self.protypeID) 
	stream:writeString(self.name) 
	stream:writeUInt8(self.level) 
	stream:writeUInt8(self.sex) 
	stream:writeInt32(self.maxExp) 
	stream:writeInt32(self.exp) 
	stream:writeInt32(self.gold) 
	stream:writeInt32(self.rmb) 
	stream:writeUInt16(self.mapID) 
	stream:writeInt16(self.xPos) 
	stream:writeInt16(self.yPos) 
	stream:writeUInt8(self.dir) 
	stream:writeInt16(self.moveSpeed) 
	stream:writeInt32(self.maxHp) 
	stream:writeInt32(self.curHp) 
	stream:writeInt32(self.maxEnergy) 
	stream:writeInt32(self.curEnergy) 
	stream:writeInt32(self.power) 
	stream:writeInt32(self.agility) 
	stream:writeInt32(self.wisdom) 
	stream:writeInt32(self.physical) 
	stream:writeInt32(self.attack) 
	stream:writeInt32(self.skillAttack) 
	stream:writeInt32(self.damage) 
	stream:writeInt32(self.crit) 
	stream:writeInt32(self.defense) 
	stream:writeInt32(self.damageReduce) 
	stream:writeInt32(self.dodge) 
end
LoadRoleData = class("LoadRoleData", BaseStruct)
function LoadRoleData:ctor()
	self.roleUID = nil       -------- 角色UID
	self.accountID = nil       -------- 账号UID
	self.objUID = nil       -------- 对象UID
	self.loadType = nil       -------- 加载类型
	self.sceneID = nil       -------- 场景ID
	--! AxisPos
	self.pos = nil       -------- 地图位置
	self.needOpenMap = nil       -------- 是否需要开启地图
	self.mapID = nil       -------- 地图ID
end

function LoadRoleData:Read(stream)
	self.roleUID = stream:readUInt64()		-------- 角色UID
	self.accountID = stream:readUInt64()		-------- 账号UID
	self.objUID = stream:readUInt32()		-------- 对象UID
	self.loadType = stream:readInt32()		-------- 加载类型
	self.sceneID = stream:readUInt64()		-------- 场景ID
	self.pos = {}		-------- 地图位置
	AxisPos.Read(self.pos, stream)
	self.needOpenMap = stream:readInt8()		-------- 是否需要开启地图
	self.mapID = stream:readUInt16()		-------- 地图ID
end

function LoadRoleData:Write(stream)
	stream:writeUInt64(self.roleUID) 
	stream:writeUInt64(self.accountID) 
	stream:writeUInt32(self.objUID) 
	stream:writeInt32(self.loadType) 
	stream:writeUInt64(self.sceneID) 
	AxisPos.Write(self.pos, stream)
	stream:writeInt8(self.needOpenMap) 
	stream:writeUInt16(self.mapID) 
end

------------------------请求区列表------------------------
CLGetZoneList = class("CLGetZoneList", BaseRequest)
CLGetZoneList.PackID = 1010
_G.Protocol["CLGetZoneList"] = 1010
_G.Protocol[1010] = "CLGetZoneList"
function CLGetZoneList:ctor()
end

function CLGetZoneList:Read(stream)
end

function CLGetZoneList:Write(stream)
end

------------------------区列表返回------------------------
LCGetZoneListRet = class("LCGetZoneListRet", BaseResponse)
LCGetZoneListRet.PackID = 1011
_G.Protocol["LCGetZoneListRet"] = 1011
_G.Protocol[1011] = "LCGetZoneListRet"
function LCGetZoneListRet:ctor()
	--! ZoneServer
	self.platformList = {}        -------- 区服列表
end

function LCGetZoneListRet:Read(stream)
	local _platformList_0_t = {}		-------- 区服列表
	local _platformList_0_len = stream:readUInt16()
	for _0=1,_platformList_0_len,1 do
	  local _platformList_2_o = {}
	  ZoneServer.Read(_platformList_2_o, stream)
	  table.insert(_platformList_0_t, _platformList_2_o)
	end
	self.platformList = _platformList_0_t
end

function LCGetZoneListRet:Write(stream)
	local _platformList_0_t = self.platformList 
	stream:writeUInt16(#_platformList_0_t)
	for _,_platformList_1_t in pairs(_platformList_0_t) do
	  ZoneServer.Write(_platformList_1_t, stream)
	end
end

------------------------请求有创建角色的区列表------------------------
CLGetHasRoleZoneList = class("CLGetHasRoleZoneList", BaseRequest)
CLGetHasRoleZoneList.PackID = 1016
_G.Protocol["CLGetHasRoleZoneList"] = 1016
_G.Protocol[1016] = "CLGetHasRoleZoneList"
function CLGetHasRoleZoneList:ctor()
	self.account = nil       -------- 账号
end

function CLGetHasRoleZoneList:Read(stream)
	self.account = stream:readString()		-------- 账号
end

function CLGetHasRoleZoneList:Write(stream)
	stream:writeString(self.account) 
end

------------------------有创建角色的区列表返回------------------------
LCGetHasRoleZoneListRet = class("LCGetHasRoleZoneListRet", BaseResponse)
LCGetHasRoleZoneListRet.PackID = 1017
_G.Protocol["LCGetHasRoleZoneListRet"] = 1017
_G.Protocol[1017] = "LCGetHasRoleZoneListRet"
function LCGetHasRoleZoneListRet:ctor()
	--! ZoneServer
	self.zones = {}        -------- 区服列表
end

function LCGetHasRoleZoneListRet:Read(stream)
	local _zones_0_t = {}		-------- 区服列表
	local _zones_0_len = stream:readUInt8()
	for _0=1,_zones_0_len,1 do
	  local _zones_2_o = {}
	  ZoneServer.Read(_zones_2_o, stream)
	  table.insert(_zones_0_t, _zones_2_o)
	end
	self.zones = _zones_0_t
end

function LCGetHasRoleZoneListRet:Write(stream)
	local _zones_0_t = self.zones 
	stream:writeUInt8(#_zones_0_t)
	for _,_zones_1_t in pairs(_zones_0_t) do
	  ZoneServer.Write(_zones_1_t, stream)
	end
end

------------------------请求验证玩家账号------------------------
CLVerifyAccount = class("CLVerifyAccount", BaseRequest)
CLVerifyAccount.PackID = 1001
_G.Protocol["CLVerifyAccount"] = 1001
_G.Protocol[1001] = "CLVerifyAccount"
function CLVerifyAccount:ctor()
	self.serverID = nil       -------- 区服ID
	self.accountName = nil       -------- 玩家账号名
	self.platUID = nil       -------- 平台用户UID
	self.password = nil       -------- 动态密码
	self.extData = nil       -------- 扩展数据
end

function CLVerifyAccount:Read(stream)
	self.serverID = stream:readUInt16()		-------- 区服ID
	self.accountName = stream:readString()		-------- 玩家账号名
	self.platUID = stream:readString()		-------- 平台用户UID
	self.password = stream:readString()		-------- 动态密码
	self.extData = stream:readString()		-------- 扩展数据
end

function CLVerifyAccount:Write(stream)
	stream:writeUInt16(self.serverID) 
	stream:writeString(self.accountName) 
	stream:writeString(self.platUID) 
	stream:writeString(self.password) 
	stream:writeString(self.extData) 
end

------------------------验证玩家账号返回------------------------
LCVerifyAccountRet = class("LCVerifyAccountRet", BaseResponse)
LCVerifyAccountRet.PackID = 1002
_G.Protocol["LCVerifyAccountRet"] = 1002
_G.Protocol[1002] = "LCVerifyAccountRet"
function LCVerifyAccountRet:ctor()
	self.loginKey = nil       -------- 登陆密钥
	self.serverIP = nil       -------- 角色服务器IP
	self.port = nil       -------- 角色服务器端口
	self.prvMsg = nil       -------- 内部数据
end

function LCVerifyAccountRet:Read(stream)
	self.loginKey = stream:readUInt64()		-------- 登陆密钥
	self.serverIP = stream:readString()		-------- 角色服务器IP
	self.port = stream:readUInt32()		-------- 角色服务器端口
	self.prvMsg = stream:readString()		-------- 内部数据
end

function LCVerifyAccountRet:Write(stream)
	stream:writeUInt64(self.loginKey) 
	stream:writeString(self.serverIP) 
	stream:writeUInt32(self.port) 
	stream:writeString(self.prvMsg) 
end

------------------------主动添加物品操作------------------------
MCAddItems = class("MCAddItems", BaseResponse)
MCAddItems.PackID = 1401
_G.Protocol["MCAddItems"] = 1401
_G.Protocol[1401] = "MCAddItems"
function MCAddItems:ctor()
	self.bagType = nil       -------- 背包类型 @ref EPackType
	--! PackItem
	self.items = {}        -------- 添加的道具列表
end

function MCAddItems:Read(stream)
	self.bagType = stream:readUInt8()		-------- 背包类型 @ref EPackType
	local _items_0_t = {}		-------- 添加的道具列表
	local _items_0_len = stream:readUInt8()
	for _0=1,_items_0_len,1 do
	  local _items_2_o = {}
	  PackItem.Read(_items_2_o, stream)
	  table.insert(_items_0_t, _items_2_o)
	end
	self.items = _items_0_t
end

function MCAddItems:Write(stream)
	stream:writeUInt8(self.bagType) 
	local _items_0_t = self.items 
	stream:writeUInt8(#_items_0_t)
	for _,_items_1_t in pairs(_items_0_t) do
	  PackItem.Write(_items_1_t, stream)
	end
end

------------------------主动删除物品操作------------------------
MCDelItems = class("MCDelItems", BaseResponse)
MCDelItems.PackID = 1402
_G.Protocol["MCDelItems"] = 1402
_G.Protocol[1402] = "MCDelItems"
function MCDelItems:ctor()
	self.bagType = nil       -------- 背包类型 @ref EPackType
	self.items = {}        -------- 删除的道具列表
end

function MCDelItems:Read(stream)
	self.bagType = stream:readUInt8()		-------- 背包类型 @ref EPackType
	local _items_0_t = {}		-------- 删除的道具列表
	local _items_0_len = stream:readUInt8()
	for _0=1,_items_0_len,1 do
	  table.insert(_items_0_t, stream:readUInt32())
	end
	self.items = _items_0_t
end

function MCDelItems:Write(stream)
	stream:writeUInt8(self.bagType) 
	local _items_0_t = self.items 
	stream:writeUInt8(#_items_0_t)
	for _,_items_1_t in pairs(_items_0_t) do
	  stream:writeUInt32(_items_1_t)
	end
end

------------------------主动更新物品操作------------------------
MCUpdateItems = class("MCUpdateItems", BaseResponse)
MCUpdateItems.PackID = 1403
_G.Protocol["MCUpdateItems"] = 1403
_G.Protocol[1403] = "MCUpdateItems"
function MCUpdateItems:ctor()
	self.bagType = nil       -------- 背包类型 @ref EPackType
	--! UpdateItem
	self.items = {}        -------- 更新道具列表
end

function MCUpdateItems:Read(stream)
	self.bagType = stream:readUInt8()		-------- 背包类型 @ref EPackType
	local _items_0_t = {}		-------- 更新道具列表
	local _items_0_len = stream:readUInt8()
	for _0=1,_items_0_len,1 do
	  local _items_2_o = {}
	  UpdateItem.Read(_items_2_o, stream)
	  table.insert(_items_0_t, _items_2_o)
	end
	self.items = _items_0_t
end

function MCUpdateItems:Write(stream)
	stream:writeUInt8(self.bagType) 
	local _items_0_t = self.items 
	stream:writeUInt8(#_items_0_t)
	for _,_items_1_t in pairs(_items_0_t) do
	  UpdateItem.Write(_items_1_t, stream)
	end
end

------------------------移动道具------------------------
MCMoveItems = class("MCMoveItems", BaseResponse)
MCMoveItems.PackID = 1404
_G.Protocol["MCMoveItems"] = 1404
_G.Protocol[1404] = "MCMoveItems"
function MCMoveItems:ctor()
	--! MoveItem
	self.items = {}        -------- 道具列表
end

function MCMoveItems:Read(stream)
	local _items_0_t = {}		-------- 道具列表
	local _items_0_len = stream:readUInt8()
	for _0=1,_items_0_len,1 do
	  local _items_2_o = {}
	  MoveItem.Read(_items_2_o, stream)
	  table.insert(_items_0_t, _items_2_o)
	end
	self.items = _items_0_t
end

function MCMoveItems:Write(stream)
	local _items_0_t = self.items 
	stream:writeUInt8(#_items_0_t)
	for _,_items_1_t in pairs(_items_0_t) do
	  MoveItem.Write(_items_1_t, stream)
	end
end

------------------------交换道具------------------------
MCExchangeItem = class("MCExchangeItem", BaseResponse)
MCExchangeItem.PackID = 1405
_G.Protocol["MCExchangeItem"] = 1405
_G.Protocol[1405] = "MCExchangeItem"
function MCExchangeItem:ctor()
	self.srcBagType = nil       -------- 源背包类型
	self.srcItemUID = nil       -------- 源道具UID
	self.destBagType = nil       -------- 目标背包类型
	self.destItemUID = nil       -------- 目标道具UID
end

function MCExchangeItem:Read(stream)
	self.srcBagType = stream:readUInt8()		-------- 源背包类型
	self.srcItemUID = stream:readUInt32()		-------- 源道具UID
	self.destBagType = stream:readUInt8()		-------- 目标背包类型
	self.destItemUID = stream:readUInt32()		-------- 目标道具UID
end

function MCExchangeItem:Write(stream)
	stream:writeUInt8(self.srcBagType) 
	stream:writeUInt32(self.srcItemUID) 
	stream:writeUInt8(self.destBagType) 
	stream:writeUInt32(self.destItemUID) 
end

------------------------请求使用、删除、出售、整理------------------------
CMBagOperate = class("CMBagOperate", BaseRequest)
CMBagOperate.PackID = 1409
_G.Protocol["CMBagOperate"] = 1409
_G.Protocol[1409] = "CMBagOperate"
function CMBagOperate:ctor()
	self.opType = nil       -------- 操作类型 @ref EBagOperateType
	self.index = nil       -------- 背包位置
end

function CMBagOperate:Read(stream)
	self.opType = stream:readUInt8()		-------- 操作类型 @ref EBagOperateType
	self.index = stream:readUInt8()		-------- 背包位置
end

function CMBagOperate:Write(stream)
	stream:writeUInt8(self.opType) 
	stream:writeUInt8(self.index) 
end

------------------------返回背包操作结果使用、删除、出售------------------------
MCBagOperateRet = class("MCBagOperateRet", BaseResponse)
MCBagOperateRet.PackID = 1410
_G.Protocol["MCBagOperateRet"] = 1410
_G.Protocol[1410] = "MCBagOperateRet"
function MCBagOperateRet:ctor()
end

function MCBagOperateRet:Read(stream)
end

function MCBagOperateRet:Write(stream)
end

------------------------请求购买背包格子------------------------
CMBagExtend = class("CMBagExtend", BaseRequest)
CMBagExtend.PackID = 1406
_G.Protocol["CMBagExtend"] = 1406
_G.Protocol[1406] = "CMBagExtend"
function CMBagExtend:ctor()
	self.size = nil       -------- 背包增加的格子数
end

function CMBagExtend:Read(stream)
	self.size = stream:readUInt8()		-------- 背包增加的格子数
end

function CMBagExtend:Write(stream)
	stream:writeUInt8(self.size) 
end

------------------------返回购买背包格子结果------------------------
MCBagExtendRet = class("MCBagExtendRet", BaseResponse)
MCBagExtendRet.PackID = 1407
_G.Protocol["MCBagExtendRet"] = 1407
_G.Protocol[1407] = "MCBagExtendRet"
function MCBagExtendRet:ctor()
end

function MCBagExtendRet:Read(stream)
end

function MCBagExtendRet:Write(stream)
end

------------------------背包增加格子------------------------
MCBagExtend = class("MCBagExtend", BaseResponse)
MCBagExtend.PackID = 1408
_G.Protocol["MCBagExtend"] = 1408
_G.Protocol[1408] = "MCBagExtend"
function MCBagExtend:ctor()
	self.size = nil       -------- 背包增加的格子数
end

function MCBagExtend:Read(stream)
	self.size = stream:readUInt8()		-------- 背包增加的格子数
end

function MCBagExtend:Write(stream)
	stream:writeUInt8(self.size) 
end

------------------------输入兑换号,兑换礼包------------------------
CMExchangeGiftReq = class("CMExchangeGiftReq", BaseRequest)
CMExchangeGiftReq.PackID = 4600
_G.Protocol["CMExchangeGiftReq"] = 4600
_G.Protocol[4600] = "CMExchangeGiftReq"
function CMExchangeGiftReq:ctor()
	self.id = nil       -------- 兑换码
end

function CMExchangeGiftReq:Read(stream)
	self.id = stream:readString()		-------- 兑换码
end

function CMExchangeGiftReq:Write(stream)
	stream:writeString(self.id) 
end

------------------------兑换礼包返回------------------------
MCExchangeGiftRet = class("MCExchangeGiftRet", BaseResponse)
MCExchangeGiftRet.PackID = 4601
_G.Protocol["MCExchangeGiftRet"] = 4601
_G.Protocol[4601] = "MCExchangeGiftRet"
function MCExchangeGiftRet:ctor()
	self.itemId = nil       -------- 兑换对应的礼包ID
end

function MCExchangeGiftRet:Read(stream)
	self.itemId = stream:readUInt32()		-------- 兑换对应的礼包ID
end

function MCExchangeGiftRet:Write(stream)
	stream:writeUInt32(self.itemId) 
end

------------------------进入视野------------------------
MCEnterView = class("MCEnterView", BaseResponse)
MCEnterView.PackID = 1200
_G.Protocol["MCEnterView"] = 1200
_G.Protocol[1200] = "MCEnterView"
function MCEnterView:ctor()
	--! RoleDetail
	self.roleList = {}        -------- 玩家列表
end

function MCEnterView:Read(stream)
	local _roleList_0_t = {}		-------- 玩家列表
	local _roleList_0_len = stream:readUInt8()
	for _0=1,_roleList_0_len,1 do
	  local _roleList_2_o = {}
	  RoleDetail.Read(_roleList_2_o, stream)
	  table.insert(_roleList_0_t, _roleList_2_o)
	end
	self.roleList = _roleList_0_t
end

function MCEnterView:Write(stream)
	local _roleList_0_t = self.roleList 
	stream:writeUInt8(#_roleList_0_t)
	for _,_roleList_1_t in pairs(_roleList_0_t) do
	  RoleDetail.Write(_roleList_1_t, stream)
	end
end

------------------------离开视野------------------------
MCLeaveView = class("MCLeaveView", BaseResponse)
MCLeaveView.PackID = 1201
_G.Protocol["MCLeaveView"] = 1201
_G.Protocol[1201] = "MCLeaveView"
function MCLeaveView:ctor()
	self.objAry = {}        -------- 对象列表
end

function MCLeaveView:Read(stream)
	local _objAry_0_t = {}		-------- 对象列表
	local _objAry_0_len = stream:readUInt8()
	for _0=1,_objAry_0_len,1 do
	  table.insert(_objAry_0_t, stream:readUInt32())
	end
	self.objAry = _objAry_0_t
end

function MCLeaveView:Write(stream)
	local _objAry_0_t = self.objAry 
	stream:writeUInt8(#_objAry_0_t)
	for _,_objAry_1_t in pairs(_objAry_0_t) do
	  stream:writeUInt32(_objAry_1_t)
	end
end

------------------------场景数据(NPC, 传送点)------------------------
MCSceneData = class("MCSceneData", BaseResponse)
MCSceneData.PackID = 1202
_G.Protocol["MCSceneData"] = 1202
_G.Protocol[1202] = "MCSceneData"
function MCSceneData:ctor()
	self.npcs = {}        -------- NPC列表
	self.trans = {}        -------- 传送点列表
end

function MCSceneData:Read(stream)
	local _npcs_0_t = {}		-------- NPC列表
	local _npcs_0_len = stream:readUInt8()
	for _0=1,_npcs_0_len,1 do
	  table.insert(_npcs_0_t, stream:readUInt16())
	end
	self.npcs = _npcs_0_t
	local _trans_0_t = {}		-------- 传送点列表
	local _trans_0_len = stream:readUInt8()
	for _0=1,_trans_0_len,1 do
	  table.insert(_trans_0_t, stream:readUInt16())
	end
	self.trans = _trans_0_t
end

function MCSceneData:Write(stream)
	local _npcs_0_t = self.npcs 
	stream:writeUInt8(#_npcs_0_t)
	for _,_npcs_1_t in pairs(_npcs_0_t) do
	  stream:writeUInt16(_npcs_1_t)
	end
	local _trans_0_t = self.trans 
	stream:writeUInt8(#_trans_0_t)
	for _,_trans_1_t in pairs(_trans_0_t) do
	  stream:writeUInt16(_trans_1_t)
	end
end

------------------------请求移动------------------------
CMMove = class("CMMove", BaseRequest)
CMMove.PackID = 1203
_G.Protocol["CMMove"] = 1203
_G.Protocol[1203] = "CMMove"
function CMMove:ctor()
	self.moveType = nil       -------- 移动类型 @ref ERoleMoveType
	--! AxisPos
	self.posList = {}        -------- 坐标列表
end

function CMMove:Read(stream)
	self.moveType = stream:readUInt8()		-------- 移动类型 @ref ERoleMoveType
	local _posList_0_t = {}		-------- 坐标列表
	local _posList_0_len = stream:readUInt8()
	for _0=1,_posList_0_len,1 do
	  local _posList_2_o = {}
	  AxisPos.Read(_posList_2_o, stream)
	  table.insert(_posList_0_t, _posList_2_o)
	end
	self.posList = _posList_0_t
end

function CMMove:Write(stream)
	stream:writeUInt8(self.moveType) 
	local _posList_0_t = self.posList 
	stream:writeUInt8(#_posList_0_t)
	for _,_posList_1_t in pairs(_posList_0_t) do
	  AxisPos.Write(_posList_1_t, stream)
	end
end

------------------------移动返回------------------------
MCMoveRet = class("MCMoveRet", BaseResponse)
MCMoveRet.PackID = 1204
_G.Protocol["MCMoveRet"] = 1204
_G.Protocol[1204] = "MCMoveRet"
function MCMoveRet:ctor()
end

function MCMoveRet:Read(stream)
end

function MCMoveRet:Write(stream)
end

------------------------移动广播------------------------
MCMoveBroad = class("MCMoveBroad", BaseResponse)
MCMoveBroad.PackID = 1205
_G.Protocol["MCMoveBroad"] = 1205
_G.Protocol[1205] = "MCMoveBroad"
function MCMoveBroad:ctor()
	self.objUID = nil       -------- 对象UID
	self.moveType = nil       -------- 移动类型 @ref ERoleMoveType
	--! AxisPos
	self.posList = {}        -------- 位置列表
end

function MCMoveBroad:Read(stream)
	self.objUID = stream:readUInt32()		-------- 对象UID
	self.moveType = stream:readUInt8()		-------- 移动类型 @ref ERoleMoveType
	local _posList_0_t = {}		-------- 位置列表
	local _posList_0_len = stream:readUInt8()
	for _0=1,_posList_0_len,1 do
	  local _posList_2_o = {}
	  AxisPos.Read(_posList_2_o, stream)
	  table.insert(_posList_0_t, _posList_2_o)
	end
	self.posList = _posList_0_t
end

function MCMoveBroad:Write(stream)
	stream:writeUInt32(self.objUID) 
	stream:writeUInt8(self.moveType) 
	local _posList_0_t = self.posList 
	stream:writeUInt8(#_posList_0_t)
	for _,_posList_1_t in pairs(_posList_0_t) do
	  AxisPos.Write(_posList_1_t, stream)
	end
end

------------------------跳跃------------------------
CMJump = class("CMJump", BaseRequest)
CMJump.PackID = 1220
_G.Protocol["CMJump"] = 1220
_G.Protocol[1220] = "CMJump"
function CMJump:ctor()
	self.x = nil       -------- X速度
	self.y = nil       -------- Y速度
end

function CMJump:Read(stream)
	self.x = stream:readInt16()		-------- X速度
	self.y = stream:readInt16()		-------- Y速度
end

function CMJump:Write(stream)
	stream:writeInt16(self.x) 
	stream:writeInt16(self.y) 
end

------------------------跳跃返回------------------------
MCJumpRet = class("MCJumpRet", BaseResponse)
MCJumpRet.PackID = 1221
_G.Protocol["MCJumpRet"] = 1221
_G.Protocol[1221] = "MCJumpRet"
function MCJumpRet:ctor()
	self.objUID = nil       -------- 对象UID
	self.x = nil       -------- X速度
	self.y = nil       -------- Y速度
end

function MCJumpRet:Read(stream)
	self.objUID = stream:readUInt32()		-------- 对象UID
	self.x = stream:readInt16()		-------- X速度
	self.y = stream:readInt16()		-------- Y速度
end

function MCJumpRet:Write(stream)
	stream:writeUInt32(self.objUID) 
	stream:writeInt16(self.x) 
	stream:writeInt16(self.y) 
end

------------------------降落------------------------
CMDrop = class("CMDrop", BaseRequest)
CMDrop.PackID = 1222
_G.Protocol["CMDrop"] = 1222
_G.Protocol[1222] = "CMDrop"
function CMDrop:ctor()
	self.x = nil       -------- X速度
	self.y = nil       -------- Y速度
end

function CMDrop:Read(stream)
	self.x = stream:readInt16()		-------- X速度
	self.y = stream:readInt16()		-------- Y速度
end

function CMDrop:Write(stream)
	stream:writeInt16(self.x) 
	stream:writeInt16(self.y) 
end

------------------------降落返回------------------------
MCDropRet = class("MCDropRet", BaseResponse)
MCDropRet.PackID = 1223
_G.Protocol["MCDropRet"] = 1223
_G.Protocol[1223] = "MCDropRet"
function MCDropRet:ctor()
	self.objUID = nil       -------- 对象UID
	self.x = nil       -------- X速度
	self.y = nil       -------- Y速度
end

function MCDropRet:Read(stream)
	self.objUID = stream:readUInt32()		-------- 对象UID
	self.x = stream:readInt16()		-------- X速度
	self.y = stream:readInt16()		-------- Y速度
end

function MCDropRet:Write(stream)
	stream:writeUInt32(self.objUID) 
	stream:writeInt16(self.x) 
	stream:writeInt16(self.y) 
end

------------------------着陆------------------------
CMLand = class("CMLand", BaseRequest)
CMLand.PackID = 1224
_G.Protocol["CMLand"] = 1224
_G.Protocol[1224] = "CMLand"
function CMLand:ctor()
	self.objUID = nil       -------- 停靠的对象UID(地表则为0)
	self.x = nil       -------- 着陆位置X
	self.y = nil       -------- 着陆位置Y
end

function CMLand:Read(stream)
	self.objUID = stream:readUInt32()		-------- 停靠的对象UID(地表则为0)
	self.x = stream:readInt16()		-------- 着陆位置X
	self.y = stream:readInt16()		-------- 着陆位置Y
end

function CMLand:Write(stream)
	stream:writeUInt32(self.objUID) 
	stream:writeInt16(self.x) 
	stream:writeInt16(self.y) 
end

------------------------着陆返回------------------------
MCLandRet = class("MCLandRet", BaseResponse)
MCLandRet.PackID = 1225
_G.Protocol["MCLandRet"] = 1225
_G.Protocol[1225] = "MCLandRet"
function MCLandRet:ctor()
	self.srcObjUID = nil       -------- 对象UID
	self.objUID = nil       -------- 停靠的对象UID(地表则为0)
	self.x = nil       -------- 着陆位置X
	self.y = nil       -------- 着陆位置Y
end

function MCLandRet:Read(stream)
	self.srcObjUID = stream:readUInt32()		-------- 对象UID
	self.objUID = stream:readUInt32()		-------- 停靠的对象UID(地表则为0)
	self.x = stream:readInt16()		-------- 着陆位置X
	self.y = stream:readInt16()		-------- 着陆位置Y
end

function MCLandRet:Write(stream)
	stream:writeUInt32(self.srcObjUID) 
	stream:writeUInt32(self.objUID) 
	stream:writeInt16(self.x) 
	stream:writeInt16(self.y) 
end

------------------------瞬移------------------------
MCResetPos = class("MCResetPos", BaseResponse)
MCResetPos.PackID = 1226
_G.Protocol["MCResetPos"] = 1226
_G.Protocol[1226] = "MCResetPos"
function MCResetPos:ctor()
	self.objUID = nil       -------- 对象UID
	self.x = nil       -------- X位置
	self.y = nil       -------- Y位置
	self.type = nil       -------- 类型(@ref EResetPosType)
end

function MCResetPos:Read(stream)
	self.objUID = stream:readUInt32()		-------- 对象UID
	self.x = stream:readInt16()		-------- X位置
	self.y = stream:readInt16()		-------- Y位置
	self.type = stream:readUInt8()		-------- 类型(@ref EResetPosType)
end

function MCResetPos:Write(stream)
	stream:writeUInt32(self.objUID) 
	stream:writeInt16(self.x) 
	stream:writeInt16(self.y) 
	stream:writeUInt8(self.type) 
end

------------------------通知角色已经可以进入场景------------------------
MCEnterScene = class("MCEnterScene", BaseResponse)
MCEnterScene.PackID = 1229
_G.Protocol["MCEnterScene"] = 1229
_G.Protocol[1229] = "MCEnterScene"
function MCEnterScene:ctor()
	self.mapType = nil       -------- 地图类型
end

function MCEnterScene:Read(stream)
	self.mapType = stream:readUInt8()		-------- 地图类型
end

function MCEnterScene:Write(stream)
	stream:writeUInt8(self.mapType) 
end

------------------------进入场景------------------------
CMEnterScene = class("CMEnterScene", BaseRequest)
CMEnterScene.PackID = 1206
_G.Protocol["CMEnterScene"] = 1206
_G.Protocol[1206] = "CMEnterScene"
function CMEnterScene:ctor()
end

function CMEnterScene:Read(stream)
end

function CMEnterScene:Write(stream)
end

------------------------进入场景返回------------------------
MCEnterSceneRet = class("MCEnterSceneRet", BaseResponse)
MCEnterSceneRet.PackID = 1212
_G.Protocol["MCEnterSceneRet"] = 1212
_G.Protocol[1212] = "MCEnterSceneRet"
function MCEnterSceneRet:ctor()
	self.mapID = nil       -------- 地图ID
	--! AxisPos
	self.pos = nil       -------- 当前坐标
	self.npcs = {}        -------- NPC列表
	self.trans = {}        -------- 传送点列表
end

function MCEnterSceneRet:Read(stream)
	self.mapID = stream:readUInt16()		-------- 地图ID
	self.pos = {}		-------- 当前坐标
	AxisPos.Read(self.pos, stream)
	local _npcs_0_t = {}		-------- NPC列表
	local _npcs_0_len = stream:readUInt8()
	for _0=1,_npcs_0_len,1 do
	  table.insert(_npcs_0_t, stream:readUInt16())
	end
	self.npcs = _npcs_0_t
	local _trans_0_t = {}		-------- 传送点列表
	local _trans_0_len = stream:readUInt8()
	for _0=1,_trans_0_len,1 do
	  table.insert(_trans_0_t, stream:readUInt16())
	end
	self.trans = _trans_0_t
end

function MCEnterSceneRet:Write(stream)
	stream:writeUInt16(self.mapID) 
	AxisPos.Write(self.pos, stream)
	local _npcs_0_t = self.npcs 
	stream:writeUInt8(#_npcs_0_t)
	for _,_npcs_1_t in pairs(_npcs_0_t) do
	  stream:writeUInt16(_npcs_1_t)
	end
	local _trans_0_t = self.trans 
	stream:writeUInt8(#_trans_0_t)
	for _,_trans_1_t in pairs(_trans_0_t) do
	  stream:writeUInt16(_trans_1_t)
	end
end

------------------------切换地图------------------------
CMChangeMap = class("CMChangeMap", BaseRequest)
CMChangeMap.PackID = 1232
_G.Protocol["CMChangeMap"] = 1232
_G.Protocol[1232] = "CMChangeMap"
function CMChangeMap:ctor()
	self.mapID = nil       -------- 地图ID
end

function CMChangeMap:Read(stream)
	self.mapID = stream:readUInt16()		-------- 地图ID
end

function CMChangeMap:Write(stream)
	stream:writeUInt16(self.mapID) 
end

------------------------切换地图返回------------------------
MCChangeMapRet = class("MCChangeMapRet", BaseResponse)
MCChangeMapRet.PackID = 1233
_G.Protocol["MCChangeMapRet"] = 1233
_G.Protocol[1233] = "MCChangeMapRet"
function MCChangeMapRet:ctor()
	self.mapID = nil       -------- 地图ID
end

function MCChangeMapRet:Read(stream)
	self.mapID = stream:readUInt16()		-------- 地图ID
end

function MCChangeMapRet:Write(stream)
	stream:writeUInt16(self.mapID) 
end

------------------------动态地图列表------------------------
CMDynamicMapList = class("CMDynamicMapList", BaseRequest)
CMDynamicMapList.PackID = 1234
_G.Protocol["CMDynamicMapList"] = 1234
_G.Protocol[1234] = "CMDynamicMapList"
function CMDynamicMapList:ctor()
	self.mapType = nil       -------- 地图类型
end

function CMDynamicMapList:Read(stream)
	self.mapType = stream:readUInt8()		-------- 地图类型
end

function CMDynamicMapList:Write(stream)
	stream:writeUInt8(self.mapType) 
end

------------------------动态地图列表返回------------------------
MCDynamicMapListRet = class("MCDynamicMapListRet", BaseResponse)
MCDynamicMapListRet.PackID = 1235
_G.Protocol["MCDynamicMapListRet"] = 1235
_G.Protocol[1235] = "MCDynamicMapListRet"
function MCDynamicMapListRet:ctor()
	self.scenes = {}        -------- 场景列表
end

function MCDynamicMapListRet:Read(stream)
	local _scenes_0_t = {}		-------- 场景列表
	local _scenes_0_len = stream:readUInt8()
	for _0=1,_scenes_0_len,1 do
	  table.insert(_scenes_0_t, stream:readUInt64())
	end
	self.scenes = _scenes_0_t
end

function MCDynamicMapListRet:Write(stream)
	local _scenes_0_t = self.scenes 
	stream:writeUInt8(#_scenes_0_t)
	for _,_scenes_1_t in pairs(_scenes_0_t) do
	  stream:writeUInt64(_scenes_1_t)
	end
end

------------------------聊天请求------------------------
CMChat = class("CMChat", BaseRequest)
CMChat.PackID = 1207
_G.Protocol["CMChat"] = 1207
_G.Protocol[1207] = "CMChat"
function CMChat:ctor()
	self.channelType = nil       -------- 聊天频道（0非法，1世界，2军团，3私聊，4公告, 5GM)
	self.objUid = nil       -------- 角色uid（目标者）
	self.roleName = nil       -------- 角色名字
	self.msg = nil       -------- 消息内容
	self.perMsg = nil       -------- 特殊的消息内容（供客户端额外使用）
end

function CMChat:Read(stream)
	self.channelType = stream:readUInt8()		-------- 聊天频道（0非法，1世界，2军团，3私聊，4公告, 5GM)
	self.objUid = stream:readUInt32()		-------- 角色uid（目标者）
	self.roleName = stream:readString()		-------- 角色名字
	self.msg = stream:readString()		-------- 消息内容
	self.perMsg = stream:readString()		-------- 特殊的消息内容（供客户端额外使用）
end

function CMChat:Write(stream)
	stream:writeUInt8(self.channelType) 
	stream:writeUInt32(self.objUid) 
	stream:writeString(self.roleName) 
	stream:writeString(self.msg) 
	stream:writeString(self.perMsg) 
end

------------------------聊天广播 ------------------------
MCChatBroad = class("MCChatBroad", BaseResponse)
MCChatBroad.PackID = 1208
_G.Protocol["MCChatBroad"] = 1208
_G.Protocol[1208] = "MCChatBroad"
function MCChatBroad:ctor()
	self.channelType = nil       -------- 聊天频道
	self.objUid = nil       -------- 角色uid（发送者）
	self.roleName = nil       -------- 角色名字
	self.msg = nil       -------- 消息内容
	self.perMsg = nil       -------- 特殊的消息内容（供客户端额外使用）
end

function MCChatBroad:Read(stream)
	self.channelType = stream:readUInt8()		-------- 聊天频道
	self.objUid = stream:readUInt32()		-------- 角色uid（发送者）
	self.roleName = stream:readString()		-------- 角色名字
	self.msg = stream:readString()		-------- 消息内容
	self.perMsg = stream:readString()		-------- 特殊的消息内容（供客户端额外使用）
end

function MCChatBroad:Write(stream)
	stream:writeUInt8(self.channelType) 
	stream:writeUInt32(self.objUid) 
	stream:writeString(self.roleName) 
	stream:writeString(self.msg) 
	stream:writeString(self.perMsg) 
end

------------------------公告及提示------------------------
MCAnnouncement = class("MCAnnouncement", BaseResponse)
MCAnnouncement.PackID = 1219
_G.Protocol["MCAnnouncement"] = 1219
_G.Protocol[1219] = "MCAnnouncement"
function MCAnnouncement:ctor()
	self.id = nil       -------- 公告ID 如果公告ID为0则msg表示公告内容,直接显示
	self.key = nil       -------- 公告Key
	self.msg = nil       -------- 公告信息 格式: type1|id|xxx,type2|id|xxx @ref EAnnouncement
end

function MCAnnouncement:Read(stream)
	self.id = stream:readInt16()		-------- 公告ID 如果公告ID为0则msg表示公告内容,直接显示
	self.key = stream:readString()		-------- 公告Key
	self.msg = stream:readString()		-------- 公告信息 格式: type1|id|xxx,type2|id|xxx @ref EAnnouncement
end

function MCAnnouncement:Write(stream)
	stream:writeInt16(self.id) 
	stream:writeString(self.key) 
	stream:writeString(self.msg) 
end

------------------------传送点传送------------------------
CMTransmite = class("CMTransmite", BaseRequest)
CMTransmite.PackID = 1209
_G.Protocol["CMTransmite"] = 1209
_G.Protocol[1209] = "CMTransmite"
function CMTransmite:ctor()
	self.transportTypeID = nil       -------- 传送点类型ID
end

function CMTransmite:Read(stream)
	self.transportTypeID = stream:readUInt16()		-------- 传送点类型ID
end

function CMTransmite:Write(stream)
	stream:writeUInt16(self.transportTypeID) 
end

------------------------传送返回------------------------
MCTransmiteRet = class("MCTransmiteRet", BaseResponse)
MCTransmiteRet.PackID = 1210
_G.Protocol["MCTransmiteRet"] = 1210
_G.Protocol[1210] = "MCTransmiteRet"
function MCTransmiteRet:ctor()
end

function MCTransmiteRet:Read(stream)
end

function MCTransmiteRet:Write(stream)
end

------------------------同步角色数据------------------------
MCSyncRoleData = class("MCSyncRoleData", BaseResponse)
MCSyncRoleData.PackID = 1211
_G.Protocol["MCSyncRoleData"] = 1211
_G.Protocol[1211] = "MCSyncRoleData"
function MCSyncRoleData:ctor()
	self.objUID = nil       -------- 对象UID
	self.num = nil       -------- 数目
	self.datas = {}        -------- 混合结构列表(枚举[8位]:属性值[根据具体的类型获得实际位数]) @ref EAttributes @ref RoleAttrBackup
end

function MCSyncRoleData:Read(stream)
	self.objUID = stream:readUInt32()		-------- 对象UID
	self.num = stream:readUInt8()		-------- 数目
	local _datas_0_t = {}		-------- 混合结构列表(枚举[8位]:属性值[根据具体的类型获得实际位数]) @ref EAttributes @ref RoleAttrBackup
	local _datas_0_len = stream:readUInt16()
	for _0=1,_datas_0_len,1 do
	  table.insert(_datas_0_t, stream:readInt8())
	end
	self.datas = _datas_0_t
end

function MCSyncRoleData:Write(stream)
	stream:writeUInt32(self.objUID) 
	stream:writeUInt8(self.num) 
	local _datas_0_t = self.datas 
	stream:writeUInt16(#_datas_0_t)
	for _,_datas_1_t in pairs(_datas_0_t) do
	  stream:writeInt8(_datas_1_t)
	end
end

------------------------返回错误码------------------------
MCCallBackRetCode = class("MCCallBackRetCode", BaseResponse)
MCCallBackRetCode.PackID = 3999
_G.Protocol["MCCallBackRetCode"] = 3999
_G.Protocol[3999] = "MCCallBackRetCode"
function MCCallBackRetCode:ctor()
	self.callRetCode = nil       -------- 返回码
end

function MCCallBackRetCode:Read(stream)
	self.callRetCode = stream:readUInt16()		-------- 返回码
end

function MCCallBackRetCode:Write(stream)
	stream:writeUInt16(self.callRetCode) 
end

------------------------角色修改名字------------------------
CMRenameRoleName = class("CMRenameRoleName", BaseRequest)
CMRenameRoleName.PackID = 1213
_G.Protocol["CMRenameRoleName"] = 1213
_G.Protocol[1213] = "CMRenameRoleName"
function CMRenameRoleName:ctor()
	self.roleName = nil       -------- 角色名字
end

function CMRenameRoleName:Read(stream)
	self.roleName = stream:readString()		-------- 角色名字
end

function CMRenameRoleName:Write(stream)
	stream:writeString(self.roleName) 
end

------------------------角色修改名字返回------------------------
MCRenameRoleNameRet = class("MCRenameRoleNameRet", BaseResponse)
MCRenameRoleNameRet.PackID = 1214
_G.Protocol["MCRenameRoleNameRet"] = 1214
_G.Protocol[1214] = "MCRenameRoleNameRet"
function MCRenameRoleNameRet:ctor()
	self.roleName = nil       -------- 角色名字
end

function MCRenameRoleNameRet:Read(stream)
	self.roleName = stream:readString()		-------- 角色名字
end

function MCRenameRoleNameRet:Write(stream)
	stream:writeString(self.roleName) 
end

------------------------角色随机名字------------------------
CMRandRoleName = class("CMRandRoleName", BaseRequest)
CMRandRoleName.PackID = 1215
_G.Protocol["CMRandRoleName"] = 1215
_G.Protocol[1215] = "CMRandRoleName"
function CMRandRoleName:ctor()
end

function CMRandRoleName:Read(stream)
end

function CMRandRoleName:Write(stream)
end

------------------------角色随机名字返回------------------------
MCRandRoleNameRet = class("MCRandRoleNameRet", BaseResponse)
MCRandRoleNameRet.PackID = 1216
_G.Protocol["MCRandRoleNameRet"] = 1216
_G.Protocol[1216] = "MCRandRoleNameRet"
function MCRandRoleNameRet:ctor()
	self.roleName = nil       -------- 角色名字
end

function MCRandRoleNameRet:Read(stream)
	self.roleName = stream:readString()		-------- 角色名字
end

function MCRandRoleNameRet:Write(stream)
	stream:writeString(self.roleName) 
end

------------------------踢掉玩家------------------------
MCKickRole = class("MCKickRole", BaseResponse)
MCKickRole.PackID = 1217
_G.Protocol["MCKickRole"] = 1217
_G.Protocol[1217] = "MCKickRole"
function MCKickRole:ctor()
	self.type = nil       -------- 踢掉玩家类型 @ref EKickType
end

function MCKickRole:Read(stream)
	self.type = stream:readInt8()		-------- 踢掉玩家类型 @ref EKickType
end

function MCKickRole:Write(stream)
	stream:writeInt8(self.type) 
end

------------------------开启动态场景------------------------
CMOpenDynamicMap = class("CMOpenDynamicMap", BaseRequest)
CMOpenDynamicMap.PackID = 1230
_G.Protocol["CMOpenDynamicMap"] = 1230
_G.Protocol[1230] = "CMOpenDynamicMap"
function CMOpenDynamicMap:ctor()
	self.mapID = nil       -------- 地图ID
end

function CMOpenDynamicMap:Read(stream)
	self.mapID = stream:readUInt16()		-------- 地图ID
end

function CMOpenDynamicMap:Write(stream)
	stream:writeUInt16(self.mapID) 
end

------------------------开启动态场景返回------------------------
MCOpenDynamicMapRet = class("MCOpenDynamicMapRet", BaseResponse)
MCOpenDynamicMapRet.PackID = 1231
_G.Protocol["MCOpenDynamicMapRet"] = 1231
_G.Protocol[1231] = "MCOpenDynamicMapRet"
function MCOpenDynamicMapRet:ctor()
	self.mapID = nil       -------- 地图ID
end

function MCOpenDynamicMapRet:Read(stream)
	self.mapID = stream:readUInt16()		-------- 地图ID
end

function MCOpenDynamicMapRet:Write(stream)
	stream:writeUInt16(self.mapID) 
end

------------------------------------------------
CMWorldChatMsg = class("CMWorldChatMsg", BaseRequest)
CMWorldChatMsg.PackID = 87
_G.Protocol["CMWorldChatMsg"] = 87
_G.Protocol[87] = "CMWorldChatMsg"
function CMWorldChatMsg:ctor()
	self.msg = nil       -------- 
end

function CMWorldChatMsg:Read(stream)
	self.msg = stream:readString()		-------- 
end

function CMWorldChatMsg:Write(stream)
	stream:writeString(self.msg) 
end

------------------------------------------------
MCWorldChatMsg = class("MCWorldChatMsg", BaseResponse)
MCWorldChatMsg.PackID = 853
_G.Protocol["MCWorldChatMsg"] = 853
_G.Protocol[853] = "MCWorldChatMsg"
function MCWorldChatMsg:ctor()
	self.fromPlayer = nil       -------- 
	self.fromPlayerTitle = nil       -------- 
	self.msg = nil       -------- 
	self.fromPlayerVipLv = nil       -------- 
end

function MCWorldChatMsg:Read(stream)
	self.fromPlayer = stream:readString()		-------- 
	self.fromPlayerTitle = stream:readString()		-------- 
	self.msg = stream:readString()		-------- 
	self.fromPlayerVipLv = stream:readInt16()		-------- 
end

function MCWorldChatMsg:Write(stream)
	stream:writeString(self.fromPlayer) 
	stream:writeString(self.fromPlayerTitle) 
	stream:writeString(self.msg) 
	stream:writeInt16(self.fromPlayerVipLv) 
end

------------------------------------------------
CMRoomChatMsg = class("CMRoomChatMsg", BaseRequest)
CMRoomChatMsg.PackID = 88
_G.Protocol["CMRoomChatMsg"] = 88
_G.Protocol[88] = "CMRoomChatMsg"
function CMRoomChatMsg:ctor()
	self.msg = nil       -------- 
end

function CMRoomChatMsg:Read(stream)
	self.msg = stream:readString()		-------- 
end

function CMRoomChatMsg:Write(stream)
	stream:writeString(self.msg) 
end

------------------------------------------------
MCRoomChatMsg = class("MCRoomChatMsg", BaseResponse)
MCRoomChatMsg.PackID = 854
_G.Protocol["MCRoomChatMsg"] = 854
_G.Protocol[854] = "MCRoomChatMsg"
function MCRoomChatMsg:ctor()
	self.fromPlayer = nil       -------- 
	self.fromPlayerTitle = nil       -------- 
	self.msg = nil       -------- 
	self.fromPlayerVipLv = nil       -------- 
end

function MCRoomChatMsg:Read(stream)
	self.fromPlayer = stream:readString()		-------- 
	self.fromPlayerTitle = stream:readString()		-------- 
	self.msg = stream:readString()		-------- 
	self.fromPlayerVipLv = stream:readInt16()		-------- 
end

function MCRoomChatMsg:Write(stream)
	stream:writeString(self.fromPlayer) 
	stream:writeString(self.fromPlayerTitle) 
	stream:writeString(self.msg) 
	stream:writeInt16(self.fromPlayerVipLv) 
end

------------------------------------------------
MCScreenAnnounce = class("MCScreenAnnounce", BaseResponse)
MCScreenAnnounce.PackID = 491
_G.Protocol["MCScreenAnnounce"] = 491
_G.Protocol[491] = "MCScreenAnnounce"
function MCScreenAnnounce:ctor()
	self.name = nil       -------- 
	self.type = nil       -------- 
	self.count = nil       -------- 
end

function MCScreenAnnounce:Read(stream)
	self.name = stream:readString()		-------- 
	self.type = stream:readUInt8()		-------- 
	self.count = stream:readInt32()		-------- 
end

function MCScreenAnnounce:Write(stream)
	stream:writeString(self.name) 
	stream:writeUInt8(self.type) 
	stream:writeInt32(self.count) 
end

------------------------攻击广播------------------------
MCAttackBroad = class("MCAttackBroad", BaseResponse)
MCAttackBroad.PackID = 1300
_G.Protocol["MCAttackBroad"] = 1300
_G.Protocol[1300] = "MCAttackBroad"
function MCAttackBroad:ctor()
	self.srcObjUID = nil       -------- 
	self.destObjUID = nil       -------- 
	self.skillID = nil       -------- 
	self.x = nil       -------- 
	self.y = nil       -------- 
	self.objs = {}        -------- 
end

function MCAttackBroad:Read(stream)
	self.srcObjUID = stream:readUInt32()		-------- 
	self.destObjUID = stream:readUInt32()		-------- 
	self.skillID = stream:readUInt16()		-------- 
	self.x = stream:readInt16()		-------- 
	self.y = stream:readInt16()		-------- 
	local _objs_0_t = {}		-------- 
	local _objs_0_len = stream:readUInt8()
	for _0=1,_objs_0_len,1 do
	  table.insert(_objs_0_t, stream:readUInt32())
	end
	self.objs = _objs_0_t
end

function MCAttackBroad:Write(stream)
	stream:writeUInt32(self.srcObjUID) 
	stream:writeUInt32(self.destObjUID) 
	stream:writeUInt16(self.skillID) 
	stream:writeInt16(self.x) 
	stream:writeInt16(self.y) 
	local _objs_0_t = self.objs 
	stream:writeUInt8(#_objs_0_t)
	for _,_objs_1_t in pairs(_objs_0_t) do
	  stream:writeUInt32(_objs_1_t)
	end
end

------------------------攻击效果------------------------
MCAttackImpact = class("MCAttackImpact", BaseResponse)
MCAttackImpact.PackID = 1301
_G.Protocol["MCAttackImpact"] = 1301
_G.Protocol[1301] = "MCAttackImpact"
function MCAttackImpact:ctor()
	self.skillID = nil       -------- 
	--! AttackorImpact
	self.attackors = {}        -------- 
end

function MCAttackImpact:Read(stream)
	self.skillID = stream:readUInt16()		-------- 
	local _attackors_0_t = {}		-------- 
	local _attackors_0_len = stream:readUInt8()
	for _0=1,_attackors_0_len,1 do
	  local _attackors_2_o = {}
	  AttackorImpact.Read(_attackors_2_o, stream)
	  table.insert(_attackors_0_t, _attackors_2_o)
	end
	self.attackors = _attackors_0_t
end

function MCAttackImpact:Write(stream)
	stream:writeUInt16(self.skillID) 
	local _attackors_0_t = self.attackors 
	stream:writeUInt8(#_attackors_0_t)
	for _,_attackors_1_t in pairs(_attackors_0_t) do
	  AttackorImpact.Write(_attackors_1_t, stream)
	end
end

------------------------行为禁止标记改变------------------------
MCObjActionBan = class("MCObjActionBan", BaseResponse)
MCObjActionBan.PackID = 1308
_G.Protocol["MCObjActionBan"] = 1308
_G.Protocol[1308] = "MCObjActionBan"
function MCObjActionBan:ctor()
	self.objUID = nil       -------- 
	self.state = nil       -------- 
end

function MCObjActionBan:Read(stream)
	self.objUID = stream:readUInt32()		-------- 
	self.state = stream:readUInt16()		-------- 
end

function MCObjActionBan:Write(stream)
	stream:writeUInt32(self.objUID) 
	stream:writeUInt16(self.state) 
end

------------------------添加BUFFER------------------------
MCAddBuffer = class("MCAddBuffer", BaseResponse)
MCAddBuffer.PackID = 1306
_G.Protocol["MCAddBuffer"] = 1306
_G.Protocol[1306] = "MCAddBuffer"
function MCAddBuffer:ctor()
	--! PackSimpleBuff
	self.ary = {}        -------- 
end

function MCAddBuffer:Read(stream)
	local _ary_0_t = {}		-------- 
	local _ary_0_len = stream:readUInt8()
	for _0=1,_ary_0_len,1 do
	  local _ary_2_o = {}
	  PackSimpleBuff.Read(_ary_2_o, stream)
	  table.insert(_ary_0_t, _ary_2_o)
	end
	self.ary = _ary_0_t
end

function MCAddBuffer:Write(stream)
	local _ary_0_t = self.ary 
	stream:writeUInt8(#_ary_0_t)
	for _,_ary_1_t in pairs(_ary_0_t) do
	  PackSimpleBuff.Write(_ary_1_t, stream)
	end
end

------------------------删除BUFFER------------------------
MCDelBuffer = class("MCDelBuffer", BaseResponse)
MCDelBuffer.PackID = 1307
_G.Protocol["MCDelBuffer"] = 1307
_G.Protocol[1307] = "MCDelBuffer"
function MCDelBuffer:ctor()
	self.objUID = nil       -------- 
	self.ary = {}        -------- 
end

function MCDelBuffer:Read(stream)
	self.objUID = stream:readUInt32()		-------- 
	local _ary_0_t = {}		-------- 
	local _ary_0_len = stream:readUInt16()
	for _0=1,_ary_0_len,1 do
	  table.insert(_ary_0_t, stream:readUInt16())
	end
	self.ary = _ary_0_t
end

function MCDelBuffer:Write(stream)
	stream:writeUInt32(self.objUID) 
	local _ary_0_t = self.ary 
	stream:writeUInt16(#_ary_0_t)
	for _,_ary_1_t in pairs(_ary_0_t) do
	  stream:writeUInt16(_ary_1_t)
	end
end

------------------------请求Buff列表------------------------
CMBuffArray = class("CMBuffArray", BaseRequest)
CMBuffArray.PackID = 1302
_G.Protocol["CMBuffArray"] = 1302
_G.Protocol[1302] = "CMBuffArray"
function CMBuffArray:ctor()
	self.objUID = nil       -------- 
end

function CMBuffArray:Read(stream)
	self.objUID = stream:readUInt32()		-------- 
end

function CMBuffArray:Write(stream)
	stream:writeUInt32(self.objUID) 
end

------------------------Buff列表返回------------------------
MCBuffArrayRet = class("MCBuffArrayRet", BaseResponse)
MCBuffArrayRet.PackID = 1303
_G.Protocol["MCBuffArrayRet"] = 1303
_G.Protocol[1303] = "MCBuffArrayRet"
function MCBuffArrayRet:ctor()
	self.objUID = nil       -------- 
end

function MCBuffArrayRet:Read(stream)
	self.objUID = stream:readUInt32()		-------- 
end

function MCBuffArrayRet:Write(stream)
	stream:writeUInt32(self.objUID) 
end

------------------------查看单个Buff------------------------
CMViewBuff = class("CMViewBuff", BaseRequest)
CMViewBuff.PackID = 1304
_G.Protocol["CMViewBuff"] = 1304
_G.Protocol[1304] = "CMViewBuff"
function CMViewBuff:ctor()
	self.objUID = nil       -------- 
	self.buffTypeID = nil       -------- 
end

function CMViewBuff:Read(stream)
	self.objUID = stream:readUInt32()		-------- 
	self.buffTypeID = stream:readUInt16()		-------- 
end

function CMViewBuff:Write(stream)
	stream:writeUInt32(self.objUID) 
	stream:writeUInt16(self.buffTypeID) 
end

------------------------查看单个Buff返回------------------------
MCViewBuffRet = class("MCViewBuffRet", BaseResponse)
MCViewBuffRet.PackID = 1305
_G.Protocol["MCViewBuffRet"] = 1305
_G.Protocol[1305] = "MCViewBuffRet"
function MCViewBuffRet:ctor()
	--! PackBuffer
	self.buff = nil       -------- 
end

function MCViewBuffRet:Read(stream)
	self.buff = {}		-------- 
	PackBuffer.Read(self.buff, stream)
end

function MCViewBuffRet:Write(stream)
	PackBuffer.Write(self.buff, stream)
end

------------------------打开战斗关卡------------------------
CMFightOpenChapter = class("CMFightOpenChapter", BaseRequest)
CMFightOpenChapter.PackID = 1311
_G.Protocol["CMFightOpenChapter"] = 1311
_G.Protocol[1311] = "CMFightOpenChapter"
function CMFightOpenChapter:ctor()
	self.chapterTypeID = nil       -------- 关卡ID
end

function CMFightOpenChapter:Read(stream)
	self.chapterTypeID = stream:readInt32()		-------- 关卡ID
end

function CMFightOpenChapter:Write(stream)
	stream:writeInt32(self.chapterTypeID) 
end

------------------------打开战斗关卡返回------------------------
MCFightOpenChapterRet = class("MCFightOpenChapterRet", BaseResponse)
MCFightOpenChapterRet.PackID = 1312
_G.Protocol["MCFightOpenChapterRet"] = 1312
_G.Protocol[1312] = "MCFightOpenChapterRet"
function MCFightOpenChapterRet:ctor()
	self.chapterTypeID = nil       -------- 关卡ID
end

function MCFightOpenChapterRet:Read(stream)
	self.chapterTypeID = stream:readInt32()		-------- 关卡ID
end

function MCFightOpenChapterRet:Write(stream)
	stream:writeInt32(self.chapterTypeID) 
end

------------------------战斗完成------------------------
CMFightFinish = class("CMFightFinish", BaseRequest)
CMFightFinish.PackID = 1309
_G.Protocol["CMFightFinish"] = 1309
_G.Protocol[1309] = "CMFightFinish"
function CMFightFinish:ctor()
	self.victoryFlag = nil       -------- 胜利标记(-1放弃, 0失败, 1胜利)
end

function CMFightFinish:Read(stream)
	self.victoryFlag = stream:readInt8()		-------- 胜利标记(-1放弃, 0失败, 1胜利)
end

function CMFightFinish:Write(stream)
	stream:writeInt8(self.victoryFlag) 
end

------------------------战斗完成返回------------------------
MCFightFinishRet = class("MCFightFinishRet", BaseResponse)
MCFightFinishRet.PackID = 1310
_G.Protocol["MCFightFinishRet"] = 1310
_G.Protocol[1310] = "MCFightFinishRet"
function MCFightFinishRet:ctor()
end

function MCFightFinishRet:Read(stream)
end

function MCFightFinishRet:Write(stream)
end

------------------------登陆服务器请求------------------------
CMLoginServer = class("CMLoginServer", BaseRequest)
CMLoginServer.PackID = 2001
_G.Protocol["CMLoginServer"] = 2001
_G.Protocol[2001] = "CMLoginServer"
function CMLoginServer:ctor()
	self.platformId = nil       -------- 
	self.keyId = nil       -------- 
	self.accountPass = nil       -------- 
	self.isGuest = nil       -------- 
	self.OS = nil       -------- 
end

function CMLoginServer:Read(stream)
	self.platformId = stream:readUInt16()		-------- 
	self.keyId = stream:readString()		-------- 
	self.accountPass = stream:readString()		-------- 
	self.isGuest = stream:readInt8()		-------- 
	self.OS = stream:readInt8()		-------- 
end

function CMLoginServer:Write(stream)
	stream:writeUInt16(self.platformId) 
	stream:writeString(self.keyId) 
	stream:writeString(self.accountPass) 
	stream:writeInt8(self.isGuest) 
	stream:writeInt8(self.OS) 
end

------------------------登陆服务器返回------------------------
MCLoginServerRet = class("MCLoginServerRet", BaseResponse)
MCLoginServerRet.PackID = 20011
_G.Protocol["MCLoginServerRet"] = 20011
_G.Protocol[20011] = "MCLoginServerRet"
function MCLoginServerRet:ctor()
end

function MCLoginServerRet:Read(stream)
end

function MCLoginServerRet:Write(stream)
end

------------------------服务器列表返回------------------------
MCServerListSvr = class("MCServerListSvr", BaseResponse)
MCServerListSvr.PackID = 20021
_G.Protocol["MCServerListSvr"] = 20021
_G.Protocol[20021] = "MCServerListSvr"
function MCServerListSvr:ctor()
	--! ZoneServer
	self.platformList = {}        -------- 区服列表
end

function MCServerListSvr:Read(stream)
	local _platformList_0_t = {}		-------- 区服列表
	local _platformList_0_len = stream:readUInt16()
	for _0=1,_platformList_0_len,1 do
	  local _platformList_2_o = {}
	  ZoneServer.Read(_platformList_2_o, stream)
	  table.insert(_platformList_0_t, _platformList_2_o)
	end
	self.platformList = _platformList_0_t
end

function MCServerListSvr:Write(stream)
	local _platformList_0_t = self.platformList 
	stream:writeUInt16(#_platformList_0_t)
	for _,_platformList_1_t in pairs(_platformList_0_t) do
	  ZoneServer.Write(_platformList_1_t, stream)
	end
end

------------------------获取该账号登陆过的服务器请求------------------------
CMLoginLogList = class("CMLoginLogList", BaseRequest)
CMLoginLogList.PackID = 2010
_G.Protocol["CMLoginLogList"] = 2010
_G.Protocol[2010] = "CMLoginLogList"
function CMLoginLogList:ctor()
end

function CMLoginLogList:Read(stream)
end

function CMLoginLogList:Write(stream)
end

------------------------获取该账号登陆过的服务器返回------------------------
MCLoginLogListRet = class("MCLoginLogListRet", BaseResponse)
MCLoginLogListRet.PackID = 20101
_G.Protocol["MCLoginLogListRet"] = 20101
_G.Protocol[20101] = "MCLoginLogListRet"
function MCLoginLogListRet:ctor()
	--! LoginServerLog
	self.loginLogList = {}        -------- 区服列表
end

function MCLoginLogListRet:Read(stream)
	local _loginLogList_0_t = {}		-------- 区服列表
	local _loginLogList_0_len = stream:readUInt16()
	for _0=1,_loginLogList_0_len,1 do
	  local _loginLogList_2_o = {}
	  LoginServerLog.Read(_loginLogList_2_o, stream)
	  table.insert(_loginLogList_0_t, _loginLogList_2_o)
	end
	self.loginLogList = _loginLogList_0_t
end

function MCLoginLogListRet:Write(stream)
	local _loginLogList_0_t = self.loginLogList 
	stream:writeUInt16(#_loginLogList_0_t)
	for _,_loginLogList_1_t in pairs(_loginLogList_0_t) do
	  LoginServerLog.Write(_loginLogList_1_t, stream)
	end
end

------------------------选择服务器信息请求------------------------
CMSelectServerMsg = class("CMSelectServerMsg", BaseRequest)
CMSelectServerMsg.PackID = 2003
_G.Protocol["CMSelectServerMsg"] = 2003
_G.Protocol[2003] = "CMSelectServerMsg"
function CMSelectServerMsg:ctor()
	self.serverId = nil       -------- 区服ID
end

function CMSelectServerMsg:Read(stream)
	self.serverId = stream:readUInt16()		-------- 区服ID
end

function CMSelectServerMsg:Write(stream)
	stream:writeUInt16(self.serverId) 
end

------------------------选择服务器信息返回------------------------
MCSelectServerMsgRet = class("MCSelectServerMsgRet", BaseResponse)
MCSelectServerMsgRet.PackID = 20031
_G.Protocol["MCSelectServerMsgRet"] = 20031
_G.Protocol[20031] = "MCSelectServerMsgRet"
function MCSelectServerMsgRet:ctor()
	self.accountId = nil       -------- 账号名
	self.md5 = nil       -------- 密码MD5
	self.ip = nil       -------- IP
	self.port = nil       -------- 端口
	self.platformId = nil       -------- 平台
end

function MCSelectServerMsgRet:Read(stream)
	self.accountId = stream:readString()		-------- 账号名
	self.md5 = stream:readString()		-------- 密码MD5
	self.ip = stream:readString()		-------- IP
	self.port = stream:readUInt16()		-------- 端口
	self.platformId = stream:readUInt16()		-------- 平台
end

function MCSelectServerMsgRet:Write(stream)
	stream:writeString(self.accountId) 
	stream:writeString(self.md5) 
	stream:writeString(self.ip) 
	stream:writeUInt16(self.port) 
	stream:writeUInt16(self.platformId) 
end

------------------------登录游戏服务器请求------------------------
CMLoginGameServer = class("CMLoginGameServer", BaseRequest)
CMLoginGameServer.PackID = 2011
_G.Protocol["CMLoginGameServer"] = 2011
_G.Protocol[2011] = "CMLoginGameServer"
function CMLoginGameServer:ctor()
	self.platformId = nil       -------- 
	self.accountId = nil       -------- 
	self.serverId = nil       -------- 
	self.md5 = nil       -------- 
	self.os = nil       -------- 
	self.osVersion = nil       -------- 
	self.relogin = nil       -------- 
	self.channel = nil       -------- 
end

function CMLoginGameServer:Read(stream)
	self.platformId = stream:readInt32()		-------- 
	self.accountId = stream:readString()		-------- 
	self.serverId = stream:readUInt16()		-------- 
	self.md5 = stream:readString()		-------- 
	self.os = stream:readInt8()		-------- 
	self.osVersion = stream:readString()		-------- 
	self.relogin = stream:readInt8()		-------- 
	self.channel = stream:readString()		-------- 
end

function CMLoginGameServer:Write(stream)
	stream:writeInt32(self.platformId) 
	stream:writeString(self.accountId) 
	stream:writeUInt16(self.serverId) 
	stream:writeString(self.md5) 
	stream:writeInt8(self.os) 
	stream:writeString(self.osVersion) 
	stream:writeInt8(self.relogin) 
	stream:writeString(self.channel) 
end

------------------------登录游戏服务器返回------------------------
MCLoginGameServerRet = class("MCLoginGameServerRet", BaseResponse)
MCLoginGameServerRet.PackID = 20111
_G.Protocol["MCLoginGameServerRet"] = 20111
_G.Protocol[20111] = "MCLoginGameServerRet"
function MCLoginGameServerRet:ctor()
end

function MCLoginGameServerRet:Read(stream)
end

function MCLoginGameServerRet:Write(stream)
end

------------------------服务器准备完成------------------------
MCGameServerReady = class("MCGameServerReady", BaseResponse)
MCGameServerReady.PackID = 1105
_G.Protocol["MCGameServerReady"] = 1105
_G.Protocol[1105] = "MCGameServerReady"
function MCGameServerReady:ctor()
end

function MCGameServerReady:Read(stream)
end

function MCGameServerReady:Write(stream)
end

------------------------本地登陆------------------------
CMLocalLoginGame = class("CMLocalLoginGame", BaseRequest)
CMLocalLoginGame.PackID = 1101
_G.Protocol["CMLocalLoginGame"] = 1101
_G.Protocol[1101] = "CMLocalLoginGame"
function CMLocalLoginGame:ctor()
	self.roleUID = nil       -------- 角色UID
end

function CMLocalLoginGame:Read(stream)
	self.roleUID = stream:readUInt64()		-------- 角色UID
end

function CMLocalLoginGame:Write(stream)
	stream:writeUInt64(self.roleUID) 
end

------------------------本地登陆返回------------------------
MCLocalLoginGameRet = class("MCLocalLoginGameRet", BaseResponse)
MCLocalLoginGameRet.PackID = 1102
_G.Protocol["MCLocalLoginGameRet"] = 1102
_G.Protocol[1102] = "MCLocalLoginGameRet"
function MCLocalLoginGameRet:ctor()
	self.roleUID = nil       -------- 角色UID
end

function MCLocalLoginGameRet:Read(stream)
	self.roleUID = stream:readUInt64()		-------- 角色UID
end

function MCLocalLoginGameRet:Write(stream)
	stream:writeUInt64(self.roleUID) 
end

------------------------通过账号本地登陆------------------------
CMLocalLoginGameAccount = class("CMLocalLoginGameAccount", BaseRequest)
CMLocalLoginGameAccount.PackID = 32
_G.Protocol["CMLocalLoginGameAccount"] = 32
_G.Protocol[32] = "CMLocalLoginGameAccount"
function CMLocalLoginGameAccount:ctor()
	self.accountFlag = nil       -------- 
	self.accountName = nil       -------- 账号名
	self.passwordFlag = nil       -------- 
	self.password = nil       -------- 
	self.sPhoneModelFlag = nil       -------- 
	self.sPhoneModel = nil       -------- 
	self.sChannelFlag = nil       -------- 
	self.sChannel = nil       -------- 
	self.sChildChannelFlag = nil       -------- 
	self.sChildChannel = nil       -------- 
	self.iUserType = nil       -------- 
end

function CMLocalLoginGameAccount:Read(stream)
	self.accountFlag = stream:readUInt8()		-------- 
	self.accountName = stream:readString()		-------- 账号名
	self.passwordFlag = stream:readUInt8()		-------- 
	self.password = stream:readString()		-------- 
	self.sPhoneModelFlag = stream:readUInt8()		-------- 
	self.sPhoneModel = stream:readString()		-------- 
	self.sChannelFlag = stream:readUInt8()		-------- 
	self.sChannel = stream:readString()		-------- 
	self.sChildChannelFlag = stream:readUInt8()		-------- 
	self.sChildChannel = stream:readString()		-------- 
	self.iUserType = stream:readUInt32()		-------- 
end

function CMLocalLoginGameAccount:Write(stream)
	stream:writeUInt8(self.accountFlag) 
	stream:writeString(self.accountName) 
	stream:writeUInt8(self.passwordFlag) 
	stream:writeString(self.password) 
	stream:writeUInt8(self.sPhoneModelFlag) 
	stream:writeString(self.sPhoneModel) 
	stream:writeUInt8(self.sChannelFlag) 
	stream:writeString(self.sChannel) 
	stream:writeUInt8(self.sChildChannelFlag) 
	stream:writeString(self.sChildChannel) 
	stream:writeUInt32(self.iUserType) 
end

------------------------通过账号本地登陆返回------------------------
MCLocalLoginGameAccountRet = class("MCLocalLoginGameAccountRet", BaseResponse)
MCLocalLoginGameAccountRet.PackID = 321
_G.Protocol["MCLocalLoginGameAccountRet"] = 321
_G.Protocol[321] = "MCLocalLoginGameAccountRet"
function MCLocalLoginGameAccountRet:ctor()
	self.playerDataFlag = nil       -------- 
	--! PlayerInfoBeanReader
	self.playerData = nil       -------- 
	self.realName = nil       -------- 
	self.address = nil       -------- 
	self.passtokenFlag = nil       -------- 
	self.passtoken = nil       -------- 
	self.serverTime = nil       -------- 
	self.loginAwardGot = nil       -------- 
	self.loginAwardTime = nil       -------- 
	self.selfIconAwardTime = nil       -------- 
	self.dayFirstLogin = nil       -------- 
	self.selfIconAwardGot = nil       -------- 
	self.catAwardGot = nil       -------- 
	self.catAwardValue = nil       -------- 
	self.reachTargetGolds = nil       -------- 
	self.reachTargetAwards = nil       -------- 
	self.hasCharged = nil       -------- 
	self.restGetFreeGoldsTime = nil       -------- 
	self.dayLuckyItem = nil       -------- 
	self.dayLuckyAnim = nil       -------- 
	--! CannonBeanReader
	self.cannons = {}        -------- 
	self.catVipAddition = nil       -------- 
	self.recommendShopId = nil       -------- 
	self.enterRoom = nil       -------- 
	self.friendActionMsgNum = nil       -------- 
	self.chatHistoryNum = nil       -------- 
	self.mailsFlag = nil       -------- 
	--! MailBeanReader
	self.mails = {}        -------- 
	self.startedActivitysFlag = nil       -------- 
	self.startedActivitys = {}        -------- 
	self.sortActivityIdsFlag = nil       -------- 
	self.sortActivityIds = {}        -------- 
	self.loginAdds = {}        -------- 
	self.catAdds = {}        -------- 
	self.onlineAdds = {}        -------- 
	self.shopAdds = {}        -------- 
	self.tradeAdds = {}        -------- 
	self.charmAdds = {}        -------- 
end

function MCLocalLoginGameAccountRet:Read(stream)
	self.playerDataFlag = stream:readUInt8()		-------- 
	self.playerData = {}		-------- 
	PlayerInfoBeanReader.Read(self.playerData, stream)
	self.realName = stream:readString()		-------- 
	self.address = stream:readString()		-------- 
	self.passtokenFlag = stream:readUInt8()		-------- 
	self.passtoken = stream:readString()		-------- 
	self.serverTime = stream:readUInt32()		-------- 
	self.loginAwardGot = stream:readUInt8()		-------- 
	self.loginAwardTime = stream:readUInt32()		-------- 
	self.selfIconAwardTime = stream:readUInt32()		-------- 
	self.dayFirstLogin = stream:readUInt8()		-------- 
	self.selfIconAwardGot = stream:readUInt8()		-------- 
	self.catAwardGot = stream:readUInt8()		-------- 
	self.catAwardValue = stream:readUInt32()		-------- 
	self.reachTargetGolds = stream:readUInt32()		-------- 
	self.reachTargetAwards = stream:readUInt32()		-------- 
	self.hasCharged = stream:readUInt8()		-------- 
	self.restGetFreeGoldsTime = stream:readUInt32()		-------- 
	self.dayLuckyItem = stream:readUInt8()		-------- 
	self.dayLuckyAnim = stream:readString()		-------- 
	local _cannons_0_t = {}		-------- 
	local _cannons_0_len = stream:readUInt8()
	for _0=1,_cannons_0_len,1 do
	  local _cannons_2_o = {}
	  CannonBeanReader.Read(_cannons_2_o, stream)
	  table.insert(_cannons_0_t, _cannons_2_o)
	end
	self.cannons = _cannons_0_t
	self.catVipAddition = stream:readUInt32()		-------- 
	self.recommendShopId = stream:readUInt32()		-------- 
	self.enterRoom = stream:readUInt8()		-------- 
	self.friendActionMsgNum = stream:readInt32()		-------- 
	self.chatHistoryNum = stream:readInt32()		-------- 
	self.mailsFlag = stream:readUInt8()		-------- 
	local _mails_0_t = {}		-------- 
	local _mails_0_len = stream:readUInt16()
	for _0=1,_mails_0_len,1 do
	  local _mails_2_o = {}
	  MailBeanReader.Read(_mails_2_o, stream)
	  table.insert(_mails_0_t, _mails_2_o)
	end
	self.mails = _mails_0_t
	self.startedActivitysFlag = stream:readUInt8()		-------- 
	local _startedActivitys_0_t = {}		-------- 
	local _startedActivitys_0_len = stream:readUInt16()
	for _0=1,_startedActivitys_0_len,1 do
	  table.insert(_startedActivitys_0_t, stream:readInt32())
	end
	self.startedActivitys = _startedActivitys_0_t
	self.sortActivityIdsFlag = stream:readUInt8()		-------- 
	local _sortActivityIds_0_t = {}		-------- 
	local _sortActivityIds_0_len = stream:readUInt16()
	for _0=1,_sortActivityIds_0_len,1 do
	  table.insert(_sortActivityIds_0_t, stream:readInt32())
	end
	self.sortActivityIds = _sortActivityIds_0_t
	local _loginAdds_0_t = {}		-------- 
	local _loginAdds_0_len = stream:readUInt8()
	for _0=1,_loginAdds_0_len,1 do
	  table.insert(_loginAdds_0_t, stream:readUInt8())
	end
	self.loginAdds = _loginAdds_0_t
	local _catAdds_0_t = {}		-------- 
	local _catAdds_0_len = stream:readUInt8()
	for _0=1,_catAdds_0_len,1 do
	  table.insert(_catAdds_0_t, stream:readUInt8())
	end
	self.catAdds = _catAdds_0_t
	local _onlineAdds_0_t = {}		-------- 
	local _onlineAdds_0_len = stream:readUInt8()
	for _0=1,_onlineAdds_0_len,1 do
	  table.insert(_onlineAdds_0_t, stream:readUInt8())
	end
	self.onlineAdds = _onlineAdds_0_t
	local _shopAdds_0_t = {}		-------- 
	local _shopAdds_0_len = stream:readUInt8()
	for _0=1,_shopAdds_0_len,1 do
	  table.insert(_shopAdds_0_t, stream:readUInt8())
	end
	self.shopAdds = _shopAdds_0_t
	local _tradeAdds_0_t = {}		-------- 
	local _tradeAdds_0_len = stream:readUInt8()
	for _0=1,_tradeAdds_0_len,1 do
	  table.insert(_tradeAdds_0_t, stream:readUInt8())
	end
	self.tradeAdds = _tradeAdds_0_t
	local _charmAdds_0_t = {}		-------- 
	local _charmAdds_0_len = stream:readUInt8()
	for _0=1,_charmAdds_0_len,1 do
	  table.insert(_charmAdds_0_t, stream:readUInt8())
	end
	self.charmAdds = _charmAdds_0_t
end

function MCLocalLoginGameAccountRet:Write(stream)
	stream:writeUInt8(self.playerDataFlag) 
	PlayerInfoBeanReader.Write(self.playerData, stream)
	stream:writeString(self.realName) 
	stream:writeString(self.address) 
	stream:writeUInt8(self.passtokenFlag) 
	stream:writeString(self.passtoken) 
	stream:writeUInt32(self.serverTime) 
	stream:writeUInt8(self.loginAwardGot) 
	stream:writeUInt32(self.loginAwardTime) 
	stream:writeUInt32(self.selfIconAwardTime) 
	stream:writeUInt8(self.dayFirstLogin) 
	stream:writeUInt8(self.selfIconAwardGot) 
	stream:writeUInt8(self.catAwardGot) 
	stream:writeUInt32(self.catAwardValue) 
	stream:writeUInt32(self.reachTargetGolds) 
	stream:writeUInt32(self.reachTargetAwards) 
	stream:writeUInt8(self.hasCharged) 
	stream:writeUInt32(self.restGetFreeGoldsTime) 
	stream:writeUInt8(self.dayLuckyItem) 
	stream:writeString(self.dayLuckyAnim) 
	local _cannons_0_t = self.cannons 
	stream:writeUInt8(#_cannons_0_t)
	for _,_cannons_1_t in pairs(_cannons_0_t) do
	  CannonBeanReader.Write(_cannons_1_t, stream)
	end
	stream:writeUInt32(self.catVipAddition) 
	stream:writeUInt32(self.recommendShopId) 
	stream:writeUInt8(self.enterRoom) 
	stream:writeInt32(self.friendActionMsgNum) 
	stream:writeInt32(self.chatHistoryNum) 
	stream:writeUInt8(self.mailsFlag) 
	local _mails_0_t = self.mails 
	stream:writeUInt16(#_mails_0_t)
	for _,_mails_1_t in pairs(_mails_0_t) do
	  MailBeanReader.Write(_mails_1_t, stream)
	end
	stream:writeUInt8(self.startedActivitysFlag) 
	local _startedActivitys_0_t = self.startedActivitys 
	stream:writeUInt16(#_startedActivitys_0_t)
	for _,_startedActivitys_1_t in pairs(_startedActivitys_0_t) do
	  stream:writeInt32(_startedActivitys_1_t)
	end
	stream:writeUInt8(self.sortActivityIdsFlag) 
	local _sortActivityIds_0_t = self.sortActivityIds 
	stream:writeUInt16(#_sortActivityIds_0_t)
	for _,_sortActivityIds_1_t in pairs(_sortActivityIds_0_t) do
	  stream:writeInt32(_sortActivityIds_1_t)
	end
	local _loginAdds_0_t = self.loginAdds 
	stream:writeUInt8(#_loginAdds_0_t)
	for _,_loginAdds_1_t in pairs(_loginAdds_0_t) do
	  stream:writeUInt8(_loginAdds_1_t)
	end
	local _catAdds_0_t = self.catAdds 
	stream:writeUInt8(#_catAdds_0_t)
	for _,_catAdds_1_t in pairs(_catAdds_0_t) do
	  stream:writeUInt8(_catAdds_1_t)
	end
	local _onlineAdds_0_t = self.onlineAdds 
	stream:writeUInt8(#_onlineAdds_0_t)
	for _,_onlineAdds_1_t in pairs(_onlineAdds_0_t) do
	  stream:writeUInt8(_onlineAdds_1_t)
	end
	local _shopAdds_0_t = self.shopAdds 
	stream:writeUInt8(#_shopAdds_0_t)
	for _,_shopAdds_1_t in pairs(_shopAdds_0_t) do
	  stream:writeUInt8(_shopAdds_1_t)
	end
	local _tradeAdds_0_t = self.tradeAdds 
	stream:writeUInt8(#_tradeAdds_0_t)
	for _,_tradeAdds_1_t in pairs(_tradeAdds_0_t) do
	  stream:writeUInt8(_tradeAdds_1_t)
	end
	local _charmAdds_0_t = self.charmAdds 
	stream:writeUInt8(#_charmAdds_0_t)
	for _,_charmAdds_1_t in pairs(_charmAdds_0_t) do
	  stream:writeUInt8(_charmAdds_1_t)
	end
end

------------------------请求进入游戏------------------------
CMEnterGame = class("CMEnterGame", BaseRequest)
CMEnterGame.PackID = 1103
_G.Protocol["CMEnterGame"] = 1103
_G.Protocol[1103] = "CMEnterGame"
function CMEnterGame:ctor()
	self.roleUID = nil       -------- 角色UID
end

function CMEnterGame:Read(stream)
	self.roleUID = stream:readUInt64()		-------- 角色UID
end

function CMEnterGame:Write(stream)
	stream:writeUInt64(self.roleUID) 
end

------------------------进入游戏返回------------------------
MCEnterGameRet = class("MCEnterGameRet", BaseResponse)
MCEnterGameRet.PackID = 1104
_G.Protocol["MCEnterGameRet"] = 1104
_G.Protocol[1104] = "MCEnterGameRet"
function MCEnterGameRet:ctor()
	--! RoleDetail
	self.detailData = nil       -------- 玩家详细数据
end

function MCEnterGameRet:Read(stream)
	self.detailData = {}		-------- 玩家详细数据
	RoleDetail.Read(self.detailData, stream)
end

function MCEnterGameRet:Write(stream)
	RoleDetail.Write(self.detailData, stream)
end

------------------------角色心跳------------------------
MCPlayerHeart = class("MCPlayerHeart", BaseResponse)
MCPlayerHeart.PackID = 1227
_G.Protocol["MCPlayerHeart"] = 1227
_G.Protocol[1227] = "MCPlayerHeart"
function MCPlayerHeart:ctor()
end

function MCPlayerHeart:Read(stream)
end

function MCPlayerHeart:Write(stream)
end

------------------------角色心跳返回------------------------
CMPlayerHeartRet = class("CMPlayerHeartRet", BaseRequest)
CMPlayerHeartRet.PackID = 1228
_G.Protocol["CMPlayerHeartRet"] = 1228
_G.Protocol[1228] = "CMPlayerHeartRet"
function CMPlayerHeartRet:ctor()
end

function CMPlayerHeartRet:Read(stream)
end

function CMPlayerHeartRet:Write(stream)
end

------------------------更新任务列表------------------------
MCUpdateMissionList = class("MCUpdateMissionList", BaseResponse)
MCUpdateMissionList.PackID = 2900
_G.Protocol["MCUpdateMissionList"] = 2900
_G.Protocol[2900] = "MCUpdateMissionList"
function MCUpdateMissionList:ctor()
	--! PackMission
	self.missions = {}        -------- 任务列表
end

function MCUpdateMissionList:Read(stream)
	local _missions_0_t = {}		-------- 任务列表
	local _missions_0_len = stream:readUInt8()
	for _0=1,_missions_0_len,1 do
	  local _missions_2_o = {}
	  PackMission.Read(_missions_2_o, stream)
	  table.insert(_missions_0_t, _missions_2_o)
	end
	self.missions = _missions_0_t
end

function MCUpdateMissionList:Write(stream)
	local _missions_0_t = self.missions 
	stream:writeUInt8(#_missions_0_t)
	for _,_missions_1_t in pairs(_missions_0_t) do
	  PackMission.Write(_missions_1_t, stream)
	end
end

------------------------更新条件参数(当前杀怪数,当前物品数)------------------------
MCUpdateMissionParam = class("MCUpdateMissionParam", BaseResponse)
MCUpdateMissionParam.PackID = 2901
_G.Protocol["MCUpdateMissionParam"] = 2901
_G.Protocol[2901] = "MCUpdateMissionParam"
function MCUpdateMissionParam:ctor()
	--! PackMissionParams
	self.params = {}        -------- 任务列表参数
end

function MCUpdateMissionParam:Read(stream)
	local _params_0_t = {}		-------- 任务列表参数
	local _params_0_len = stream:readUInt8()
	for _0=1,_params_0_len,1 do
	  local _params_2_o = {}
	  PackMissionParams.Read(_params_2_o, stream)
	  table.insert(_params_0_t, _params_2_o)
	end
	self.params = _params_0_t
end

function MCUpdateMissionParam:Write(stream)
	local _params_0_t = self.params 
	stream:writeUInt8(#_params_0_t)
	for _,_params_1_t in pairs(_params_0_t) do
	  PackMissionParams.Write(_params_1_t, stream)
	end
end

------------------------删除一个任务------------------------
MCDeleteMission = class("MCDeleteMission", BaseResponse)
MCDeleteMission.PackID = 2902
_G.Protocol["MCDeleteMission"] = 2902
_G.Protocol[2902] = "MCDeleteMission"
function MCDeleteMission:ctor()
	self.missionID = nil       -------- 任务ID
end

function MCDeleteMission:Read(stream)
	self.missionID = stream:readUInt16()		-------- 任务ID
end

function MCDeleteMission:Write(stream)
	stream:writeUInt16(self.missionID) 
end

------------------------任务操作(领取或提交)------------------------
CMMissionOperate = class("CMMissionOperate", BaseRequest)
CMMissionOperate.PackID = 2903
_G.Protocol["CMMissionOperate"] = 2903
_G.Protocol[2903] = "CMMissionOperate"
function CMMissionOperate:ctor()
	self.operateType = nil       -------- 操作类型 参考见: @ref EMissionOperation
	self.missionID = nil       -------- 任务ID
end

function CMMissionOperate:Read(stream)
	self.operateType = stream:readUInt8()		-------- 操作类型 参考见: @ref EMissionOperation
	self.missionID = stream:readUInt16()		-------- 任务ID
end

function CMMissionOperate:Write(stream)
	stream:writeUInt8(self.operateType) 
	stream:writeUInt16(self.missionID) 
end

------------------------任务操作返回(领取或提交)------------------------
MCMissionOperateRet = class("MCMissionOperateRet", BaseResponse)
MCMissionOperateRet.PackID = 2904
_G.Protocol["MCMissionOperateRet"] = 2904
_G.Protocol[2904] = "MCMissionOperateRet"
function MCMissionOperateRet:ctor()
	self.operateType = nil       -------- 操作类型 参考见: @ref EMissionOperation
	self.missionID = nil       -------- 任务ID
end

function MCMissionOperateRet:Read(stream)
	self.operateType = stream:readUInt8()		-------- 操作类型 参考见: @ref EMissionOperation
	self.missionID = stream:readUInt16()		-------- 任务ID
end

function MCMissionOperateRet:Write(stream)
	stream:writeUInt8(self.operateType) 
	stream:writeUInt16(self.missionID) 
end

------------------------请求验证客户端连接------------------------
CWVerifyConnect = class("CWVerifyConnect", BaseRequest)
CWVerifyConnect.PackID = 1012
_G.Protocol["CWVerifyConnect"] = 1012
_G.Protocol[1012] = "CWVerifyConnect"
function CWVerifyConnect:ctor()
	self.loginKey = nil       -------- 登陆密钥
	self.prevMsg = nil       -------- 内部私有数据
end

function CWVerifyConnect:Read(stream)
	self.loginKey = stream:readUInt64()		-------- 登陆密钥
	self.prevMsg = stream:readString()		-------- 内部私有数据
end

function CWVerifyConnect:Write(stream)
	stream:writeUInt64(self.loginKey) 
	stream:writeString(self.prevMsg) 
end

------------------------验证客户端连接返回------------------------
WCVerifyConnectRet = class("WCVerifyConnectRet", BaseResponse)
WCVerifyConnectRet.PackID = 1013
_G.Protocol["WCVerifyConnectRet"] = 1013
_G.Protocol[1013] = "WCVerifyConnectRet"
function WCVerifyConnectRet:ctor()
	self.roleUID = nil       -------- 角色UID 0表示无角色
end

function WCVerifyConnectRet:Read(stream)
	self.roleUID = stream:readUInt64()		-------- 角色UID 0表示无角色
end

function WCVerifyConnectRet:Write(stream)
	stream:writeUInt64(self.roleUID) 
end

------------------------请求随机角色名字------------------------
CWRandGenName = class("CWRandGenName", BaseRequest)
CWRandGenName.PackID = 1014
_G.Protocol["CWRandGenName"] = 1014
_G.Protocol[1014] = "CWRandGenName"
function CWRandGenName:ctor()
	self.sex = nil       -------- 性别
end

function CWRandGenName:Read(stream)
	self.sex = stream:readUInt8()		-------- 性别
end

function CWRandGenName:Write(stream)
	stream:writeUInt8(self.sex) 
end

------------------------随机角色名字返回------------------------
WCRandGenNameRet = class("WCRandGenNameRet", BaseResponse)
WCRandGenNameRet.PackID = 1015
_G.Protocol["WCRandGenNameRet"] = 1015
_G.Protocol[1015] = "WCRandGenNameRet"
function WCRandGenNameRet:ctor()
	self.name = nil       -------- 名字
end

function WCRandGenNameRet:Read(stream)
	self.name = stream:readString()		-------- 名字
end

function WCRandGenNameRet:Write(stream)
	stream:writeString(self.name) 
end

------------------------创建角色------------------------
CWCreateRole = class("CWCreateRole", BaseRequest)
CWCreateRole.PackID = 1008
_G.Protocol["CWCreateRole"] = 1008
_G.Protocol[1008] = "CWCreateRole"
function CWCreateRole:ctor()
	self.rolePrototypeID = nil       -------- 角色原型ID
	self.roleName = nil       -------- 角色名字
end

function CWCreateRole:Read(stream)
	self.rolePrototypeID = stream:readUInt8()		-------- 角色原型ID
	self.roleName = stream:readString()		-------- 角色名字
end

function CWCreateRole:Write(stream)
	stream:writeUInt8(self.rolePrototypeID) 
	stream:writeString(self.roleName) 
end

------------------------创建角色返回------------------------
WCCreateRoleRet = class("WCCreateRoleRet", BaseResponse)
WCCreateRoleRet.PackID = 1009
_G.Protocol["WCCreateRoleRet"] = 1009
_G.Protocol[1009] = "WCCreateRoleRet"
function WCCreateRoleRet:ctor()
	self.roleUID = nil       -------- 角色UID
end

function WCCreateRoleRet:Read(stream)
	self.roleUID = stream:readUInt64()		-------- 角色UID
end

function WCCreateRoleRet:Write(stream)
	stream:writeUInt64(self.roleUID) 
end

------------------------请求登陆游戏------------------------
CWLoginGame = class("CWLoginGame", BaseRequest)
CWLoginGame.PackID = 1003
_G.Protocol["CWLoginGame"] = 1003
_G.Protocol[1003] = "CWLoginGame"
function CWLoginGame:ctor()
end

function CWLoginGame:Read(stream)
end

function CWLoginGame:Write(stream)
end

------------------------登陆游戏返回------------------------
WCLoginGameRet = class("WCLoginGameRet", BaseResponse)
WCLoginGameRet.PackID = 1004
_G.Protocol["WCLoginGameRet"] = 1004
_G.Protocol[1004] = "WCLoginGameRet"
function WCLoginGameRet:ctor()
	self.roleUID = nil       -------- 角色UID
	self.serverIP = nil       -------- 游戏服务器IP
	self.serverPort = nil       -------- 游戏服务器端口
end

function WCLoginGameRet:Read(stream)
	self.roleUID = stream:readUInt64()		-------- 角色UID
	self.serverIP = stream:readString()		-------- 游戏服务器IP
	self.serverPort = stream:readUInt32()		-------- 游戏服务器端口
end

function WCLoginGameRet:Write(stream)
	stream:writeUInt64(self.roleUID) 
	stream:writeString(self.serverIP) 
	stream:writeUInt32(self.serverPort) 
end

------------------------请求退出登陆------------------------
CWLoginQuit = class("CWLoginQuit", BaseRequest)
CWLoginQuit.PackID = 1005
_G.Protocol["CWLoginQuit"] = 1005
_G.Protocol[1005] = "CWLoginQuit"
function CWLoginQuit:ctor()
end

function CWLoginQuit:Read(stream)
end

function CWLoginQuit:Write(stream)
end

------------------------退出登陆返回------------------------
WCLoginQuitRet = class("WCLoginQuitRet", BaseResponse)
WCLoginQuitRet.PackID = 1006
_G.Protocol["WCLoginQuitRet"] = 1006
_G.Protocol[1006] = "WCLoginQuitRet"
function WCLoginQuitRet:ctor()
end

function WCLoginQuitRet:Read(stream)
end

function WCLoginQuitRet:Write(stream)
end

------------------------世界服务器注册到登陆服务器------------------------
CWLRegiste = class("CWLRegiste", BaseRequest)
CWLRegiste.PackID = 31500
_G.Protocol["CWLRegiste"] = 31500
_G.Protocol[31500] = "CWLRegiste"
function CWLRegiste:ctor()
	self.serverID = nil       -------- 
	self.ip = nil       -------- 
	self.port = nil       -------- 
	self.num = nil       -------- 
	self.dbIP = nil       -------- 
	self.dbPort = nil       -------- 
	self.dbUser = nil       -------- 
	self.dbPasswd = nil       -------- 
end

function CWLRegiste:Read(stream)
	self.serverID = stream:readUInt16()		-------- 
	self.ip = stream:readString()		-------- 
	self.port = stream:readUInt16()		-------- 
	self.num = stream:readInt32()		-------- 
	self.dbIP = stream:readString()		-------- 
	self.dbPort = stream:readUInt16()		-------- 
	self.dbUser = stream:readSString()		-------- 
	self.dbPasswd = stream:readSString()		-------- 
end

function CWLRegiste:Write(stream)
	stream:writeUInt16(self.serverID) 
	stream:writeString(self.ip) 
	stream:writeUInt16(self.port) 
	stream:writeInt32(self.num) 
	stream:writeString(self.dbIP) 
	stream:writeUInt16(self.dbPort) 
	stream:writeSString(self.dbUser) 
	stream:writeSString(self.dbPasswd) 
end

------------------------世界服务器注册到登陆服务器返回------------------------
CLWRegisteRet = class("CLWRegisteRet", BaseResponse)
CLWRegisteRet.PackID = 31501
_G.Protocol["CLWRegisteRet"] = 31501
_G.Protocol[31501] = "CLWRegisteRet"
function CLWRegisteRet:ctor()
	--! LoginServerData
	self.serverData = nil       -------- 
end

function CLWRegisteRet:Read(stream)
	self.serverData = {}		-------- 
	LoginServerData.Read(self.serverData, stream)
end

function CLWRegisteRet:Write(stream)
	LoginServerData.Write(self.serverData, stream)
end

------------------------角色登陆------------------------
CWLRoleLogin = class("CWLRoleLogin", BaseRequest)
CWLRoleLogin.PackID = 31502
_G.Protocol["CWLRoleLogin"] = 31502
_G.Protocol[31502] = "CWLRoleLogin"
function CWLRoleLogin:ctor()
	self.loginKey = nil       -------- 登陆Key
	self.accountID = nil       -------- 账号ID
	self.roleUID = nil       -------- 角色UID
	self.roleName = nil       -------- 角色名字
	self.worldServerID = nil       -------- 服务器ID
	self.clientIP = nil       -------- 客户端IP
end

function CWLRoleLogin:Read(stream)
	self.loginKey = stream:readUInt64()		-------- 登陆Key
	self.accountID = stream:readUInt64()		-------- 账号ID
	self.roleUID = stream:readUInt64()		-------- 角色UID
	self.roleName = stream:readString()		-------- 角色名字
	self.worldServerID = stream:readUInt16()		-------- 服务器ID
	self.clientIP = stream:readString()		-------- 客户端IP
end

function CWLRoleLogin:Write(stream)
	stream:writeUInt64(self.loginKey) 
	stream:writeUInt64(self.accountID) 
	stream:writeUInt64(self.roleUID) 
	stream:writeString(self.roleName) 
	stream:writeUInt16(self.worldServerID) 
	stream:writeString(self.clientIP) 
end

------------------------角色登陆返回------------------------
CLWRoleLoginRet = class("CLWRoleLoginRet", BaseResponse)
CLWRoleLoginRet.PackID = 31503
_G.Protocol["CLWRoleLoginRet"] = 31503
_G.Protocol[31503] = "CLWRoleLoginRet"
function CLWRoleLoginRet:ctor()
	self.loginKey = nil       -------- 登陆Key
	self.accountID = nil       -------- 账号ID
	self.roleUID = nil       -------- 角色UID
end

function CLWRoleLoginRet:Read(stream)
	self.loginKey = stream:readUInt64()		-------- 登陆Key
	self.accountID = stream:readUInt64()		-------- 账号ID
	self.roleUID = stream:readUInt64()		-------- 角色UID
end

function CLWRoleLoginRet:Write(stream)
	stream:writeUInt64(self.loginKey) 
	stream:writeUInt64(self.accountID) 
	stream:writeUInt64(self.roleUID) 
end

------------------------角色创建------------------------
CWLRoleCreate = class("CWLRoleCreate", BaseRequest)
CWLRoleCreate.PackID = 31504
_G.Protocol["CWLRoleCreate"] = 31504
_G.Protocol[31504] = "CWLRoleCreate"
function CWLRoleCreate:ctor()
	self.loginKey = nil       -------- 登陆Key
	self.accountID = nil       -------- 账号ID
	self.roleUID = nil       -------- 角色UID
end

function CWLRoleCreate:Read(stream)
	self.loginKey = stream:readUInt64()		-------- 登陆Key
	self.accountID = stream:readUInt64()		-------- 账号ID
	self.roleUID = stream:readUInt64()		-------- 角色UID
end

function CWLRoleCreate:Write(stream)
	stream:writeUInt64(self.loginKey) 
	stream:writeUInt64(self.accountID) 
	stream:writeUInt64(self.roleUID) 
end

------------------------角色登陆返回------------------------
CLWRoleCreateRet = class("CLWRoleCreateRet", BaseResponse)
CLWRoleCreateRet.PackID = 31503
_G.Protocol["CLWRoleCreateRet"] = 31503
_G.Protocol[31503] = "CLWRoleCreateRet"
function CLWRoleCreateRet:ctor()
	self.loginKey = nil       -------- 登陆Key
	self.accountID = nil       -------- 账号ID
	self.roleUID = nil       -------- 角色UID
end

function CLWRoleCreateRet:Read(stream)
	self.loginKey = stream:readUInt64()		-------- 登陆Key
	self.accountID = stream:readUInt64()		-------- 账号ID
	self.roleUID = stream:readUInt64()		-------- 角色UID
end

function CLWRoleCreateRet:Write(stream)
	stream:writeUInt64(self.loginKey) 
	stream:writeUInt64(self.accountID) 
	stream:writeUInt64(self.roleUID) 
end

------------------------数据更新------------------------
CWLDataUpdate = class("CWLDataUpdate", BaseRequest)
CWLDataUpdate.PackID = 31506
_G.Protocol["CWLDataUpdate"] = 31506
_G.Protocol[31506] = "CWLDataUpdate"
function CWLDataUpdate:ctor()
	self.roleNum = nil       -------- 角色数目
end

function CWLDataUpdate:Read(stream)
	self.roleNum = stream:readInt32()		-------- 角色数目
end

function CWLDataUpdate:Write(stream)
	stream:writeInt32(self.roleNum) 
end

------------------------限号信息更新------------------------
CLWLimitInfoUpdate = class("CLWLimitInfoUpdate", BaseResponse)
CLWLimitInfoUpdate.PackID = 31507
_G.Protocol["CLWLimitInfoUpdate"] = 31507
_G.Protocol[31507] = "CLWLimitInfoUpdate"
function CLWLimitInfoUpdate:ctor()
	self.accountID = {}        -------- 账号列表
	self.limitKey = nil       -------- 限制字符串
	self.limitType = nil       -------- 限制类型
	self.limitVal = nil       -------- 限制值
	self.limitTime = nil       -------- 限制结束时间
end

function CLWLimitInfoUpdate:Read(stream)
	local _accountID_0_t = {}		-------- 账号列表
	local _accountID_0_len = stream:readUInt8()
	for _0=1,_accountID_0_len,1 do
	  table.insert(_accountID_0_t, stream:readUInt64())
	end
	self.accountID = _accountID_0_t
	self.limitKey = stream:readString()		-------- 限制字符串
	self.limitType = stream:readInt32()		-------- 限制类型
	self.limitVal = stream:readUInt8()		-------- 限制值
	self.limitTime = stream:readUInt32()		-------- 限制结束时间
end

function CLWLimitInfoUpdate:Write(stream)
	local _accountID_0_t = self.accountID 
	stream:writeUInt8(#_accountID_0_t)
	for _,_accountID_1_t in pairs(_accountID_0_t) do
	  stream:writeUInt64(_accountID_1_t)
	end
	stream:writeString(self.limitKey) 
	stream:writeInt32(self.limitType) 
	stream:writeUInt8(self.limitVal) 
	stream:writeUInt32(self.limitTime) 
end

------------------------限号信息------------------------
CLWLimitAccountInfo = class("CLWLimitAccountInfo", BaseResponse)
CLWLimitAccountInfo.PackID = 31508
_G.Protocol["CLWLimitAccountInfo"] = 31508
_G.Protocol[31508] = "CLWLimitAccountInfo"
function CLWLimitAccountInfo:ctor()
	self.limitAccountID = nil       -------- 限制账号
	self.limitRoleID = nil       -------- 限制角色
	self.begintime = nil       -------- 开始时间
	self.endtime = nil       -------- 结束时间
end

function CLWLimitAccountInfo:Read(stream)
	self.limitAccountID = stream:readUInt64()		-------- 限制账号
	self.limitRoleID = stream:readUInt64()		-------- 限制角色
	self.begintime = stream:readUInt32()		-------- 开始时间
	self.endtime = stream:readUInt32()		-------- 结束时间
end

function CLWLimitAccountInfo:Write(stream)
	stream:writeUInt64(self.limitAccountID) 
	stream:writeUInt64(self.limitRoleID) 
	stream:writeUInt32(self.begintime) 
	stream:writeUInt32(self.endtime) 
end

------------------------限号信息------------------------
CLWLimitChatInfo = class("CLWLimitChatInfo", BaseResponse)
CLWLimitChatInfo.PackID = 31509
_G.Protocol["CLWLimitChatInfo"] = 31509
_G.Protocol[31509] = "CLWLimitChatInfo"
function CLWLimitChatInfo:ctor()
	self.limitAccountID = nil       -------- 限制账号
	self.limitRoleID = nil       -------- 限制角色
	self.begintime = nil       -------- 开始时间
	self.endtime = nil       -------- 结束时间
	self.uniqueId = nil       -------- 唯一id
end

function CLWLimitChatInfo:Read(stream)
	self.limitAccountID = stream:readUInt64()		-------- 限制账号
	self.limitRoleID = stream:readUInt64()		-------- 限制角色
	self.begintime = stream:readUInt32()		-------- 开始时间
	self.endtime = stream:readUInt32()		-------- 结束时间
	self.uniqueId = stream:readInt32()		-------- 唯一id
end

function CLWLimitChatInfo:Write(stream)
	stream:writeUInt64(self.limitAccountID) 
	stream:writeUInt64(self.limitRoleID) 
	stream:writeUInt32(self.begintime) 
	stream:writeUInt32(self.endtime) 
	stream:writeInt32(self.uniqueId) 
end

------------------------发送限制请求------------------------
CWLLimitInfoReq = class("CWLLimitInfoReq", BaseResponse)
CWLLimitInfoReq.PackID = 31510
_G.Protocol["CWLLimitInfoReq"] = 31510
_G.Protocol[31510] = "CWLLimitInfoReq"
function CWLLimitInfoReq:ctor()
	self.limitAccountID = nil       -------- 限制账号
	self.limitRoleID = nil       -------- 限制角色
	self.serverID = nil       -------- 服务器id
end

function CWLLimitInfoReq:Read(stream)
	self.limitAccountID = stream:readUInt64()		-------- 限制账号
	self.limitRoleID = stream:readUInt64()		-------- 限制角色
	self.serverID = stream:readUInt16()		-------- 服务器id
end

function CWLLimitInfoReq:Write(stream)
	stream:writeUInt64(self.limitAccountID) 
	stream:writeUInt64(self.limitRoleID) 
	stream:writeUInt16(self.serverID) 
end

------------------------------------------------
MWRegiste = class("MWRegiste", BaseRequest)
MWRegiste.PackID = 31001
_G.Protocol["MWRegiste"] = 31001
_G.Protocol[31001] = "MWRegiste"
function MWRegiste:ctor()
	--! MapServerUpdate
	self.serverData = nil       -------- 
	self.serverType = nil       -------- 
	self.clientListenIP = nil       -------- 
	self.clientListenPort = nil       -------- 
end

function MWRegiste:Read(stream)
	self.serverData = {}		-------- 
	MapServerUpdate.Read(self.serverData, stream)
	self.serverType = stream:readInt32()		-------- 
	self.clientListenIP = stream:readString()		-------- 
	self.clientListenPort = stream:readUInt16()		-------- 
end

function MWRegiste:Write(stream)
	MapServerUpdate.Write(self.serverData, stream)
	stream:writeInt32(self.serverType) 
	stream:writeString(self.clientListenIP) 
	stream:writeUInt16(self.clientListenPort) 
end

------------------------------------------------
WMRegisteRet = class("WMRegisteRet", BaseResponse)
WMRegisteRet.PackID = 31002
_G.Protocol["WMRegisteRet"] = 31002
_G.Protocol[31002] = "WMRegisteRet"
function WMRegisteRet:ctor()
	self.worldServerID = nil       -------- 
end

function WMRegisteRet:Read(stream)
	self.worldServerID = stream:readUInt16()		-------- 
end

function WMRegisteRet:Write(stream)
	stream:writeUInt16(self.worldServerID) 
end

------------------------------------------------
MWBroadPacket = class("MWBroadPacket", BaseRequest)
MWBroadPacket.PackID = 31101
_G.Protocol["MWBroadPacket"] = 31101
_G.Protocol[31101] = "MWBroadPacket"
function MWBroadPacket:ctor()
	self.sendToMe = nil       -------- 
	self.srcObjUID = nil       -------- 
	self.msg = nil       -------- 
end

function MWBroadPacket:Read(stream)
	self.sendToMe = stream:readInt8()		-------- 
	self.srcObjUID = stream:readUInt32()		-------- 
	self.msg = stream:readString()		-------- 
end

function MWBroadPacket:Write(stream)
	stream:writeInt8(self.sendToMe) 
	stream:writeUInt32(self.srcObjUID) 
	stream:writeString(self.msg) 
end

------------------------------------------------
MWTransPacket = class("MWTransPacket", BaseRequest)
MWTransPacket.PackID = 31102
_G.Protocol["MWTransPacket"] = 31102
_G.Protocol[31102] = "MWTransPacket"
function MWTransPacket:ctor()
	self.srcObjUID = nil       -------- 
	self.destObjUID = nil       -------- 
	self.failedNeedRes = nil       -------- 
	self.msg = nil       -------- 
end

function MWTransPacket:Read(stream)
	self.srcObjUID = stream:readUInt32()		-------- 
	self.destObjUID = stream:readUInt32()		-------- 
	self.failedNeedRes = stream:readInt8()		-------- 
	self.msg = stream:readString()		-------- 
end

function MWTransPacket:Write(stream)
	stream:writeUInt32(self.srcObjUID) 
	stream:writeUInt32(self.destObjUID) 
	stream:writeInt8(self.failedNeedRes) 
	stream:writeString(self.msg) 
end

------------------------------------------------
MWTrans2WorldPacket = class("MWTrans2WorldPacket", BaseRequest)
MWTrans2WorldPacket.PackID = 31104
_G.Protocol["MWTrans2WorldPacket"] = 31104
_G.Protocol[31104] = "MWTrans2WorldPacket"
function MWTrans2WorldPacket:ctor()
	self.destObjUID = nil       -------- 
	self.msg = nil       -------- 
end

function MWTrans2WorldPacket:Read(stream)
	self.destObjUID = stream:readUInt32()		-------- 
	self.msg = stream:readString()		-------- 
end

function MWTrans2WorldPacket:Write(stream)
	stream:writeUInt32(self.destObjUID) 
	stream:writeString(self.msg) 
end

------------------------------------------------
WMTransPacketError = class("WMTransPacketError", BaseResponse)
WMTransPacketError.PackID = 31103
_G.Protocol["WMTransPacketError"] = 31103
_G.Protocol[31103] = "WMTransPacketError"
function WMTransPacketError:ctor()
	self.srcObjUID = nil       -------- 
	self.destObjUID = nil       -------- 
	self.msg = nil       -------- 
end

function WMTransPacketError:Read(stream)
	self.srcObjUID = stream:readUInt32()		-------- 
	self.destObjUID = stream:readUInt32()		-------- 
	self.msg = stream:readString()		-------- 
end

function WMTransPacketError:Write(stream)
	stream:writeUInt32(self.srcObjUID) 
	stream:writeUInt32(self.destObjUID) 
	stream:writeString(self.msg) 
end

------------------------------------------------
WMUpdateServer = class("WMUpdateServer", BaseResponse)
WMUpdateServer.PackID = 31004
_G.Protocol["WMUpdateServer"] = 31004
_G.Protocol[31004] = "WMUpdateServer"
function WMUpdateServer:ctor()
	--! MapServerUpdate
	self.servers = {}        -------- 
end

function WMUpdateServer:Read(stream)
	local _servers_0_t = {}		-------- 
	local _servers_0_len = stream:readUInt8()
	for _0=1,_servers_0_len,1 do
	  local _servers_2_o = {}
	  MapServerUpdate.Read(_servers_2_o, stream)
	  table.insert(_servers_0_t, _servers_2_o)
	end
	self.servers = _servers_0_t
end

function WMUpdateServer:Write(stream)
	local _servers_0_t = self.servers 
	stream:writeUInt8(#_servers_0_t)
	for _,_servers_1_t in pairs(_servers_0_t) do
	  MapServerUpdate.Write(_servers_1_t, stream)
	end
end

------------------------------------------------
MWUpdateServer = class("MWUpdateServer", BaseResponse)
MWUpdateServer.PackID = 31005
_G.Protocol["MWUpdateServer"] = 31005
_G.Protocol[31005] = "MWUpdateServer"
function MWUpdateServer:ctor()
	--! MapServerUpdate
	self.server = nil       -------- 
end

function MWUpdateServer:Read(stream)
	self.server = {}		-------- 
	MapServerUpdate.Read(self.server, stream)
end

function MWUpdateServer:Write(stream)
	MapServerUpdate.Write(self.server, stream)
end

------------------------------------------------
MWOpenScene = class("MWOpenScene", BaseResponse)
MWOpenScene.PackID = 31006
_G.Protocol["MWOpenScene"] = 31006
_G.Protocol[31006] = "MWOpenScene"
function MWOpenScene:ctor()
	--! SceneData
	self.sceneData = nil       -------- 
end

function MWOpenScene:Read(stream)
	self.sceneData = {}		-------- 
	SceneData.Read(self.sceneData, stream)
end

function MWOpenScene:Write(stream)
	SceneData.Write(self.sceneData, stream)
end

------------------------------------------------
MWCloseScene = class("MWCloseScene", BaseResponse)
MWCloseScene.PackID = 31007
_G.Protocol["MWCloseScene"] = 31007
_G.Protocol[31007] = "MWCloseScene"
function MWCloseScene:ctor()
	self.sceneID = nil       -------- 
	self.mapServerID = nil       -------- 
end

function MWCloseScene:Read(stream)
	self.sceneID = stream:readUInt64()		-------- 
	self.mapServerID = stream:readUInt16()		-------- 
end

function MWCloseScene:Write(stream)
	stream:writeUInt64(self.sceneID) 
	stream:writeUInt16(self.mapServerID) 
end

------------------------通知其他玩家切换到目标场景------------------------
MMChangeScene = class("MMChangeScene", BaseResponse)
MMChangeScene.PackID = 31252
_G.Protocol["MMChangeScene"] = 31252
_G.Protocol[31252] = "MMChangeScene"
function MMChangeScene:ctor()
	self.roleUID = nil       -------- 发出请求的角色UID
	self.sceneID = nil       -------- 场景UID
	--! AxisPos
	self.pos = nil       -------- 进入位置
	self.serverID = nil       -------- 服务器ID
end

function MMChangeScene:Read(stream)
	self.roleUID = stream:readUInt64()		-------- 发出请求的角色UID
	self.sceneID = stream:readUInt64()		-------- 场景UID
	self.pos = {}		-------- 进入位置
	AxisPos.Read(self.pos, stream)
	self.serverID = stream:readUInt16()		-------- 服务器ID
end

function MMChangeScene:Write(stream)
	stream:writeUInt64(self.roleUID) 
	stream:writeUInt64(self.sceneID) 
	AxisPos.Write(self.pos, stream)
	stream:writeUInt16(self.serverID) 
end

------------------------切线请求------------------------
MWChangeLine = class("MWChangeLine", BaseRequest)
MWChangeLine.PackID = 31212
_G.Protocol["MWChangeLine"] = 31212
_G.Protocol[31212] = "MWChangeLine"
function MWChangeLine:ctor()
	self.objUID = nil       -------- 
	self.sceneID = nil       -------- 
	--! AxisPos
	self.pos = nil       -------- 
	self.mapServerID = nil       -------- 
	self.lastSceneID = nil       -------- 
	--! AxisPos
	self.lastPos = nil       -------- 
	self.lastMapServerID = nil       -------- 
	--! ChangeLineTempData
	self.changeLineTempData = nil       -------- 
end

function MWChangeLine:Read(stream)
	self.objUID = stream:readUInt32()		-------- 
	self.sceneID = stream:readUInt64()		-------- 
	self.pos = {}		-------- 
	AxisPos.Read(self.pos, stream)
	self.mapServerID = stream:readUInt16()		-------- 
	self.lastSceneID = stream:readUInt64()		-------- 
	self.lastPos = {}		-------- 
	AxisPos.Read(self.lastPos, stream)
	self.lastMapServerID = stream:readUInt16()		-------- 
	self.changeLineTempData = {}		-------- 
	ChangeLineTempData.Read(self.changeLineTempData, stream)
end

function MWChangeLine:Write(stream)
	stream:writeUInt32(self.objUID) 
	stream:writeUInt64(self.sceneID) 
	AxisPos.Write(self.pos, stream)
	stream:writeUInt16(self.mapServerID) 
	stream:writeUInt64(self.lastSceneID) 
	AxisPos.Write(self.lastPos, stream)
	stream:writeUInt16(self.lastMapServerID) 
	ChangeLineTempData.Write(self.changeLineTempData, stream)
end

------------------------通知切换场景------------------------
WMChangeLine = class("WMChangeLine", BaseResponse)
WMChangeLine.PackID = 31214
_G.Protocol["WMChangeLine"] = 31214
_G.Protocol[31214] = "WMChangeLine"
function WMChangeLine:ctor()
	self.objUID = nil       -------- 
	self.mapID = nil       -------- 
	self.sceneID = nil       -------- 
	self.mapServerID = nil       -------- 
	--! AxisPos
	self.pos = nil       -------- 
end

function WMChangeLine:Read(stream)
	self.objUID = stream:readUInt32()		-------- 
	self.mapID = stream:readUInt16()		-------- 
	self.sceneID = stream:readUInt64()		-------- 
	self.mapServerID = stream:readUInt16()		-------- 
	self.pos = {}		-------- 
	AxisPos.Read(self.pos, stream)
end

function WMChangeLine:Write(stream)
	stream:writeUInt32(self.objUID) 
	stream:writeUInt16(self.mapID) 
	stream:writeUInt64(self.sceneID) 
	stream:writeUInt16(self.mapServerID) 
	AxisPos.Write(self.pos, stream)
end

------------------------切线请求返回------------------------
WMChangeLineRet = class("WMChangeLineRet", BaseResponse)
WMChangeLineRet.PackID = 31213
_G.Protocol["WMChangeLineRet"] = 31213
_G.Protocol[31213] = "WMChangeLineRet"
function WMChangeLineRet:ctor()
	self.objUID = nil       -------- 
	self.mapID = nil       -------- 
	self.clientListenIP = nil       -------- 
	self.clientListenPort = nil       -------- 
end

function WMChangeLineRet:Read(stream)
	self.objUID = stream:readUInt32()		-------- 
	self.mapID = stream:readUInt16()		-------- 
	self.clientListenIP = stream:readString()		-------- 
	self.clientListenPort = stream:readUInt16()		-------- 
end

function WMChangeLineRet:Write(stream)
	stream:writeUInt32(self.objUID) 
	stream:writeUInt16(self.mapID) 
	stream:writeString(self.clientListenIP) 
	stream:writeUInt16(self.clientListenPort) 
end

------------------------请求加载角色数据------------------------
WMLoadRoleData = class("WMLoadRoleData", BaseRequest)
WMLoadRoleData.PackID = 31201
_G.Protocol["WMLoadRoleData"] = 31201
_G.Protocol[31201] = "WMLoadRoleData"
function WMLoadRoleData:ctor()
	--! LoadRoleData
	self.loadData = nil       -------- 
	self.socketIndex = nil       -------- 
	--! ChangeLineTempData
	self.changeLineTempData = nil       -------- 
end

function WMLoadRoleData:Read(stream)
	self.loadData = {}		-------- 
	LoadRoleData.Read(self.loadData, stream)
	self.socketIndex = stream:readUInt64()		-------- 
	self.changeLineTempData = {}		-------- 
	ChangeLineTempData.Read(self.changeLineTempData, stream)
end

function WMLoadRoleData:Write(stream)
	LoadRoleData.Write(self.loadData, stream)
	stream:writeUInt64(self.socketIndex) 
	ChangeLineTempData.Write(self.changeLineTempData, stream)
end

------------------------加载数据返回------------------------
MWLoadRoleDataRet = class("MWLoadRoleDataRet", BaseResponse)
MWLoadRoleDataRet.PackID = 31202
_G.Protocol["MWLoadRoleDataRet"] = 31202
_G.Protocol[31202] = "MWLoadRoleDataRet"
function MWLoadRoleDataRet:ctor()
	--! LoadRoleData
	self.loadData = nil       -------- 
	--! CWorldUserData
	self.userData = nil       -------- 
	self.socketIndex = nil       -------- 
end

function MWLoadRoleDataRet:Read(stream)
	self.loadData = {}		-------- 
	LoadRoleData.Read(self.loadData, stream)
	self.userData = {}		-------- 
	CWorldUserData.Read(self.userData, stream)
	self.socketIndex = stream:readUInt64()		-------- 
end

function MWLoadRoleDataRet:Write(stream)
	LoadRoleData.Write(self.loadData, stream)
	CWorldUserData.Write(self.userData, stream)
	stream:writeUInt64(self.socketIndex) 
end

------------------------请求释放角色数据------------------------
WMUnloadRoleData = class("WMUnloadRoleData", BaseRequest)
WMUnloadRoleData.PackID = 31203
_G.Protocol["WMUnloadRoleData"] = 31203
_G.Protocol[31203] = "WMUnloadRoleData"
function WMUnloadRoleData:ctor()
	self.needRet = nil       -------- 
	self.unloadType = nil       -------- 
	self.socketIndex = nil       -------- 
	self.roleUID = nil       -------- 
	self.accountID = nil       -------- 
	self.objUID = nil       -------- 
end

function WMUnloadRoleData:Read(stream)
	self.needRet = stream:readInt8()		-------- 
	self.unloadType = stream:readInt32()		-------- 
	self.socketIndex = stream:readUInt64()		-------- 
	self.roleUID = stream:readUInt64()		-------- 
	self.accountID = stream:readUInt64()		-------- 
	self.objUID = stream:readUInt32()		-------- 
end

function WMUnloadRoleData:Write(stream)
	stream:writeInt8(self.needRet) 
	stream:writeInt32(self.unloadType) 
	stream:writeUInt64(self.socketIndex) 
	stream:writeUInt64(self.roleUID) 
	stream:writeUInt64(self.accountID) 
	stream:writeUInt32(self.objUID) 
end

------------------------释放数据返回------------------------
MWUnloadRoleDataRet = class("MWUnloadRoleDataRet", BaseResponse)
MWUnloadRoleDataRet.PackID = 31204
_G.Protocol["MWUnloadRoleDataRet"] = 31204
_G.Protocol[31204] = "MWUnloadRoleDataRet"
function MWUnloadRoleDataRet:ctor()
	self.unloadType = nil       -------- 
	self.socketIndex = nil       -------- 
	self.roleUID = nil       -------- 
	self.accountID = nil       -------- 
end

function MWUnloadRoleDataRet:Read(stream)
	self.unloadType = stream:readInt32()		-------- 
	self.socketIndex = stream:readUInt64()		-------- 
	self.roleUID = stream:readUInt64()		-------- 
	self.accountID = stream:readUInt64()		-------- 
end

function MWUnloadRoleDataRet:Write(stream)
	stream:writeInt32(self.unloadType) 
	stream:writeUInt64(self.socketIndex) 
	stream:writeUInt64(self.roleUID) 
	stream:writeUInt64(self.accountID) 
end

------------------------角色请求退出游戏------------------------
MWRoleQuit = class("MWRoleQuit", BaseRequest)
MWRoleQuit.PackID = 31205
_G.Protocol["MWRoleQuit"] = 31205
_G.Protocol[31205] = "MWRoleQuit"
function MWRoleQuit:ctor()
	self.roleUID = nil       -------- 
	self.objUID = nil       -------- 
	self.accountID = nil       -------- 
	self.socketIndex = nil       -------- 
end

function MWRoleQuit:Read(stream)
	self.roleUID = stream:readUInt64()		-------- 
	self.objUID = stream:readUInt32()		-------- 
	self.accountID = stream:readUInt64()		-------- 
	self.socketIndex = stream:readUInt64()		-------- 
end

function MWRoleQuit:Write(stream)
	stream:writeUInt64(self.roleUID) 
	stream:writeUInt32(self.objUID) 
	stream:writeUInt64(self.accountID) 
	stream:writeUInt64(self.socketIndex) 
end

------------------------角色登陆------------------------
MWUserLogin = class("MWUserLogin", BaseResponse)
MWUserLogin.PackID = 31211
_G.Protocol["MWUserLogin"] = 31211
_G.Protocol[31211] = "MWUserLogin"
function MWUserLogin:ctor()
	self.firstLogin = nil       -------- 
	self.objUID = nil       -------- 
end

function MWUserLogin:Read(stream)
	self.firstLogin = stream:readInt8()		-------- 
	self.objUID = stream:readUInt32()		-------- 
end

function MWUserLogin:Write(stream)
	stream:writeInt8(self.firstLogin) 
	stream:writeUInt32(self.objUID) 
end

------------------------角色心跳------------------------
MWRoleHeart = class("MWRoleHeart", BaseRequest)
MWRoleHeart.PackID = 31207
_G.Protocol["MWRoleHeart"] = 31207
_G.Protocol[31207] = "MWRoleHeart"
function MWRoleHeart:ctor()
	--! RoleHeart
	self.roles = {}        -------- 
end

function MWRoleHeart:Read(stream)
	local _roles_0_t = {}		-------- 
	local _roles_0_len = stream:readUInt16()
	for _0=1,_roles_0_len,1 do
	  local _roles_2_o = {}
	  RoleHeart.Read(_roles_2_o, stream)
	  table.insert(_roles_0_t, _roles_2_o)
	end
	self.roles = _roles_0_t
end

function MWRoleHeart:Write(stream)
	local _roles_0_t = self.roles 
	stream:writeUInt16(#_roles_0_t)
	for _,_roles_1_t in pairs(_roles_0_t) do
	  RoleHeart.Write(_roles_1_t, stream)
	end
end

------------------------角色心跳返回------------------------
WMRoleHeartRet = class("WMRoleHeartRet", BaseResponse)
WMRoleHeartRet.PackID = 31208
_G.Protocol["WMRoleHeartRet"] = 31208
_G.Protocol[31208] = "WMRoleHeartRet"
function WMRoleHeartRet:ctor()
	--! RoleHeart
	self.roles = {}        -------- 
end

function WMRoleHeartRet:Read(stream)
	local _roles_0_t = {}		-------- 
	local _roles_0_len = stream:readUInt16()
	for _0=1,_roles_0_len,1 do
	  local _roles_2_o = {}
	  RoleHeart.Read(_roles_2_o, stream)
	  table.insert(_roles_0_t, _roles_2_o)
	end
	self.roles = _roles_0_t
end

function WMRoleHeartRet:Write(stream)
	local _roles_0_t = self.roles 
	stream:writeUInt16(#_roles_0_t)
	for _,_roles_1_t in pairs(_roles_0_t) do
	  RoleHeart.Write(_roles_1_t, stream)
	end
end

------------------------踢掉角色------------------------
MWRoleKick = class("MWRoleKick", BaseResponse)
MWRoleKick.PackID = 31206
_G.Protocol["MWRoleKick"] = 31206
_G.Protocol[31206] = "MWRoleKick"
function MWRoleKick:ctor()
	self.roleUID = nil       -------- 
	self.accountID = nil       -------- 
	self.socketIndex = nil       -------- 
end

function MWRoleKick:Read(stream)
	self.roleUID = stream:readUInt64()		-------- 
	self.accountID = stream:readUInt64()		-------- 
	self.socketIndex = stream:readUInt64()		-------- 
end

function MWRoleKick:Write(stream)
	stream:writeUInt64(self.roleUID) 
	stream:writeUInt64(self.accountID) 
	stream:writeUInt64(self.socketIndex) 
end

------------------------更新user数据到MapServer------------------------
WMUpdateUserData = class("WMUpdateUserData", BaseResponse)
WMUpdateUserData.PackID = 31209
_G.Protocol["WMUpdateUserData"] = 31209
_G.Protocol[31209] = "WMUpdateUserData"
function WMUpdateUserData:ctor()
	self.objUID = nil       -------- 
	--! W2MUserDataUpdate
	self.userData = nil       -------- 
end

function WMUpdateUserData:Read(stream)
	self.objUID = stream:readUInt32()		-------- 
	self.userData = {}		-------- 
	W2MUserDataUpdate.Read(self.userData, stream)
end

function WMUpdateUserData:Write(stream)
	stream:writeUInt32(self.objUID) 
	W2MUserDataUpdate.Write(self.userData, stream)
end

------------------------更新role数据到WorldServer------------------------
MWUpdateRoleData = class("MWUpdateRoleData", BaseResponse)
MWUpdateRoleData.PackID = 31210
_G.Protocol["MWUpdateRoleData"] = 31210
_G.Protocol[31210] = "MWUpdateRoleData"
function MWUpdateRoleData:ctor()
	self.objUID = nil       -------- 
	--! M2WRoleDataUpdate
	self.roleData = nil       -------- 
end

function MWUpdateRoleData:Read(stream)
	self.objUID = stream:readUInt32()		-------- 
	self.roleData = {}		-------- 
	M2WRoleDataUpdate.Read(self.roleData, stream)
end

function MWUpdateRoleData:Write(stream)
	stream:writeUInt32(self.objUID) 
	M2WRoleDataUpdate.Write(self.roleData, stream)
end

------------------------随机角色名字------------------------
MWRandRoleName = class("MWRandRoleName", BaseRequest)
MWRandRoleName.PackID = 31215
_G.Protocol["MWRandRoleName"] = 31215
_G.Protocol[31215] = "MWRandRoleName"
function MWRandRoleName:ctor()
	self.roleUID = nil       -------- 
	self.sex = nil       -------- 
end

function MWRandRoleName:Read(stream)
	self.roleUID = stream:readUInt64()		-------- 
	self.sex = stream:readUInt8()		-------- 
end

function MWRandRoleName:Write(stream)
	stream:writeUInt64(self.roleUID) 
	stream:writeUInt8(self.sex) 
end

------------------------随机角色名字返回------------------------
WMRandRoleNameRet = class("WMRandRoleNameRet", BaseResponse)
WMRandRoleNameRet.PackID = 31216
_G.Protocol["WMRandRoleNameRet"] = 31216
_G.Protocol[31216] = "WMRandRoleNameRet"
function WMRandRoleNameRet:ctor()
	self.roleUID = nil       -------- 角色UID
	self.roleName = nil       -------- 角色名字
end

function WMRandRoleNameRet:Read(stream)
	self.roleUID = stream:readUInt64()		-------- 角色UID
	self.roleName = stream:readString()		-------- 角色名字
end

function WMRandRoleNameRet:Write(stream)
	stream:writeUInt64(self.roleUID) 
	stream:writeString(self.roleName) 
end

------------------------随机角色名字------------------------
MWRenameRoleName = class("MWRenameRoleName", BaseRequest)
MWRenameRoleName.PackID = 31217
_G.Protocol["MWRenameRoleName"] = 31217
_G.Protocol[31217] = "MWRenameRoleName"
function MWRenameRoleName:ctor()
	self.roleUID = nil       -------- 
	self.roleName = nil       -------- 
end

function MWRenameRoleName:Read(stream)
	self.roleUID = stream:readUInt64()		-------- 
	self.roleName = stream:readString()		-------- 
end

function MWRenameRoleName:Write(stream)
	stream:writeUInt64(self.roleUID) 
	stream:writeString(self.roleName) 
end

------------------------随机角色名字返回------------------------
WMRenameRoleNameRet = class("WMRenameRoleNameRet", BaseResponse)
WMRenameRoleNameRet.PackID = 31218
_G.Protocol["WMRenameRoleNameRet"] = 31218
_G.Protocol[31218] = "WMRenameRoleNameRet"
function WMRenameRoleNameRet:ctor()
	self.roleUID = nil       -------- 
	self.roleName = nil       -------- 
end

function WMRenameRoleNameRet:Read(stream)
	self.roleUID = stream:readUInt64()		-------- 
	self.roleName = stream:readString()		-------- 
end

function WMRenameRoleNameRet:Write(stream)
	stream:writeUInt64(self.roleUID) 
	stream:writeString(self.roleName) 
end

------------------------得到随机名字列表------------------------
MWGetRandNameList = class("MWGetRandNameList", BaseRequest)
MWGetRandNameList.PackID = 31219
_G.Protocol["MWGetRandNameList"] = 31219
_G.Protocol[31219] = "MWGetRandNameList"
function MWGetRandNameList:ctor()
end

function MWGetRandNameList:Read(stream)
end

function MWGetRandNameList:Write(stream)
end

------------------------得到随机名字列表返回------------------------
WMGetRandNameListRet = class("WMGetRandNameListRet", BaseResponse)
WMGetRandNameListRet.PackID = 31220
_G.Protocol["WMGetRandNameListRet"] = 31220
_G.Protocol[31220] = "WMGetRandNameListRet"
function WMGetRandNameListRet:ctor()
	self.roleNameList = {}        -------- 
end

function WMGetRandNameListRet:Read(stream)
	local _roleNameList_0_t = {}		-------- 
	local _roleNameList_0_len = stream:readUInt8()
	for _0=1,_roleNameList_0_len,1 do
	  table.insert(_roleNameList_0_t, stream:readString())
	end
	self.roleNameList = _roleNameList_0_t
end

function WMGetRandNameListRet:Write(stream)
	local _roleNameList_0_t = self.roleNameList 
	stream:writeUInt8(#_roleNameList_0_t)
	for _,_roleNameList_1_t in pairs(_roleNameList_0_t) do
	  stream:writeString(_roleNameList_1_t)
	end
end

------------------------充值------------------------
WMRecharge = class("WMRecharge", BaseRequest)
WMRecharge.PackID = 32104
_G.Protocol["WMRecharge"] = 32104
_G.Protocol[32104] = "WMRecharge"
function WMRecharge:ctor()
	self.serialNo = nil       -------- 
	self.roleUID = nil       -------- 
	self.accountID = nil       -------- 
	self.rmb = nil       -------- 
	self.bindRmb = nil       -------- 
end

function WMRecharge:Read(stream)
	self.serialNo = stream:readString()		-------- 
	self.roleUID = stream:readUInt64()		-------- 
	self.accountID = stream:readUInt64()		-------- 
	self.rmb = stream:readInt32()		-------- 
	self.bindRmb = stream:readInt32()		-------- 
end

function WMRecharge:Write(stream)
	stream:writeString(self.serialNo) 
	stream:writeUInt64(self.roleUID) 
	stream:writeUInt64(self.accountID) 
	stream:writeInt32(self.rmb) 
	stream:writeInt32(self.bindRmb) 
end

------------------------充值返回------------------------
MWRechargeRet = class("MWRechargeRet", BaseResponse)
MWRechargeRet.PackID = 32105
_G.Protocol["MWRechargeRet"] = 32105
_G.Protocol[32105] = "MWRechargeRet"
function MWRechargeRet:ctor()
	self.serialNo = nil       -------- 
	self.roleUID = nil       -------- 
	self.accountID = nil       -------- 
	self.isFirstCharge = nil       -------- 
	self.rmb = nil       -------- 
	self.bindRmb = nil       -------- 
end

function MWRechargeRet:Read(stream)
	self.serialNo = stream:readString()		-------- 
	self.roleUID = stream:readUInt64()		-------- 
	self.accountID = stream:readUInt64()		-------- 
	self.isFirstCharge = stream:readInt8()		-------- 
	self.rmb = stream:readInt32()		-------- 
	self.bindRmb = stream:readInt32()		-------- 
end

function MWRechargeRet:Write(stream)
	stream:writeString(self.serialNo) 
	stream:writeUInt64(self.roleUID) 
	stream:writeUInt64(self.accountID) 
	stream:writeInt8(self.isFirstCharge) 
	stream:writeInt32(self.rmb) 
	stream:writeInt32(self.bindRmb) 
end

------------------------区服信息------------------------
WMServerInfo = class("WMServerInfo", BaseResponse)
WMServerInfo.PackID = 31244
_G.Protocol["WMServerInfo"] = 31244
_G.Protocol[31244] = "WMServerInfo"
function WMServerInfo:ctor()
	self.openTime = nil       -------- 
	self.firstStartTime = nil       -------- 
end

function WMServerInfo:Read(stream)
	self.openTime = stream:readUInt32()		-------- 
	self.firstStartTime = stream:readUInt32()		-------- 
end

function WMServerInfo:Write(stream)
	stream:writeUInt32(self.openTime) 
	stream:writeUInt32(self.firstStartTime) 
end

------------------------绑定元宝------------------------
WMAwardBindRmb = class("WMAwardBindRmb", BaseResponse)
WMAwardBindRmb.PackID = 31245
_G.Protocol["WMAwardBindRmb"] = 31245
_G.Protocol[31245] = "WMAwardBindRmb"
function WMAwardBindRmb:ctor()
	self.bindRmb = nil       -------- 绑定元宝
	self.gameMoney = nil       -------- 金钱
	self.roleUID = nil       -------- 玩家UID
end

function WMAwardBindRmb:Read(stream)
	self.bindRmb = stream:readInt32()		-------- 绑定元宝
	self.gameMoney = stream:readInt32()		-------- 金钱
	self.roleUID = stream:readUInt64()		-------- 玩家UID
end

function WMAwardBindRmb:Write(stream)
	stream:writeInt32(self.bindRmb) 
	stream:writeInt32(self.gameMoney) 
	stream:writeUInt64(self.roleUID) 
end

------------------------服务器公告------------------------
MWAnnoucement = class("MWAnnoucement", BaseResponse)
MWAnnoucement.PackID = 31246
_G.Protocol["MWAnnoucement"] = 31246
_G.Protocol[31246] = "MWAnnoucement"
function MWAnnoucement:ctor()
	self.lastTime = nil       -------- 
	self.interval = nil       -------- 
	self.msg = nil       -------- 
end

function MWAnnoucement:Read(stream)
	self.lastTime = stream:readInt32()		-------- 
	self.interval = stream:readInt32()		-------- 
	self.msg = stream:readString()		-------- 
end

function MWAnnoucement:Write(stream)
	stream:writeInt32(self.lastTime) 
	stream:writeInt32(self.interval) 
	stream:writeString(self.msg) 
end

------------------------封号信息------------------------
CWMLimitAccountInfo = class("CWMLimitAccountInfo", BaseResponse)
CWMLimitAccountInfo.PackID = 31241
_G.Protocol["CWMLimitAccountInfo"] = 31241
_G.Protocol[31241] = "CWMLimitAccountInfo"
function CWMLimitAccountInfo:ctor()
	self.limitAccountID = nil       -------- 限制账号
	self.limitRoleID = nil       -------- 限制角色
	self.begintime = nil       -------- 开始时间
	self.endtime = nil       -------- 结束时间
end

function CWMLimitAccountInfo:Read(stream)
	self.limitAccountID = stream:readUInt64()		-------- 限制账号
	self.limitRoleID = stream:readUInt64()		-------- 限制角色
	self.begintime = stream:readUInt32()		-------- 开始时间
	self.endtime = stream:readUInt32()		-------- 结束时间
end

function CWMLimitAccountInfo:Write(stream)
	stream:writeUInt64(self.limitAccountID) 
	stream:writeUInt64(self.limitRoleID) 
	stream:writeUInt32(self.begintime) 
	stream:writeUInt32(self.endtime) 
end

------------------------禁言信息------------------------
CWMLimitChatInfo = class("CWMLimitChatInfo", BaseResponse)
CWMLimitChatInfo.PackID = 31242
_G.Protocol["CWMLimitChatInfo"] = 31242
_G.Protocol[31242] = "CWMLimitChatInfo"
function CWMLimitChatInfo:ctor()
	self.limitAccountID = nil       -------- 限制账号
	self.limitRoleID = nil       -------- 限制角色
	self.begintime = nil       -------- 开始时间
	self.endtime = nil       -------- 结束时间
	self.uniqueId = nil       -------- 唯一标示符
end

function CWMLimitChatInfo:Read(stream)
	self.limitAccountID = stream:readUInt64()		-------- 限制账号
	self.limitRoleID = stream:readUInt64()		-------- 限制角色
	self.begintime = stream:readUInt32()		-------- 开始时间
	self.endtime = stream:readUInt32()		-------- 结束时间
	self.uniqueId = stream:readInt32()		-------- 唯一标示符
end

function CWMLimitChatInfo:Write(stream)
	stream:writeUInt64(self.limitAccountID) 
	stream:writeUInt64(self.limitRoleID) 
	stream:writeUInt32(self.begintime) 
	stream:writeUInt32(self.endtime) 
	stream:writeInt32(self.uniqueId) 
end

------------------------通知世界服务，玩家已进入游戏，转发限号信息------------------------
CMWLimitInfoReq = class("CMWLimitInfoReq", BaseResponse)
CMWLimitInfoReq.PackID = 31243
_G.Protocol["CMWLimitInfoReq"] = 31243
_G.Protocol[31243] = "CMWLimitInfoReq"
function CMWLimitInfoReq:ctor()
	self.limitAccountID = nil       -------- 限制账号
	self.limitRoleID = nil       -------- 限制角色	
end

function CMWLimitInfoReq:Read(stream)
	self.limitAccountID = stream:readUInt64()		-------- 限制账号
	self.limitRoleID = stream:readUInt64()		-------- 限制角色	
end

function CMWLimitInfoReq:Write(stream)
	stream:writeUInt64(self.limitAccountID) 
	stream:writeUInt64(self.limitRoleID) 
end

------------------------玩家兑换礼包请求------------------------
MWExchangeGiftReq = class("MWExchangeGiftReq", BaseRequest)
MWExchangeGiftReq.PackID = 31238
_G.Protocol["MWExchangeGiftReq"] = 31238
_G.Protocol[31238] = "MWExchangeGiftReq"
function MWExchangeGiftReq:ctor()
	self.roleUID = nil       -------- 角色uid		
	self.objUid = nil       -------- 对象uid
	self.id = nil       -------- 兑换码
end

function MWExchangeGiftReq:Read(stream)
	self.roleUID = stream:readUInt64()		-------- 角色uid		
	self.objUid = stream:readUInt32()		-------- 对象uid
	self.id = stream:readString()		-------- 兑换码
end

function MWExchangeGiftReq:Write(stream)
	stream:writeUInt64(self.roleUID) 
	stream:writeUInt32(self.objUid) 
	stream:writeString(self.id) 
end

------------------------玩家兑换礼包回复------------------------
WMExchangeGiftRet = class("WMExchangeGiftRet", BaseResponse)
WMExchangeGiftRet.PackID = 31239
_G.Protocol["WMExchangeGiftRet"] = 31239
_G.Protocol[31239] = "WMExchangeGiftRet"
function WMExchangeGiftRet:ctor()
	self.roleUID = nil       -------- 角色uid		
	self.objUid = nil       -------- 对象uid
	self.itemId = nil       -------- 兑换码兑换的物品id 
end

function WMExchangeGiftRet:Read(stream)
	self.roleUID = stream:readUInt64()		-------- 角色uid		
	self.objUid = stream:readUInt32()		-------- 对象uid
	self.itemId = stream:readUInt32()		-------- 兑换码兑换的物品id 
end

function WMExchangeGiftRet:Write(stream)
	stream:writeUInt64(self.roleUID) 
	stream:writeUInt32(self.objUid) 
	stream:writeUInt32(self.itemId) 
end

------------------------服务器注册到管理服务器------------------------
XMServerRegiste = class("XMServerRegiste", BaseRequest)
XMServerRegiste.PackID = 32000
_G.Protocol["XMServerRegiste"] = 32000
_G.Protocol[32000] = "XMServerRegiste"
function XMServerRegiste:ctor()
	self.msg = nil       -------- JSON格式 {id:xxx, type:xxx, recvtype={}, msg={xxx}} recvtype:表示是否接受其他类型服务器注册信息
end

function XMServerRegiste:Read(stream)
	self.msg = stream:readString()		-------- JSON格式 {id:xxx, type:xxx, recvtype={}, msg={xxx}} recvtype:表示是否接受其他类型服务器注册信息
end

function XMServerRegiste:Write(stream)
	stream:writeString(self.msg) 
end

------------------------服务器注册到管理服务器返回------------------------
MXServerRegisteRet = class("MXServerRegisteRet", BaseResponse)
MXServerRegisteRet.PackID = 32001
_G.Protocol["MXServerRegisteRet"] = 32001
_G.Protocol[32001] = "MXServerRegisteRet"
function MXServerRegisteRet:ctor()
	self.msg = nil       -------- JSON格式 {{id:xxx, type:xxx, recvtype={}, msg={xxx}}} recvtype:表示是否接受其他类型服务器注册信息
end

function MXServerRegisteRet:Read(stream)
	self.msg = stream:readString()		-------- JSON格式 {{id:xxx, type:xxx, recvtype={}, msg={xxx}}} recvtype:表示是否接受其他类型服务器注册信息
end

function MXServerRegisteRet:Write(stream)
	stream:writeString(self.msg) 
end

------------------------地图服务器到日志服务器------------------------
CMRRecorde = class("CMRRecorde", BaseResponse)
CMRRecorde.PackID = 31400
_G.Protocol["CMRRecorde"] = 31400
_G.Protocol[31400] = "CMRRecorde"
function CMRRecorde:ctor()
	self.recordeData = nil       -------- 
end

function CMRRecorde:Read(stream)
	self.recordeData = stream:readString()		-------- 
end

function CMRRecorde:Write(stream)
	stream:writeString(self.recordeData) 
end

------------------------世界服务器到日志服务器------------------------
CWRRecorde = class("CWRRecorde", BaseResponse)
CWRRecorde.PackID = 31401
_G.Protocol["CWRRecorde"] = 31401
_G.Protocol[31401] = "CWRRecorde"
function CWRRecorde:ctor()
	self.recordeData = nil       -------- 
end

function CWRRecorde:Read(stream)
	self.recordeData = stream:readString()		-------- 
end

function CWRRecorde:Write(stream)
	stream:writeString(self.recordeData) 
end

------------------------世界服务器到日志服务器------------------------
CLRRecorde = class("CLRRecorde", BaseResponse)
CLRRecorde.PackID = 31401
_G.Protocol["CLRRecorde"] = 31401
_G.Protocol[31401] = "CLRRecorde"
function CLRRecorde:ctor()
	self.recordeData = nil       -------- 
end

function CLRRecorde:Read(stream)
	self.recordeData = stream:readString()		-------- 
end

function CLRRecorde:Write(stream)
	stream:writeString(self.recordeData) 
end

------------------------日志服务器到主日志服务器------------------------
CRRRecorde = class("CRRRecorde", BaseResponse)
CRRRecorde.PackID = 31404
_G.Protocol["CRRRecorde"] = 31404
_G.Protocol[31404] = "CRRRecorde"
function CRRRecorde:ctor()
	self.recordeData = nil       -------- 
end

function CRRRecorde:Read(stream)
	self.recordeData = stream:readString()		-------- 
end

function CRRRecorde:Write(stream)
	stream:writeString(self.recordeData) 
end

------------------------充值服务器日志------------------------
CBRRecorde = class("CBRRecorde", BaseResponse)
CBRRecorde.PackID = 31409
_G.Protocol["CBRRecorde"] = 31409
_G.Protocol[31409] = "CBRRecorde"
function CBRRecorde:ctor()
	self.recordeData = nil       -------- 
end

function CBRRecorde:Read(stream)
	self.recordeData = stream:readString()		-------- 
end

function CBRRecorde:Write(stream)
	stream:writeString(self.recordeData) 
end

------------------------请求服务器信息RecordeServer--WorldServer------------------------
CRWRequestServerInfo = class("CRWRequestServerInfo", BaseRequest)
CRWRequestServerInfo.PackID = 31405
_G.Protocol["CRWRequestServerInfo"] = 31405
_G.Protocol[31405] = "CRWRequestServerInfo"
function CRWRequestServerInfo:ctor()
end

function CRWRequestServerInfo:Read(stream)
end

function CRWRequestServerInfo:Write(stream)
end

------------------------请求服务器信息返回WorldServer--RecordeServer------------------------
CWRRequestServerInfoRet = class("CWRRequestServerInfoRet", BaseResponse)
CWRRequestServerInfoRet.PackID = 31406
_G.Protocol["CWRRequestServerInfoRet"] = 31406
_G.Protocol[31406] = "CWRRequestServerInfoRet"
function CWRRequestServerInfoRet:ctor()
	self.serverIP = nil       -------- 
	self.serverPort = nil       -------- 
	self.startTime = nil       -------- 
	self.platFormID = nil       -------- 
	self.serverID = nil       -------- 
	self.platFormName = nil       -------- 
	self.md5KeyStr = nil       -------- 
end

function CWRRequestServerInfoRet:Read(stream)
	self.serverIP = stream:readString()		-------- 
	self.serverPort = stream:readUInt16()		-------- 
	self.startTime = stream:readUInt32()		-------- 
	self.platFormID = stream:readUInt16()		-------- 
	self.serverID = stream:readUInt16()		-------- 
	self.platFormName = stream:readString()		-------- 
	self.md5KeyStr = stream:readString()		-------- 
end

function CWRRequestServerInfoRet:Write(stream)
	stream:writeString(self.serverIP) 
	stream:writeUInt16(self.serverPort) 
	stream:writeUInt32(self.startTime) 
	stream:writeUInt16(self.platFormID) 
	stream:writeUInt16(self.serverID) 
	stream:writeString(self.platFormName) 
	stream:writeString(self.md5KeyStr) 
end

------------------------世界服务器注册------------------------
CWBRegiste = class("CWBRegiste", BaseRequest)
CWBRegiste.PackID = 32100
_G.Protocol["CWBRegiste"] = 32100
_G.Protocol[32100] = "CWBRegiste"
function CWBRegiste:ctor()
	self.serverID = nil       -------- 
end

function CWBRegiste:Read(stream)
	self.serverID = stream:readUInt16()		-------- 
end

function CWBRegiste:Write(stream)
	stream:writeUInt16(self.serverID) 
end

------------------------世界服务器注册返回------------------------
CBWRegisteRet = class("CBWRegisteRet", BaseResponse)
CBWRegisteRet.PackID = 32101
_G.Protocol["CBWRegisteRet"] = 32101
_G.Protocol[32101] = "CBWRegisteRet"
function CBWRegisteRet:ctor()
end

function CBWRegisteRet:Read(stream)
end

function CBWRegisteRet:Write(stream)
end

------------------------充值------------------------
BWRecharge = class("BWRecharge", BaseRequest)
BWRecharge.PackID = 32102
_G.Protocol["BWRecharge"] = 32102
_G.Protocol[32102] = "BWRecharge"
function BWRecharge:ctor()
	self.serialNo = nil       -------- 
	self.accountID = nil       -------- 
	self.rmb = nil       -------- 
end

function BWRecharge:Read(stream)
	self.serialNo = stream:readString()		-------- 
	self.accountID = stream:readUInt64()		-------- 
	self.rmb = stream:readInt32()		-------- 
end

function BWRecharge:Write(stream)
	stream:writeString(self.serialNo) 
	stream:writeUInt64(self.accountID) 
	stream:writeInt32(self.rmb) 
end

------------------------充值返回------------------------
WBRechargeRet = class("WBRechargeRet", BaseResponse)
WBRechargeRet.PackID = 32103
_G.Protocol["WBRechargeRet"] = 32103
_G.Protocol[32103] = "WBRechargeRet"
function WBRechargeRet:ctor()
	self.serialNo = nil       -------- 
	self.accountID = nil       -------- 
	self.rmb = nil       -------- 
	self.bindRmb = nil       -------- 
	self.retCode = nil       -------- 
	self.onlineFlag = nil       -------- 
end

function WBRechargeRet:Read(stream)
	self.serialNo = stream:readString()		-------- 
	self.accountID = stream:readUInt64()		-------- 
	self.rmb = stream:readInt32()		-------- 
	self.bindRmb = stream:readInt32()		-------- 
	self.retCode = stream:readUInt16()		-------- 
	self.onlineFlag = stream:readInt8()		-------- 
end

function WBRechargeRet:Write(stream)
	stream:writeString(self.serialNo) 
	stream:writeUInt64(self.accountID) 
	stream:writeInt32(self.rmb) 
	stream:writeInt32(self.bindRmb) 
	stream:writeUInt16(self.retCode) 
	stream:writeInt8(self.onlineFlag) 
end