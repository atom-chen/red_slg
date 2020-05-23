--
-- Author: wdx
-- Date: 2015-01-23 19:44:48
--

local MsgMD5 = {}

function MsgMD5:init(packCfg)
	self.md5Cfg = ConfigMgr:requestConfig("msg_md5", nil, true)
	for msg,info in pairs(self.md5Cfg) do
		local pack = packCfg[msg]
		if pack then
			local c = pack.c
			if c then
				table.insert(c,1, {"md5","string"})
			end
		end
	end
end

function MsgMD5:md5List(opcode,list)
	local info = self.md5Cfg[opcode]
	if info then
		local str = ""
		for i,v in ipairs(info.list) do
			if v == "k" then
				str = str..info["key"]
			else
				str = str..list[v]
			end
		end
		str = crypto.md5(str)
		table.insert(list,1,str)
	end
end

function MsgMD5:md5Msg(opcode,msg,template)
	local info = self.md5Cfg[opcode]
	if info then
		local str = ""
		for i,v in ipairs(info.list) do
			if v == "k" then
				str = str..info["key"]
			else
				str = str..msg[template[v+1][1]]
			end
		end
		str = crypto.md5(str)
		msg.md5 = str
	end
end


return MsgMD5