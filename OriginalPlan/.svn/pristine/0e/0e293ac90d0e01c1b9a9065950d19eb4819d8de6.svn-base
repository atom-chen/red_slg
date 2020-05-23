
IndianaRecordBean = class("IndianaRecordBean", BaseStruct)
function IndianaRecordBean:ctor()
	self.serialNo = nil       -------- 
	self.joinNum = nil       -------- 
	self.winName = nil       -------- 
	self.closeTime = nil       -------- 
	self.winNumber = nil       -------- 
	self.winerUID = nil       -------- 
end

function IndianaRecordBean:Read(stream)
	self.serialNo = stream:readUInt32()		-------- 
	self.joinNum = stream:readUInt32()		-------- 
	self.winName = stream:readString()		-------- 
	self.closeTime = stream:readUInt32()		-------- 
	self.winNumber = stream:readUInt32()		-------- 
	self.winerUID = stream:readUInt32()		-------- 
end

function IndianaRecordBean:Write(stream)
	stream:writeUInt32(self.serialNo) 
	stream:writeUInt32(self.joinNum) 
	stream:writeString(self.winName) 
	stream:writeUInt32(self.closeTime) 
	stream:writeUInt32(self.winNumber) 
	stream:writeUInt32(self.winerUID) 
end
IndianaBean = class("IndianaBean", BaseStruct)
function IndianaBean:ctor()
	self.id = nil       -------- 
	self.icon = nil       -------- 
	self.serialNo = nil       -------- 
	self.maxNum = nil       -------- 
	self.currentNum = nil       -------- 
	self.number = nil       -------- 
	self.joinNum = nil       -------- 
end

function IndianaBean:Read(stream)
	self.id = stream:readUInt8()		-------- 
	self.icon = stream:readString()		-------- 
	self.serialNo = stream:readUInt32()		-------- 
	self.maxNum = stream:readUInt32()		-------- 
	self.currentNum = stream:readUInt32()		-------- 
	self.number = stream:readUInt16()		-------- 
	self.joinNum = stream:readUInt16()		-------- 
end

function IndianaBean:Write(stream)
	stream:writeUInt8(self.id) 
	stream:writeString(self.icon) 
	stream:writeUInt32(self.serialNo) 
	stream:writeUInt32(self.maxNum) 
	stream:writeUInt32(self.currentNum) 
	stream:writeUInt16(self.number) 
	stream:writeUInt16(self.joinNum) 
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
	self.serverID = nil       -------- 区ID
	self.serverName = nil       -------- 区名字
	self.state = nil       -------- 区状态 @ref EZoneServerState
	self.flag = nil       -------- 区标记 @ref EZoneServerFlag
end

function ZoneServer:Read(stream)
	self.serverID = stream:readUInt16()		-------- 区ID
	self.serverName = stream:readString()		-------- 区名字
	self.state = stream:readUInt8()		-------- 区状态 @ref EZoneServerState
	self.flag = stream:readUInt8()		-------- 区标记 @ref EZoneServerFlag
end

function ZoneServer:Write(stream)
	stream:writeUInt16(self.serverID) 
	stream:writeString(self.serverName) 
	stream:writeUInt8(self.state) 
	stream:writeUInt8(self.flag) 
end
TradeItemBeanReader = class("TradeItemBeanReader", BaseStruct)
function TradeItemBeanReader:ctor()
	self.descFlag = nil       -------- 
	self.desc = nil       -------- 
	self.golds = nil       -------- 
	self.huafei = nil       -------- 
	self.iconFlag = nil       -------- 
	self.icon = nil       -------- 
	self.id = nil       -------- 
	self.jewels = nil       -------- 
	self.nameFlag = nil       -------- 
	self.name = nil       -------- 
end

function TradeItemBeanReader:Read(stream)
	self.descFlag = stream:readUInt8()		-------- 
	self.desc = stream:readString()		-------- 
	self.golds = stream:readInt32()		-------- 
	self.huafei = stream:readInt32()		-------- 
	self.iconFlag = stream:readUInt8()		-------- 
	self.icon = stream:readString()		-------- 
	self.id = stream:readInt32()		-------- 
	self.jewels = stream:readInt32()		-------- 
	self.nameFlag = stream:readUInt8()		-------- 
	self.name = stream:readString()		-------- 
end

function TradeItemBeanReader:Write(stream)
	stream:writeUInt8(self.descFlag) 
	stream:writeString(self.desc) 
	stream:writeInt32(self.golds) 
	stream:writeInt32(self.huafei) 
	stream:writeUInt8(self.iconFlag) 
	stream:writeString(self.icon) 
	stream:writeInt32(self.id) 
	stream:writeInt32(self.jewels) 
	stream:writeUInt8(self.nameFlag) 
	stream:writeString(self.name) 
end
MyGuessBeanReader = class("MyGuessBeanReader", BaseStruct)
function MyGuessBeanReader:ctor()
	self.golds = nil       -------- 
	self.id = nil       -------- 
end

function MyGuessBeanReader:Read(stream)
	self.golds = stream:readInt32()		-------- 
	self.id = stream:readInt32()		-------- 
end

function MyGuessBeanReader:Write(stream)
	stream:writeInt32(self.golds) 
	stream:writeInt32(self.id) 
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
IndianaJoinBean = class("IndianaJoinBean", BaseStruct)
function IndianaJoinBean:ctor()
	self.id = nil       -------- 
	self.number = nil       -------- 
end

function IndianaJoinBean:Read(stream)
	self.id = stream:readUInt8()		-------- 
	self.number = stream:readUInt16()		-------- 
end

function IndianaJoinBean:Write(stream)
	stream:writeUInt8(self.id) 
	stream:writeUInt16(self.number) 
end
_PackSimpleBuff = class("_PackSimpleBuff", BaseStruct)
function _PackSimpleBuff:ctor()
	self.objUID = nil       -------- 对象UID
	self.bufferTypeID = nil       -------- Buffer类型ID
end

function _PackSimpleBuff:Read(stream)
	self.objUID = stream:readUInt32()		-------- 对象UID
	self.bufferTypeID = stream:readUInt16()		-------- Buffer类型ID
end

function _PackSimpleBuff:Write(stream)
	stream:writeUInt32(self.objUID) 
	stream:writeUInt16(self.bufferTypeID) 
end
GiveGiftSimpleBeanReader = class("GiveGiftSimpleBeanReader", BaseStruct)
function GiveGiftSimpleBeanReader:ctor()
	self.dataId = nil       -------- 
	self.giftId = nil       -------- 
	self.id = nil       -------- 
	self.num = nil       -------- 
	self.playerFlag = nil       -------- 
	--! SimplePlayerInfoBeanReader
	self.player = nil       -------- 
end

function GiveGiftSimpleBeanReader:Read(stream)
	self.dataId = stream:readUInt32()		-------- 
	self.giftId = stream:readInt32()		-------- 
	self.id = stream:readInt32()		-------- 
	self.num = stream:readInt32()		-------- 
	self.playerFlag = stream:readUInt8()		-------- 
	self.player = {}		-------- 
	SimplePlayerInfoBeanReader.Read(self.player, stream)
end

function GiveGiftSimpleBeanReader:Write(stream)
	stream:writeUInt32(self.dataId) 
	stream:writeInt32(self.giftId) 
	stream:writeInt32(self.id) 
	stream:writeInt32(self.num) 
	stream:writeUInt8(self.playerFlag) 
	SimplePlayerInfoBeanReader.Write(self.player, stream)
end
FriendPageBeanReader = class("FriendPageBeanReader", BaseStruct)
function FriendPageBeanReader:ctor()
	self.agreeResponsesFlag = nil       -------- 
	--! PlayerInfoBeanReader
	self.agreeResponses = {}        -------- 
	self.disagreeResponsesFlag = nil       -------- 
	--! PlayerInfoBeanReader
	self.disagreeResponses = {}        -------- 
	self.friendDeletesFlag = nil       -------- 
	--! PlayerInfoBeanReader
	self.friendDeletes = {}        -------- 
	self.friendRequestsFlag = nil       -------- 
	--! PlayerInfoBeanReader
	self.friendRequests = {}        -------- 
	self.friendsFlag = nil       -------- 
	--! PlayerInfoBeanReader
	self.friends = {}        -------- 
	self.giveGiftsFlag = nil       -------- 
	--! GiveGiftBeanReader
	self.giveGifts = {}        -------- 
end

function FriendPageBeanReader:Read(stream)
	self.agreeResponsesFlag = stream:readUInt8()		-------- 
	local _agreeResponses_0_t = {}		-------- 
	local _agreeResponses_0_len = stream:readUInt16()
	for _0=1,_agreeResponses_0_len,1 do
	  local _agreeResponses_2_o = {}
	  PlayerInfoBeanReader.Read(_agreeResponses_2_o, stream)
	  table.insert(_agreeResponses_0_t, _agreeResponses_2_o)
	end
	self.agreeResponses = _agreeResponses_0_t
	self.disagreeResponsesFlag = stream:readUInt8()		-------- 
	local _disagreeResponses_0_t = {}		-------- 
	local _disagreeResponses_0_len = stream:readUInt16()
	for _0=1,_disagreeResponses_0_len,1 do
	  local _disagreeResponses_2_o = {}
	  PlayerInfoBeanReader.Read(_disagreeResponses_2_o, stream)
	  table.insert(_disagreeResponses_0_t, _disagreeResponses_2_o)
	end
	self.disagreeResponses = _disagreeResponses_0_t
	self.friendDeletesFlag = stream:readUInt8()		-------- 
	local _friendDeletes_0_t = {}		-------- 
	local _friendDeletes_0_len = stream:readUInt16()
	for _0=1,_friendDeletes_0_len,1 do
	  local _friendDeletes_2_o = {}
	  PlayerInfoBeanReader.Read(_friendDeletes_2_o, stream)
	  table.insert(_friendDeletes_0_t, _friendDeletes_2_o)
	end
	self.friendDeletes = _friendDeletes_0_t
	self.friendRequestsFlag = stream:readUInt8()		-------- 
	local _friendRequests_0_t = {}		-------- 
	local _friendRequests_0_len = stream:readUInt16()
	for _0=1,_friendRequests_0_len,1 do
	  local _friendRequests_2_o = {}
	  PlayerInfoBeanReader.Read(_friendRequests_2_o, stream)
	  table.insert(_friendRequests_0_t, _friendRequests_2_o)
	end
	self.friendRequests = _friendRequests_0_t
	self.friendsFlag = stream:readUInt8()		-------- 
	local _friends_0_t = {}		-------- 
	local _friends_0_len = stream:readUInt16()
	for _0=1,_friends_0_len,1 do
	  local _friends_2_o = {}
	  PlayerInfoBeanReader.Read(_friends_2_o, stream)
	  table.insert(_friends_0_t, _friends_2_o)
	end
	self.friends = _friends_0_t
	self.giveGiftsFlag = stream:readUInt8()		-------- 
	local _giveGifts_0_t = {}		-------- 
	local _giveGifts_0_len = stream:readUInt16()
	for _0=1,_giveGifts_0_len,1 do
	  local _giveGifts_2_o = {}
	  GiveGiftBeanReader.Read(_giveGifts_2_o, stream)
	  table.insert(_giveGifts_0_t, _giveGifts_2_o)
	end
	self.giveGifts = _giveGifts_0_t
end

function FriendPageBeanReader:Write(stream)
	stream:writeUInt8(self.agreeResponsesFlag) 
	local _agreeResponses_0_t = self.agreeResponses 
	stream:writeUInt16(#_agreeResponses_0_t)
	for _,_agreeResponses_1_t in pairs(_agreeResponses_0_t) do
	  PlayerInfoBeanReader.Write(_agreeResponses_1_t, stream)
	end
	stream:writeUInt8(self.disagreeResponsesFlag) 
	local _disagreeResponses_0_t = self.disagreeResponses 
	stream:writeUInt16(#_disagreeResponses_0_t)
	for _,_disagreeResponses_1_t in pairs(_disagreeResponses_0_t) do
	  PlayerInfoBeanReader.Write(_disagreeResponses_1_t, stream)
	end
	stream:writeUInt8(self.friendDeletesFlag) 
	local _friendDeletes_0_t = self.friendDeletes 
	stream:writeUInt16(#_friendDeletes_0_t)
	for _,_friendDeletes_1_t in pairs(_friendDeletes_0_t) do
	  PlayerInfoBeanReader.Write(_friendDeletes_1_t, stream)
	end
	stream:writeUInt8(self.friendRequestsFlag) 
	local _friendRequests_0_t = self.friendRequests 
	stream:writeUInt16(#_friendRequests_0_t)
	for _,_friendRequests_1_t in pairs(_friendRequests_0_t) do
	  PlayerInfoBeanReader.Write(_friendRequests_1_t, stream)
	end
	stream:writeUInt8(self.friendsFlag) 
	local _friends_0_t = self.friends 
	stream:writeUInt16(#_friends_0_t)
	for _,_friends_1_t in pairs(_friends_0_t) do
	  PlayerInfoBeanReader.Write(_friends_1_t, stream)
	end
	stream:writeUInt8(self.giveGiftsFlag) 
	local _giveGifts_0_t = self.giveGifts 
	stream:writeUInt16(#_giveGifts_0_t)
	for _,_giveGifts_1_t in pairs(_giveGifts_0_t) do
	  GiveGiftBeanReader.Write(_giveGifts_1_t, stream)
	end
end
GuessBeanReader = class("GuessBeanReader", BaseStruct)
function GuessBeanReader:ctor()
	self.iconFlag = nil       -------- 
	self.icon = nil       -------- 
	self.id = nil       -------- 
end

function GuessBeanReader:Read(stream)
	self.iconFlag = stream:readUInt8()		-------- 
	self.icon = stream:readString()		-------- 
	self.id = stream:readInt32()		-------- 
end

function GuessBeanReader:Write(stream)
	stream:writeUInt8(self.iconFlag) 
	stream:writeString(self.icon) 
	stream:writeInt32(self.id) 
end
SimplePlayerInfoBeanReader = class("SimplePlayerInfoBeanReader", BaseStruct)
function SimplePlayerInfoBeanReader:ctor()
	self.level = nil       -------- 
	self.nicknameFlag = nil       -------- 
	self.nickname = nil       -------- 
	self.playerId = nil       -------- 
	self.selfIconUrlFlag = nil       -------- 
	self.selfIconUrl = nil       -------- 
	self.systemIcon = nil       -------- 
	self.vipLevel = nil       -------- 
	self.male = nil       -------- 
end

function SimplePlayerInfoBeanReader:Read(stream)
	self.level = stream:readInt32()		-------- 
	self.nicknameFlag = stream:readUInt8()		-------- 
	self.nickname = stream:readString()		-------- 
	self.playerId = stream:readUInt32()		-------- 
	self.selfIconUrlFlag = stream:readUInt8()		-------- 
	self.selfIconUrl = stream:readString()		-------- 
	self.systemIcon = stream:readInt32()		-------- 
	self.vipLevel = stream:readInt32()		-------- 
	self.male = stream:readUInt8()		-------- 
end

function SimplePlayerInfoBeanReader:Write(stream)
	stream:writeInt32(self.level) 
	stream:writeUInt8(self.nicknameFlag) 
	stream:writeString(self.nickname) 
	stream:writeUInt32(self.playerId) 
	stream:writeUInt8(self.selfIconUrlFlag) 
	stream:writeString(self.selfIconUrl) 
	stream:writeInt32(self.systemIcon) 
	stream:writeInt32(self.vipLevel) 
	stream:writeUInt8(self.male) 
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
LoginAwardBeanReader = class("LoginAwardBeanReader", BaseStruct)
function LoginAwardBeanReader:ctor()
	self.day = nil       -------- 
	self.golds = nil       -------- 
end

function LoginAwardBeanReader:Read(stream)
	self.day = stream:readInt32()		-------- 
	self.golds = stream:readInt32()		-------- 
end

function LoginAwardBeanReader:Write(stream)
	stream:writeInt32(self.day) 
	stream:writeInt32(self.golds) 
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
GiveGiftBeanReader = class("GiveGiftBeanReader", BaseStruct)
function GiveGiftBeanReader:ctor()
	self.dataId = nil       -------- 
	self.giftId = nil       -------- 
	self.id = nil       -------- 
	self.num = nil       -------- 
	self.playerFlag = nil       -------- 
	--! PlayerInfoBeanReader
	self.player = nil       -------- 
end

function GiveGiftBeanReader:Read(stream)
	self.dataId = stream:readUInt32()		-------- 
	self.giftId = stream:readInt32()		-------- 
	self.id = stream:readInt32()		-------- 
	self.num = stream:readInt32()		-------- 
	self.playerFlag = stream:readUInt8()		-------- 
	self.player = {}		-------- 
	PlayerInfoBeanReader.Read(self.player, stream)
end

function GiveGiftBeanReader:Write(stream)
	stream:writeUInt32(self.dataId) 
	stream:writeInt32(self.giftId) 
	stream:writeInt32(self.id) 
	stream:writeInt32(self.num) 
	stream:writeUInt8(self.playerFlag) 
	PlayerInfoBeanReader.Write(self.player, stream)
end
RankBeanReader = class("RankBeanReader", BaseStruct)
function RankBeanReader:ctor()
	self.nicknameFlag = nil       -------- 
	self.nickname = nil       -------- 
	self.num = nil       -------- 
	self.playerFlag = nil       -------- 
	--! PlayerInfoBeanReader
	self.player = nil       -------- 
	self.rank = nil       -------- 
end

function RankBeanReader:Read(stream)
	self.nicknameFlag = stream:readUInt8()		-------- 
	self.nickname = stream:readString()		-------- 
	self.num = stream:readInt32()		-------- 
	self.playerFlag = stream:readUInt8()		-------- 
	self.player = {}		-------- 
	PlayerInfoBeanReader.Read(self.player, stream)
	self.rank = stream:readInt32()		-------- 
end

function RankBeanReader:Write(stream)
	stream:writeUInt8(self.nicknameFlag) 
	stream:writeString(self.nickname) 
	stream:writeInt32(self.num) 
	stream:writeUInt8(self.playerFlag) 
	PlayerInfoBeanReader.Write(self.player, stream)
	stream:writeInt32(self.rank) 
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
_PackBuffer = class("_PackBuffer", BaseStruct)
function _PackBuffer:ctor()
	self.objUID = nil       -------- 对象UID
	self.bufferTypeID = nil       -------- Buffer类型ID
	self.level = nil       -------- Buff等级
	self.timeElapsed = nil       -------- 已经持续的时间
	self.param = nil       -------- 参数(血/蓝球表示当前总容量)
end

function _PackBuffer:Read(stream)
	self.objUID = stream:readUInt32()		-------- 对象UID
	self.bufferTypeID = stream:readUInt16()		-------- Buffer类型ID
	self.level = stream:readUInt8()		-------- Buff等级
	self.timeElapsed = stream:readUInt32()		-------- 已经持续的时间
	self.param = stream:readUInt32()		-------- 参数(血/蓝球表示当前总容量)
end

function _PackBuffer:Write(stream)
	stream:writeUInt32(self.objUID) 
	stream:writeUInt16(self.bufferTypeID) 
	stream:writeUInt8(self.level) 
	stream:writeUInt32(self.timeElapsed) 
	stream:writeUInt32(self.param) 
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
RechargeOrderBeanReader = class("RechargeOrderBeanReader", BaseStruct)
function RechargeOrderBeanReader:ctor()
	self.orderIdFlag = nil       -------- 
	self.orderId = nil       -------- 
	self.rechargeDate = nil       -------- 
	self.status = nil       -------- 
end

function RechargeOrderBeanReader:Read(stream)
	self.orderIdFlag = stream:readUInt8()		-------- 
	self.orderId = stream:readString()		-------- 
	self.rechargeDate = stream:readInt32()		-------- 
	self.status = stream:readInt32()		-------- 
end

function RechargeOrderBeanReader:Write(stream)
	stream:writeUInt8(self.orderIdFlag) 
	stream:writeString(self.orderId) 
	stream:writeInt32(self.rechargeDate) 
	stream:writeInt32(self.status) 
end
ChatMsgBeanReader = class("ChatMsgBeanReader", BaseStruct)
function ChatMsgBeanReader:ctor()
	self.dataId = nil       -------- 
	self.msg = nil       -------- 
	self.dateTime = nil       -------- 
end

function ChatMsgBeanReader:Read(stream)
	self.dataId = stream:readUInt32()		-------- 
	self.msg = stream:readString()		-------- 
	self.dateTime = stream:readUInt32()		-------- 
end

function ChatMsgBeanReader:Write(stream)
	stream:writeUInt32(self.dataId) 
	stream:writeString(self.msg) 
	stream:writeUInt32(self.dateTime) 
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
SeatPlayerBeanReader = class("SeatPlayerBeanReader", BaseStruct)
function SeatPlayerBeanReader:ctor()
	self.currGolds = nil       -------- 
	self.enterGolds = nil       -------- 
	self.jewels = nil       -------- 
	self.fishingActsFlag = nil       -------- 
	self.fishingActs = nil       -------- 
	self.goldsChangeAll = nil       -------- 
	self.playerId = nil       -------- 
	self.playerNameFlag = nil       -------- 
	self.playerName = nil       -------- 
	self.pos = nil       -------- 
	self.time = nil       -------- 
	self.totalBosses = nil       -------- 
	self.totalDisks = nil       -------- 
	self.totalHalfscreenBoom = nil       -------- 
	self.totalSameTypeBoom = nil       -------- 
	self.totalScreenBoom = nil       -------- 
	self.self = nil       -------- 
	self.doubleGolds = nil       -------- 
	self.freeBullets = nil       -------- 
	self.reachTarget = nil       -------- 
	self.playerLevel = nil       -------- 
	self.vipLevel = nil       -------- 
	self.selfIconUrlFlag = nil       -------- 
	self.selfIconUrl = nil       -------- 
	self.systemIcon = nil       -------- 
	self.sex = nil       -------- 
end

function SeatPlayerBeanReader:Read(stream)
	self.currGolds = stream:readInt32()		-------- 
	self.enterGolds = stream:readInt32()		-------- 
	self.jewels = stream:readInt32()		-------- 
	self.fishingActsFlag = stream:readUInt8()		-------- 
	self.fishingActs = stream:readString()		-------- 
	self.goldsChangeAll = stream:readInt32()		-------- 
	self.playerId = stream:readUInt32()		-------- 
	self.playerNameFlag = stream:readUInt8()		-------- 
	self.playerName = stream:readString()		-------- 
	self.pos = stream:readInt32()		-------- 
	self.time = stream:readInt32()		-------- 
	self.totalBosses = stream:readInt32()		-------- 
	self.totalDisks = stream:readInt32()		-------- 
	self.totalHalfscreenBoom = stream:readInt32()		-------- 
	self.totalSameTypeBoom = stream:readInt32()		-------- 
	self.totalScreenBoom = stream:readInt32()		-------- 
	self.self = stream:readUInt8()		-------- 
	self.doubleGolds = stream:readUInt8()		-------- 
	self.freeBullets = stream:readUInt8()		-------- 
	self.reachTarget = stream:readUInt8()		-------- 
	self.playerLevel = stream:readInt32()		-------- 
	self.vipLevel = stream:readInt32()		-------- 
	self.selfIconUrlFlag = stream:readUInt8()		-------- 
	self.selfIconUrl = stream:readString()		-------- 
	self.systemIcon = stream:readInt32()		-------- 
	self.sex = stream:readUInt8()		-------- 
end

function SeatPlayerBeanReader:Write(stream)
	stream:writeInt32(self.currGolds) 
	stream:writeInt32(self.enterGolds) 
	stream:writeInt32(self.jewels) 
	stream:writeUInt8(self.fishingActsFlag) 
	stream:writeString(self.fishingActs) 
	stream:writeInt32(self.goldsChangeAll) 
	stream:writeUInt32(self.playerId) 
	stream:writeUInt8(self.playerNameFlag) 
	stream:writeString(self.playerName) 
	stream:writeInt32(self.pos) 
	stream:writeInt32(self.time) 
	stream:writeInt32(self.totalBosses) 
	stream:writeInt32(self.totalDisks) 
	stream:writeInt32(self.totalHalfscreenBoom) 
	stream:writeInt32(self.totalSameTypeBoom) 
	stream:writeInt32(self.totalScreenBoom) 
	stream:writeUInt8(self.self) 
	stream:writeUInt8(self.doubleGolds) 
	stream:writeUInt8(self.freeBullets) 
	stream:writeUInt8(self.reachTarget) 
	stream:writeInt32(self.playerLevel) 
	stream:writeInt32(self.vipLevel) 
	stream:writeUInt8(self.selfIconUrlFlag) 
	stream:writeString(self.selfIconUrl) 
	stream:writeInt32(self.systemIcon) 
	stream:writeUInt8(self.sex) 
end
ShopItemBeanReader = class("ShopItemBeanReader", BaseStruct)
function ShopItemBeanReader:ctor()
	self.id = nil       -------- 
	self.type = nil       -------- 
	self.paycode = nil       -------- 
	self.price = nil       -------- 
	self.count = nil       -------- 
	self.desc = nil       -------- 
	self.icon = nil       -------- 
	self.name = nil       -------- 
end

function ShopItemBeanReader:Read(stream)
	self.id = stream:readInt32()		-------- 
	self.type = stream:readUInt8()		-------- 
	self.paycode = stream:readInt32()		-------- 
	self.price = stream:readInt32()		-------- 
	self.count = stream:readInt32()		-------- 
	self.desc = stream:readString()		-------- 
	self.icon = stream:readString()		-------- 
	self.name = stream:readString()		-------- 
end

function ShopItemBeanReader:Write(stream)
	stream:writeInt32(self.id) 
	stream:writeUInt8(self.type) 
	stream:writeInt32(self.paycode) 
	stream:writeInt32(self.price) 
	stream:writeInt32(self.count) 
	stream:writeString(self.desc) 
	stream:writeString(self.icon) 
	stream:writeString(self.name) 
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
FriendSimplePageBeanReader = class("FriendSimplePageBeanReader", BaseStruct)
function FriendSimplePageBeanReader:ctor()
	self.agreeResponsesFlag = nil       -------- 
	--! SimplePlayerInfoBeanReader
	self.agreeResponses = {}        -------- 
	self.disagreeResponsesFlag = nil       -------- 
	--! SimplePlayerInfoBeanReader
	self.disagreeResponses = {}        -------- 
	self.friendDeletesFlag = nil       -------- 
	--! SimplePlayerInfoBeanReader
	self.friendDeletes = {}        -------- 
	self.friendRequestsFlag = nil       -------- 
	--! SimplePlayerInfoBeanReader
	self.friendRequests = {}        -------- 
	self.friendsFlag = nil       -------- 
	--! SimplePlayerInfoBeanReader
	self.friends = {}        -------- 
	self.giveGiftsFlag = nil       -------- 
	--! GiveGiftSimpleBeanReader
	self.giveGifts = {}        -------- 
end

function FriendSimplePageBeanReader:Read(stream)
	self.agreeResponsesFlag = stream:readUInt8()		-------- 
	local _agreeResponses_0_t = {}		-------- 
	local _agreeResponses_0_len = stream:readUInt16()
	for _0=1,_agreeResponses_0_len,1 do
	  local _agreeResponses_2_o = {}
	  SimplePlayerInfoBeanReader.Read(_agreeResponses_2_o, stream)
	  table.insert(_agreeResponses_0_t, _agreeResponses_2_o)
	end
	self.agreeResponses = _agreeResponses_0_t
	self.disagreeResponsesFlag = stream:readUInt8()		-------- 
	local _disagreeResponses_0_t = {}		-------- 
	local _disagreeResponses_0_len = stream:readUInt16()
	for _0=1,_disagreeResponses_0_len,1 do
	  local _disagreeResponses_2_o = {}
	  SimplePlayerInfoBeanReader.Read(_disagreeResponses_2_o, stream)
	  table.insert(_disagreeResponses_0_t, _disagreeResponses_2_o)
	end
	self.disagreeResponses = _disagreeResponses_0_t
	self.friendDeletesFlag = stream:readUInt8()		-------- 
	local _friendDeletes_0_t = {}		-------- 
	local _friendDeletes_0_len = stream:readUInt16()
	for _0=1,_friendDeletes_0_len,1 do
	  local _friendDeletes_2_o = {}
	  SimplePlayerInfoBeanReader.Read(_friendDeletes_2_o, stream)
	  table.insert(_friendDeletes_0_t, _friendDeletes_2_o)
	end
	self.friendDeletes = _friendDeletes_0_t
	self.friendRequestsFlag = stream:readUInt8()		-------- 
	local _friendRequests_0_t = {}		-------- 
	local _friendRequests_0_len = stream:readUInt16()
	for _0=1,_friendRequests_0_len,1 do
	  local _friendRequests_2_o = {}
	  SimplePlayerInfoBeanReader.Read(_friendRequests_2_o, stream)
	  table.insert(_friendRequests_0_t, _friendRequests_2_o)
	end
	self.friendRequests = _friendRequests_0_t
	self.friendsFlag = stream:readUInt8()		-------- 
	local _friends_0_t = {}		-------- 
	local _friends_0_len = stream:readUInt16()
	for _0=1,_friends_0_len,1 do
	  local _friends_2_o = {}
	  SimplePlayerInfoBeanReader.Read(_friends_2_o, stream)
	  table.insert(_friends_0_t, _friends_2_o)
	end
	self.friends = _friends_0_t
	self.giveGiftsFlag = stream:readUInt8()		-------- 
	local _giveGifts_0_t = {}		-------- 
	local _giveGifts_0_len = stream:readUInt16()
	for _0=1,_giveGifts_0_len,1 do
	  local _giveGifts_2_o = {}
	  GiveGiftSimpleBeanReader.Read(_giveGifts_2_o, stream)
	  table.insert(_giveGifts_0_t, _giveGifts_2_o)
	end
	self.giveGifts = _giveGifts_0_t
end

function FriendSimplePageBeanReader:Write(stream)
	stream:writeUInt8(self.agreeResponsesFlag) 
	local _agreeResponses_0_t = self.agreeResponses 
	stream:writeUInt16(#_agreeResponses_0_t)
	for _,_agreeResponses_1_t in pairs(_agreeResponses_0_t) do
	  SimplePlayerInfoBeanReader.Write(_agreeResponses_1_t, stream)
	end
	stream:writeUInt8(self.disagreeResponsesFlag) 
	local _disagreeResponses_0_t = self.disagreeResponses 
	stream:writeUInt16(#_disagreeResponses_0_t)
	for _,_disagreeResponses_1_t in pairs(_disagreeResponses_0_t) do
	  SimplePlayerInfoBeanReader.Write(_disagreeResponses_1_t, stream)
	end
	stream:writeUInt8(self.friendDeletesFlag) 
	local _friendDeletes_0_t = self.friendDeletes 
	stream:writeUInt16(#_friendDeletes_0_t)
	for _,_friendDeletes_1_t in pairs(_friendDeletes_0_t) do
	  SimplePlayerInfoBeanReader.Write(_friendDeletes_1_t, stream)
	end
	stream:writeUInt8(self.friendRequestsFlag) 
	local _friendRequests_0_t = self.friendRequests 
	stream:writeUInt16(#_friendRequests_0_t)
	for _,_friendRequests_1_t in pairs(_friendRequests_0_t) do
	  SimplePlayerInfoBeanReader.Write(_friendRequests_1_t, stream)
	end
	stream:writeUInt8(self.friendsFlag) 
	local _friends_0_t = self.friends 
	stream:writeUInt16(#_friends_0_t)
	for _,_friends_1_t in pairs(_friends_0_t) do
	  SimplePlayerInfoBeanReader.Write(_friends_1_t, stream)
	end
	stream:writeUInt8(self.giveGiftsFlag) 
	local _giveGifts_0_t = self.giveGifts 
	stream:writeUInt16(#_giveGifts_0_t)
	for _,_giveGifts_1_t in pairs(_giveGifts_0_t) do
	  GiveGiftSimpleBeanReader.Write(_giveGifts_1_t, stream)
	end
end
CBit16 = class("CBit16", BaseStruct)
function CBit16:ctor()
end

function CBit16:Read(stream)
end

function CBit16:Write(stream)
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
	self.name = stream:readSString()		-------- 姓名
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
	stream:writeSString(self.name) 
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
InianaMyHistoryBean = class("InianaMyHistoryBean", BaseStruct)
function InianaMyHistoryBean:ctor()
	self.id = nil       -------- 
	self.serialNo = nil       -------- 
	self.winerUID = nil       -------- 
	self.joinNum = nil       -------- 
	self.winName = nil       -------- 
	self.closeTime = nil       -------- 
	self.winNumber = nil       -------- 
	self.number = nil       -------- 
end

function InianaMyHistoryBean:Read(stream)
	self.id = stream:readUInt8()		-------- 
	self.serialNo = stream:readUInt32()		-------- 
	self.winerUID = stream:readUInt32()		-------- 
	self.joinNum = stream:readUInt32()		-------- 
	self.winName = stream:readString()		-------- 
	self.closeTime = stream:readUInt32()		-------- 
	self.winNumber = stream:readUInt32()		-------- 
	self.number = stream:readUInt16()		-------- 
end

function InianaMyHistoryBean:Write(stream)
	stream:writeUInt8(self.id) 
	stream:writeUInt32(self.serialNo) 
	stream:writeUInt32(self.winerUID) 
	stream:writeUInt32(self.joinNum) 
	stream:writeString(self.winName) 
	stream:writeUInt32(self.closeTime) 
	stream:writeUInt32(self.winNumber) 
	stream:writeUInt16(self.number) 
end
VipInfoBeanReader = class("VipInfoBeanReader", BaseStruct)
function VipInfoBeanReader:ctor()
	self.detailDescFlag = nil       -------- 
	self.detailDesc = nil       -------- 
	self.level = nil       -------- 
	self.mainDescFlag = nil       -------- 
	self.mainDesc = nil       -------- 
	self.needPayGold = nil       -------- 
end

function VipInfoBeanReader:Read(stream)
	self.detailDescFlag = stream:readUInt8()		-------- 
	self.detailDesc = stream:readString()		-------- 
	self.level = stream:readInt32()		-------- 
	self.mainDescFlag = stream:readUInt8()		-------- 
	self.mainDesc = stream:readString()		-------- 
	self.needPayGold = stream:readInt32()		-------- 
end

function VipInfoBeanReader:Write(stream)
	stream:writeUInt8(self.detailDescFlag) 
	stream:writeString(self.detailDesc) 
	stream:writeInt32(self.level) 
	stream:writeUInt8(self.mainDescFlag) 
	stream:writeString(self.mainDesc) 
	stream:writeInt32(self.needPayGold) 
end
CharmsItemBeanReader = class("CharmsItemBeanReader", BaseStruct)
function CharmsItemBeanReader:ctor()
	self.charms = nil       -------- 
	self.descFlag = nil       -------- 
	self.desc = nil       -------- 
	self.golds = nil       -------- 
	self.iconFlag = nil       -------- 
	self.icon = nil       -------- 
	self.id = nil       -------- 
	self.nameFlag = nil       -------- 
	self.name = nil       -------- 
end

function CharmsItemBeanReader:Read(stream)
	self.charms = stream:readInt32()		-------- 
	self.descFlag = stream:readUInt8()		-------- 
	self.desc = stream:readString()		-------- 
	self.golds = stream:readInt32()		-------- 
	self.iconFlag = stream:readUInt8()		-------- 
	self.icon = stream:readString()		-------- 
	self.id = stream:readInt32()		-------- 
	self.nameFlag = stream:readUInt8()		-------- 
	self.name = stream:readString()		-------- 
end

function CharmsItemBeanReader:Write(stream)
	stream:writeInt32(self.charms) 
	stream:writeUInt8(self.descFlag) 
	stream:writeString(self.desc) 
	stream:writeInt32(self.golds) 
	stream:writeUInt8(self.iconFlag) 
	stream:writeString(self.icon) 
	stream:writeInt32(self.id) 
	stream:writeUInt8(self.nameFlag) 
	stream:writeString(self.name) 
end
SimpleRankBeanReader = class("SimpleRankBeanReader", BaseStruct)
function SimpleRankBeanReader:ctor()
	self.nicknameFlag = nil       -------- 
	self.nickname = nil       -------- 
	self.num = nil       -------- 
	self.playerId = nil       -------- 
	self.rank = nil       -------- 
	self.selfIconUrlFlag = nil       -------- 
	self.selfIconUrl = nil       -------- 
	self.systemIcon = nil       -------- 
	self.sex = nil       -------- 
	self.vipLevel = nil       -------- 
end

function SimpleRankBeanReader:Read(stream)
	self.nicknameFlag = stream:readUInt8()		-------- 
	self.nickname = stream:readString()		-------- 
	self.num = stream:readInt32()		-------- 
	self.playerId = stream:readUInt32()		-------- 
	self.rank = stream:readInt32()		-------- 
	self.selfIconUrlFlag = stream:readUInt8()		-------- 
	self.selfIconUrl = stream:readString()		-------- 
	self.systemIcon = stream:readInt32()		-------- 
	self.sex = stream:readUInt8()		-------- 
	self.vipLevel = stream:readInt32()		-------- 
end

function SimpleRankBeanReader:Write(stream)
	stream:writeUInt8(self.nicknameFlag) 
	stream:writeString(self.nickname) 
	stream:writeInt32(self.num) 
	stream:writeUInt32(self.playerId) 
	stream:writeInt32(self.rank) 
	stream:writeUInt8(self.selfIconUrlFlag) 
	stream:writeString(self.selfIconUrl) 
	stream:writeInt32(self.systemIcon) 
	stream:writeUInt8(self.sex) 
	stream:writeInt32(self.vipLevel) 
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
	self.zones = {}        -------- 区服列表
end

function LCGetZoneListRet:Read(stream)
	local _zones_0_t = {}		-------- 区服列表
	local _zones_0_len = stream:readUInt8()
	for _0=1,_zones_0_len,1 do
	  local _zones_2_o = {}
	  ZoneServer.Read(_zones_2_o, stream)
	  table.insert(_zones_0_t, _zones_2_o)
	end
	self.zones = _zones_0_t
end

function LCGetZoneListRet:Write(stream)
	local _zones_0_t = self.zones 
	stream:writeUInt8(#_zones_0_t)
	for _,_zones_1_t in pairs(_zones_0_t) do
	  ZoneServer.Write(_zones_1_t, stream)
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
	self.roleName = stream:readSString()		-------- 角色名字
	self.msg = stream:readString()		-------- 消息内容
	self.perMsg = stream:readString()		-------- 特殊的消息内容（供客户端额外使用）
end

function CMChat:Write(stream)
	stream:writeUInt8(self.channelType) 
	stream:writeUInt32(self.objUid) 
	stream:writeSString(self.roleName) 
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
	self.roleName = stream:readSString()		-------- 角色名字
	self.msg = stream:readString()		-------- 消息内容
	self.perMsg = stream:readString()		-------- 特殊的消息内容（供客户端额外使用）
end

function MCChatBroad:Write(stream)
	stream:writeUInt8(self.channelType) 
	stream:writeUInt32(self.objUid) 
	stream:writeSString(self.roleName) 
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

------------------------返回错误码------------------------
MCCallBackRetCode = class("MCCallBackRetCode", BaseResponse)
MCCallBackRetCode.PackID = 3999
_G.Protocol["MCCallBackRetCode"] = 3999
_G.Protocol[3999] = "MCCallBackRetCode"
function MCCallBackRetCode:ctor()
	self.retCode = nil       -------- 返回码
end

function MCCallBackRetCode:Read(stream)
	self.retCode = stream:readUInt16()		-------- 返回码
end

function MCCallBackRetCode:Write(stream)
	stream:writeUInt16(self.retCode) 
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
	--! CBit16
	self.state = nil       -------- 
end

function MCObjActionBan:Read(stream)
	self.objUID = stream:readUInt32()		-------- 
	self.state = {}		-------- 
	CBit16.Read(self.state, stream)
end

function MCObjActionBan:Write(stream)
	stream:writeUInt32(self.objUID) 
	CBit16.Write(self.state, stream)
end

------------------------添加BUFFER------------------------
MCAddBuffer = class("MCAddBuffer", BaseResponse)
MCAddBuffer.PackID = 1306
_G.Protocol["MCAddBuffer"] = 1306
_G.Protocol[1306] = "MCAddBuffer"
function MCAddBuffer:ctor()
	--! _PackSimpleBuff
	self.ary = {}        -------- 
end

function MCAddBuffer:Read(stream)
	local _ary_0_t = {}		-------- 
	local _ary_0_len = stream:readUInt8()
	for _0=1,_ary_0_len,1 do
	  local _ary_2_o = {}
	  _PackSimpleBuff.Read(_ary_2_o, stream)
	  table.insert(_ary_0_t, _ary_2_o)
	end
	self.ary = _ary_0_t
end

function MCAddBuffer:Write(stream)
	local _ary_0_t = self.ary 
	stream:writeUInt8(#_ary_0_t)
	for _,_ary_1_t in pairs(_ary_0_t) do
	  _PackSimpleBuff.Write(_ary_1_t, stream)
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
	--! _PackBuffer
	self.buff = nil       -------- 
end

function MCViewBuffRet:Read(stream)
	self.buff = {}		-------- 
	_PackBuffer.Read(self.buff, stream)
end

function MCViewBuffRet:Write(stream)
	_PackBuffer.Write(self.buff, stream)
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

------------------------------------------------
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

------------------------------------------------
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
	self.name = stream:readSString()		-------- 名字
end

function WCRandGenNameRet:Write(stream)
	stream:writeSString(self.name) 
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
	self.roleName = stream:readSString()		-------- 角色名字
end

function CWCreateRole:Write(stream)
	stream:writeUInt8(self.rolePrototypeID) 
	stream:writeSString(self.roleName) 
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

------------------------测试协议------------------------
CMVarideTest = class("CMVarideTest", BaseRequest)
CMVarideTest.PackID = 100
_G.Protocol["CMVarideTest"] = 100
_G.Protocol[100] = "CMVarideTest"
function CMVarideTest:ctor()
	self.testFlag = nil       -------- 
end

function CMVarideTest:Read(stream)
	self.testFlag = stream:readInt8()		-------- 
end

function CMVarideTest:Write(stream)
	stream:writeInt8(self.testFlag) 
end

------------------------测试协议------------------------
MCVarideTestRet = class("MCVarideTestRet", BaseResponse)
MCVarideTestRet.PackID = 101
_G.Protocol["MCVarideTestRet"] = 101
_G.Protocol[101] = "MCVarideTestRet"
function MCVarideTestRet:ctor()
	self.testFlag = nil       -------- 
	self.testNumber = nil       -------- 
end

function MCVarideTestRet:Read(stream)
	self.testFlag = stream:readInt8()		-------- 
	self.testNumber = stream:readUInt32()		-------- 
end

function MCVarideTestRet:Write(stream)
	stream:writeInt8(self.testFlag) 
	stream:writeUInt32(self.testNumber) 
end

------------------------------------------------
CMCharmsCharms = class("CMCharmsCharms", BaseRequest)
CMCharmsCharms.PackID = 75
_G.Protocol["CMCharmsCharms"] = 75
_G.Protocol[75] = "CMCharmsCharms"
function CMCharmsCharms:ctor()
	self.iId = nil       -------- 
end

function CMCharmsCharms:Read(stream)
	self.iId = stream:readInt32()		-------- 
end

function CMCharmsCharms:Write(stream)
	stream:writeInt32(self.iId) 
end

------------------------------------------------
CMCharmsPageInfo = class("CMCharmsPageInfo", BaseRequest)
CMCharmsPageInfo.PackID = 76
_G.Protocol["CMCharmsPageInfo"] = 76
_G.Protocol[76] = "CMCharmsPageInfo"
function CMCharmsPageInfo:ctor()
end

function CMCharmsPageInfo:Read(stream)
end

function CMCharmsPageInfo:Write(stream)
end

------------------------------------------------
CMFriendDelete = class("CMFriendDelete", BaseRequest)
CMFriendDelete.PackID = 0
_G.Protocol["CMFriendDelete"] = 0
_G.Protocol[0] = "CMFriendDelete"
function CMFriendDelete:ctor()
	self.iDataId = nil       -------- 
end

function CMFriendDelete:Read(stream)
	self.iDataId = stream:readUInt32()		-------- 
end

function CMFriendDelete:Write(stream)
	stream:writeUInt32(self.iDataId) 
end

------------------------------------------------
CMFriendGiveGift = class("CMFriendGiveGift", BaseRequest)
CMFriendGiveGift.PackID = 1
_G.Protocol["CMFriendGiveGift"] = 1
_G.Protocol[1] = "CMFriendGiveGift"
function CMFriendGiveGift:ctor()
	self.iDataId = nil       -------- 
	self.iGiftId = nil       -------- 
	self.iNum = nil       -------- 
end

function CMFriendGiveGift:Read(stream)
	self.iDataId = stream:readUInt32()		-------- 
	self.iGiftId = stream:readInt32()		-------- 
	self.iNum = stream:readInt32()		-------- 
end

function CMFriendGiveGift:Write(stream)
	stream:writeUInt32(self.iDataId) 
	stream:writeInt32(self.iGiftId) 
	stream:writeInt32(self.iNum) 
end

------------------------------------------------
CMFriendMarkGiftInfo = class("CMFriendMarkGiftInfo", BaseRequest)
CMFriendMarkGiftInfo.PackID = 2
_G.Protocol["CMFriendMarkGiftInfo"] = 2
_G.Protocol[2] = "CMFriendMarkGiftInfo"
function CMFriendMarkGiftInfo:ctor()
	self.iId = nil       -------- 
end

function CMFriendMarkGiftInfo:Read(stream)
	self.iId = stream:readInt32()		-------- 
end

function CMFriendMarkGiftInfo:Write(stream)
	stream:writeInt32(self.iId) 
end

------------------------------------------------
CMFriendMarkRead = class("CMFriendMarkRead", BaseRequest)
CMFriendMarkRead.PackID = 3
_G.Protocol["CMFriendMarkRead"] = 3
_G.Protocol[3] = "CMFriendMarkRead"
function CMFriendMarkRead:ctor()
	self.iDataId = nil       -------- 
	self.iMsgtype = nil       -------- 
end

function CMFriendMarkRead:Read(stream)
	self.iDataId = stream:readUInt32()		-------- 
	self.iMsgtype = stream:readUInt16()		-------- 
end

function CMFriendMarkRead:Write(stream)
	stream:writeUInt32(self.iDataId) 
	stream:writeUInt16(self.iMsgtype) 
end

------------------------------------------------
CMFriendPageInfo = class("CMFriendPageInfo", BaseRequest)
CMFriendPageInfo.PackID = 4
_G.Protocol["CMFriendPageInfo"] = 4
_G.Protocol[4] = "CMFriendPageInfo"
function CMFriendPageInfo:ctor()
end

function CMFriendPageInfo:Read(stream)
end

function CMFriendPageInfo:Write(stream)
end

------------------------------------------------
CMFriendRequest = class("CMFriendRequest", BaseRequest)
CMFriendRequest.PackID = 5
_G.Protocol["CMFriendRequest"] = 5
_G.Protocol[5] = "CMFriendRequest"
function CMFriendRequest:ctor()
	self.iDataId = nil       -------- 
end

function CMFriendRequest:Read(stream)
	self.iDataId = stream:readUInt32()		-------- 
end

function CMFriendRequest:Write(stream)
	stream:writeUInt32(self.iDataId) 
end

------------------------------------------------
CMFriendResponse = class("CMFriendResponse", BaseRequest)
CMFriendResponse.PackID = 6
_G.Protocol["CMFriendResponse"] = 6
_G.Protocol[6] = "CMFriendResponse"
function CMFriendResponse:ctor()
	self.iDataId = nil       -------- 
	self.bAgree = nil       -------- 
end

function CMFriendResponse:Read(stream)
	self.iDataId = stream:readUInt32()		-------- 
	self.bAgree = stream:readUInt8()		-------- 
end

function CMFriendResponse:Write(stream)
	stream:writeUInt32(self.iDataId) 
	stream:writeUInt8(self.bAgree) 
end

------------------------------------------------
CMFriendSimplePageInfo = class("CMFriendSimplePageInfo", BaseRequest)
CMFriendSimplePageInfo.PackID = 79
_G.Protocol["CMFriendSimplePageInfo"] = 79
_G.Protocol[79] = "CMFriendSimplePageInfo"
function CMFriendSimplePageInfo:ctor()
end

function CMFriendSimplePageInfo:Read(stream)
end

function CMFriendSimplePageInfo:Write(stream)
end

------------------------------------------------
CMGuessBet = class("CMGuessBet", BaseRequest)
CMGuessBet.PackID = 60
_G.Protocol["CMGuessBet"] = 60
_G.Protocol[60] = "CMGuessBet"
function CMGuessBet:ctor()
	self.sBetStrFlag = nil       -------- 
	self.sBetStr = nil       -------- 
end

function CMGuessBet:Read(stream)
	self.sBetStrFlag = stream:readUInt8()		-------- 
	self.sBetStr = stream:readString()		-------- 
end

function CMGuessBet:Write(stream)
	stream:writeUInt8(self.sBetStrFlag) 
	stream:writeString(self.sBetStr) 
end

------------------------------------------------
CMGuessPageInfo = class("CMGuessPageInfo", BaseRequest)
CMGuessPageInfo.PackID = 61
_G.Protocol["CMGuessPageInfo"] = 61
_G.Protocol[61] = "CMGuessPageInfo"
function CMGuessPageInfo:ctor()
end

function CMGuessPageInfo:Read(stream)
end

function CMGuessPageInfo:Write(stream)
end

------------------------------------------------
CMGuessReceiveAward = class("CMGuessReceiveAward", BaseRequest)
CMGuessReceiveAward.PackID = 70
_G.Protocol["CMGuessReceiveAward"] = 70
_G.Protocol[70] = "CMGuessReceiveAward"
function CMGuessReceiveAward:ctor()
end

function CMGuessReceiveAward:Read(stream)
end

function CMGuessReceiveAward:Write(stream)
end

------------------------------------------------
CMMailDelete = class("CMMailDelete", BaseRequest)
CMMailDelete.PackID = 7
_G.Protocol["CMMailDelete"] = 7
_G.Protocol[7] = "CMMailDelete"
function CMMailDelete:ctor()
	self.iId = nil       -------- 
end

function CMMailDelete:Read(stream)
	self.iId = stream:readInt32()		-------- 
end

function CMMailDelete:Write(stream)
	stream:writeInt32(self.iId) 
end

------------------------------------------------
CMMailGetAttach = class("CMMailGetAttach", BaseRequest)
CMMailGetAttach.PackID = 8
_G.Protocol["CMMailGetAttach"] = 8
_G.Protocol[8] = "CMMailGetAttach"
function CMMailGetAttach:ctor()
	self.iId = nil       -------- 
end

function CMMailGetAttach:Read(stream)
	self.iId = stream:readInt32()		-------- 
end

function CMMailGetAttach:Write(stream)
	stream:writeInt32(self.iId) 
end

------------------------------------------------
CMMailMails = class("CMMailMails", BaseRequest)
CMMailMails.PackID = 9
_G.Protocol["CMMailMails"] = 9
_G.Protocol[9] = "CMMailMails"
function CMMailMails:ctor()
end

function CMMailMails:Read(stream)
end

function CMMailMails:Write(stream)
end

------------------------------------------------
CMMailMarkRead = class("CMMailMarkRead", BaseRequest)
CMMailMarkRead.PackID = 10
_G.Protocol["CMMailMarkRead"] = 10
_G.Protocol[10] = "CMMailMarkRead"
function CMMailMarkRead:ctor()
	self.iId = nil       -------- 
end

function CMMailMarkRead:Read(stream)
	self.iId = stream:readInt32()		-------- 
end

function CMMailMarkRead:Write(stream)
	stream:writeInt32(self.iId) 
end

------------------------------------------------
CMPlatChangeAccount = class("CMPlatChangeAccount", BaseRequest)
CMPlatChangeAccount.PackID = 11
_G.Protocol["CMPlatChangeAccount"] = 11
_G.Protocol[11] = "CMPlatChangeAccount"
function CMPlatChangeAccount:ctor()
	self.sAccountFlag = nil       -------- 
	self.sAccount = nil       -------- 
	self.sOldpwdFlag = nil       -------- 
	self.sOldpwd = nil       -------- 
	self.sNewpwdFlag = nil       -------- 
	self.sNewpwd = nil       -------- 
	self.iUserType = nil       -------- 
end

function CMPlatChangeAccount:Read(stream)
	self.sAccountFlag = stream:readUInt8()		-------- 
	self.sAccount = stream:readString()		-------- 
	self.sOldpwdFlag = stream:readUInt8()		-------- 
	self.sOldpwd = stream:readString()		-------- 
	self.sNewpwdFlag = stream:readUInt8()		-------- 
	self.sNewpwd = stream:readString()		-------- 
	self.iUserType = stream:readInt32()		-------- 
end

function CMPlatChangeAccount:Write(stream)
	stream:writeUInt8(self.sAccountFlag) 
	stream:writeString(self.sAccount) 
	stream:writeUInt8(self.sOldpwdFlag) 
	stream:writeString(self.sOldpwd) 
	stream:writeUInt8(self.sNewpwdFlag) 
	stream:writeString(self.sNewpwd) 
	stream:writeInt32(self.iUserType) 
end

------------------------------------------------
CMPlatChangePassword = class("CMPlatChangePassword", BaseRequest)
CMPlatChangePassword.PackID = 12
_G.Protocol["CMPlatChangePassword"] = 12
_G.Protocol[12] = "CMPlatChangePassword"
function CMPlatChangePassword:ctor()
	self.sAccountFlag = nil       -------- 
	self.sAccount = nil       -------- 
	self.sOldpwdFlag = nil       -------- 
	self.sOldpwd = nil       -------- 
	self.sNewpwdFlag = nil       -------- 
	self.sNewpwd = nil       -------- 
	self.iUserType = nil       -------- 
end

function CMPlatChangePassword:Read(stream)
	self.sAccountFlag = stream:readUInt8()		-------- 
	self.sAccount = stream:readString()		-------- 
	self.sOldpwdFlag = stream:readUInt8()		-------- 
	self.sOldpwd = stream:readString()		-------- 
	self.sNewpwdFlag = stream:readUInt8()		-------- 
	self.sNewpwd = stream:readString()		-------- 
	self.iUserType = stream:readInt32()		-------- 
end

function CMPlatChangePassword:Write(stream)
	stream:writeUInt8(self.sAccountFlag) 
	stream:writeString(self.sAccount) 
	stream:writeUInt8(self.sOldpwdFlag) 
	stream:writeString(self.sOldpwd) 
	stream:writeUInt8(self.sNewpwdFlag) 
	stream:writeString(self.sNewpwd) 
	stream:writeInt32(self.iUserType) 
end

------------------------------------------------
CMPlatLogin = class("CMPlatLogin", BaseRequest)
CMPlatLogin.PackID = 13
_G.Protocol["CMPlatLogin"] = 13
_G.Protocol[13] = "CMPlatLogin"
function CMPlatLogin:ctor()
	self.sAccountFlag = nil       -------- 
	self.sAccount = nil       -------- 
	self.sPasswordFlag = nil       -------- 
	self.sPassword = nil       -------- 
	self.sChannelFlag = nil       -------- 
	self.sChannel = nil       -------- 
	self.sChildChannelFlag = nil       -------- 
	self.sChildChannel = nil       -------- 
	self.sMachineIdFlag = nil       -------- 
	self.sMachineId = nil       -------- 
	self.iUserType = nil       -------- 
end

function CMPlatLogin:Read(stream)
	self.sAccountFlag = stream:readUInt8()		-------- 
	self.sAccount = stream:readString()		-------- 
	self.sPasswordFlag = stream:readUInt8()		-------- 
	self.sPassword = stream:readString()		-------- 
	self.sChannelFlag = stream:readUInt8()		-------- 
	self.sChannel = stream:readString()		-------- 
	self.sChildChannelFlag = stream:readUInt8()		-------- 
	self.sChildChannel = stream:readString()		-------- 
	self.sMachineIdFlag = stream:readUInt8()		-------- 
	self.sMachineId = stream:readString()		-------- 
	self.iUserType = stream:readInt32()		-------- 
end

function CMPlatLogin:Write(stream)
	stream:writeUInt8(self.sAccountFlag) 
	stream:writeString(self.sAccount) 
	stream:writeUInt8(self.sPasswordFlag) 
	stream:writeString(self.sPassword) 
	stream:writeUInt8(self.sChannelFlag) 
	stream:writeString(self.sChannel) 
	stream:writeUInt8(self.sChildChannelFlag) 
	stream:writeString(self.sChildChannel) 
	stream:writeUInt8(self.sMachineIdFlag) 
	stream:writeString(self.sMachineId) 
	stream:writeInt32(self.iUserType) 
end

------------------------------------------------
CMPlatQuickRegister = class("CMPlatQuickRegister", BaseRequest)
CMPlatQuickRegister.PackID = 14
_G.Protocol["CMPlatQuickRegister"] = 14
_G.Protocol[14] = "CMPlatQuickRegister"
function CMPlatQuickRegister:ctor()
	self.sChannelFlag = nil       -------- 
	self.sChannel = nil       -------- 
	self.sChildChannelFlag = nil       -------- 
	self.sChildChannel = nil       -------- 
	self.sMachineIdFlag = nil       -------- 
	self.sMachineId = nil       -------- 
	self.sMobileNumFlag = nil       -------- 
	self.sMobileNum = nil       -------- 
	self.iTimes = nil       -------- 
	self.sPhoneModelFlag = nil       -------- 
	self.sPhoneModel = nil       -------- 
	self.iUserType = nil       -------- 
end

function CMPlatQuickRegister:Read(stream)
	self.sChannelFlag = stream:readUInt8()		-------- 
	self.sChannel = stream:readString()		-------- 
	self.sChildChannelFlag = stream:readUInt8()		-------- 
	self.sChildChannel = stream:readString()		-------- 
	self.sMachineIdFlag = stream:readUInt8()		-------- 
	self.sMachineId = stream:readString()		-------- 
	self.sMobileNumFlag = stream:readUInt8()		-------- 
	self.sMobileNum = stream:readString()		-------- 
	self.iTimes = stream:readInt32()		-------- 
	self.sPhoneModelFlag = stream:readUInt8()		-------- 
	self.sPhoneModel = stream:readString()		-------- 
	self.iUserType = stream:readInt32()		-------- 
end

function CMPlatQuickRegister:Write(stream)
	stream:writeUInt8(self.sChannelFlag) 
	stream:writeString(self.sChannel) 
	stream:writeUInt8(self.sChildChannelFlag) 
	stream:writeString(self.sChildChannel) 
	stream:writeUInt8(self.sMachineIdFlag) 
	stream:writeString(self.sMachineId) 
	stream:writeUInt8(self.sMobileNumFlag) 
	stream:writeString(self.sMobileNum) 
	stream:writeInt32(self.iTimes) 
	stream:writeUInt8(self.sPhoneModelFlag) 
	stream:writeString(self.sPhoneModel) 
	stream:writeInt32(self.iUserType) 
end

------------------------------------------------
CMPlatRegister = class("CMPlatRegister", BaseRequest)
CMPlatRegister.PackID = 15
_G.Protocol["CMPlatRegister"] = 15
_G.Protocol[15] = "CMPlatRegister"
function CMPlatRegister:ctor()
	self.sAccountFlag = nil       -------- 
	self.sAccount = nil       -------- 
	self.sPasswordFlag = nil       -------- 
	self.sPassword = nil       -------- 
	self.sChannelFlag = nil       -------- 
	self.sChannel = nil       -------- 
	self.sChildChannelFlag = nil       -------- 
	self.sChildChannel = nil       -------- 
	self.sMachineIdFlag = nil       -------- 
	self.sMachineId = nil       -------- 
	self.sMobileNumFlag = nil       -------- 
	self.sMobileNum = nil       -------- 
	self.iTimes = nil       -------- 
	self.sPhoneModelFlag = nil       -------- 
	self.sPhoneModel = nil       -------- 
	self.iUserType = nil       -------- 
end

function CMPlatRegister:Read(stream)
	self.sAccountFlag = stream:readUInt8()		-------- 
	self.sAccount = stream:readString()		-------- 
	self.sPasswordFlag = stream:readUInt8()		-------- 
	self.sPassword = stream:readString()		-------- 
	self.sChannelFlag = stream:readUInt8()		-------- 
	self.sChannel = stream:readString()		-------- 
	self.sChildChannelFlag = stream:readUInt8()		-------- 
	self.sChildChannel = stream:readString()		-------- 
	self.sMachineIdFlag = stream:readUInt8()		-------- 
	self.sMachineId = stream:readString()		-------- 
	self.sMobileNumFlag = stream:readUInt8()		-------- 
	self.sMobileNum = stream:readString()		-------- 
	self.iTimes = stream:readInt32()		-------- 
	self.sPhoneModelFlag = stream:readUInt8()		-------- 
	self.sPhoneModel = stream:readString()		-------- 
	self.iUserType = stream:readInt32()		-------- 
end

function CMPlatRegister:Write(stream)
	stream:writeUInt8(self.sAccountFlag) 
	stream:writeString(self.sAccount) 
	stream:writeUInt8(self.sPasswordFlag) 
	stream:writeString(self.sPassword) 
	stream:writeUInt8(self.sChannelFlag) 
	stream:writeString(self.sChannel) 
	stream:writeUInt8(self.sChildChannelFlag) 
	stream:writeString(self.sChildChannel) 
	stream:writeUInt8(self.sMachineIdFlag) 
	stream:writeString(self.sMachineId) 
	stream:writeUInt8(self.sMobileNumFlag) 
	stream:writeString(self.sMobileNum) 
	stream:writeInt32(self.iTimes) 
	stream:writeUInt8(self.sPhoneModelFlag) 
	stream:writeString(self.sPhoneModel) 
	stream:writeInt32(self.iUserType) 
end

------------------------------------------------
CMPlatSdkLogin = class("CMPlatSdkLogin", BaseRequest)
CMPlatSdkLogin.PackID = 71
_G.Protocol["CMPlatSdkLogin"] = 71
_G.Protocol[71] = "CMPlatSdkLogin"
function CMPlatSdkLogin:ctor()
	self.sAccountFlag = nil       -------- 
	self.sAccount = nil       -------- 
	self.sPasswordFlag = nil       -------- 
	self.sPassword = nil       -------- 
	self.sChannelFlag = nil       -------- 
	self.sChannel = nil       -------- 
	self.sChildChannelFlag = nil       -------- 
	self.sChildChannel = nil       -------- 
	self.sMachineIdFlag = nil       -------- 
	self.sMachineId = nil       -------- 
	self.sMobileNumFlag = nil       -------- 
	self.sMobileNum = nil       -------- 
	self.iTimes = nil       -------- 
	self.sPhoneModelFlag = nil       -------- 
	self.sPhoneModel = nil       -------- 
	self.iUserType = nil       -------- 
end

function CMPlatSdkLogin:Read(stream)
	self.sAccountFlag = stream:readUInt8()		-------- 
	self.sAccount = stream:readString()		-------- 
	self.sPasswordFlag = stream:readUInt8()		-------- 
	self.sPassword = stream:readString()		-------- 
	self.sChannelFlag = stream:readUInt8()		-------- 
	self.sChannel = stream:readString()		-------- 
	self.sChildChannelFlag = stream:readUInt8()		-------- 
	self.sChildChannel = stream:readString()		-------- 
	self.sMachineIdFlag = stream:readUInt8()		-------- 
	self.sMachineId = stream:readString()		-------- 
	self.sMobileNumFlag = stream:readUInt8()		-------- 
	self.sMobileNum = stream:readString()		-------- 
	self.iTimes = stream:readInt32()		-------- 
	self.sPhoneModelFlag = stream:readUInt8()		-------- 
	self.sPhoneModel = stream:readString()		-------- 
	self.iUserType = stream:readInt32()		-------- 
end

function CMPlatSdkLogin:Write(stream)
	stream:writeUInt8(self.sAccountFlag) 
	stream:writeString(self.sAccount) 
	stream:writeUInt8(self.sPasswordFlag) 
	stream:writeString(self.sPassword) 
	stream:writeUInt8(self.sChannelFlag) 
	stream:writeString(self.sChannel) 
	stream:writeUInt8(self.sChildChannelFlag) 
	stream:writeString(self.sChildChannel) 
	stream:writeUInt8(self.sMachineIdFlag) 
	stream:writeString(self.sMachineId) 
	stream:writeUInt8(self.sMobileNumFlag) 
	stream:writeString(self.sMobileNum) 
	stream:writeInt32(self.iTimes) 
	stream:writeUInt8(self.sPhoneModelFlag) 
	stream:writeString(self.sPhoneModel) 
	stream:writeInt32(self.iUserType) 
end

------------------------------------------------
CMPlatTestConnect = class("CMPlatTestConnect", BaseRequest)
CMPlatTestConnect.PackID = 16
_G.Protocol["CMPlatTestConnect"] = 16
_G.Protocol[16] = "CMPlatTestConnect"
function CMPlatTestConnect:ctor()
end

function CMPlatTestConnect:Read(stream)
end

function CMPlatTestConnect:Write(stream)
end

------------------------------------------------
CMPlatVersion = class("CMPlatVersion", BaseRequest)
CMPlatVersion.PackID = 17
_G.Protocol["CMPlatVersion"] = 17
_G.Protocol[17] = "CMPlatVersion"
function CMPlatVersion:ctor()
	self.sClientVersionFlag = nil       -------- 
	self.sClientVersion = nil       -------- 
end

function CMPlatVersion:Read(stream)
	self.sClientVersionFlag = stream:readUInt8()		-------- 
	self.sClientVersion = stream:readString()		-------- 
end

function CMPlatVersion:Write(stream)
	stream:writeUInt8(self.sClientVersionFlag) 
	stream:writeString(self.sClientVersion) 
end

------------------------------------------------
CMRankPageInfo = class("CMRankPageInfo", BaseRequest)
CMRankPageInfo.PackID = 18
_G.Protocol["CMRankPageInfo"] = 18
_G.Protocol[18] = "CMRankPageInfo"
function CMRankPageInfo:ctor()
end

function CMRankPageInfo:Read(stream)
end

function CMRankPageInfo:Write(stream)
end

------------------------------------------------
CMRankPageSimpleInfo = class("CMRankPageSimpleInfo", BaseRequest)
CMRankPageSimpleInfo.PackID = 72
_G.Protocol["CMRankPageSimpleInfo"] = 72
_G.Protocol[72] = "CMRankPageSimpleInfo"
function CMRankPageSimpleInfo:ctor()
end

function CMRankPageSimpleInfo:Read(stream)
end

function CMRankPageSimpleInfo:Write(stream)
end

------------------------------------------------
CMRoomAllSpecial = class("CMRoomAllSpecial", BaseRequest)
CMRoomAllSpecial.PackID = 19
_G.Protocol["CMRoomAllSpecial"] = 19
_G.Protocol[19] = "CMRoomAllSpecial"
function CMRoomAllSpecial:ctor()
	self.sActsFlag = nil       -------- 
	self.sActs = nil       -------- 
end

function CMRoomAllSpecial:Read(stream)
	self.sActsFlag = stream:readUInt8()		-------- 
	self.sActs = stream:readString()		-------- 
end

function CMRoomAllSpecial:Write(stream)
	stream:writeUInt8(self.sActsFlag) 
	stream:writeString(self.sActs) 
end

------------------------------------------------
CMRoomChangePos = class("CMRoomChangePos", BaseRequest)
CMRoomChangePos.PackID = 20
_G.Protocol["CMRoomChangePos"] = 20
_G.Protocol[20] = "CMRoomChangePos"
function CMRoomChangePos:ctor()
	self.iPos = nil       -------- 
	self.lTotalGainGolds = nil       -------- 
	self.lTotalBulletGolds = nil       -------- 
	self.lTotalScreenBoom = nil       -------- 
	self.lTotalHalfScreenBoom = nil       -------- 
	self.lTotalSameTypeBoom = nil       -------- 
	self.lTotalBosses = nil       -------- 
	self.lTotalDisks = nil       -------- 
	self.sFishingActsFlag = nil       -------- 
	self.sFishingActs = nil       -------- 
end

function CMRoomChangePos:Read(stream)
	self.iPos = stream:readInt32()		-------- 
	self.lTotalGainGolds = stream:readInt32()		-------- 
	self.lTotalBulletGolds = stream:readInt32()		-------- 
	self.lTotalScreenBoom = stream:readInt32()		-------- 
	self.lTotalHalfScreenBoom = stream:readInt32()		-------- 
	self.lTotalSameTypeBoom = stream:readInt32()		-------- 
	self.lTotalBosses = stream:readInt32()		-------- 
	self.lTotalDisks = stream:readInt32()		-------- 
	self.sFishingActsFlag = stream:readUInt8()		-------- 
	self.sFishingActs = stream:readString()		-------- 
end

function CMRoomChangePos:Write(stream)
	stream:writeInt32(self.iPos) 
	stream:writeInt32(self.lTotalGainGolds) 
	stream:writeInt32(self.lTotalBulletGolds) 
	stream:writeInt32(self.lTotalScreenBoom) 
	stream:writeInt32(self.lTotalHalfScreenBoom) 
	stream:writeInt32(self.lTotalSameTypeBoom) 
	stream:writeInt32(self.lTotalBosses) 
	stream:writeInt32(self.lTotalDisks) 
	stream:writeUInt8(self.sFishingActsFlag) 
	stream:writeString(self.sFishingActs) 
end

------------------------------------------------
CMRoomEnter = class("CMRoomEnter", BaseRequest)
CMRoomEnter.PackID = 21
_G.Protocol["CMRoomEnter"] = 21
_G.Protocol[21] = "CMRoomEnter"
function CMRoomEnter:ctor()
	self.iType = nil       -------- 
end

function CMRoomEnter:Read(stream)
	self.iType = stream:readInt32()		-------- 
end

function CMRoomEnter:Write(stream)
	stream:writeInt32(self.iType) 
end

------------------------------------------------
CMRoomGiveGift = class("CMRoomGiveGift", BaseRequest)
CMRoomGiveGift.PackID = 22
_G.Protocol["CMRoomGiveGift"] = 22
_G.Protocol[22] = "CMRoomGiveGift"
function CMRoomGiveGift:ctor()
	self.iDataId = nil       -------- 
	self.iGiftId = nil       -------- 
	self.iNum = nil       -------- 
end

function CMRoomGiveGift:Read(stream)
	self.iDataId = stream:readUInt32()		-------- 
	self.iGiftId = stream:readInt32()		-------- 
	self.iNum = stream:readInt32()		-------- 
end

function CMRoomGiveGift:Write(stream)
	stream:writeUInt32(self.iDataId) 
	stream:writeInt32(self.iGiftId) 
	stream:writeInt32(self.iNum) 
end

------------------------------------------------
CMRoomOwnChange = class("CMRoomOwnChange", BaseRequest)
CMRoomOwnChange.PackID = 65
_G.Protocol["CMRoomOwnChange"] = 65
_G.Protocol[65] = "CMRoomOwnChange"
function CMRoomOwnChange:ctor()
	self.iChanceId = nil       -------- 
	self.lTotalGainGolds = nil       -------- 
	self.lTotalBulletGolds = nil       -------- 
	self.lTotalScreenBoom = nil       -------- 
	self.lTotalHalfScreenBoom = nil       -------- 
	self.lTotalSameTypeBoom = nil       -------- 
	self.lTotalBosses = nil       -------- 
	self.lTotalDisks = nil       -------- 
	self.sFishingActsFlag = nil       -------- 
	self.sFishingActs = nil       -------- 
end

function CMRoomOwnChange:Read(stream)
	self.iChanceId = stream:readInt32()		-------- 
	self.lTotalGainGolds = stream:readInt32()		-------- 
	self.lTotalBulletGolds = stream:readInt32()		-------- 
	self.lTotalScreenBoom = stream:readInt32()		-------- 
	self.lTotalHalfScreenBoom = stream:readInt32()		-------- 
	self.lTotalSameTypeBoom = stream:readInt32()		-------- 
	self.lTotalBosses = stream:readInt32()		-------- 
	self.lTotalDisks = stream:readInt32()		-------- 
	self.sFishingActsFlag = stream:readUInt8()		-------- 
	self.sFishingActs = stream:readString()		-------- 
end

function CMRoomOwnChange:Write(stream)
	stream:writeInt32(self.iChanceId) 
	stream:writeInt32(self.lTotalGainGolds) 
	stream:writeInt32(self.lTotalBulletGolds) 
	stream:writeInt32(self.lTotalScreenBoom) 
	stream:writeInt32(self.lTotalHalfScreenBoom) 
	stream:writeInt32(self.lTotalSameTypeBoom) 
	stream:writeInt32(self.lTotalBosses) 
	stream:writeInt32(self.lTotalDisks) 
	stream:writeUInt8(self.sFishingActsFlag) 
	stream:writeString(self.sFishingActs) 
end

------------------------------------------------
CMRoomPeriodSync = class("CMRoomPeriodSync", BaseRequest)
CMRoomPeriodSync.PackID = 23
_G.Protocol["CMRoomPeriodSync"] = 23
_G.Protocol[23] = "CMRoomPeriodSync"
function CMRoomPeriodSync:ctor()
	self.lTotalGainGolds = nil       -------- 
	self.lTotalBulletGolds = nil       -------- 
	self.lTotalScreenBoom = nil       -------- 
	self.lTotalHalfScreenBoom = nil       -------- 
	self.lTotalSameTypeBoom = nil       -------- 
	self.lTotalBosses = nil       -------- 
	self.lTotalDisks = nil       -------- 
	self.lBullets = nil       -------- 
	self.sFishingActsFlag = nil       -------- 
	self.sFishingActs = nil       -------- 
end

function CMRoomPeriodSync:Read(stream)
	self.lTotalGainGolds = stream:readInt32()		-------- 
	self.lTotalBulletGolds = stream:readInt32()		-------- 
	self.lTotalScreenBoom = stream:readInt32()		-------- 
	self.lTotalHalfScreenBoom = stream:readInt32()		-------- 
	self.lTotalSameTypeBoom = stream:readInt32()		-------- 
	self.lTotalBosses = stream:readInt32()		-------- 
	self.lTotalDisks = stream:readInt32()		-------- 
	self.lBullets = stream:readInt32()		-------- 
	self.sFishingActsFlag = stream:readUInt8()		-------- 
	self.sFishingActs = stream:readString()		-------- 
end

function CMRoomPeriodSync:Write(stream)
	stream:writeInt32(self.lTotalGainGolds) 
	stream:writeInt32(self.lTotalBulletGolds) 
	stream:writeInt32(self.lTotalScreenBoom) 
	stream:writeInt32(self.lTotalHalfScreenBoom) 
	stream:writeInt32(self.lTotalSameTypeBoom) 
	stream:writeInt32(self.lTotalBosses) 
	stream:writeInt32(self.lTotalDisks) 
	stream:writeInt32(self.lBullets) 
	stream:writeUInt8(self.sFishingActsFlag) 
	stream:writeString(self.sFishingActs) 
end

------------------------------------------------
CMRoomQuit = class("CMRoomQuit", BaseRequest)
CMRoomQuit.PackID = 24
_G.Protocol["CMRoomQuit"] = 24
_G.Protocol[24] = "CMRoomQuit"
function CMRoomQuit:ctor()
	self.lTotalGainGolds = nil       -------- 
	self.lTotalBulletGolds = nil       -------- 
	self.lTotalScreenBoom = nil       -------- 
	self.lTotalHalfScreenBoom = nil       -------- 
	self.lTotalSameTypeBoom = nil       -------- 
	self.lTotalBosses = nil       -------- 
	self.lTotalDisks = nil       -------- 
	self.sFishingActsFlag = nil       -------- 
	self.sFishingActs = nil       -------- 
end

function CMRoomQuit:Read(stream)
	self.lTotalGainGolds = stream:readInt32()		-------- 
	self.lTotalBulletGolds = stream:readInt32()		-------- 
	self.lTotalScreenBoom = stream:readInt32()		-------- 
	self.lTotalHalfScreenBoom = stream:readInt32()		-------- 
	self.lTotalSameTypeBoom = stream:readInt32()		-------- 
	self.lTotalBosses = stream:readInt32()		-------- 
	self.lTotalDisks = stream:readInt32()		-------- 
	self.sFishingActsFlag = stream:readUInt8()		-------- 
	self.sFishingActs = stream:readString()		-------- 
end

function CMRoomQuit:Write(stream)
	stream:writeInt32(self.lTotalGainGolds) 
	stream:writeInt32(self.lTotalBulletGolds) 
	stream:writeInt32(self.lTotalScreenBoom) 
	stream:writeInt32(self.lTotalHalfScreenBoom) 
	stream:writeInt32(self.lTotalSameTypeBoom) 
	stream:writeInt32(self.lTotalBosses) 
	stream:writeInt32(self.lTotalDisks) 
	stream:writeUInt8(self.sFishingActsFlag) 
	stream:writeString(self.sFishingActs) 
end

------------------------------------------------
CMRoomReachTarget = class("CMRoomReachTarget", BaseRequest)
CMRoomReachTarget.PackID = 66
_G.Protocol["CMRoomReachTarget"] = 66
_G.Protocol[66] = "CMRoomReachTarget"
function CMRoomReachTarget:ctor()
	self.lTotalGainGolds = nil       -------- 
	self.lTotalBulletGolds = nil       -------- 
	self.lTotalScreenBoom = nil       -------- 
	self.lTotalHalfScreenBoom = nil       -------- 
	self.lTotalSameTypeBoom = nil       -------- 
	self.lTotalBosses = nil       -------- 
	self.lTotalDisks = nil       -------- 
	self.sFishingActsFlag = nil       -------- 
	self.sFishingActs = nil       -------- 
end

function CMRoomReachTarget:Read(stream)
	self.lTotalGainGolds = stream:readInt32()		-------- 
	self.lTotalBulletGolds = stream:readInt32()		-------- 
	self.lTotalScreenBoom = stream:readInt32()		-------- 
	self.lTotalHalfScreenBoom = stream:readInt32()		-------- 
	self.lTotalSameTypeBoom = stream:readInt32()		-------- 
	self.lTotalBosses = stream:readInt32()		-------- 
	self.lTotalDisks = stream:readInt32()		-------- 
	self.sFishingActsFlag = stream:readUInt8()		-------- 
	self.sFishingActs = stream:readString()		-------- 
end

function CMRoomReachTarget:Write(stream)
	stream:writeInt32(self.lTotalGainGolds) 
	stream:writeInt32(self.lTotalBulletGolds) 
	stream:writeInt32(self.lTotalScreenBoom) 
	stream:writeInt32(self.lTotalHalfScreenBoom) 
	stream:writeInt32(self.lTotalSameTypeBoom) 
	stream:writeInt32(self.lTotalBosses) 
	stream:writeInt32(self.lTotalDisks) 
	stream:writeUInt8(self.sFishingActsFlag) 
	stream:writeString(self.sFishingActs) 
end

------------------------------------------------
CMRoomSendExpression = class("CMRoomSendExpression", BaseRequest)
CMRoomSendExpression.PackID = 77
_G.Protocol["CMRoomSendExpression"] = 77
_G.Protocol[77] = "CMRoomSendExpression"
function CMRoomSendExpression:ctor()
	self.sActsFlag = nil       -------- 
	self.sActs = nil       -------- 
end

function CMRoomSendExpression:Read(stream)
	self.sActsFlag = stream:readUInt8()		-------- 
	self.sActs = stream:readString()		-------- 
end

function CMRoomSendExpression:Write(stream)
	stream:writeUInt8(self.sActsFlag) 
	stream:writeString(self.sActs) 
end

------------------------------------------------
CMRoomTicketGot = class("CMRoomTicketGot", BaseRequest)
CMRoomTicketGot.PackID = 56
_G.Protocol["CMRoomTicketGot"] = 56
_G.Protocol[56] = "CMRoomTicketGot"
function CMRoomTicketGot:ctor()
	self.iNum = nil       -------- 
end

function CMRoomTicketGot:Read(stream)
	self.iNum = stream:readInt32()		-------- 
end

function CMRoomTicketGot:Write(stream)
	stream:writeInt32(self.iNum) 
end

------------------------------------------------
CMShopGetReAddition = class("CMShopGetReAddition", BaseRequest)
CMShopGetReAddition.PackID = 78
_G.Protocol["CMShopGetReAddition"] = 78
_G.Protocol[78] = "CMShopGetReAddition"
function CMShopGetReAddition:ctor()
end

function CMShopGetReAddition:Read(stream)
end

function CMShopGetReAddition:Write(stream)
end

------------------------------------------------
CMShopPageInfo = class("CMShopPageInfo", BaseRequest)
CMShopPageInfo.PackID = 25
_G.Protocol["CMShopPageInfo"] = 25
_G.Protocol[25] = "CMShopPageInfo"
function CMShopPageInfo:ctor()
	self.type = nil       -------- 
end

function CMShopPageInfo:Read(stream)
	self.type = stream:readUInt8()		-------- 
end

function CMShopPageInfo:Write(stream)
	stream:writeUInt8(self.type) 
end

------------------------------------------------
CMTradePageInfo = class("CMTradePageInfo", BaseRequest)
CMTradePageInfo.PackID = 26
_G.Protocol["CMTradePageInfo"] = 26
_G.Protocol[26] = "CMTradePageInfo"
function CMTradePageInfo:ctor()
end

function CMTradePageInfo:Read(stream)
end

function CMTradePageInfo:Write(stream)
end

------------------------------------------------
CMTradeTrade = class("CMTradeTrade", BaseRequest)
CMTradeTrade.PackID = 27
_G.Protocol["CMTradeTrade"] = 27
_G.Protocol[27] = "CMTradeTrade"
function CMTradeTrade:ctor()
	self.iId = nil       -------- 
	self.sMobileNumFlag = nil       -------- 
	self.sMobileNum = nil       -------- 
end

function CMTradeTrade:Read(stream)
	self.iId = stream:readInt32()		-------- 
	self.sMobileNumFlag = stream:readUInt8()		-------- 
	self.sMobileNum = stream:readString()		-------- 
end

function CMTradeTrade:Write(stream)
	stream:writeInt32(self.iId) 
	stream:writeUInt8(self.sMobileNumFlag) 
	stream:writeString(self.sMobileNum) 
end

------------------------------------------------
CMUserChangeInfo = class("CMUserChangeInfo", BaseRequest)
CMUserChangeInfo.PackID = 28
_G.Protocol["CMUserChangeInfo"] = 28
_G.Protocol[28] = "CMUserChangeInfo"
function CMUserChangeInfo:ctor()
	self.sNickNameFlag = nil       -------- 
	self.sNickName = nil       -------- 
	self.bMale = nil       -------- 
	self.sLocationFlag = nil       -------- 
	self.sLocation = nil       -------- 
	self.sCity = nil       -------- 
	self.sMobileNumFlag = nil       -------- 
	self.sMobileNum = nil       -------- 
	self.iSystemIcon = nil       -------- 
	self.sSignatureFlag = nil       -------- 
	self.sSignature = nil       -------- 
	self.sConstellationFlag = nil       -------- 
	self.sConstellation = nil       -------- 
	self.name = nil       -------- 
	self.address = nil       -------- 
end

function CMUserChangeInfo:Read(stream)
	self.sNickNameFlag = stream:readUInt8()		-------- 
	self.sNickName = stream:readString()		-------- 
	self.bMale = stream:readUInt8()		-------- 
	self.sLocationFlag = stream:readUInt8()		-------- 
	self.sLocation = stream:readString()		-------- 
	self.sCity = stream:readString()		-------- 
	self.sMobileNumFlag = stream:readUInt8()		-------- 
	self.sMobileNum = stream:readString()		-------- 
	self.iSystemIcon = stream:readInt32()		-------- 
	self.sSignatureFlag = stream:readUInt8()		-------- 
	self.sSignature = stream:readString()		-------- 
	self.sConstellationFlag = stream:readUInt8()		-------- 
	self.sConstellation = stream:readString()		-------- 
	self.name = stream:readString()		-------- 
	self.address = stream:readString()		-------- 
end

function CMUserChangeInfo:Write(stream)
	stream:writeUInt8(self.sNickNameFlag) 
	stream:writeString(self.sNickName) 
	stream:writeUInt8(self.bMale) 
	stream:writeUInt8(self.sLocationFlag) 
	stream:writeString(self.sLocation) 
	stream:writeString(self.sCity) 
	stream:writeUInt8(self.sMobileNumFlag) 
	stream:writeString(self.sMobileNum) 
	stream:writeInt32(self.iSystemIcon) 
	stream:writeUInt8(self.sSignatureFlag) 
	stream:writeString(self.sSignature) 
	stream:writeUInt8(self.sConstellationFlag) 
	stream:writeString(self.sConstellation) 
	stream:writeString(self.name) 
	stream:writeString(self.address) 
end

------------------------------------------------
CMUserCheckSomeThing = class("CMUserCheckSomeThing", BaseRequest)
CMUserCheckSomeThing.PackID = 54
_G.Protocol["CMUserCheckSomeThing"] = 54
_G.Protocol[54] = "CMUserCheckSomeThing"
function CMUserCheckSomeThing:ctor()
	self.sSomeStrFlag = nil       -------- 
	self.sSomeStr = nil       -------- 
end

function CMUserCheckSomeThing:Read(stream)
	self.sSomeStrFlag = stream:readUInt8()		-------- 
	self.sSomeStr = stream:readString()		-------- 
end

function CMUserCheckSomeThing:Write(stream)
	stream:writeUInt8(self.sSomeStrFlag) 
	stream:writeString(self.sSomeStr) 
end

------------------------------------------------
CMUserClientLog = class("CMUserClientLog", BaseRequest)
CMUserClientLog.PackID = 55
_G.Protocol["CMUserClientLog"] = 55
_G.Protocol[55] = "CMUserClientLog"
function CMUserClientLog:ctor()
	self.sLogFlag = nil       -------- 
	self.sLog = nil       -------- 
end

function CMUserClientLog:Read(stream)
	self.sLogFlag = stream:readUInt8()		-------- 
	self.sLog = stream:readString()		-------- 
end

function CMUserClientLog:Write(stream)
	stream:writeUInt8(self.sLogFlag) 
	stream:writeString(self.sLog) 
end

------------------------------------------------
CMUserEcho = class("CMUserEcho", BaseRequest)
CMUserEcho.PackID = 29
_G.Protocol["CMUserEcho"] = 29
_G.Protocol[29] = "CMUserEcho"
function CMUserEcho:ctor()
	self.sInfoFlag = nil       -------- 
	self.sInfo = nil       -------- 
end

function CMUserEcho:Read(stream)
	self.sInfoFlag = stream:readUInt8()		-------- 
	self.sInfo = stream:readString()		-------- 
end

function CMUserEcho:Write(stream)
	stream:writeUInt8(self.sInfoFlag) 
	stream:writeString(self.sInfo) 
end

------------------------------------------------
CMUserFishContestPage = class("CMUserFishContestPage", BaseRequest)
CMUserFishContestPage.PackID = 69
_G.Protocol["CMUserFishContestPage"] = 69
_G.Protocol[69] = "CMUserFishContestPage"
function CMUserFishContestPage:ctor()
end

function CMUserFishContestPage:Read(stream)
end

function CMUserFishContestPage:Write(stream)
end

------------------------------------------------
CMUserGetCatAward = class("CMUserGetCatAward", BaseRequest)
CMUserGetCatAward.PackID = 59
_G.Protocol["CMUserGetCatAward"] = 59
_G.Protocol[59] = "CMUserGetCatAward"
function CMUserGetCatAward:ctor()
end

function CMUserGetCatAward:Read(stream)
end

function CMUserGetCatAward:Write(stream)
end

------------------------------------------------
CMUserGetCatAwardValue = class("CMUserGetCatAwardValue", BaseRequest)
CMUserGetCatAwardValue.PackID = 68
_G.Protocol["CMUserGetCatAwardValue"] = 68
_G.Protocol[68] = "CMUserGetCatAwardValue"
function CMUserGetCatAwardValue:ctor()
end

function CMUserGetCatAwardValue:Read(stream)
end

function CMUserGetCatAwardValue:Write(stream)
end

------------------------------------------------
CMUserGetLoginAward = class("CMUserGetLoginAward", BaseRequest)
CMUserGetLoginAward.PackID = 30
_G.Protocol["CMUserGetLoginAward"] = 30
_G.Protocol[30] = "CMUserGetLoginAward"
function CMUserGetLoginAward:ctor()
end

function CMUserGetLoginAward:Read(stream)
end

function CMUserGetLoginAward:Write(stream)
end

------------------------------------------------
CMUserGetLoginAwardByTimes = class("CMUserGetLoginAwardByTimes", BaseRequest)
CMUserGetLoginAwardByTimes.PackID = 58
_G.Protocol["CMUserGetLoginAwardByTimes"] = 58
_G.Protocol[58] = "CMUserGetLoginAwardByTimes"
function CMUserGetLoginAwardByTimes:ctor()
	self.iDayTimes = nil       -------- 
end

function CMUserGetLoginAwardByTimes:Read(stream)
	self.iDayTimes = stream:readInt32()		-------- 
end

function CMUserGetLoginAwardByTimes:Write(stream)
	stream:writeInt32(self.iDayTimes) 
end

------------------------------------------------
CMUserGetOrderInfos = class("CMUserGetOrderInfos", BaseRequest)
CMUserGetOrderInfos.PackID = 80
_G.Protocol["CMUserGetOrderInfos"] = 80
_G.Protocol[80] = "CMUserGetOrderInfos"
function CMUserGetOrderInfos:ctor()
end

function CMUserGetOrderInfos:Read(stream)
end

function CMUserGetOrderInfos:Write(stream)
end

------------------------------------------------
CMUserGetSelfIconAward = class("CMUserGetSelfIconAward", BaseRequest)
CMUserGetSelfIconAward.PackID = 57
_G.Protocol["CMUserGetSelfIconAward"] = 57
_G.Protocol[57] = "CMUserGetSelfIconAward"
function CMUserGetSelfIconAward:ctor()
	self.iTimes = nil       -------- 
end

function CMUserGetSelfIconAward:Read(stream)
	self.iTimes = stream:readInt32()		-------- 
end

function CMUserGetSelfIconAward:Write(stream)
	stream:writeInt32(self.iTimes) 
end

------------------------------------------------
CMUserGetVipInfo = class("CMUserGetVipInfo", BaseRequest)
CMUserGetVipInfo.PackID = 74
_G.Protocol["CMUserGetVipInfo"] = 74
_G.Protocol[74] = "CMUserGetVipInfo"
function CMUserGetVipInfo:ctor()
end

function CMUserGetVipInfo:Read(stream)
end

function CMUserGetVipInfo:Write(stream)
end

------------------------------------------------
CMUserHeartBeat = class("CMUserHeartBeat", BaseRequest)
CMUserHeartBeat.PackID = 31
_G.Protocol["CMUserHeartBeat"] = 31
_G.Protocol[31] = "CMUserHeartBeat"
function CMUserHeartBeat:ctor()
end

function CMUserHeartBeat:Read(stream)
end

function CMUserHeartBeat:Write(stream)
end

------------------------------------------------
CMUserLogin = class("CMUserLogin", BaseRequest)
CMUserLogin.PackID = 32
_G.Protocol["CMUserLogin"] = 32
_G.Protocol[32] = "CMUserLogin"
function CMUserLogin:ctor()
	self.sAccoutnameFlag = nil       -------- 
	self.sAccoutname = nil       -------- 
	self.sPassTokenFlag = nil       -------- 
	self.sPassToken = nil       -------- 
	self.sPhoneModelFlag = nil       -------- 
	self.sPhoneModel = nil       -------- 
	self.sChannelFlag = nil       -------- 
	self.sChannel = nil       -------- 
	self.sChildChannelFlag = nil       -------- 
	self.sChildChannel = nil       -------- 
	self.iUserType = nil       -------- 
end

function CMUserLogin:Read(stream)
	self.sAccoutnameFlag = stream:readUInt8()		-------- 
	self.sAccoutname = stream:readString()		-------- 
	self.sPassTokenFlag = stream:readUInt8()		-------- 
	self.sPassToken = stream:readString()		-------- 
	self.sPhoneModelFlag = stream:readUInt8()		-------- 
	self.sPhoneModel = stream:readString()		-------- 
	self.sChannelFlag = stream:readUInt8()		-------- 
	self.sChannel = stream:readString()		-------- 
	self.sChildChannelFlag = stream:readUInt8()		-------- 
	self.sChildChannel = stream:readString()		-------- 
	self.iUserType = stream:readInt32()		-------- 
end

function CMUserLogin:Write(stream)
	stream:writeUInt8(self.sAccoutnameFlag) 
	stream:writeString(self.sAccoutname) 
	stream:writeUInt8(self.sPassTokenFlag) 
	stream:writeString(self.sPassToken) 
	stream:writeUInt8(self.sPhoneModelFlag) 
	stream:writeString(self.sPhoneModel) 
	stream:writeUInt8(self.sChannelFlag) 
	stream:writeString(self.sChannel) 
	stream:writeUInt8(self.sChildChannelFlag) 
	stream:writeString(self.sChildChannel) 
	stream:writeInt32(self.iUserType) 
end

------------------------------------------------
CMUserLoginAwardInfo = class("CMUserLoginAwardInfo", BaseRequest)
CMUserLoginAwardInfo.PackID = 33
_G.Protocol["CMUserLoginAwardInfo"] = 33
_G.Protocol[33] = "CMUserLoginAwardInfo"
function CMUserLoginAwardInfo:ctor()
end

function CMUserLoginAwardInfo:Read(stream)
end

function CMUserLoginAwardInfo:Write(stream)
end

------------------------------------------------
CMUserOnline = class("CMUserOnline", BaseRequest)
CMUserOnline.PackID = 34
_G.Protocol["CMUserOnline"] = 34
_G.Protocol[34] = "CMUserOnline"
function CMUserOnline:ctor()
end

function CMUserOnline:Read(stream)
end

function CMUserOnline:Write(stream)
end

------------------------------------------------
CMUserOpenCard = class("CMUserOpenCard", BaseRequest)
CMUserOpenCard.PackID = 35
_G.Protocol["CMUserOpenCard"] = 35
_G.Protocol[35] = "CMUserOpenCard"
function CMUserOpenCard:ctor()
	self.sCard = nil       -------- 
end

function CMUserOpenCard:Read(stream)
	self.sCard = stream:readString()		-------- 
end

function CMUserOpenCard:Write(stream)
	stream:writeString(self.sCard) 
end

------------------------------------------------
CMUserPlayerInfo = class("CMUserPlayerInfo", BaseRequest)
CMUserPlayerInfo.PackID = 36
_G.Protocol["CMUserPlayerInfo"] = 36
_G.Protocol[36] = "CMUserPlayerInfo"
function CMUserPlayerInfo:ctor()
	self.iId = nil       -------- 
end

function CMUserPlayerInfo:Read(stream)
	self.iId = stream:readUInt32()		-------- 
end

function CMUserPlayerInfo:Write(stream)
	stream:writeUInt32(self.iId) 
end

------------------------------------------------
CMUserSaveRechargeOrder = class("CMUserSaveRechargeOrder", BaseRequest)
CMUserSaveRechargeOrder.PackID = 81
_G.Protocol["CMUserSaveRechargeOrder"] = 81
_G.Protocol[81] = "CMUserSaveRechargeOrder"
function CMUserSaveRechargeOrder:ctor()
	self.sOrderIdFlag = nil       -------- 
	self.sOrderId = nil       -------- 
end

function CMUserSaveRechargeOrder:Read(stream)
	self.sOrderIdFlag = stream:readUInt8()		-------- 
	self.sOrderId = stream:readString()		-------- 
end

function CMUserSaveRechargeOrder:Write(stream)
	stream:writeUInt8(self.sOrderIdFlag) 
	stream:writeString(self.sOrderId) 
end

------------------------------------------------
CMUserSimpleFishContestPage = class("CMUserSimpleFishContestPage", BaseRequest)
CMUserSimpleFishContestPage.PackID = 73
_G.Protocol["CMUserSimpleFishContestPage"] = 73
_G.Protocol[73] = "CMUserSimpleFishContestPage"
function CMUserSimpleFishContestPage:ctor()
end

function CMUserSimpleFishContestPage:Read(stream)
end

function CMUserSimpleFishContestPage:Write(stream)
end

------------------------------------------------
CMUserVersion = class("CMUserVersion", BaseRequest)
CMUserVersion.PackID = 37
_G.Protocol["CMUserVersion"] = 37
_G.Protocol[37] = "CMUserVersion"
function CMUserVersion:ctor()
	self.sClientVersionFlag = nil       -------- 
	self.sClientVersion = nil       -------- 
end

function CMUserVersion:Read(stream)
	self.sClientVersionFlag = stream:readUInt8()		-------- 
	self.sClientVersion = stream:readString()		-------- 
end

function CMUserVersion:Write(stream)
	stream:writeUInt8(self.sClientVersionFlag) 
	stream:writeString(self.sClientVersion) 
end

------------------------------------------------
CMGetFriendChatHistory = class("CMGetFriendChatHistory", BaseRequest)
CMGetFriendChatHistory.PackID = 85
_G.Protocol["CMGetFriendChatHistory"] = 85
_G.Protocol[85] = "CMGetFriendChatHistory"
function CMGetFriendChatHistory:ctor()
end

function CMGetFriendChatHistory:Read(stream)
end

function CMGetFriendChatHistory:Write(stream)
end

------------------------------------------------
CMFriendPrivateChat = class("CMFriendPrivateChat", BaseRequest)
CMFriendPrivateChat.PackID = 86
_G.Protocol["CMFriendPrivateChat"] = 86
_G.Protocol[86] = "CMFriendPrivateChat"
function CMFriendPrivateChat:ctor()
	self.iDataId = nil       -------- 
	self.msg = nil       -------- 
end

function CMFriendPrivateChat:Read(stream)
	self.iDataId = stream:readUInt32()		-------- 
	self.msg = stream:readString()		-------- 
end

function CMFriendPrivateChat:Write(stream)
	stream:writeUInt32(self.iDataId) 
	stream:writeString(self.msg) 
end

------------------------------------------------
MCCharmsCharmsRet = class("MCCharmsCharmsRet", BaseResponse)
MCCharmsCharmsRet.PackID = 751
_G.Protocol["MCCharmsCharmsRet"] = 751
_G.Protocol[751] = "MCCharmsCharmsRet"
function MCCharmsCharmsRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
end

function MCCharmsCharmsRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
end

function MCCharmsCharmsRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
end

------------------------------------------------
MCCharmsPageInfoRet = class("MCCharmsPageInfoRet", BaseResponse)
MCCharmsPageInfoRet.PackID = 761
_G.Protocol["MCCharmsPageInfoRet"] = 761
_G.Protocol[761] = "MCCharmsPageInfoRet"
function MCCharmsPageInfoRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
	self.descFlag = nil       -------- 
	self.desc = nil       -------- 
	self.charmsLimit = nil       -------- 
	self.charmsItemsFlag = nil       -------- 
	--! CharmsItemBeanReader
	self.charmsItems = {}        -------- 
end

function MCCharmsPageInfoRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
	self.descFlag = stream:readUInt8()		-------- 
	self.desc = stream:readString()		-------- 
	self.charmsLimit = stream:readInt32()		-------- 
	self.charmsItemsFlag = stream:readUInt8()		-------- 
	local _charmsItems_0_t = {}		-------- 
	local _charmsItems_0_len = stream:readUInt16()
	for _0=1,_charmsItems_0_len,1 do
	  local _charmsItems_2_o = {}
	  CharmsItemBeanReader.Read(_charmsItems_2_o, stream)
	  table.insert(_charmsItems_0_t, _charmsItems_2_o)
	end
	self.charmsItems = _charmsItems_0_t
end

function MCCharmsPageInfoRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
	stream:writeUInt8(self.descFlag) 
	stream:writeString(self.desc) 
	stream:writeInt32(self.charmsLimit) 
	stream:writeUInt8(self.charmsItemsFlag) 
	local _charmsItems_0_t = self.charmsItems 
	stream:writeUInt16(#_charmsItems_0_t)
	for _,_charmsItems_1_t in pairs(_charmsItems_0_t) do
	  CharmsItemBeanReader.Write(_charmsItems_1_t, stream)
	end
end

------------------------------------------------
MCFriendDeleteRet = class("MCFriendDeleteRet", BaseResponse)
MCFriendDeleteRet.PackID = 99
_G.Protocol["MCFriendDeleteRet"] = 99
_G.Protocol[99] = "MCFriendDeleteRet"
function MCFriendDeleteRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
end

function MCFriendDeleteRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
end

function MCFriendDeleteRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
end

------------------------------------------------
MCFriendGiveGiftRet = class("MCFriendGiveGiftRet", BaseResponse)
MCFriendGiveGiftRet.PackID = 119
_G.Protocol["MCFriendGiveGiftRet"] = 119
_G.Protocol[119] = "MCFriendGiveGiftRet"
function MCFriendGiveGiftRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
end

function MCFriendGiveGiftRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
end

function MCFriendGiveGiftRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
end

------------------------------------------------
MCFriendMarkGiftInfoRet = class("MCFriendMarkGiftInfoRet", BaseResponse)
MCFriendMarkGiftInfoRet.PackID = 129
_G.Protocol["MCFriendMarkGiftInfoRet"] = 129
_G.Protocol[129] = "MCFriendMarkGiftInfoRet"
function MCFriendMarkGiftInfoRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
end

function MCFriendMarkGiftInfoRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
end

function MCFriendMarkGiftInfoRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
end

------------------------------------------------
MCFriendMarkReadRet = class("MCFriendMarkReadRet", BaseResponse)
MCFriendMarkReadRet.PackID = 139
_G.Protocol["MCFriendMarkReadRet"] = 139
_G.Protocol[139] = "MCFriendMarkReadRet"
function MCFriendMarkReadRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
end

function MCFriendMarkReadRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
end

function MCFriendMarkReadRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
end

------------------------------------------------
MCFriendPageInfoRet = class("MCFriendPageInfoRet", BaseResponse)
MCFriendPageInfoRet.PackID = 149
_G.Protocol["MCFriendPageInfoRet"] = 149
_G.Protocol[149] = "MCFriendPageInfoRet"
function MCFriendPageInfoRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
	self.pageInfoFlag = nil       -------- 
	--! FriendPageBeanReader
	self.pageInfo = nil       -------- 
end

function MCFriendPageInfoRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
	self.pageInfoFlag = stream:readUInt8()		-------- 
	self.pageInfo = {}		-------- 
	FriendPageBeanReader.Read(self.pageInfo, stream)
end

function MCFriendPageInfoRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
	stream:writeUInt8(self.pageInfoFlag) 
	FriendPageBeanReader.Write(self.pageInfo, stream)
end

------------------------------------------------
MCFriendRequestRet = class("MCFriendRequestRet", BaseResponse)
MCFriendRequestRet.PackID = 159
_G.Protocol["MCFriendRequestRet"] = 159
_G.Protocol[159] = "MCFriendRequestRet"
function MCFriendRequestRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
end

function MCFriendRequestRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
end

function MCFriendRequestRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
end

------------------------------------------------
MCFriendResponseRet = class("MCFriendResponseRet", BaseResponse)
MCFriendResponseRet.PackID = 169
_G.Protocol["MCFriendResponseRet"] = 169
_G.Protocol[169] = "MCFriendResponseRet"
function MCFriendResponseRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
end

function MCFriendResponseRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
end

function MCFriendResponseRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
end

------------------------------------------------
MCFriendSimplePageInfoRet = class("MCFriendSimplePageInfoRet", BaseResponse)
MCFriendSimplePageInfoRet.PackID = 791
_G.Protocol["MCFriendSimplePageInfoRet"] = 791
_G.Protocol[791] = "MCFriendSimplePageInfoRet"
function MCFriendSimplePageInfoRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
	self.pageInfoFlag = nil       -------- 
	--! FriendSimplePageBeanReader
	self.pageInfo = nil       -------- 
end

function MCFriendSimplePageInfoRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
	self.pageInfoFlag = stream:readUInt8()		-------- 
	self.pageInfo = {}		-------- 
	FriendSimplePageBeanReader.Read(self.pageInfo, stream)
end

function MCFriendSimplePageInfoRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
	stream:writeUInt8(self.pageInfoFlag) 
	FriendSimplePageBeanReader.Write(self.pageInfo, stream)
end

------------------------------------------------
MCGuessBetRet = class("MCGuessBetRet", BaseResponse)
MCGuessBetRet.PackID = 601
_G.Protocol["MCGuessBetRet"] = 601
_G.Protocol[601] = "MCGuessBetRet"
function MCGuessBetRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
end

function MCGuessBetRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
end

function MCGuessBetRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
end

------------------------------------------------
MCGuessPageInfoRet = class("MCGuessPageInfoRet", BaseResponse)
MCGuessPageInfoRet.PackID = 611
_G.Protocol["MCGuessPageInfoRet"] = 611
_G.Protocol[611] = "MCGuessPageInfoRet"
function MCGuessPageInfoRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
	self.endTime = nil       -------- 
	self.firstDesrGolds = nil       -------- 
	self.startTime = nil       -------- 
	self.wages = nil       -------- 
	self.leastGoldLimit = nil       -------- 
	self.winingBeanFlag = nil       -------- 
	--! MyGuessBeanReader
	self.winingBean = nil       -------- 
	self.winningFish = nil       -------- 
	self.beansFlag = nil       -------- 
	--! MyGuessBeanReader
	self.beans = {}        -------- 
	self.guessBeansFlag = nil       -------- 
	--! GuessBeanReader
	self.guessBeans = {}        -------- 
end

function MCGuessPageInfoRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
	self.endTime = stream:readInt32()		-------- 
	self.firstDesrGolds = stream:readInt32()		-------- 
	self.startTime = stream:readInt32()		-------- 
	self.wages = stream:readInt32()		-------- 
	self.leastGoldLimit = stream:readInt32()		-------- 
	self.winingBeanFlag = stream:readUInt8()		-------- 
	self.winingBean = {}		-------- 
	MyGuessBeanReader.Read(self.winingBean, stream)
	self.winningFish = stream:readInt32()		-------- 
	self.beansFlag = stream:readUInt8()		-------- 
	local _beans_0_t = {}		-------- 
	local _beans_0_len = stream:readUInt16()
	for _0=1,_beans_0_len,1 do
	  local _beans_2_o = {}
	  MyGuessBeanReader.Read(_beans_2_o, stream)
	  table.insert(_beans_0_t, _beans_2_o)
	end
	self.beans = _beans_0_t
	self.guessBeansFlag = stream:readUInt8()		-------- 
	local _guessBeans_0_t = {}		-------- 
	local _guessBeans_0_len = stream:readUInt16()
	for _0=1,_guessBeans_0_len,1 do
	  local _guessBeans_2_o = {}
	  GuessBeanReader.Read(_guessBeans_2_o, stream)
	  table.insert(_guessBeans_0_t, _guessBeans_2_o)
	end
	self.guessBeans = _guessBeans_0_t
end

function MCGuessPageInfoRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
	stream:writeInt32(self.endTime) 
	stream:writeInt32(self.firstDesrGolds) 
	stream:writeInt32(self.startTime) 
	stream:writeInt32(self.wages) 
	stream:writeInt32(self.leastGoldLimit) 
	stream:writeUInt8(self.winingBeanFlag) 
	MyGuessBeanReader.Write(self.winingBean, stream)
	stream:writeInt32(self.winningFish) 
	stream:writeUInt8(self.beansFlag) 
	local _beans_0_t = self.beans 
	stream:writeUInt16(#_beans_0_t)
	for _,_beans_1_t in pairs(_beans_0_t) do
	  MyGuessBeanReader.Write(_beans_1_t, stream)
	end
	stream:writeUInt8(self.guessBeansFlag) 
	local _guessBeans_0_t = self.guessBeans 
	stream:writeUInt16(#_guessBeans_0_t)
	for _,_guessBeans_1_t in pairs(_guessBeans_0_t) do
	  GuessBeanReader.Write(_guessBeans_1_t, stream)
	end
end

------------------------------------------------
MCGuessReceiveAwardRet = class("MCGuessReceiveAwardRet", BaseResponse)
MCGuessReceiveAwardRet.PackID = 701
_G.Protocol["MCGuessReceiveAwardRet"] = 701
_G.Protocol[701] = "MCGuessReceiveAwardRet"
function MCGuessReceiveAwardRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
end

function MCGuessReceiveAwardRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
end

function MCGuessReceiveAwardRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
end

------------------------------------------------
MCMailDeleteRet = class("MCMailDeleteRet", BaseResponse)
MCMailDeleteRet.PackID = 179
_G.Protocol["MCMailDeleteRet"] = 179
_G.Protocol[179] = "MCMailDeleteRet"
function MCMailDeleteRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
	self.iId = nil       -------- 
end

function MCMailDeleteRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
	self.iId = stream:readInt32()		-------- 
end

function MCMailDeleteRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
	stream:writeInt32(self.iId) 
end

------------------------------------------------
MCMailGetAttachRet = class("MCMailGetAttachRet", BaseResponse)
MCMailGetAttachRet.PackID = 189
_G.Protocol["MCMailGetAttachRet"] = 189
_G.Protocol[189] = "MCMailGetAttachRet"
function MCMailGetAttachRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
	self.iId = nil       -------- 
end

function MCMailGetAttachRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
	self.iId = stream:readInt32()		-------- 
end

function MCMailGetAttachRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
	stream:writeInt32(self.iId) 
end

------------------------------------------------
MCMailMailsRet = class("MCMailMailsRet", BaseResponse)
MCMailMailsRet.PackID = 199
_G.Protocol["MCMailMailsRet"] = 199
_G.Protocol[199] = "MCMailMailsRet"
function MCMailMailsRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
	self.mailsFlag = nil       -------- 
	--! MailBeanReader
	self.mails = {}        -------- 
end

function MCMailMailsRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
	self.mailsFlag = stream:readUInt8()		-------- 
	local _mails_0_t = {}		-------- 
	local _mails_0_len = stream:readUInt16()
	for _0=1,_mails_0_len,1 do
	  local _mails_2_o = {}
	  MailBeanReader.Read(_mails_2_o, stream)
	  table.insert(_mails_0_t, _mails_2_o)
	end
	self.mails = _mails_0_t
end

function MCMailMailsRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
	stream:writeUInt8(self.mailsFlag) 
	local _mails_0_t = self.mails 
	stream:writeUInt16(#_mails_0_t)
	for _,_mails_1_t in pairs(_mails_0_t) do
	  MailBeanReader.Write(_mails_1_t, stream)
	end
end

------------------------------------------------
MCMailMarkReadRet = class("MCMailMarkReadRet", BaseResponse)
MCMailMarkReadRet.PackID = 109
_G.Protocol["MCMailMarkReadRet"] = 109
_G.Protocol[109] = "MCMailMarkReadRet"
function MCMailMarkReadRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
	self.mailsFlag = nil       -------- 
	--! MailBeanReader
	self.mails = {}        -------- 
end

function MCMailMarkReadRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
	self.mailsFlag = stream:readUInt8()		-------- 
	local _mails_0_t = {}		-------- 
	local _mails_0_len = stream:readUInt16()
	for _0=1,_mails_0_len,1 do
	  local _mails_2_o = {}
	  MailBeanReader.Read(_mails_2_o, stream)
	  table.insert(_mails_0_t, _mails_2_o)
	end
	self.mails = _mails_0_t
end

function MCMailMarkReadRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
	stream:writeUInt8(self.mailsFlag) 
	local _mails_0_t = self.mails 
	stream:writeUInt16(#_mails_0_t)
	for _,_mails_1_t in pairs(_mails_0_t) do
	  MailBeanReader.Write(_mails_1_t, stream)
	end
end

------------------------------------------------
MCPlatChangeAccountRet = class("MCPlatChangeAccountRet", BaseResponse)
MCPlatChangeAccountRet.PackID = 111
_G.Protocol["MCPlatChangeAccountRet"] = 111
_G.Protocol[111] = "MCPlatChangeAccountRet"
function MCPlatChangeAccountRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
end

function MCPlatChangeAccountRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
end

function MCPlatChangeAccountRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
end

------------------------------------------------
MCPlatChangePasswordRet = class("MCPlatChangePasswordRet", BaseResponse)
MCPlatChangePasswordRet.PackID = 121
_G.Protocol["MCPlatChangePasswordRet"] = 121
_G.Protocol[121] = "MCPlatChangePasswordRet"
function MCPlatChangePasswordRet:ctor()
end

function MCPlatChangePasswordRet:Read(stream)
end

function MCPlatChangePasswordRet:Write(stream)
end

------------------------------------------------
MCPlatLoginRet = class("MCPlatLoginRet", BaseResponse)
MCPlatLoginRet.PackID = 131
_G.Protocol["MCPlatLoginRet"] = 131
_G.Protocol[131] = "MCPlatLoginRet"
function MCPlatLoginRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
	self.accountFlag = nil       -------- 
	self.account = nil       -------- 
	self.announceFlag = nil       -------- 
	self.announce = nil       -------- 
	self.gameServerIpFlag = nil       -------- 
	self.gameServerIp = nil       -------- 
	self.gameServerPort = nil       -------- 
	self.passtokenFlag = nil       -------- 
	self.passtoken = nil       -------- 
	self.uploadUrlFlag = nil       -------- 
	self.uploadUrl = nil       -------- 
	self.systemAccount = nil       -------- 
	self.newSdkAccount = nil       -------- 
end

function MCPlatLoginRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
	self.accountFlag = stream:readUInt8()		-------- 
	self.account = stream:readString()		-------- 
	self.announceFlag = stream:readUInt8()		-------- 
	self.announce = stream:readString()		-------- 
	self.gameServerIpFlag = stream:readUInt8()		-------- 
	self.gameServerIp = stream:readString()		-------- 
	self.gameServerPort = stream:readInt32()		-------- 
	self.passtokenFlag = stream:readUInt8()		-------- 
	self.passtoken = stream:readString()		-------- 
	self.uploadUrlFlag = stream:readUInt8()		-------- 
	self.uploadUrl = stream:readString()		-------- 
	self.systemAccount = stream:readUInt8()		-------- 
	self.newSdkAccount = stream:readUInt8()		-------- 
end

function MCPlatLoginRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
	stream:writeUInt8(self.accountFlag) 
	stream:writeString(self.account) 
	stream:writeUInt8(self.announceFlag) 
	stream:writeString(self.announce) 
	stream:writeUInt8(self.gameServerIpFlag) 
	stream:writeString(self.gameServerIp) 
	stream:writeInt32(self.gameServerPort) 
	stream:writeUInt8(self.passtokenFlag) 
	stream:writeString(self.passtoken) 
	stream:writeUInt8(self.uploadUrlFlag) 
	stream:writeString(self.uploadUrl) 
	stream:writeUInt8(self.systemAccount) 
	stream:writeUInt8(self.newSdkAccount) 
end

------------------------------------------------
MCPlatQuickRegisterRet = class("MCPlatQuickRegisterRet", BaseResponse)
MCPlatQuickRegisterRet.PackID = 141
_G.Protocol["MCPlatQuickRegisterRet"] = 141
_G.Protocol[141] = "MCPlatQuickRegisterRet"
function MCPlatQuickRegisterRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
	self.accountFlag = nil       -------- 
	self.account = nil       -------- 
	self.passwordFlag = nil       -------- 
	self.password = nil       -------- 
end

function MCPlatQuickRegisterRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
	self.accountFlag = stream:readUInt8()		-------- 
	self.account = stream:readString()		-------- 
	self.passwordFlag = stream:readUInt8()		-------- 
	self.password = stream:readString()		-------- 
end

function MCPlatQuickRegisterRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
	stream:writeUInt8(self.accountFlag) 
	stream:writeString(self.account) 
	stream:writeUInt8(self.passwordFlag) 
	stream:writeString(self.password) 
end

------------------------------------------------
MCPlatRegisterRet = class("MCPlatRegisterRet", BaseResponse)
MCPlatRegisterRet.PackID = 151
_G.Protocol["MCPlatRegisterRet"] = 151
_G.Protocol[151] = "MCPlatRegisterRet"
function MCPlatRegisterRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
	self.accountFlag = nil       -------- 
	self.account = nil       -------- 
	self.passwordFlag = nil       -------- 
	self.password = nil       -------- 
end

function MCPlatRegisterRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
	self.accountFlag = stream:readUInt8()		-------- 
	self.account = stream:readString()		-------- 
	self.passwordFlag = stream:readUInt8()		-------- 
	self.password = stream:readString()		-------- 
end

function MCPlatRegisterRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
	stream:writeUInt8(self.accountFlag) 
	stream:writeString(self.account) 
	stream:writeUInt8(self.passwordFlag) 
	stream:writeString(self.password) 
end

------------------------------------------------
MCPlatSdkLoginRet = class("MCPlatSdkLoginRet", BaseResponse)
MCPlatSdkLoginRet.PackID = 711
_G.Protocol["MCPlatSdkLoginRet"] = 711
_G.Protocol[711] = "MCPlatSdkLoginRet"
function MCPlatSdkLoginRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
	self.accountFlag = nil       -------- 
	self.account = nil       -------- 
	self.announceFlag = nil       -------- 
	self.announce = nil       -------- 
	self.gameServerIpFlag = nil       -------- 
	self.gameServerIp = nil       -------- 
	self.gameServerPort = nil       -------- 
	self.passtokenFlag = nil       -------- 
	self.passtoken = nil       -------- 
	self.uploadUrlFlag = nil       -------- 
	self.uploadUrl = nil       -------- 
	self.systemAccount = nil       -------- 
	self.newSdkAccount = nil       -------- 
end

function MCPlatSdkLoginRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
	self.accountFlag = stream:readUInt8()		-------- 
	self.account = stream:readString()		-------- 
	self.announceFlag = stream:readUInt8()		-------- 
	self.announce = stream:readString()		-------- 
	self.gameServerIpFlag = stream:readUInt8()		-------- 
	self.gameServerIp = stream:readString()		-------- 
	self.gameServerPort = stream:readInt32()		-------- 
	self.passtokenFlag = stream:readUInt8()		-------- 
	self.passtoken = stream:readString()		-------- 
	self.uploadUrlFlag = stream:readUInt8()		-------- 
	self.uploadUrl = stream:readString()		-------- 
	self.systemAccount = stream:readUInt8()		-------- 
	self.newSdkAccount = stream:readUInt8()		-------- 
end

function MCPlatSdkLoginRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
	stream:writeUInt8(self.accountFlag) 
	stream:writeString(self.account) 
	stream:writeUInt8(self.announceFlag) 
	stream:writeString(self.announce) 
	stream:writeUInt8(self.gameServerIpFlag) 
	stream:writeString(self.gameServerIp) 
	stream:writeInt32(self.gameServerPort) 
	stream:writeUInt8(self.passtokenFlag) 
	stream:writeString(self.passtoken) 
	stream:writeUInt8(self.uploadUrlFlag) 
	stream:writeString(self.uploadUrl) 
	stream:writeUInt8(self.systemAccount) 
	stream:writeUInt8(self.newSdkAccount) 
end

------------------------------------------------
MCPlatTestConnectRet = class("MCPlatTestConnectRet", BaseResponse)
MCPlatTestConnectRet.PackID = 161
_G.Protocol["MCPlatTestConnectRet"] = 161
_G.Protocol[161] = "MCPlatTestConnectRet"
function MCPlatTestConnectRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
end

function MCPlatTestConnectRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
end

function MCPlatTestConnectRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
end

------------------------------------------------
MCPlatVersionRet = class("MCPlatVersionRet", BaseResponse)
MCPlatVersionRet.PackID = 171
_G.Protocol["MCPlatVersionRet"] = 171
_G.Protocol[171] = "MCPlatVersionRet"
function MCPlatVersionRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
	self.changeLogFlag = nil       -------- 
	self.changeLog = nil       -------- 
	self.downloadUrlFlag = nil       -------- 
	self.downloadUrl = nil       -------- 
	self.serverVersionFlag = nil       -------- 
	self.serverVersion = nil       -------- 
	self.strongUpdate = nil       -------- 
	self.updateAdvice = nil       -------- 
end

function MCPlatVersionRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
	self.changeLogFlag = stream:readUInt8()		-------- 
	self.changeLog = stream:readString()		-------- 
	self.downloadUrlFlag = stream:readUInt8()		-------- 
	self.downloadUrl = stream:readString()		-------- 
	self.serverVersionFlag = stream:readUInt8()		-------- 
	self.serverVersion = stream:readString()		-------- 
	self.strongUpdate = stream:readUInt8()		-------- 
	self.updateAdvice = stream:readUInt8()		-------- 
end

function MCPlatVersionRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
	stream:writeUInt8(self.changeLogFlag) 
	stream:writeString(self.changeLog) 
	stream:writeUInt8(self.downloadUrlFlag) 
	stream:writeString(self.downloadUrl) 
	stream:writeUInt8(self.serverVersionFlag) 
	stream:writeString(self.serverVersion) 
	stream:writeUInt8(self.strongUpdate) 
	stream:writeUInt8(self.updateAdvice) 
end

------------------------------------------------
MCRankPageInfoRet = class("MCRankPageInfoRet", BaseResponse)
MCRankPageInfoRet.PackID = 181
_G.Protocol["MCRankPageInfoRet"] = 181
_G.Protocol[181] = "MCRankPageInfoRet"
function MCRankPageInfoRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
	self.fishRanksFlag = nil       -------- 
	--! RankBeanReader
	self.fishRanks = {}        -------- 
	self.giftRanksFlag = nil       -------- 
	--! RankBeanReader
	self.giftRanks = {}        -------- 
	self.goldRanksFlag = nil       -------- 
	--! RankBeanReader
	self.goldRanks = {}        -------- 
end

function MCRankPageInfoRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
	self.fishRanksFlag = stream:readUInt8()		-------- 
	local _fishRanks_0_t = {}		-------- 
	local _fishRanks_0_len = stream:readUInt16()
	for _0=1,_fishRanks_0_len,1 do
	  local _fishRanks_2_o = {}
	  RankBeanReader.Read(_fishRanks_2_o, stream)
	  table.insert(_fishRanks_0_t, _fishRanks_2_o)
	end
	self.fishRanks = _fishRanks_0_t
	self.giftRanksFlag = stream:readUInt8()		-------- 
	local _giftRanks_0_t = {}		-------- 
	local _giftRanks_0_len = stream:readUInt16()
	for _0=1,_giftRanks_0_len,1 do
	  local _giftRanks_2_o = {}
	  RankBeanReader.Read(_giftRanks_2_o, stream)
	  table.insert(_giftRanks_0_t, _giftRanks_2_o)
	end
	self.giftRanks = _giftRanks_0_t
	self.goldRanksFlag = stream:readUInt8()		-------- 
	local _goldRanks_0_t = {}		-------- 
	local _goldRanks_0_len = stream:readUInt16()
	for _0=1,_goldRanks_0_len,1 do
	  local _goldRanks_2_o = {}
	  RankBeanReader.Read(_goldRanks_2_o, stream)
	  table.insert(_goldRanks_0_t, _goldRanks_2_o)
	end
	self.goldRanks = _goldRanks_0_t
end

function MCRankPageInfoRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
	stream:writeUInt8(self.fishRanksFlag) 
	local _fishRanks_0_t = self.fishRanks 
	stream:writeUInt16(#_fishRanks_0_t)
	for _,_fishRanks_1_t in pairs(_fishRanks_0_t) do
	  RankBeanReader.Write(_fishRanks_1_t, stream)
	end
	stream:writeUInt8(self.giftRanksFlag) 
	local _giftRanks_0_t = self.giftRanks 
	stream:writeUInt16(#_giftRanks_0_t)
	for _,_giftRanks_1_t in pairs(_giftRanks_0_t) do
	  RankBeanReader.Write(_giftRanks_1_t, stream)
	end
	stream:writeUInt8(self.goldRanksFlag) 
	local _goldRanks_0_t = self.goldRanks 
	stream:writeUInt16(#_goldRanks_0_t)
	for _,_goldRanks_1_t in pairs(_goldRanks_0_t) do
	  RankBeanReader.Write(_goldRanks_1_t, stream)
	end
end

------------------------------------------------
MCRankPageSimpleInfoRet = class("MCRankPageSimpleInfoRet", BaseResponse)
MCRankPageSimpleInfoRet.PackID = 721
_G.Protocol["MCRankPageSimpleInfoRet"] = 721
_G.Protocol[721] = "MCRankPageSimpleInfoRet"
function MCRankPageSimpleInfoRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
	self.fishRanksFlag = nil       -------- 
	--! SimpleRankBeanReader
	self.fishRanks = {}        -------- 
	self.giftRanksFlag = nil       -------- 
	--! SimpleRankBeanReader
	self.giftRanks = {}        -------- 
	self.goldRanksFlag = nil       -------- 
	--! SimpleRankBeanReader
	self.goldRanks = {}        -------- 
end

function MCRankPageSimpleInfoRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
	self.fishRanksFlag = stream:readUInt8()		-------- 
	local _fishRanks_0_t = {}		-------- 
	local _fishRanks_0_len = stream:readUInt16()
	for _0=1,_fishRanks_0_len,1 do
	  local _fishRanks_2_o = {}
	  SimpleRankBeanReader.Read(_fishRanks_2_o, stream)
	  table.insert(_fishRanks_0_t, _fishRanks_2_o)
	end
	self.fishRanks = _fishRanks_0_t
	self.giftRanksFlag = stream:readUInt8()		-------- 
	local _giftRanks_0_t = {}		-------- 
	local _giftRanks_0_len = stream:readUInt16()
	for _0=1,_giftRanks_0_len,1 do
	  local _giftRanks_2_o = {}
	  SimpleRankBeanReader.Read(_giftRanks_2_o, stream)
	  table.insert(_giftRanks_0_t, _giftRanks_2_o)
	end
	self.giftRanks = _giftRanks_0_t
	self.goldRanksFlag = stream:readUInt8()		-------- 
	local _goldRanks_0_t = {}		-------- 
	local _goldRanks_0_len = stream:readUInt16()
	for _0=1,_goldRanks_0_len,1 do
	  local _goldRanks_2_o = {}
	  SimpleRankBeanReader.Read(_goldRanks_2_o, stream)
	  table.insert(_goldRanks_0_t, _goldRanks_2_o)
	end
	self.goldRanks = _goldRanks_0_t
end

function MCRankPageSimpleInfoRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
	stream:writeUInt8(self.fishRanksFlag) 
	local _fishRanks_0_t = self.fishRanks 
	stream:writeUInt16(#_fishRanks_0_t)
	for _,_fishRanks_1_t in pairs(_fishRanks_0_t) do
	  SimpleRankBeanReader.Write(_fishRanks_1_t, stream)
	end
	stream:writeUInt8(self.giftRanksFlag) 
	local _giftRanks_0_t = self.giftRanks 
	stream:writeUInt16(#_giftRanks_0_t)
	for _,_giftRanks_1_t in pairs(_giftRanks_0_t) do
	  SimpleRankBeanReader.Write(_giftRanks_1_t, stream)
	end
	stream:writeUInt8(self.goldRanksFlag) 
	local _goldRanks_0_t = self.goldRanks 
	stream:writeUInt16(#_goldRanks_0_t)
	for _,_goldRanks_1_t in pairs(_goldRanks_0_t) do
	  SimpleRankBeanReader.Write(_goldRanks_1_t, stream)
	end
end

------------------------------------------------
MCRoomAllSpecialRet = class("MCRoomAllSpecialRet", BaseResponse)
MCRoomAllSpecialRet.PackID = 191
_G.Protocol["MCRoomAllSpecialRet"] = 191
_G.Protocol[191] = "MCRoomAllSpecialRet"
function MCRoomAllSpecialRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
end

function MCRoomAllSpecialRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
end

function MCRoomAllSpecialRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
end

------------------------------------------------
MCRoomChangePosRet = class("MCRoomChangePosRet", BaseResponse)
MCRoomChangePosRet.PackID = 201
_G.Protocol["MCRoomChangePosRet"] = 201
_G.Protocol[201] = "MCRoomChangePosRet"
function MCRoomChangePosRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
end

function MCRoomChangePosRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
end

function MCRoomChangePosRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
end

------------------------------------------------
MCRoomEnterRet = class("MCRoomEnterRet", BaseResponse)
MCRoomEnterRet.PackID = 211
_G.Protocol["MCRoomEnterRet"] = 211
_G.Protocol[211] = "MCRoomEnterRet"
function MCRoomEnterRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
	self.seatPlayersFlag = nil       -------- 
	--! SeatPlayerBeanReader
	self.seatPlayers = {}        -------- 
end

function MCRoomEnterRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
	self.seatPlayersFlag = stream:readUInt8()		-------- 
	local _seatPlayers_0_t = {}		-------- 
	local _seatPlayers_0_len = stream:readUInt16()
	for _0=1,_seatPlayers_0_len,1 do
	  local _seatPlayers_2_o = {}
	  SeatPlayerBeanReader.Read(_seatPlayers_2_o, stream)
	  table.insert(_seatPlayers_0_t, _seatPlayers_2_o)
	end
	self.seatPlayers = _seatPlayers_0_t
end

function MCRoomEnterRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
	stream:writeUInt8(self.seatPlayersFlag) 
	local _seatPlayers_0_t = self.seatPlayers 
	stream:writeUInt16(#_seatPlayers_0_t)
	for _,_seatPlayers_1_t in pairs(_seatPlayers_0_t) do
	  SeatPlayerBeanReader.Write(_seatPlayers_1_t, stream)
	end
end

------------------------------------------------
MCRoomGiveGiftRet = class("MCRoomGiveGiftRet", BaseResponse)
MCRoomGiveGiftRet.PackID = 221
_G.Protocol["MCRoomGiveGiftRet"] = 221
_G.Protocol[221] = "MCRoomGiveGiftRet"
function MCRoomGiveGiftRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
end

function MCRoomGiveGiftRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
end

function MCRoomGiveGiftRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
end

------------------------------------------------
MCRoomOwnChangeRet = class("MCRoomOwnChangeRet", BaseResponse)
MCRoomOwnChangeRet.PackID = 651
_G.Protocol["MCRoomOwnChangeRet"] = 651
_G.Protocol[651] = "MCRoomOwnChangeRet"
function MCRoomOwnChangeRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
end

function MCRoomOwnChangeRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
end

function MCRoomOwnChangeRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
end

------------------------------------------------
MCRoomPeriodSyncRet = class("MCRoomPeriodSyncRet", BaseResponse)
MCRoomPeriodSyncRet.PackID = 231
_G.Protocol["MCRoomPeriodSyncRet"] = 231
_G.Protocol[231] = "MCRoomPeriodSyncRet"
function MCRoomPeriodSyncRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
	self.seatPlayersFlag = nil       -------- 
	--! SeatPlayerBeanReader
	self.addRoles = {}        -------- 
	self.delRoles = {}        -------- 
end

function MCRoomPeriodSyncRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
	self.seatPlayersFlag = stream:readUInt8()		-------- 
	local _addRoles_0_t = {}		-------- 
	local _addRoles_0_len = stream:readUInt16()
	for _0=1,_addRoles_0_len,1 do
	  local _addRoles_2_o = {}
	  SeatPlayerBeanReader.Read(_addRoles_2_o, stream)
	  table.insert(_addRoles_0_t, _addRoles_2_o)
	end
	self.addRoles = _addRoles_0_t
	local _delRoles_0_t = {}		-------- 
	local _delRoles_0_len = stream:readUInt16()
	for _0=1,_delRoles_0_len,1 do
	  table.insert(_delRoles_0_t, stream:readUInt8())
	end
	self.delRoles = _delRoles_0_t
end

function MCRoomPeriodSyncRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
	stream:writeUInt8(self.seatPlayersFlag) 
	local _addRoles_0_t = self.addRoles 
	stream:writeUInt16(#_addRoles_0_t)
	for _,_addRoles_1_t in pairs(_addRoles_0_t) do
	  SeatPlayerBeanReader.Write(_addRoles_1_t, stream)
	end
	local _delRoles_0_t = self.delRoles 
	stream:writeUInt16(#_delRoles_0_t)
	for _,_delRoles_1_t in pairs(_delRoles_0_t) do
	  stream:writeUInt8(_delRoles_1_t)
	end
end

------------------------------------------------
MCRoomQuitRet = class("MCRoomQuitRet", BaseResponse)
MCRoomQuitRet.PackID = 241
_G.Protocol["MCRoomQuitRet"] = 241
_G.Protocol[241] = "MCRoomQuitRet"
function MCRoomQuitRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
end

function MCRoomQuitRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
end

function MCRoomQuitRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
end

------------------------------------------------
MCRoomReachTargetRet = class("MCRoomReachTargetRet", BaseResponse)
MCRoomReachTargetRet.PackID = 661
_G.Protocol["MCRoomReachTargetRet"] = 661
_G.Protocol[661] = "MCRoomReachTargetRet"
function MCRoomReachTargetRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
end

function MCRoomReachTargetRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
end

function MCRoomReachTargetRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
end

------------------------------------------------
MCRoomSendExpressionRet = class("MCRoomSendExpressionRet", BaseResponse)
MCRoomSendExpressionRet.PackID = 771
_G.Protocol["MCRoomSendExpressionRet"] = 771
_G.Protocol[771] = "MCRoomSendExpressionRet"
function MCRoomSendExpressionRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
end

function MCRoomSendExpressionRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
end

function MCRoomSendExpressionRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
end

------------------------------------------------
MCRoomTicketGotRet = class("MCRoomTicketGotRet", BaseResponse)
MCRoomTicketGotRet.PackID = 561
_G.Protocol["MCRoomTicketGotRet"] = 561
_G.Protocol[561] = "MCRoomTicketGotRet"
function MCRoomTicketGotRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
end

function MCRoomTicketGotRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
end

function MCRoomTicketGotRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
end

------------------------------------------------
MCShopGetReAdditionRet = class("MCShopGetReAdditionRet", BaseResponse)
MCShopGetReAdditionRet.PackID = 781
_G.Protocol["MCShopGetReAdditionRet"] = 781
_G.Protocol[781] = "MCShopGetReAdditionRet"
function MCShopGetReAdditionRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
	self.vipRechargeAdditionFlag = nil       -------- 
	self.vipRechargeAddition = nil       -------- 
end

function MCShopGetReAdditionRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
	self.vipRechargeAdditionFlag = stream:readUInt8()		-------- 
	self.vipRechargeAddition = stream:readString()		-------- 
end

function MCShopGetReAdditionRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
	stream:writeUInt8(self.vipRechargeAdditionFlag) 
	stream:writeString(self.vipRechargeAddition) 
end

------------------------------------------------
MCShopPageInfoRet = class("MCShopPageInfoRet", BaseResponse)
MCShopPageInfoRet.PackID = 251
_G.Protocol["MCShopPageInfoRet"] = 251
_G.Protocol[251] = "MCShopPageInfoRet"
function MCShopPageInfoRet:ctor()
	self.type = nil       -------- 
	self.desc = nil       -------- 
	self.vipRechargeAddition = nil       -------- 
	--! ShopItemBeanReader
	self.shopItems = {}        -------- 
end

function MCShopPageInfoRet:Read(stream)
	self.type = stream:readUInt8()		-------- 
	self.desc = stream:readString()		-------- 
	self.vipRechargeAddition = stream:readString()		-------- 
	local _shopItems_0_t = {}		-------- 
	local _shopItems_0_len = stream:readUInt16()
	for _0=1,_shopItems_0_len,1 do
	  local _shopItems_2_o = {}
	  ShopItemBeanReader.Read(_shopItems_2_o, stream)
	  table.insert(_shopItems_0_t, _shopItems_2_o)
	end
	self.shopItems = _shopItems_0_t
end

function MCShopPageInfoRet:Write(stream)
	stream:writeUInt8(self.type) 
	stream:writeString(self.desc) 
	stream:writeString(self.vipRechargeAddition) 
	local _shopItems_0_t = self.shopItems 
	stream:writeUInt16(#_shopItems_0_t)
	for _,_shopItems_1_t in pairs(_shopItems_0_t) do
	  ShopItemBeanReader.Write(_shopItems_1_t, stream)
	end
end

------------------------------------------------
MCTradePageInfoRet = class("MCTradePageInfoRet", BaseResponse)
MCTradePageInfoRet.PackID = 261
_G.Protocol["MCTradePageInfoRet"] = 261
_G.Protocol[261] = "MCTradePageInfoRet"
function MCTradePageInfoRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
	self.descFlag = nil       -------- 
	self.desc = nil       -------- 
	self.vipDiscountFlag = nil       -------- 
	self.vipDiscount = nil       -------- 
	self.tradeItemsFlag = nil       -------- 
	--! TradeItemBeanReader
	self.tradeItems = {}        -------- 
end

function MCTradePageInfoRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
	self.descFlag = stream:readUInt8()		-------- 
	self.desc = stream:readString()		-------- 
	self.vipDiscountFlag = stream:readUInt8()		-------- 
	self.vipDiscount = stream:readString()		-------- 
	self.tradeItemsFlag = stream:readUInt8()		-------- 
	local _tradeItems_0_t = {}		-------- 
	local _tradeItems_0_len = stream:readUInt16()
	for _0=1,_tradeItems_0_len,1 do
	  local _tradeItems_2_o = {}
	  TradeItemBeanReader.Read(_tradeItems_2_o, stream)
	  table.insert(_tradeItems_0_t, _tradeItems_2_o)
	end
	self.tradeItems = _tradeItems_0_t
end

function MCTradePageInfoRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
	stream:writeUInt8(self.descFlag) 
	stream:writeString(self.desc) 
	stream:writeUInt8(self.vipDiscountFlag) 
	stream:writeString(self.vipDiscount) 
	stream:writeUInt8(self.tradeItemsFlag) 
	local _tradeItems_0_t = self.tradeItems 
	stream:writeUInt16(#_tradeItems_0_t)
	for _,_tradeItems_1_t in pairs(_tradeItems_0_t) do
	  TradeItemBeanReader.Write(_tradeItems_1_t, stream)
	end
end

------------------------------------------------
MCTradeTradeRet = class("MCTradeTradeRet", BaseResponse)
MCTradeTradeRet.PackID = 271
_G.Protocol["MCTradeTradeRet"] = 271
_G.Protocol[271] = "MCTradeTradeRet"
function MCTradeTradeRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
end

function MCTradeTradeRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
end

function MCTradeTradeRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
end

------------------------------------------------
MCUserChangeInfoRet = class("MCUserChangeInfoRet", BaseResponse)
MCUserChangeInfoRet.PackID = 281
_G.Protocol["MCUserChangeInfoRet"] = 281
_G.Protocol[281] = "MCUserChangeInfoRet"
function MCUserChangeInfoRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
end

function MCUserChangeInfoRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
end

function MCUserChangeInfoRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
end

------------------------------------------------
MCUserCheckSomeThingRet = class("MCUserCheckSomeThingRet", BaseResponse)
MCUserCheckSomeThingRet.PackID = 541
_G.Protocol["MCUserCheckSomeThingRet"] = 541
_G.Protocol[541] = "MCUserCheckSomeThingRet"
function MCUserCheckSomeThingRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
end

function MCUserCheckSomeThingRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
end

function MCUserCheckSomeThingRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
end

------------------------------------------------
MCUserClientLogRet = class("MCUserClientLogRet", BaseResponse)
MCUserClientLogRet.PackID = 551
_G.Protocol["MCUserClientLogRet"] = 551
_G.Protocol[551] = "MCUserClientLogRet"
function MCUserClientLogRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
end

function MCUserClientLogRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
end

function MCUserClientLogRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
end

------------------------------------------------
MCUserEchoRet = class("MCUserEchoRet", BaseResponse)
MCUserEchoRet.PackID = 291
_G.Protocol["MCUserEchoRet"] = 291
_G.Protocol[291] = "MCUserEchoRet"
function MCUserEchoRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
	self.infoFlag = nil       -------- 
	self.info = nil       -------- 
end

function MCUserEchoRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
	self.infoFlag = stream:readUInt8()		-------- 
	self.info = stream:readString()		-------- 
end

function MCUserEchoRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
	stream:writeUInt8(self.infoFlag) 
	stream:writeString(self.info) 
end

------------------------------------------------
MCUserFishContestPageRet = class("MCUserFishContestPageRet", BaseResponse)
MCUserFishContestPageRet.PackID = 691
_G.Protocol["MCUserFishContestPageRet"] = 691
_G.Protocol[691] = "MCUserFishContestPageRet"
function MCUserFishContestPageRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
	self.currentTargetFish = nil       -------- 
	self.endSecs = nil       -------- 
	self.endTime = nil       -------- 
	self.lastTargetFish = nil       -------- 
	self.myNum = nil       -------- 
	self.myRank = nil       -------- 
	self.startSecs = nil       -------- 
	self.startTime = nil       -------- 
	self.inContest = nil       -------- 
	self.ranksFlag = nil       -------- 
	--! RankBeanReader
	self.ranks = {}        -------- 
end

function MCUserFishContestPageRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
	self.currentTargetFish = stream:readInt32()		-------- 
	self.endSecs = stream:readInt32()		-------- 
	self.endTime = stream:readInt32()		-------- 
	self.lastTargetFish = stream:readInt32()		-------- 
	self.myNum = stream:readInt32()		-------- 
	self.myRank = stream:readInt32()		-------- 
	self.startSecs = stream:readInt32()		-------- 
	self.startTime = stream:readInt32()		-------- 
	self.inContest = stream:readUInt8()		-------- 
	self.ranksFlag = stream:readUInt8()		-------- 
	local _ranks_0_t = {}		-------- 
	local _ranks_0_len = stream:readUInt16()
	for _0=1,_ranks_0_len,1 do
	  local _ranks_2_o = {}
	  RankBeanReader.Read(_ranks_2_o, stream)
	  table.insert(_ranks_0_t, _ranks_2_o)
	end
	self.ranks = _ranks_0_t
end

function MCUserFishContestPageRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
	stream:writeInt32(self.currentTargetFish) 
	stream:writeInt32(self.endSecs) 
	stream:writeInt32(self.endTime) 
	stream:writeInt32(self.lastTargetFish) 
	stream:writeInt32(self.myNum) 
	stream:writeInt32(self.myRank) 
	stream:writeInt32(self.startSecs) 
	stream:writeInt32(self.startTime) 
	stream:writeUInt8(self.inContest) 
	stream:writeUInt8(self.ranksFlag) 
	local _ranks_0_t = self.ranks 
	stream:writeUInt16(#_ranks_0_t)
	for _,_ranks_1_t in pairs(_ranks_0_t) do
	  RankBeanReader.Write(_ranks_1_t, stream)
	end
end

------------------------------------------------
MCUserGetCatAwardRet = class("MCUserGetCatAwardRet", BaseResponse)
MCUserGetCatAwardRet.PackID = 591
_G.Protocol["MCUserGetCatAwardRet"] = 591
_G.Protocol[591] = "MCUserGetCatAwardRet"
function MCUserGetCatAwardRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
	self.golds = nil       -------- 
end

function MCUserGetCatAwardRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
	self.golds = stream:readInt32()		-------- 
end

function MCUserGetCatAwardRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
	stream:writeInt32(self.golds) 
end

------------------------------------------------
MCUserGetCatAwardValueRet = class("MCUserGetCatAwardValueRet", BaseResponse)
MCUserGetCatAwardValueRet.PackID = 681
_G.Protocol["MCUserGetCatAwardValueRet"] = 681
_G.Protocol[681] = "MCUserGetCatAwardValueRet"
function MCUserGetCatAwardValueRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
	self.golds = nil       -------- 
end

function MCUserGetCatAwardValueRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
	self.golds = stream:readInt32()		-------- 
end

function MCUserGetCatAwardValueRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
	stream:writeInt32(self.golds) 
end

------------------------------------------------
MCUserGetLoginAwardRet = class("MCUserGetLoginAwardRet", BaseResponse)
MCUserGetLoginAwardRet.PackID = 301
_G.Protocol["MCUserGetLoginAwardRet"] = 301
_G.Protocol[301] = "MCUserGetLoginAwardRet"
function MCUserGetLoginAwardRet:ctor()
end

function MCUserGetLoginAwardRet:Read(stream)
end

function MCUserGetLoginAwardRet:Write(stream)
end

------------------------------------------------
MCUserGetLoginAwardByTimesRet = class("MCUserGetLoginAwardByTimesRet", BaseResponse)
MCUserGetLoginAwardByTimesRet.PackID = 581
_G.Protocol["MCUserGetLoginAwardByTimesRet"] = 581
_G.Protocol[581] = "MCUserGetLoginAwardByTimesRet"
function MCUserGetLoginAwardByTimesRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
end

function MCUserGetLoginAwardByTimesRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
end

function MCUserGetLoginAwardByTimesRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
end

------------------------------------------------
MCUserGetOrderInfosRet = class("MCUserGetOrderInfosRet", BaseResponse)
MCUserGetOrderInfosRet.PackID = 801
_G.Protocol["MCUserGetOrderInfosRet"] = 801
_G.Protocol[801] = "MCUserGetOrderInfosRet"
function MCUserGetOrderInfosRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
	self.ordersFlag = nil       -------- 
	--! RechargeOrderBeanReader
	self.orders = {}        -------- 
end

function MCUserGetOrderInfosRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
	self.ordersFlag = stream:readUInt8()		-------- 
	local _orders_0_t = {}		-------- 
	local _orders_0_len = stream:readUInt16()
	for _0=1,_orders_0_len,1 do
	  local _orders_2_o = {}
	  RechargeOrderBeanReader.Read(_orders_2_o, stream)
	  table.insert(_orders_0_t, _orders_2_o)
	end
	self.orders = _orders_0_t
end

function MCUserGetOrderInfosRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
	stream:writeUInt8(self.ordersFlag) 
	local _orders_0_t = self.orders 
	stream:writeUInt16(#_orders_0_t)
	for _,_orders_1_t in pairs(_orders_0_t) do
	  RechargeOrderBeanReader.Write(_orders_1_t, stream)
	end
end

------------------------------------------------
MCUserGetSelfIconAwardRet = class("MCUserGetSelfIconAwardRet", BaseResponse)
MCUserGetSelfIconAwardRet.PackID = 571
_G.Protocol["MCUserGetSelfIconAwardRet"] = 571
_G.Protocol[571] = "MCUserGetSelfIconAwardRet"
function MCUserGetSelfIconAwardRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
end

function MCUserGetSelfIconAwardRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
end

function MCUserGetSelfIconAwardRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
end

------------------------------------------------
MCUserGetVipInfoRet = class("MCUserGetVipInfoRet", BaseResponse)
MCUserGetVipInfoRet.PackID = 741
_G.Protocol["MCUserGetVipInfoRet"] = 741
_G.Protocol[741] = "MCUserGetVipInfoRet"
function MCUserGetVipInfoRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
	self.currPayGold = nil       -------- 
	self.needPayGold = nil       -------- 
	self.vipInfosFlag = nil       -------- 
	--! VipInfoBeanReader
	self.vipInfos = {}        -------- 
end

function MCUserGetVipInfoRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
	self.currPayGold = stream:readInt32()		-------- 
	self.needPayGold = stream:readInt32()		-------- 
	self.vipInfosFlag = stream:readUInt8()		-------- 
	local _vipInfos_0_t = {}		-------- 
	local _vipInfos_0_len = stream:readUInt16()
	for _0=1,_vipInfos_0_len,1 do
	  local _vipInfos_2_o = {}
	  VipInfoBeanReader.Read(_vipInfos_2_o, stream)
	  table.insert(_vipInfos_0_t, _vipInfos_2_o)
	end
	self.vipInfos = _vipInfos_0_t
end

function MCUserGetVipInfoRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
	stream:writeInt32(self.currPayGold) 
	stream:writeInt32(self.needPayGold) 
	stream:writeUInt8(self.vipInfosFlag) 
	local _vipInfos_0_t = self.vipInfos 
	stream:writeUInt16(#_vipInfos_0_t)
	for _,_vipInfos_1_t in pairs(_vipInfos_0_t) do
	  VipInfoBeanReader.Write(_vipInfos_1_t, stream)
	end
end

------------------------------------------------
MCUserHeartBeatRet = class("MCUserHeartBeatRet", BaseResponse)
MCUserHeartBeatRet.PackID = 311
_G.Protocol["MCUserHeartBeatRet"] = 311
_G.Protocol[311] = "MCUserHeartBeatRet"
function MCUserHeartBeatRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
	self.serverTimeFlag = nil       -------- 
	self.serverTime = nil       -------- 
end

function MCUserHeartBeatRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
	self.serverTimeFlag = stream:readUInt8()		-------- 
	self.serverTime = stream:readString()		-------- 
end

function MCUserHeartBeatRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
	stream:writeUInt8(self.serverTimeFlag) 
	stream:writeString(self.serverTime) 
end

------------------------------------------------
MCUserLoginRet = class("MCUserLoginRet", BaseResponse)
MCUserLoginRet.PackID = 321
_G.Protocol["MCUserLoginRet"] = 321
_G.Protocol[321] = "MCUserLoginRet"
function MCUserLoginRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
	self.myInfoFlag = nil       -------- 
	--! PlayerInfoBeanReader
	self.myInfo = nil       -------- 
	self.passTokenFlag = nil       -------- 
	self.passToken = nil       -------- 
	self.serverTime = nil       -------- 
	self.loginAwardGot = nil       -------- 
	self.loginAwardTime = nil       -------- 
	self.selfIconAwardTime = nil       -------- 
	self.dayFirstLogin = nil       -------- 
	self.selfIconAwardGot = nil       -------- 
	self.catAwardGot = nil       -------- 
	self.reachTargetGolds = nil       -------- 
	self.reachTargetAwards = nil       -------- 
	self.catAwardValue = nil       -------- 
	self.hasCharged = nil       -------- 
	self.catVipAddition = nil       -------- 
	self.recommendShopId = nil       -------- 
	self.enterRoom = nil       -------- 
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

function MCUserLoginRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
	self.myInfoFlag = stream:readUInt8()		-------- 
	self.myInfo = {}		-------- 
	PlayerInfoBeanReader.Read(self.myInfo, stream)
	self.passTokenFlag = stream:readUInt8()		-------- 
	self.passToken = stream:readString()		-------- 
	self.serverTime = stream:readInt32()		-------- 
	self.loginAwardGot = stream:readUInt8()		-------- 
	self.loginAwardTime = stream:readInt32()		-------- 
	self.selfIconAwardTime = stream:readInt32()		-------- 
	self.dayFirstLogin = stream:readUInt8()		-------- 
	self.selfIconAwardGot = stream:readUInt8()		-------- 
	self.catAwardGot = stream:readUInt8()		-------- 
	self.reachTargetGolds = stream:readInt32()		-------- 
	self.reachTargetAwards = stream:readInt32()		-------- 
	self.catAwardValue = stream:readInt32()		-------- 
	self.hasCharged = stream:readUInt8()		-------- 
	self.catVipAddition = stream:readInt32()		-------- 
	self.recommendShopId = stream:readInt32()		-------- 
	self.enterRoom = stream:readUInt8()		-------- 
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

function MCUserLoginRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
	stream:writeUInt8(self.myInfoFlag) 
	PlayerInfoBeanReader.Write(self.myInfo, stream)
	stream:writeUInt8(self.passTokenFlag) 
	stream:writeString(self.passToken) 
	stream:writeInt32(self.serverTime) 
	stream:writeUInt8(self.loginAwardGot) 
	stream:writeInt32(self.loginAwardTime) 
	stream:writeInt32(self.selfIconAwardTime) 
	stream:writeUInt8(self.dayFirstLogin) 
	stream:writeUInt8(self.selfIconAwardGot) 
	stream:writeUInt8(self.catAwardGot) 
	stream:writeInt32(self.reachTargetGolds) 
	stream:writeInt32(self.reachTargetAwards) 
	stream:writeInt32(self.catAwardValue) 
	stream:writeUInt8(self.hasCharged) 
	stream:writeInt32(self.catVipAddition) 
	stream:writeInt32(self.recommendShopId) 
	stream:writeUInt8(self.enterRoom) 
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

------------------------------------------------
MCUserLoginAwardInfoRet = class("MCUserLoginAwardInfoRet", BaseResponse)
MCUserLoginAwardInfoRet.PackID = 331
_G.Protocol["MCUserLoginAwardInfoRet"] = 331
_G.Protocol[331] = "MCUserLoginAwardInfoRet"
function MCUserLoginAwardInfoRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
	self.days = nil       -------- 
	self.vipLoginAdditionFlag = nil       -------- 
	self.vipLoginAddition = nil       -------- 
	self.loginAwardsFlag = nil       -------- 
	--! LoginAwardBeanReader
	self.loginAwards = {}        -------- 
end

function MCUserLoginAwardInfoRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
	self.days = stream:readInt32()		-------- 
	self.vipLoginAdditionFlag = stream:readUInt8()		-------- 
	self.vipLoginAddition = stream:readString()		-------- 
	self.loginAwardsFlag = stream:readUInt8()		-------- 
	local _loginAwards_0_t = {}		-------- 
	local _loginAwards_0_len = stream:readUInt16()
	for _0=1,_loginAwards_0_len,1 do
	  local _loginAwards_2_o = {}
	  LoginAwardBeanReader.Read(_loginAwards_2_o, stream)
	  table.insert(_loginAwards_0_t, _loginAwards_2_o)
	end
	self.loginAwards = _loginAwards_0_t
end

function MCUserLoginAwardInfoRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
	stream:writeInt32(self.days) 
	stream:writeUInt8(self.vipLoginAdditionFlag) 
	stream:writeString(self.vipLoginAddition) 
	stream:writeUInt8(self.loginAwardsFlag) 
	local _loginAwards_0_t = self.loginAwards 
	stream:writeUInt16(#_loginAwards_0_t)
	for _,_loginAwards_1_t in pairs(_loginAwards_0_t) do
	  LoginAwardBeanReader.Write(_loginAwards_1_t, stream)
	end
end

------------------------------------------------
MCUserOnlineRet = class("MCUserOnlineRet", BaseResponse)
MCUserOnlineRet.PackID = 341
_G.Protocol["MCUserOnlineRet"] = 341
_G.Protocol[341] = "MCUserOnlineRet"
function MCUserOnlineRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
	self.onlines = nil       -------- 
end

function MCUserOnlineRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
	self.onlines = stream:readInt32()		-------- 
end

function MCUserOnlineRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
	stream:writeInt32(self.onlines) 
end

------------------------------------------------
MCUserOpenCardRet = class("MCUserOpenCardRet", BaseResponse)
MCUserOpenCardRet.PackID = 351
_G.Protocol["MCUserOpenCardRet"] = 351
_G.Protocol[351] = "MCUserOpenCardRet"
function MCUserOpenCardRet:ctor()
	self.golds = nil       -------- 
	self.jewels = nil       -------- 
end

function MCUserOpenCardRet:Read(stream)
	self.golds = stream:readInt32()		-------- 
	self.jewels = stream:readInt32()		-------- 
end

function MCUserOpenCardRet:Write(stream)
	stream:writeInt32(self.golds) 
	stream:writeInt32(self.jewels) 
end

------------------------------------------------
MCUserPlayerInfoRet = class("MCUserPlayerInfoRet", BaseResponse)
MCUserPlayerInfoRet.PackID = 361
_G.Protocol["MCUserPlayerInfoRet"] = 361
_G.Protocol[361] = "MCUserPlayerInfoRet"
function MCUserPlayerInfoRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
	self.infoFlag = nil       -------- 
	--! PlayerInfoBeanReader
	self.info = nil       -------- 
	self.realName = nil       -------- 
	self.address = nil       -------- 
end

function MCUserPlayerInfoRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
	self.infoFlag = stream:readUInt8()		-------- 
	self.info = {}		-------- 
	PlayerInfoBeanReader.Read(self.info, stream)
	self.realName = stream:readString()		-------- 
	self.address = stream:readString()		-------- 
end

function MCUserPlayerInfoRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
	stream:writeUInt8(self.infoFlag) 
	PlayerInfoBeanReader.Write(self.info, stream)
	stream:writeString(self.realName) 
	stream:writeString(self.address) 
end

------------------------------------------------
MCUserSaveRechargeOrderRet = class("MCUserSaveRechargeOrderRet", BaseResponse)
MCUserSaveRechargeOrderRet.PackID = 811
_G.Protocol["MCUserSaveRechargeOrderRet"] = 811
_G.Protocol[811] = "MCUserSaveRechargeOrderRet"
function MCUserSaveRechargeOrderRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
end

function MCUserSaveRechargeOrderRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
end

function MCUserSaveRechargeOrderRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
end

------------------------------------------------
MCUserSimpleFishContestPageRet = class("MCUserSimpleFishContestPageRet", BaseResponse)
MCUserSimpleFishContestPageRet.PackID = 731
_G.Protocol["MCUserSimpleFishContestPageRet"] = 731
_G.Protocol[731] = "MCUserSimpleFishContestPageRet"
function MCUserSimpleFishContestPageRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
	self.currentTargetFish = nil       -------- 
	self.endSecs = nil       -------- 
	self.endTime = nil       -------- 
	self.lastTargetFish = nil       -------- 
	self.myNum = nil       -------- 
	self.myRank = nil       -------- 
	self.startSecs = nil       -------- 
	self.startTime = nil       -------- 
	self.inContest = nil       -------- 
	self.simpleRanksFlag = nil       -------- 
	--! SimpleRankBeanReader
	self.simpleRanks = {}        -------- 
end

function MCUserSimpleFishContestPageRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
	self.currentTargetFish = stream:readInt32()		-------- 
	self.endSecs = stream:readInt32()		-------- 
	self.endTime = stream:readInt32()		-------- 
	self.lastTargetFish = stream:readInt32()		-------- 
	self.myNum = stream:readInt32()		-------- 
	self.myRank = stream:readInt32()		-------- 
	self.startSecs = stream:readInt32()		-------- 
	self.startTime = stream:readInt32()		-------- 
	self.inContest = stream:readUInt8()		-------- 
	self.simpleRanksFlag = stream:readUInt8()		-------- 
	local _simpleRanks_0_t = {}		-------- 
	local _simpleRanks_0_len = stream:readUInt16()
	for _0=1,_simpleRanks_0_len,1 do
	  local _simpleRanks_2_o = {}
	  SimpleRankBeanReader.Read(_simpleRanks_2_o, stream)
	  table.insert(_simpleRanks_0_t, _simpleRanks_2_o)
	end
	self.simpleRanks = _simpleRanks_0_t
end

function MCUserSimpleFishContestPageRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
	stream:writeInt32(self.currentTargetFish) 
	stream:writeInt32(self.endSecs) 
	stream:writeInt32(self.endTime) 
	stream:writeInt32(self.lastTargetFish) 
	stream:writeInt32(self.myNum) 
	stream:writeInt32(self.myRank) 
	stream:writeInt32(self.startSecs) 
	stream:writeInt32(self.startTime) 
	stream:writeUInt8(self.inContest) 
	stream:writeUInt8(self.simpleRanksFlag) 
	local _simpleRanks_0_t = self.simpleRanks 
	stream:writeUInt16(#_simpleRanks_0_t)
	for _,_simpleRanks_1_t in pairs(_simpleRanks_0_t) do
	  SimpleRankBeanReader.Write(_simpleRanks_1_t, stream)
	end
end

------------------------------------------------
MCUserVersionRet = class("MCUserVersionRet", BaseResponse)
MCUserVersionRet.PackID = 371
_G.Protocol["MCUserVersionRet"] = 371
_G.Protocol[371] = "MCUserVersionRet"
function MCUserVersionRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
	self.changeLogFlag = nil       -------- 
	self.changeLog = nil       -------- 
	self.downloadUrlFlag = nil       -------- 
	self.downloadUrl = nil       -------- 
	self.serverVersionFlag = nil       -------- 
	self.serverVersion = nil       -------- 
	self.strongUpdate = nil       -------- 
	self.updateAdvice = nil       -------- 
end

function MCUserVersionRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
	self.changeLogFlag = stream:readUInt8()		-------- 
	self.changeLog = stream:readString()		-------- 
	self.downloadUrlFlag = stream:readUInt8()		-------- 
	self.downloadUrl = stream:readString()		-------- 
	self.serverVersionFlag = stream:readUInt8()		-------- 
	self.serverVersion = stream:readString()		-------- 
	self.strongUpdate = stream:readUInt8()		-------- 
	self.updateAdvice = stream:readUInt8()		-------- 
end

function MCUserVersionRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
	stream:writeUInt8(self.changeLogFlag) 
	stream:writeString(self.changeLog) 
	stream:writeUInt8(self.downloadUrlFlag) 
	stream:writeString(self.downloadUrl) 
	stream:writeUInt8(self.serverVersionFlag) 
	stream:writeString(self.serverVersion) 
	stream:writeUInt8(self.strongUpdate) 
	stream:writeUInt8(self.updateAdvice) 
end

------------------------------------------------
MCViewGetPlayerViewRet = class("MCViewGetPlayerViewRet", BaseResponse)
MCViewGetPlayerViewRet.PackID = 381
_G.Protocol["MCViewGetPlayerViewRet"] = 381
_G.Protocol[381] = "MCViewGetPlayerViewRet"
function MCViewGetPlayerViewRet:ctor()
	self._errorMsgFlag = nil       -------- 
	self._errorMsg = nil       -------- 
end

function MCViewGetPlayerViewRet:Read(stream)
	self._errorMsgFlag = stream:readUInt8()		-------- 
	self._errorMsg = stream:readString()		-------- 
end

function MCViewGetPlayerViewRet:Write(stream)
	stream:writeUInt8(self._errorMsgFlag) 
	stream:writeString(self._errorMsg) 
end

------------------------------------------------
MCActivityEndEventRet = class("MCActivityEndEventRet", BaseResponse)
MCActivityEndEventRet.PackID = 631
_G.Protocol["MCActivityEndEventRet"] = 631
_G.Protocol[631] = "MCActivityEndEventRet"
function MCActivityEndEventRet:ctor()
	self.activityId = nil       -------- 
end

function MCActivityEndEventRet:Read(stream)
	self.activityId = stream:readInt16()		-------- 
end

function MCActivityEndEventRet:Write(stream)
	stream:writeInt16(self.activityId) 
end

------------------------------------------------
MCActivityStartEventRet = class("MCActivityStartEventRet", BaseResponse)
MCActivityStartEventRet.PackID = 641
_G.Protocol["MCActivityStartEventRet"] = 641
_G.Protocol[641] = "MCActivityStartEventRet"
function MCActivityStartEventRet:ctor()
	self.activityId = nil       -------- 
end

function MCActivityStartEventRet:Read(stream)
	self.activityId = stream:readInt32()		-------- 
end

function MCActivityStartEventRet:Write(stream)
	stream:writeInt32(self.activityId) 
end

------------------------------------------------
MCAllSpecialEventRet = class("MCAllSpecialEventRet", BaseResponse)
MCAllSpecialEventRet.PackID = 391
_G.Protocol["MCAllSpecialEventRet"] = 391
_G.Protocol[391] = "MCAllSpecialEventRet"
function MCAllSpecialEventRet:ctor()
	self.actsFlag = nil       -------- 
	self.acts = nil       -------- 
	self.playerId = nil       -------- 
	self.pos = nil       -------- 
	self.self = nil       -------- 
end

function MCAllSpecialEventRet:Read(stream)
	self.actsFlag = stream:readUInt8()		-------- 
	self.acts = stream:readString()		-------- 
	self.playerId = stream:readUInt32()		-------- 
	self.pos = stream:readInt32()		-------- 
	self.self = stream:readUInt8()		-------- 
end

function MCAllSpecialEventRet:Write(stream)
	stream:writeUInt8(self.actsFlag) 
	stream:writeString(self.acts) 
	stream:writeUInt32(self.playerId) 
	stream:writeInt32(self.pos) 
	stream:writeUInt8(self.self) 
end

------------------------------------------------
MCChatMsgEventRet = class("MCChatMsgEventRet", BaseResponse)
MCChatMsgEventRet.PackID = 401
_G.Protocol["MCChatMsgEventRet"] = 401
_G.Protocol[401] = "MCChatMsgEventRet"
function MCChatMsgEventRet:ctor()
	self.channel = nil       -------- 
	self.fromPlayerFlag = nil       -------- 
	self.fromPlayer = nil       -------- 
	self.fromPlayerTitleFlag = nil       -------- 
	self.fromPlayerTitle = nil       -------- 
	self.fromPlayerVipLv = nil       -------- 
	self.msgFlag = nil       -------- 
	self.msg = nil       -------- 
	self.nationFlagFlag = nil       -------- 
	self.nationFlag = nil       -------- 
	self.toPlayerFlag = nil       -------- 
	self.toPlayer = nil       -------- 
	self.gm = nil       -------- 
	self.leader = nil       -------- 
	self.selfWords = nil       -------- 
end

function MCChatMsgEventRet:Read(stream)
	self.channel = stream:readInt32()		-------- 
	self.fromPlayerFlag = stream:readUInt8()		-------- 
	self.fromPlayer = stream:readString()		-------- 
	self.fromPlayerTitleFlag = stream:readUInt8()		-------- 
	self.fromPlayerTitle = stream:readString()		-------- 
	self.fromPlayerVipLv = stream:readInt32()		-------- 
	self.msgFlag = stream:readUInt8()		-------- 
	self.msg = stream:readString()		-------- 
	self.nationFlagFlag = stream:readUInt8()		-------- 
	self.nationFlag = stream:readString()		-------- 
	self.toPlayerFlag = stream:readUInt8()		-------- 
	self.toPlayer = stream:readString()		-------- 
	self.gm = stream:readUInt8()		-------- 
	self.leader = stream:readUInt8()		-------- 
	self.selfWords = stream:readUInt8()		-------- 
end

function MCChatMsgEventRet:Write(stream)
	stream:writeInt32(self.channel) 
	stream:writeUInt8(self.fromPlayerFlag) 
	stream:writeString(self.fromPlayer) 
	stream:writeUInt8(self.fromPlayerTitleFlag) 
	stream:writeString(self.fromPlayerTitle) 
	stream:writeInt32(self.fromPlayerVipLv) 
	stream:writeUInt8(self.msgFlag) 
	stream:writeString(self.msg) 
	stream:writeUInt8(self.nationFlagFlag) 
	stream:writeString(self.nationFlag) 
	stream:writeUInt8(self.toPlayerFlag) 
	stream:writeString(self.toPlayer) 
	stream:writeUInt8(self.gm) 
	stream:writeUInt8(self.leader) 
	stream:writeUInt8(self.selfWords) 
end

------------------------------------------------
MCFriendApplyRet = class("MCFriendApplyRet", BaseResponse)
MCFriendApplyRet.PackID = 411
_G.Protocol["MCFriendApplyRet"] = 411
_G.Protocol[411] = "MCFriendApplyRet"
function MCFriendApplyRet:ctor()
	self.playerFlag = nil       -------- 
	--! PlayerInfoBeanReader
	self.player = nil       -------- 
end

function MCFriendApplyRet:Read(stream)
	self.playerFlag = stream:readUInt8()		-------- 
	self.player = {}		-------- 
	PlayerInfoBeanReader.Read(self.player, stream)
end

function MCFriendApplyRet:Write(stream)
	stream:writeUInt8(self.playerFlag) 
	PlayerInfoBeanReader.Write(self.player, stream)
end

------------------------------------------------
MCFriendApplyResultRet = class("MCFriendApplyResultRet", BaseResponse)
MCFriendApplyResultRet.PackID = 421
_G.Protocol["MCFriendApplyResultRet"] = 421
_G.Protocol[421] = "MCFriendApplyResultRet"
function MCFriendApplyResultRet:ctor()
	self.playerFlag = nil       -------- 
	--! PlayerInfoBeanReader
	self.player = nil       -------- 
	self.agree = nil       -------- 
end

function MCFriendApplyResultRet:Read(stream)
	self.playerFlag = stream:readUInt8()		-------- 
	self.player = {}		-------- 
	PlayerInfoBeanReader.Read(self.player, stream)
	self.agree = stream:readUInt8()		-------- 
end

function MCFriendApplyResultRet:Write(stream)
	stream:writeUInt8(self.playerFlag) 
	PlayerInfoBeanReader.Write(self.player, stream)
	stream:writeUInt8(self.agree) 
end

------------------------------------------------
MCFriendRemoveRet = class("MCFriendRemoveRet", BaseResponse)
MCFriendRemoveRet.PackID = 431
_G.Protocol["MCFriendRemoveRet"] = 431
_G.Protocol[431] = "MCFriendRemoveRet"
function MCFriendRemoveRet:ctor()
	self.playerFlag = nil       -------- 
	--! PlayerInfoBeanReader
	self.player = nil       -------- 
end

function MCFriendRemoveRet:Read(stream)
	self.playerFlag = stream:readUInt8()		-------- 
	self.player = {}		-------- 
	PlayerInfoBeanReader.Read(self.player, stream)
end

function MCFriendRemoveRet:Write(stream)
	stream:writeUInt8(self.playerFlag) 
	PlayerInfoBeanReader.Write(self.player, stream)
end

------------------------------------------------
MCGiveGiftUpdateRet = class("MCGiveGiftUpdateRet", BaseResponse)
MCGiveGiftUpdateRet.PackID = 441
_G.Protocol["MCGiveGiftUpdateRet"] = 441
_G.Protocol[441] = "MCGiveGiftUpdateRet"
function MCGiveGiftUpdateRet:ctor()
	self.giveGiftFlag = nil       -------- 
	--! GiveGiftBeanReader
	self.giveGift = nil       -------- 
end

function MCGiveGiftUpdateRet:Read(stream)
	self.giveGiftFlag = stream:readUInt8()		-------- 
	self.giveGift = {}		-------- 
	GiveGiftBeanReader.Read(self.giveGift, stream)
end

function MCGiveGiftUpdateRet:Write(stream)
	stream:writeUInt8(self.giveGiftFlag) 
	GiveGiftBeanReader.Write(self.giveGift, stream)
end

------------------------------------------------
MCNewMailRet = class("MCNewMailRet", BaseResponse)
MCNewMailRet.PackID = 451
_G.Protocol["MCNewMailRet"] = 451
_G.Protocol[451] = "MCNewMailRet"
function MCNewMailRet:ctor()
	self.newMailFlag = nil       -------- 
	--! MailBeanReader
	self.newMail = nil       -------- 
end

function MCNewMailRet:Read(stream)
	self.newMailFlag = stream:readUInt8()		-------- 
	self.newMail = {}		-------- 
	MailBeanReader.Read(self.newMail, stream)
end

function MCNewMailRet:Write(stream)
	stream:writeUInt8(self.newMailFlag) 
	MailBeanReader.Write(self.newMail, stream)
end

------------------------------------------------
MCPlayerInRoomRet = class("MCPlayerInRoomRet", BaseResponse)
MCPlayerInRoomRet.PackID = 461
_G.Protocol["MCPlayerInRoomRet"] = 461
_G.Protocol[461] = "MCPlayerInRoomRet"
function MCPlayerInRoomRet:ctor()
end

function MCPlayerInRoomRet:Read(stream)
end

function MCPlayerInRoomRet:Write(stream)
end

------------------------------------------------
MCPlayerInfoUpdateRet = class("MCPlayerInfoUpdateRet", BaseResponse)
MCPlayerInfoUpdateRet.PackID = 471
_G.Protocol["MCPlayerInfoUpdateRet"] = 471
_G.Protocol[471] = "MCPlayerInfoUpdateRet"
function MCPlayerInfoUpdateRet:ctor()
	self.infoFlag = nil       -------- 
	--! PlayerInfoBeanReader
	self.info = nil       -------- 
end

function MCPlayerInfoUpdateRet:Read(stream)
	self.infoFlag = stream:readUInt8()		-------- 
	self.info = {}		-------- 
	PlayerInfoBeanReader.Read(self.info, stream)
end

function MCPlayerInfoUpdateRet:Write(stream)
	stream:writeUInt8(self.infoFlag) 
	PlayerInfoBeanReader.Write(self.info, stream)
end

------------------------------------------------
MCRechargeGoldsEventRet = class("MCRechargeGoldsEventRet", BaseResponse)
MCRechargeGoldsEventRet.PackID = 521
_G.Protocol["MCRechargeGoldsEventRet"] = 521
_G.Protocol[521] = "MCRechargeGoldsEventRet"
function MCRechargeGoldsEventRet:ctor()
	self.golds = nil       -------- 
	self.moneyFlag = nil       -------- 
	self.money = nil       -------- 
end

function MCRechargeGoldsEventRet:Read(stream)
	self.golds = stream:readInt32()		-------- 
	self.moneyFlag = stream:readUInt8()		-------- 
	self.money = stream:readString()		-------- 
end

function MCRechargeGoldsEventRet:Write(stream)
	stream:writeInt32(self.golds) 
	stream:writeUInt8(self.moneyFlag) 
	stream:writeString(self.money) 
end

------------------------------------------------
MCRoomChanceRet = class("MCRoomChanceRet", BaseResponse)
MCRoomChanceRet.PackID = 671
_G.Protocol["MCRoomChanceRet"] = 671
_G.Protocol[671] = "MCRoomChanceRet"
function MCRoomChanceRet:ctor()
	self.chanceId = nil       -------- 
end

function MCRoomChanceRet:Read(stream)
	self.chanceId = stream:readInt32()		-------- 
end

function MCRoomChanceRet:Write(stream)
	stream:writeInt32(self.chanceId) 
end

------------------------------------------------
MCRoomGiveGiftUpdateRet = class("MCRoomGiveGiftUpdateRet", BaseResponse)
MCRoomGiveGiftUpdateRet.PackID = 481
_G.Protocol["MCRoomGiveGiftUpdateRet"] = 481
_G.Protocol[481] = "MCRoomGiveGiftUpdateRet"
function MCRoomGiveGiftUpdateRet:ctor()
	self.fromPos = nil       -------- 
	self.giftId = nil       -------- 
	self.num = nil       -------- 
	self.toPos = nil       -------- 
end

function MCRoomGiveGiftUpdateRet:Read(stream)
	self.fromPos = stream:readInt32()		-------- 
	self.giftId = stream:readInt32()		-------- 
	self.num = stream:readInt32()		-------- 
	self.toPos = stream:readInt32()		-------- 
end

function MCRoomGiveGiftUpdateRet:Write(stream)
	stream:writeInt32(self.fromPos) 
	stream:writeInt32(self.giftId) 
	stream:writeInt32(self.num) 
	stream:writeInt32(self.toPos) 
end

------------------------------------------------
MCRoomRechargeEventRet = class("MCRoomRechargeEventRet", BaseResponse)
MCRoomRechargeEventRet.PackID = 531
_G.Protocol["MCRoomRechargeEventRet"] = 531
_G.Protocol[531] = "MCRoomRechargeEventRet"
function MCRoomRechargeEventRet:ctor()
	self.golds = nil       -------- 
	self.moneyFlag = nil       -------- 
	self.money = nil       -------- 
	self.playerId = nil       -------- 
	self.pos = nil       -------- 
	self.self = nil       -------- 
end

function MCRoomRechargeEventRet:Read(stream)
	self.golds = stream:readInt16()		-------- 
	self.moneyFlag = stream:readUInt8()		-------- 
	self.money = stream:readString()		-------- 
	self.playerId = stream:readUInt32()		-------- 
	self.pos = stream:readInt32()		-------- 
	self.self = stream:readUInt8()		-------- 
end

function MCRoomRechargeEventRet:Write(stream)
	stream:writeInt16(self.golds) 
	stream:writeUInt8(self.moneyFlag) 
	stream:writeString(self.money) 
	stream:writeUInt32(self.playerId) 
	stream:writeInt32(self.pos) 
	stream:writeUInt8(self.self) 
end

------------------------------------------------
MCSeatPlayersUpdateRet = class("MCSeatPlayersUpdateRet", BaseResponse)
MCSeatPlayersUpdateRet.PackID = 501
_G.Protocol["MCSeatPlayersUpdateRet"] = 501
_G.Protocol[501] = "MCSeatPlayersUpdateRet"
function MCSeatPlayersUpdateRet:ctor()
	self.seatPlayersFlag = nil       -------- 
	--! SeatPlayerBeanReader
	self.seatPlayers = {}        -------- 
end

function MCSeatPlayersUpdateRet:Read(stream)
	self.seatPlayersFlag = stream:readUInt8()		-------- 
	local _seatPlayers_0_t = {}		-------- 
	local _seatPlayers_0_len = stream:readUInt16()
	for _0=1,_seatPlayers_0_len,1 do
	  local _seatPlayers_2_o = {}
	  SeatPlayerBeanReader.Read(_seatPlayers_2_o, stream)
	  table.insert(_seatPlayers_0_t, _seatPlayers_2_o)
	end
	self.seatPlayers = _seatPlayers_0_t
end

function MCSeatPlayersUpdateRet:Write(stream)
	stream:writeUInt8(self.seatPlayersFlag) 
	local _seatPlayers_0_t = self.seatPlayers 
	stream:writeUInt16(#_seatPlayers_0_t)
	for _,_seatPlayers_1_t in pairs(_seatPlayers_0_t) do
	  SeatPlayerBeanReader.Write(_seatPlayers_1_t, stream)
	end
end

------------------------------------------------
MCTicketGainUpdateRet = class("MCTicketGainUpdateRet", BaseResponse)
MCTicketGainUpdateRet.PackID = 511
_G.Protocol["MCTicketGainUpdateRet"] = 511
_G.Protocol[511] = "MCTicketGainUpdateRet"
function MCTicketGainUpdateRet:ctor()
	self.playerId = nil       -------- 
	self.pos = nil       -------- 
	self.value = nil       -------- 
	self.self = nil       -------- 
end

function MCTicketGainUpdateRet:Read(stream)
	self.playerId = stream:readUInt32()		-------- 
	self.pos = stream:readInt32()		-------- 
	self.value = stream:readInt32()		-------- 
	self.self = stream:readUInt8()		-------- 
end

function MCTicketGainUpdateRet:Write(stream)
	stream:writeUInt32(self.playerId) 
	stream:writeInt32(self.pos) 
	stream:writeInt32(self.value) 
	stream:writeUInt8(self.self) 
end

------------------------------------------------
MCTicketMermaidGainUpdateRet = class("MCTicketMermaidGainUpdateRet", BaseResponse)
MCTicketMermaidGainUpdateRet.PackID = 621
_G.Protocol["MCTicketMermaidGainUpdateRet"] = 621
_G.Protocol[621] = "MCTicketMermaidGainUpdateRet"
function MCTicketMermaidGainUpdateRet:ctor()
	self.playerId = nil       -------- 
	self.pos = nil       -------- 
	self.value = nil       -------- 
	self.self = nil       -------- 
end

function MCTicketMermaidGainUpdateRet:Read(stream)
	self.playerId = stream:readUInt32()		-------- 
	self.pos = stream:readInt32()		-------- 
	self.value = stream:readInt32()		-------- 
	self.self = stream:readUInt8()		-------- 
end

function MCTicketMermaidGainUpdateRet:Write(stream)
	stream:writeUInt32(self.playerId) 
	stream:writeInt32(self.pos) 
	stream:writeInt32(self.value) 
	stream:writeUInt8(self.self) 
end

------------------------测试协议------------------------
MCTestPacketRet = class("MCTestPacketRet", BaseResponse)
MCTestPacketRet.PackID = 101
_G.Protocol["MCTestPacketRet"] = 101
_G.Protocol[101] = "MCTestPacketRet"
function MCTestPacketRet:ctor()
	self._testFlag = nil       -------- 
	self._testNumber = nil       -------- 
end

function MCTestPacketRet:Read(stream)
	self._testFlag = stream:readUInt8()		-------- 
	self._testNumber = stream:readInt32()		-------- 
end

function MCTestPacketRet:Write(stream)
	stream:writeUInt8(self._testFlag) 
	stream:writeInt32(self._testNumber) 
end

------------------------------------------------
MCGetFriendChatHistoryRet = class("MCGetFriendChatHistoryRet", BaseResponse)
MCGetFriendChatHistoryRet.PackID = 851
_G.Protocol["MCGetFriendChatHistoryRet"] = 851
_G.Protocol[851] = "MCGetFriendChatHistoryRet"
function MCGetFriendChatHistoryRet:ctor()
	--! ChatMsgBeanReader
	self.msgs = {}        -------- 
end

function MCGetFriendChatHistoryRet:Read(stream)
	local _msgs_0_t = {}		-------- 
	local _msgs_0_len = stream:readUInt16()
	for _0=1,_msgs_0_len,1 do
	  local _msgs_2_o = {}
	  ChatMsgBeanReader.Read(_msgs_2_o, stream)
	  table.insert(_msgs_0_t, _msgs_2_o)
	end
	self.msgs = _msgs_0_t
end

function MCGetFriendChatHistoryRet:Write(stream)
	local _msgs_0_t = self.msgs 
	stream:writeUInt16(#_msgs_0_t)
	for _,_msgs_1_t in pairs(_msgs_0_t) do
	  ChatMsgBeanReader.Write(_msgs_1_t, stream)
	end
end

------------------------------------------------
MCFriendPrivateChatRet = class("MCFriendPrivateChatRet", BaseResponse)
MCFriendPrivateChatRet.PackID = 852
_G.Protocol["MCFriendPrivateChatRet"] = 852
_G.Protocol[852] = "MCFriendPrivateChatRet"
function MCFriendPrivateChatRet:ctor()
	self.iDataId = nil       -------- 
	self.msg = nil       -------- 
end

function MCFriendPrivateChatRet:Read(stream)
	self.iDataId = stream:readUInt32()		-------- 
	self.msg = stream:readString()		-------- 
end

function MCFriendPrivateChatRet:Write(stream)
	stream:writeUInt32(self.iDataId) 
	stream:writeString(self.msg) 
end

------------------------------------------------
MCMoneyUpdate = class("MCMoneyUpdate", BaseResponse)
MCMoneyUpdate.PackID = 855
_G.Protocol["MCMoneyUpdate"] = 855
_G.Protocol[855] = "MCMoneyUpdate"
function MCMoneyUpdate:ctor()
	self.golds = nil       -------- 
	self.jewels = nil       -------- 
	self.charms = nil       -------- 
	self.changeAll = nil       -------- 
end

function MCMoneyUpdate:Read(stream)
	self.golds = stream:readInt32()		-------- 
	self.jewels = stream:readInt32()		-------- 
	self.charms = stream:readInt32()		-------- 
	self.changeAll = stream:readInt32()		-------- 
end

function MCMoneyUpdate:Write(stream)
	stream:writeInt32(self.golds) 
	stream:writeInt32(self.jewels) 
	stream:writeInt32(self.charms) 
	stream:writeInt32(self.changeAll) 
end

------------------------------------------------
CMIndianaHistorys = class("CMIndianaHistorys", BaseRequest)
CMIndianaHistorys.PackID = 90
_G.Protocol["CMIndianaHistorys"] = 90
_G.Protocol[90] = "CMIndianaHistorys"
function CMIndianaHistorys:ctor()
	self.id = nil       -------- 
end

function CMIndianaHistorys:Read(stream)
	self.id = stream:readUInt8()		-------- 
end

function CMIndianaHistorys:Write(stream)
	stream:writeUInt8(self.id) 
end

------------------------------------------------
MCIndianaHistorysRet = class("MCIndianaHistorysRet", BaseResponse)
MCIndianaHistorysRet.PackID = 860
_G.Protocol["MCIndianaHistorysRet"] = 860
_G.Protocol[860] = "MCIndianaHistorysRet"
function MCIndianaHistorysRet:ctor()
	self.id = nil       -------- 
	--! IndianaRecordBean
	self.historys = {}        -------- 
end

function MCIndianaHistorysRet:Read(stream)
	self.id = stream:readUInt8()		-------- 
	local _historys_0_t = {}		-------- 
	local _historys_0_len = stream:readUInt16()
	for _0=1,_historys_0_len,1 do
	  local _historys_2_o = {}
	  IndianaRecordBean.Read(_historys_2_o, stream)
	  table.insert(_historys_0_t, _historys_2_o)
	end
	self.historys = _historys_0_t
end

function MCIndianaHistorysRet:Write(stream)
	stream:writeUInt8(self.id) 
	local _historys_0_t = self.historys 
	stream:writeUInt16(#_historys_0_t)
	for _,_historys_1_t in pairs(_historys_0_t) do
	  IndianaRecordBean.Write(_historys_1_t, stream)
	end
end

------------------------------------------------
CMMyIndianaHistorys = class("CMMyIndianaHistorys", BaseRequest)
CMMyIndianaHistorys.PackID = 91
_G.Protocol["CMMyIndianaHistorys"] = 91
_G.Protocol[91] = "CMMyIndianaHistorys"
function CMMyIndianaHistorys:ctor()
end

function CMMyIndianaHistorys:Read(stream)
end

function CMMyIndianaHistorys:Write(stream)
end

------------------------------------------------
MCMyIndianaHistorysRet = class("MCMyIndianaHistorysRet", BaseResponse)
MCMyIndianaHistorysRet.PackID = 861
_G.Protocol["MCMyIndianaHistorysRet"] = 861
_G.Protocol[861] = "MCMyIndianaHistorysRet"
function MCMyIndianaHistorysRet:ctor()
	--! IndianaJoinBean
	self.joins = {}        -------- 
	--! InianaMyHistoryBean
	self.historys = {}        -------- 
end

function MCMyIndianaHistorysRet:Read(stream)
	local _joins_0_t = {}		-------- 
	local _joins_0_len = stream:readUInt16()
	for _0=1,_joins_0_len,1 do
	  local _joins_2_o = {}
	  IndianaJoinBean.Read(_joins_2_o, stream)
	  table.insert(_joins_0_t, _joins_2_o)
	end
	self.joins = _joins_0_t
	local _historys_0_t = {}		-------- 
	local _historys_0_len = stream:readUInt16()
	for _0=1,_historys_0_len,1 do
	  local _historys_2_o = {}
	  InianaMyHistoryBean.Read(_historys_2_o, stream)
	  table.insert(_historys_0_t, _historys_2_o)
	end
	self.historys = _historys_0_t
end

function MCMyIndianaHistorysRet:Write(stream)
	local _joins_0_t = self.joins 
	stream:writeUInt16(#_joins_0_t)
	for _,_joins_1_t in pairs(_joins_0_t) do
	  IndianaJoinBean.Write(_joins_1_t, stream)
	end
	local _historys_0_t = self.historys 
	stream:writeUInt16(#_historys_0_t)
	for _,_historys_1_t in pairs(_historys_0_t) do
	  InianaMyHistoryBean.Write(_historys_1_t, stream)
	end
end

------------------------------------------------
CMAllIndiana = class("CMAllIndiana", BaseRequest)
CMAllIndiana.PackID = 92
_G.Protocol["CMAllIndiana"] = 92
_G.Protocol[92] = "CMAllIndiana"
function CMAllIndiana:ctor()
end

function CMAllIndiana:Read(stream)
end

function CMAllIndiana:Write(stream)
end

------------------------------------------------
MCAllIndianaRet = class("MCAllIndianaRet", BaseResponse)
MCAllIndianaRet.PackID = 862
_G.Protocol["MCAllIndianaRet"] = 862
_G.Protocol[862] = "MCAllIndianaRet"
function MCAllIndianaRet:ctor()
	--! IndianaBean
	self.joins = {}        -------- 
end

function MCAllIndianaRet:Read(stream)
	local _joins_0_t = {}		-------- 
	local _joins_0_len = stream:readUInt16()
	for _0=1,_joins_0_len,1 do
	  local _joins_2_o = {}
	  IndianaBean.Read(_joins_2_o, stream)
	  table.insert(_joins_0_t, _joins_2_o)
	end
	self.joins = _joins_0_t
end

function MCAllIndianaRet:Write(stream)
	local _joins_0_t = self.joins 
	stream:writeUInt16(#_joins_0_t)
	for _,_joins_1_t in pairs(_joins_0_t) do
	  IndianaBean.Write(_joins_1_t, stream)
	end
end

------------------------------------------------
CMIndianaJoin = class("CMIndianaJoin", BaseRequest)
CMIndianaJoin.PackID = 93
_G.Protocol["CMIndianaJoin"] = 93
_G.Protocol[93] = "CMIndianaJoin"
function CMIndianaJoin:ctor()
	self.id = nil       -------- 
	self.count = nil       -------- 
end

function CMIndianaJoin:Read(stream)
	self.id = stream:readUInt8()		-------- 
	self.count = stream:readUInt32()		-------- 
end

function CMIndianaJoin:Write(stream)
	stream:writeUInt8(self.id) 
	stream:writeUInt32(self.count) 
end

------------------------------------------------
MCIndianaJoinRet = class("MCIndianaJoinRet", BaseResponse)
MCIndianaJoinRet.PackID = 863
_G.Protocol["MCIndianaJoinRet"] = 863
_G.Protocol[863] = "MCIndianaJoinRet"
function MCIndianaJoinRet:ctor()
	self.id = nil       -------- 
	self.count = nil       -------- 
	--! IndianaBean
	self.record = nil       -------- 
end

function MCIndianaJoinRet:Read(stream)
	self.id = stream:readUInt8()		-------- 
	self.count = stream:readUInt32()		-------- 
	self.record = {}		-------- 
	IndianaBean.Read(self.record, stream)
end

function MCIndianaJoinRet:Write(stream)
	stream:writeUInt8(self.id) 
	stream:writeUInt32(self.count) 
	IndianaBean.Write(self.record, stream)
end

------------------------------------------------
CMMyIndianaNumbers = class("CMMyIndianaNumbers", BaseRequest)
CMMyIndianaNumbers.PackID = 94
_G.Protocol["CMMyIndianaNumbers"] = 94
_G.Protocol[94] = "CMMyIndianaNumbers"
function CMMyIndianaNumbers:ctor()
	self.id = nil       -------- 
	self.serialNo = nil       -------- 
end

function CMMyIndianaNumbers:Read(stream)
	self.id = stream:readUInt8()		-------- 
	self.serialNo = stream:readUInt32()		-------- 
end

function CMMyIndianaNumbers:Write(stream)
	stream:writeUInt8(self.id) 
	stream:writeUInt32(self.serialNo) 
end

------------------------------------------------
MCMyIndianaNumbersRet = class("MCMyIndianaNumbersRet", BaseResponse)
MCMyIndianaNumbersRet.PackID = 865
_G.Protocol["MCMyIndianaNumbersRet"] = 865
_G.Protocol[865] = "MCMyIndianaNumbersRet"
function MCMyIndianaNumbersRet:ctor()
	self.id = nil       -------- 
	self.serialNo = nil       -------- 
	self.numbers = {}        -------- 
end

function MCMyIndianaNumbersRet:Read(stream)
	self.id = stream:readUInt8()		-------- 
	self.serialNo = stream:readUInt32()		-------- 
	local _numbers_0_t = {}		-------- 
	local _numbers_0_len = stream:readUInt16()
	for _0=1,_numbers_0_len,1 do
	  table.insert(_numbers_0_t, stream:readString())
	end
	self.numbers = _numbers_0_t
end

function MCMyIndianaNumbersRet:Write(stream)
	stream:writeUInt8(self.id) 
	stream:writeUInt32(self.serialNo) 
	local _numbers_0_t = self.numbers 
	stream:writeUInt16(#_numbers_0_t)
	for _,_numbers_1_t in pairs(_numbers_0_t) do
	  stream:writeString(_numbers_1_t)
	end
end

------------------------------------------------
CMIndianaRecent = class("CMIndianaRecent", BaseRequest)
CMIndianaRecent.PackID = 41
_G.Protocol["CMIndianaRecent"] = 41
_G.Protocol[41] = "CMIndianaRecent"
function CMIndianaRecent:ctor()
end

function CMIndianaRecent:Read(stream)
end

function CMIndianaRecent:Write(stream)
end

------------------------------------------------
MCIndianaRecentRet = class("MCIndianaRecentRet", BaseResponse)
MCIndianaRecentRet.PackID = 864
_G.Protocol["MCIndianaRecentRet"] = 864
_G.Protocol[864] = "MCIndianaRecentRet"
function MCIndianaRecentRet:ctor()
	--! InianaMyHistoryBean
	self.recents = {}        -------- 
end

function MCIndianaRecentRet:Read(stream)
	local _recents_0_t = {}		-------- 
	local _recents_0_len = stream:readUInt16()
	for _0=1,_recents_0_len,1 do
	  local _recents_2_o = {}
	  InianaMyHistoryBean.Read(_recents_2_o, stream)
	  table.insert(_recents_0_t, _recents_2_o)
	end
	self.recents = _recents_0_t
end

function MCIndianaRecentRet:Write(stream)
	local _recents_0_t = self.recents 
	stream:writeUInt16(#_recents_0_t)
	for _,_recents_1_t in pairs(_recents_0_t) do
	  InianaMyHistoryBean.Write(_recents_1_t, stream)
	end
end

------------------------------------------------
CMGetTradeRecords = class("CMGetTradeRecords", BaseRequest)
CMGetTradeRecords.PackID = 95
_G.Protocol["CMGetTradeRecords"] = 95
_G.Protocol[95] = "CMGetTradeRecords"
function CMGetTradeRecords:ctor()
end

function CMGetTradeRecords:Read(stream)
end

function CMGetTradeRecords:Write(stream)
end

------------------------------------------------
MCGetTradeRecordsRet = class("MCGetTradeRecordsRet", BaseResponse)
MCGetTradeRecordsRet.PackID = 866
_G.Protocol["MCGetTradeRecordsRet"] = 866
_G.Protocol[866] = "MCGetTradeRecordsRet"
function MCGetTradeRecordsRet:ctor()
end

function MCGetTradeRecordsRet:Read(stream)
end

function MCGetTradeRecordsRet:Write(stream)
end

------------------------------------------------
CMReceiveFreeGolds = class("CMReceiveFreeGolds", BaseRequest)
CMReceiveFreeGolds.PackID = 96
_G.Protocol["CMReceiveFreeGolds"] = 96
_G.Protocol[96] = "CMReceiveFreeGolds"
function CMReceiveFreeGolds:ctor()
end

function CMReceiveFreeGolds:Read(stream)
end

function CMReceiveFreeGolds:Write(stream)
end

------------------------------------------------
MCReceiveFreeGoldsRet = class("MCReceiveFreeGoldsRet", BaseResponse)
MCReceiveFreeGoldsRet.PackID = 867
_G.Protocol["MCReceiveFreeGoldsRet"] = 867
_G.Protocol[867] = "MCReceiveFreeGoldsRet"
function MCReceiveFreeGoldsRet:ctor()
	self.golds = nil       -------- 
	self.restTime = nil       -------- 
end

function MCReceiveFreeGoldsRet:Read(stream)
	self.golds = stream:readInt32()		-------- 
	self.restTime = stream:readUInt32()		-------- 
end

function MCReceiveFreeGoldsRet:Write(stream)
	stream:writeInt32(self.golds) 
	stream:writeUInt32(self.restTime) 
end

------------------------------------------------
CMLottery = class("CMLottery", BaseRequest)
CMLottery.PackID = 97
_G.Protocol["CMLottery"] = 97
_G.Protocol[97] = "CMLottery"
function CMLottery:ctor()
	self.type = nil       -------- 
end

function CMLottery:Read(stream)
	self.type = stream:readUInt8()		-------- 
end

function CMLottery:Write(stream)
	stream:writeUInt8(self.type) 
end

------------------------------------------------
MCLotteryRet = class("MCLotteryRet", BaseResponse)
MCLotteryRet.PackID = 868
_G.Protocol["MCLotteryRet"] = 868
_G.Protocol[868] = "MCLotteryRet"
function MCLotteryRet:ctor()
	self.type = nil       -------- 
	self.jewels = nil       -------- 
end

function MCLotteryRet:Read(stream)
	self.type = stream:readUInt8()		-------- 
	self.jewels = stream:readInt32()		-------- 
end

function MCLotteryRet:Write(stream)
	stream:writeUInt8(self.type) 
	stream:writeInt32(self.jewels) 
end

------------------------------------------------
CMLuckyAward = class("CMLuckyAward", BaseRequest)
CMLuckyAward.PackID = 98
_G.Protocol["CMLuckyAward"] = 98
_G.Protocol[98] = "CMLuckyAward"
function CMLuckyAward:ctor()
end

function CMLuckyAward:Read(stream)
end

function CMLuckyAward:Write(stream)
end

------------------------------------------------
MCLuckyAwardRet = class("MCLuckyAwardRet", BaseResponse)
MCLuckyAwardRet.PackID = 869
_G.Protocol["MCLuckyAwardRet"] = 869
_G.Protocol[869] = "MCLuckyAwardRet"
function MCLuckyAwardRet:ctor()
	self.itemId = nil       -------- 
	self.itemType = nil       -------- 
	self.num = nil       -------- 
end

function MCLuckyAwardRet:Read(stream)
	self.itemId = stream:readUInt8()		-------- 
	self.itemType = stream:readUInt8()		-------- 
	self.num = stream:readInt32()		-------- 
end

function MCLuckyAwardRet:Write(stream)
	stream:writeUInt8(self.itemId) 
	stream:writeUInt8(self.itemType) 
	stream:writeInt32(self.num) 
end

------------------------------------------------
MCCannonAdd = class("MCCannonAdd", BaseResponse)
MCCannonAdd.PackID = 870
_G.Protocol["MCCannonAdd"] = 870
_G.Protocol[870] = "MCCannonAdd"
function MCCannonAdd:ctor()
	self.id = nil       -------- 
	self.bc = nil       -------- 
	self.addFlag = nil       -------- 
	self.buyFlag = nil       -------- 
end

function MCCannonAdd:Read(stream)
	self.id = stream:readUInt8()		-------- 
	self.bc = stream:readUInt8()		-------- 
	self.addFlag = stream:readUInt8()		-------- 
	self.buyFlag = stream:readUInt8()		-------- 
end

function MCCannonAdd:Write(stream)
	stream:writeUInt8(self.id) 
	stream:writeUInt8(self.bc) 
	stream:writeUInt8(self.addFlag) 
	stream:writeUInt8(self.buyFlag) 
end

------------------------------------------------
MCPlayerDataUpdate = class("MCPlayerDataUpdate", BaseResponse)
MCPlayerDataUpdate.PackID = 871
_G.Protocol["MCPlayerDataUpdate"] = 871
_G.Protocol[871] = "MCPlayerDataUpdate"
function MCPlayerDataUpdate:ctor()
	self.level = nil       -------- 
end

function MCPlayerDataUpdate:Read(stream)
	self.level = stream:readInt32()		-------- 
end

function MCPlayerDataUpdate:Write(stream)
	stream:writeInt32(self.level) 
end

------------------------------------------------
CMGetShopRecords = class("CMGetShopRecords", BaseRequest)
CMGetShopRecords.PackID = 40
_G.Protocol["CMGetShopRecords"] = 40
_G.Protocol[40] = "CMGetShopRecords"
function CMGetShopRecords:ctor()
	self.mallType = nil       -------- 
end

function CMGetShopRecords:Read(stream)
	self.mallType = stream:readUInt8()		-------- 
end

function CMGetShopRecords:Write(stream)
	stream:writeUInt8(self.mallType) 
end

------------------------------------------------
MCGetShopRecordsRet = class("MCGetShopRecordsRet", BaseResponse)
MCGetShopRecordsRet.PackID = 872
_G.Protocol["MCGetShopRecordsRet"] = 872
_G.Protocol[872] = "MCGetShopRecordsRet"
function MCGetShopRecordsRet:ctor()
	self.mallType = nil       -------- 
	self.records = {}        -------- 
end

function MCGetShopRecordsRet:Read(stream)
	self.mallType = stream:readUInt8()		-------- 
	local _records_0_t = {}		-------- 
	local _records_0_len = stream:readUInt16()
	for _0=1,_records_0_len,1 do
	  table.insert(_records_0_t, stream:readString())
	end
	self.records = _records_0_t
end

function MCGetShopRecordsRet:Write(stream)
	stream:writeUInt8(self.mallType) 
	local _records_0_t = self.records 
	stream:writeUInt16(#_records_0_t)
	for _,_records_1_t in pairs(_records_0_t) do
	  stream:writeString(_records_1_t)
	end
end

------------------------------------------------
MCRechargeGoldsRet = class("MCRechargeGoldsRet", BaseResponse)
MCRechargeGoldsRet.PackID = 873
_G.Protocol["MCRechargeGoldsRet"] = 873
_G.Protocol[873] = "MCRechargeGoldsRet"
function MCRechargeGoldsRet:ctor()
end

function MCRechargeGoldsRet:Read(stream)
end

function MCRechargeGoldsRet:Write(stream)
end